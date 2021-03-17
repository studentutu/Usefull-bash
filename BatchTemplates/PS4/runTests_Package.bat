set ip=%1

set titleId={0}
set fingerprint={1}
set packagePath={2}

set sourceRaportFolder=%SCE_ORB_FSD%\%ip%\%titleId%\download0\testResults
set destRaportFolder=%~dp0testResults

:start
pushd "%~dp0"
goto :installPackage

:installPackage
orbis-ctrl pkg-install %packagePath% %ip%
goto :run

:run
orbis-ctrl pkill %ip%
{3}
goto :copyRaport

:copyRaport
timeout 5
orbis-ctrl mount-title %titleId% %fingerprint% %ip%

timeout 5
robocopy /e %sourceRaportFolder% %destRaportFolder% /move

timeout 5
orbis-ctrl unmount-title %titleId% %ip%
goto :end

:end
del temp.txt