'use strict';

TABS.setup_osd = {
};

TABS.setup_osd.initialize = function (callback) {
    var self = this;

    if (GUI.active_tab != 'setup_osd') {
        GUI.active_tab = 'setup_osd';
        googleAnalytics.sendAppView('Setup OSD');
    }

    function load_status() {
        MSP.send_message(MSP_codes.MSP_STATUS, false, false, load_html);
    }

    function load_html() {
        $('#content').load("./tabs/setup_osd.html", process_html);
    }

    load_status();

    function process_html() {

        var osdVideoModes = [
            'AUTO',
            'NTSC',
            'PAL'
        ];

        // translate to user-selected language
        localize();

        $('a.resetSettings').click(function () {
            MSP.send_message(MSP_codes.MSP_RESET_CONF, false, false, function () {
                GUI.log(chrome.i18n.getMessage('initialSetupSettingsRestored'));

                GUI.tab_switch_cleanup(function () {
                    TABS.setup_osd.initialize();
                });
            });
        });
        
        function get_slow_data() {
            MSP.send_message(MSP_codes.MSP_OSD_VIDEO_STATUS, false, false, function () {
                var element;
                
                element = $('.video-mode');
                var osdVideoMode = osdVideoModes[OSD_VIDEO_STATE.video_mode];
                element.text(osdVideoMode);
                
                element = $('.camera-connected');
                element.text(OSD_VIDEO_STATE.camera_connected ? chrome.i18n.getMessage('osdInfoCameraConnectedValueYes') : chrome.i18n.getMessage('osdInfoCameraConnectedValueNo'));
            });
        }

        GUI.interval_add('setup_data_pull_slow', get_slow_data, 250, true); // 4 fps

        GUI.content_ready(callback);
    }
};

TABS.setup_osd.cleanup = function (callback) {
    if (callback) callback();
};
