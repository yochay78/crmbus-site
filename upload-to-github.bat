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
git add -A
git commit -m "Site update %date% %time%"
git push -u origin main
echo.
echo ===== Done. Check the lines above for errors. =====
pause
