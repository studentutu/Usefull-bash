set ip=%1

set titleId={0}
set fingerprint={1}
set masterPackagePath={2}
set patchPath={3}

set sourceRaportFolder=%SCE_ORB_FSD%\%ip%\%titleId%\download0\testResults
set destRaportFolder=%~dp0testResults

:start
pushd "%~dp0"
goto :findMasterPackage

:findMasterPackage
orbis-ctrl pkg-list > temp.txt %ip%
findstr %titleId% temp.txt
if errorlevel 1 (
echo Package not found, installing master package first
goto :installMasterPackage
) else (
echo Package found, installing patch
goto :installPatch
)

:installMasterPackage
orbis-ctrl pkg-install %masterPackagePath% %ip%
goto :installPatch

:installPatch
orbis-ctrl pkg-install %patchPath% %ip%
goto :run

:run
orbis-ctrl pkill %ip%
{4}
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