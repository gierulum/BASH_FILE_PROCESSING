@echo off
setlocal EnableDelayedExpansion
REM declae o as numbers of arrays:
set o=0
REM create list of files for number of operations:
for %%I in ("E:\DEVELOP\GITHUB\BASH_FILE_PROCESSING\BASH_FILE_PROCESSING\BAT_FILES\*") do (
set /A o=o+1 
set lista_plikow_nazwy[!o!]=%%I
set lista_plikow_imiona[!o!]=%%~nI
set lista_plikow_daty[!o!]=%time:~0,2%:%time:~3,2%
echo %%I >> file_operations.txt
)
REM sort files list:
for /f %%G in (file_operations.txt) do (
REM sort list of files in another file:
sort /R file_operations.txt /o file_operations_reverse.txt)
)
REM create process of changing directory for files:
for /f %%W in (file_operations_reverse.txt) do (
REM change directory of files:
move %%W E:\DEVELOP\GITHUB\BASH_FILE_PROCESSING\BASH_FILE_PROCESSING\BAT_DONE
REM could create new names of files (if not unique names at in time) in line with variety of:
REM echo %%~nxW %DATE% %time:~0,2%:%time:~3,2% >> file_operations.txt
REM echo information of succesfully files process:
echo plik %%~nxW: has been processed: %DATE% %time:~0,2%:%time:~3,2% >> E:\DEVELOP\GITHUB\BASH_FILE_PROCESSING\BASH_FILE_PROCESSING\proces_log_file.txt)
)
REM insert data to database as user GIER:
REM create table aa_bat_test(id number(10),name varchar2(10) );
sqlldr GIER/Leopold666@ORCL control=ctl_for_bat.ctl log=log_for_bat.log
pause