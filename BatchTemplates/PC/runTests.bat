@echo off
set sourceRaportFolder={0}
set destRaportFolder=%~dp0testResults

:start
goto :run

:run
{1}
goto :copyRaport

:copyRaport
xcopy /e /i /h /y "%sourceRaportFolder%" "%destRaportFolder%"
timeout 2
rmdir /s /q "%sourceRaportFolder%"