set appId={0}
set packageName={1}

set ip=%1

set sourceRaportFolder=xr:\testResults
set destRaportFolder=%~dp0testResults
set xdkBinPath=%DurangoXDK%bin\

:start
"%xdkBinPath%xbapp" /x:%ip% terminate
goto :findInstalledPackage

:findInstalledPackage
"%xdkBinPath%xbapp" /x:%ip% list > temp.txt
findstr %appId% temp.txt
if errorlevel 1 (
echo Package not found, installing package
goto :installPackage
) else (
echo Package found, uninstalling old package
goto :uninstallPackage
)

:uninstallPackage
"%xdkBinPath%xbapp" uninstall /x:%ip% %packageName%
goto :installPackage

:installPackage
"%xdkBinPath%xbapp" install /x:%ip% %~dp0Gwent\Data\%packageName%
goto :run

:run
{2}
goto :copyRaport

:copyRaport

"%xdkBinPath%xbapp" launch /x:%ip% %appId%
timeout 2 > nul
"%xdkBinPath%xbdir" /s /x:%ip%/title "%sourceRaportFolder%" > content.txt
"%xdkBinPath%xbcp" /s /x:%ip%/title "%sourceRaportFolder%" "%destRaportFolder%"
"%xdkBinPath%xbdel" /s /x:%ip%/title "%sourceRaportFolder%"
"%xdkBinPath%xbapp" terminate /x:%ip%

goto :end

:end
del temp.txt