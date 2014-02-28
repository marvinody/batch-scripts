@echo off
echo ***************************************
echo *                                     *
echo *   Marvinody's League Audio Changer  *
echo *                                     *
echo ***************************************
echo This assumes your LoL directory is at
echo "C:\Riot Games\League of Legends\"
echo Press enter to continue or 
echo exit now if the folder is elsewhere
echo.
echo.
echo If you want to uninstall please select 
echo the language you want to remove as your 
echo "desired" language
pause > NUL
echo.
echo Select your current Language:
echo (langauge that your text is in)
echo.
:choice
echo 1. English
echo 2. Spanish
echo 3. German
echo 4. Italian
echo 5. Polish
echo 6. Korean
echo 7. Romanian
echo 8. French
echo 9. Brazilian
echo 0. Exit
echo.
echo Hit a number [0-9] and press enter.
set /P CH=[0-9]:
if "%CH%"=="0" goto quit
if "%CH%"=="1" (
  set LANG=en_us
  set fLANG=en_US
  )
if "%CH%"=="2" (
  set LANG=es_es
  set fLANG=es_ES
  )
if "%CH%"=="3" (
  set LANG=de_de
  set fLANG=de_DE
  )
if "%CH%"=="4" (
  set LANG=it_it
  set fLANG=it_IT
  )
if "%CH%"=="5" (
  set LANG=pl_pl
  set fLANG=pl_PL
  )
if "%CH%"=="6" (
  set LANG=ko_kr
  set fLANG=ko_KR
  )
if "%CH%"=="7" (
  set LANG=ro_ro
  set fLANG=ro_RO
  )
if "%CH%"=="8" (
  set LANG=fr_fr
  set fLANG=fr_FR
  )
if "%CH%"=="9" ( 
  set LANG=pt_br
  set fLANG=pt_BR
  )
if not defined cLANG (
  set cLANG=%LANG%
  set cfLANG=%fLANG%
  echo.
  echo Select your desired Language:
  echo language you want for audio
  echo.
  goto choice
  )
  

echo .
echo 1) Uninstall
echo 2) Change Voice
echo .
echo If you want to change from a non-native voice to a non-native voice, please uninstall first.
set /P CH=[1-2]:
if "%CH%"=="0" goto quit
if "%CH%"=="1" goto uninstall
if "%CH%"=="2" goto langchange

:uninstall


::goto quit
:langchange  

::current language
echo Finding League Folder
chdir /d "C:\Riot Games\League of Legends\RADS\system"
echo Writing new locale lang...
echo locale=%LANG% > locale.cfg
echo Opening League...
chdir ..\..\

ping 127.0.0.1 -n 2 > nul

lol.launcher.exe
echo Close the launcher once it finishes and click enter to continue after
pause > NUL
echo Changing Dir to new DLed Language
chdir RADS\projects\lol_game_client_%LANG%\managedfiles
ping 127.0.0.1 -n 2 > nul



::Following block I have taken from 
::http://stackoverflow.com/questions/10519389/get-last-created-directory-batch-command
FOR /F %%i IN ('dir /b /ad-h /o-d') DO (
    SET a1=%%i
    GOTO found1
)
goto quit
::above is executed if no file is found
:found1

chdir %a1%\DATA\Sounds\FMOD
set lang_dir=%cd%
chdir ..\..\..\..\..\..\
echo Finding Native Language Folder
chdir lol_game_client_%cLang%\managedfiles

FOR /F %%i IN ('dir /b /ad-h /o-d') DO (
    SET a=%%i
    GOTO found2
)
goto quit
:found2
chdir %a%\DATA\Sounds\FMOD
echo Renaming old voice file
if exist VOBank_%cfLang%.bak (
	echo .bak file exists, not renaming
) else (
	rename VOBank_%cfLang%.fsb VOBank_%cfLang%.bak
)
ping 127.0.0.1 -n 2 > nul
echo Moving new voice file

copy ..\..\..\..\..\..\lol_game_client_%LANG%\managedfiles\%a1%\DATA\Sounds\FMOD\VOBank_%fLANG%.fsb VOBank_%cfLang%.fsb

chdir /d "C:\Riot Games\League of Legends\RADS\system"
echo Rewriting locale file back to native
ping 127.0.0.1 -n 2 > nul
echo locale=%cLANG% > locale.cfg
:quit
echo Exiting...
ping 127.0.0.1 -n 2 > nul
