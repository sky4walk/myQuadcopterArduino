REM Arduino �ber USB Bus anschliessen
REM %AVRPATH%\listComPorts.exe aufrufen um COM Port zu bestimmen
REM erhaltenen COM Port anstatt COM7 eintragen

SET AVRPATH=avrdude
SET COMPORT=COM22

%AVRPATH%\avrdude.exe -C%AVRPATH%\avrdude.conf -v -patmega328p -carduino -P%COMPORT% -b57600 -D -Uflash:w:FW\FW-CriusV2.ino.hex:i 

