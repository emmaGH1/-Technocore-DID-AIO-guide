<#
.SYNOPSIS
  Automated setup script for Technocore DID on Windows (PowerShell)
#>

Write-Host "=== Technocore DID Windows Setup ===" -ForegroundColor Cyan

# 1. Check Python
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Error "Python is not installed or not in your PATH. Please install Python 3.11 or 3.12."
    exit 1
}

Write-Host "[1/4] Found Python: $(python --version)" -ForegroundColor Green

# 2. Setup Virtual Environment
if (-not (Test-Path ".venv")) {
    Write-Host "[2/4] Creating virtual environment (.venv)..." -ForegroundColor Yellow
    python -m venv .venv
} else {
    Write-Host "[2/4] Virtual environment already exists." -ForegroundColor Green
}

# 3. Activate and install requirements
Write-Host "[3/4] Installing dependencies..." -ForegroundColor Yellow
& ".\.venv\Scripts\python.exe" -m pip install --upgrade pip --quiet
& ".\.venv\Scripts\python.exe" -m pip install -r requirements.txt --quiet

# 4. Verify
Write-Host "[4/4] Verifying installation..." -ForegroundColor Yellow
$version = & ".\.venv\Scripts\python.exe" technocore_agent.py --version
Write-Host "Technocore Agent Version: $version" -ForegroundColor Green
Write-Host "`nSetup complete! Run '.\.venv\Scripts\python.exe technocore_agent.py init' to create your DID." -ForegroundColor Cyan
