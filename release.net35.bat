@echo off

for /f "usebackq tokens=*" %%i in (`vswhere -latest -products * -requires Microsoft.Component.MSBuild -property installationPath`) do (
  set InstallDir=%%i
)

if exist "%InstallDir%\MSBuild\15.0\Bin\MSBuild.exe" (
  "%InstallDir%\MSBuild\15.0\Bin\MSBuild.exe" %*
)
@echo on
if exist "%InstallDir%\MSBuild\15.0\Bin\MSBuild.exe" (
  set msBuildExe="%InstallDir%\MSBuild\15.0\Bin\MSBuild.exe"
)

call %msBuildExe% WinFormsUI.Docking.sln /t:restore /p:Configuration=Release  /p:TargetFrameworkVersion=v3.5 /p:OutputPath=..\bin\net35-client\
call %msBuildExe% WinFormsUI.Docking.sln /t:build /p:Configuration=Release  /p:TargetFrameworkVersion=v3.5 /p:OutputPath=..\bin\net35-client\
@IF %ERRORLEVEL% NEQ 0 PAUSE