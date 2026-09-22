@echo off
chcp 65001 >nul
cd /d "%~dp0"
where git >nul 2>nul || (echo Git is not installed. & pause & exit /b 1)
if not exist ".git" (
  git init
  git symbolic-ref HEAD refs/heads/main
  git remote add origin https://github.com/yochay78/crmbus-site.git
)
git config user.email >nul 2>nul || git config user.email "yochay78@gmail.com"
git config user.name >nul 2>nul || git config user.name "Yochay Mutzri"

rem 1. Save local changes, if there are any.
git add -A
git diff --cached --quiet || git commit -m "Site update %date% %time%"

rem 2. Bring in changes made elsewhere (the server pushes its fixes to GitHub too).
rem    Without this step the push below is refused whenever this copy is behind.
git pull --no-rebase --no-edit origin main || (
  echo.
  echo ===== The update from GitHub could not be merged automatically. =====
  echo ===== Nothing was uploaded. Send a screenshot of this window.   =====
  pause
  exit /b 1
)

rem 3. Upload.
git push -u origin main
echo.
echo ===== Done. Check the lines above for errors. =====
pause
