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

echo ---[ Step 1/5 - Clean output folder ] ---
echo * Attempt to remove : "%FOLDER_BUILD%"
rmdir %FOLDER_BUILD% /s /q

echo.
echo.

echo ---[ Step 2/5 - Build Jekyll site ] ---
echo * Attempt to build Jekyll website
call bundle exec jekyll build

echo.
echo.

echo ---[ Step 3/5 - Copy Jekyll site in the root ] ---
echo * Attempt to copy Jekyll website in the root of project
xcopy "%FOLDER_BUILD%" "%FOLDER_ROOT_GIT%" /E /H /Y

echo.
echo.
echo ---[ Step 4/5 - Git commit ] ---
git add --all
git commit -m "Jekyll website published"

echo.
echo.

echo ---[ Step 5/5 - Git push ] ---
git push origin master

echo.
echo.

echo ����[ End process ]����
echo.
pause
