@echo off
SETLOCAL EnableDelayedExpansion

echo ===================================================
echo   SilverBite Local Deployment Startup Script
echo ===================================================

:: Step 1: Start MongoDB
echo [1/4] Starting local MongoDB database service...
start "SilverBite MongoDB" cmd /k ""e:\food delivery\mongodb\mongodb-win32-x86_64-windows-4.4.29\bin\mongod.exe" --dbpath "e:\food delivery\mongodb\data""

:: Wait 3 seconds for MongoDB to initialize
echo Waiting for MongoDB to start...
timeout /t 3 /nobreak > nul

:: Step 2: Seed the Database
echo [2/4] Seeding the database with demo data...
cd /d "e:\food delivery\SilverBite\backend"
node seed.js
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Seeding the database failed. Please ensure MongoDB is running properly.
) else (
    echo [SUCCESS] Database seeded successfully.
)

:: Step 3: Start Backend API Server
echo [3/4] Starting backend Express server...
start "SilverBite Backend" cmd /k "npm start"

:: Step 4: Start Frontend Expo Server
echo [4/4] Starting Expo frontend developer server...
cd /d "e:\food delivery\SilverBite\frontend"
start "SilverBite Frontend" cmd /k "npm start"

echo ===================================================
echo   All services have been successfully initiated!
echo   - Backend Server is running at http://localhost:5000
echo   - Frontend Expo Server is running (scan the QR code)
echo ===================================================
pause
