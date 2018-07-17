cls
@echo off

@chcp 65001
cd /d "%~dp0"/_docs

set FOLDER_CURRENT=%cd%
set FOLDER_BUILD=%FOLDER_CURRENT%\_site
set FOLDER_ROOT_GIT=%cd%\..\


type github_jekyll.txt

echo.
echo.

echo ---[ Step 1/4 - Clean output folder ] ---
echo * Attempt to remove : "%FOLDER_BUILD%"
rmdir %FOLDER_BUILD% /s /q
echo ------------------------------------------

echo.
echo.

echo ---[ Step 2/4 - Build Jekyll site ] ---
echo * Attempt to build Jekyll website
call bundle exec jekyll build
echo ------------------------------------------

echo.
echo.

echo ---[ Step 3/4 - Copy Jekyll site in the root ] ---
echo * Attempt to copy Jekyll website in the root of project
echo.
echo * Create the file xcopy_EXCLUDE.txt in order to ignore some file and directory.
echo github_jekyll.txt > xcopy_Exclude.txt
echo .bat >> xcopy_Exclude.txt
echo * The file xcopy_EXCLUDE.txt is created.
echo.
echo * Launch command : xcopy "%FOLDER_BUILD%" "%FOLDER_ROOT_GIT%" /E /H /Y /EXCLUDE:xcopy_Exclude.txt
xcopy "%FOLDER_BUILD%" "%FOLDER_ROOT_GIT%" /E /H /Y /EXCLUDE:xcopy_Exclude.txt
echo * Files and directory are copied.
echo.
echo * Delete xcopy_Exclude.txt.
del xcopy_Exclude.txt
echo ------------------------------------------

echo.
echo.

echo ----[ Step 4/4 - Published on Github  ] ----
echo.
echo * Attempt to stage all files
git add --all

echo.
echo * Attempt to commit staged files
git commit -m "Jekyll website published"

echo.
echo * Attempt to push on Gituhb
git push origin master
echo ------------------------------------------

echo.
echo.

echo ----[ End process ]----
echo.