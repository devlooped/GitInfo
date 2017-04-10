@echo off
REM Usage: wslpath.cmd -w <linux path>
REM Converts a path from the Linux /mnt/c/... format into Windows format.

REM Requires `wslrun.cmd` in the same directory as this file.
%0\..\wslrun.cmd cd "'%2'" ; cmd.exe /c cd
