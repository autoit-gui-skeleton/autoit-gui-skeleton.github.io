cls
@echo off

set FOLDER_CURRENT=%cd%
set FOLDER_BUILD=%FOLDER_CURRENT%\_site
set FOLDER_ROOT_GIT=%cd%\..\

type github_jekyll.txt

echo.
echo.

echo ---[ Step 1/4 - Clean output folder ] ---
echo * Attempt to remove : "%FOLDER_BUILD%"
rmdir %FOLDER_BUILD% /s /q

echo * Attempt to clean folders
rmdir %FOLDER_ROOT_GIT%\articles\ /s /q
rmdir %FOLDER_ROOT_GIT%\assets\ /s /q
rmdir %FOLDER_ROOT_GIT%\blog\ /s /q
rmdir %FOLDER_ROOT_GIT%\documentation\ /s /q
rmdir %FOLDER_ROOT_GIT%\fr\ /s /q
rmdir %FOLDER_ROOT_GIT%\search\ /s /q
rmdir %FOLDER_ROOT_GIT%\tags\ /s /q
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
echo * Stage all files in git
git add --all

echo.
echo * Create a git commit for all staged files
git commit -m "AGS website built with Jekyll and published on Github"

echo.
echo * Push commit on Github (see origin : https://github.com/autoit-gui-skeleton/autoit-gui-skeleton.github.io.git)
git push origin master
echo ------------------------------------------

echo.
echo.

echo ----[ End process ]----
echo.