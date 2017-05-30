echo %~n1
pasmo --tzx %1 %~n1.tzx
fuse %~n1.tzx --no-auto-load -s bootloader.szx