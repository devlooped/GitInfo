@echo off
rem Only need to run this the first time after clone. Subsequent builds can be just "msbuild".
rem Alternatively, this batch file can be invoked passing msbuild parameters, like: build.cmd /v:detailed /t:Rebuild

cd %~dp0

SETLOCAL
SET CACHED_NUGET=%LocalAppData%\NuGet\NuGet.exe

IF EXIST %CACHED_NUGET% goto copynuget
echo Downloading latest version of NuGet.exe...
IF NOT EXIST %LocalAppData%\NuGet md %LocalAppData%\NuGet
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest 'https://www.nuget.org/nuget.exe' -OutFile '%CACHED_NUGET%'"

:copynuget
IF EXIST .nuget\nuget.exe goto restore
md .nuget
copy %CACHED_NUGET% .nuget\nuget.exe > nul

:restore
IF NOT EXIST packages.config goto run
.nuget\NuGet.exe install packages.config -OutputDirectory packages -ExcludeVersion

:run
msbuild build.proj /nologo /v:detailed %1 %2 %3 %4 %5 %6 %7 %8 %9