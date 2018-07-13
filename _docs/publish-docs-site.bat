cls
@echo off

@chcp 65001
cd /d "%~dp0"

set FOLDER_CURRENT=%cd%
set FOLDER_BUILD=%FOLDER_CURRENT%\_site
set FOLDER_ROOT_GIT=%cd%\..\


type github_jekyll.txt

echo.
echo.

echo ---[ Step 1/4 - Clean output folder ] ---
echo * Attempt to remove : "%FOLDER_BUILD%"
rmdir %FOLDER_BUILD% /s /q

echo.
echo.

echo ---[ Step 2/4 - Build Jekyll site ] ---
echo * Attempt to build Jekyll website
call bundle exec jekyll build

echo.
echo.

echo ---[ Step 3/4 - Copy Jekyll site in the root ] ---
echo * Attempt to copy Jekyll website in the root of project
echo xcopy "%FOLDER_BUILD%" "%FOLDER_ROOT_GIT%" /E /H /Y
xcopy "%FOLDER_BUILD%" "%FOLDER_ROOT_GIT%" /E /H /Y

echo.
echo.

echo ----[ Step 4/4 - Published on Github  ] ----
git add --all
git commit -m "Jekyll website published"
git push origin master


echo ----[ End process ]----
echo.
pause