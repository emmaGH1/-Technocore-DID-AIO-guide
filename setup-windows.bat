@echo off
echo === Technocore DID Windows Setup ===

python --version >nul 2>&1
if errorlevel 1 (
    echo Python is not installed or not in PATH. Please install Python 3.11+.
    pause
    exit /b 1
)

echo [1/3] Creating virtual environment...
if not exist .venv (
    python -m venv .venv
)

echo [2/3] Installing dependencies...
call .venv\Scripts\activate.bat
python -m pip install -r requirements.txt

echo [3/3] Verifying Technocore Agent...
python technocore_agent.py --version

echo.
echo Setup complete! To create your identity, run:
echo python technocore_agent.py init
echo.
pause
