set sourceRaportFolder={0}
set destRaportFolder=%~dp0testResults

:copyRaport
xcopy /e /i /h /y "%sourceRaportFolder%" "%destRaportFolder%"
timeout 2
rmdir /s /q "%sourceRaportFolder%"