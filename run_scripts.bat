@echo off
setlocal EnableDelayedExpansion
REM deklaracja o jako numer pozycji w arrays.
set o=0
for %%I in ("C:\DOCUMENTS\BAT_OPERATIONS\BAT_FILES\*") do (
set /A o=o+1 
set lista_plikow_nazwy[!o!]=%%I
set lista_plikow_imiona[!o!]=%%~nI
set lista_plikow_daty[!o!]=%time:~0,2%:%time:~3,2%
REM lista plikow po nazwach i sortowanie:
for /f "delims== tokens=2" %%x in ('set lista_plikow_nazwy') do (
echo %%x | sort /R >> file_operations.txt
sort /R file_operations.txt /o file_operations_reverse.txt)
)
REM proces zapisywania danych i przenoszenia plikow do innych folderow:
for /f %%G in (file_operations_reverse.txt) do (
for /f "tokens=*" %%L in (%G%) do (
sqlldr LOGIN/PASSWORD@CONNCTION_DATABASE control=ctl_for_bat.ctl log=log_for_bat.log)
move %%G C:\DOCUMENTS\BAT_OPERATIONS\BAT_DONE
echo plik %%~nxG: został przeprocesowany: %DATE% %time:~0,2%:%time:~3,2% >> E:\DEVELOP\BATSCHER\proces_log_file.txt)
)
pause