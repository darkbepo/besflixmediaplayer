@echo off
echo ==============================
echo   Besflix Updater Starting
echo ==============================

cd /d C:\clients\besflixmediaplayer

echo.
echo [1/6] Fetching latest from upstream...
git fetch upstream

echo.
echo [2/6] Switching to main branch...
git checkout main

echo.
echo [3/6] Merging upstream changes...
git merge upstream/master

IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo ❌ Merge failed. Resolve manually.
    pause
    exit /b
)

echo.
echo [4/6] Switching to branding branch...
git checkout branding

echo.
echo [5/6] Rebasing branding on top of main...
git rebase main

IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo ⚠️ Rebase has conflicts!
    echo Fix them, then run:
    echo git add .
    echo git rebase --continue
    pause
    exit /b
)

echo.
echo [6/6] Pushing updates to GitHub...
git push origin branding

echo.
echo ✅ Done! Your Besflix build is up to date.
pause