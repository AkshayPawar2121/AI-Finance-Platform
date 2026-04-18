# Run the Project Automatically
$ErrorActionPreference = "Stop"

Write-Host "Starting NextGen Project Setup..." -ForegroundColor Cyan

# 1. Setup Python API
Write-Host "Setting up Python Environment..." -ForegroundColor Yellow
$pyDir = "pycharm/budgetmodel"
if (-not (Test-Path $pyDir)) {
    Write-Error "Python directory not found at $pyDir"
    exit 1
}

Push-Location $pyDir

# Check for Python executable
$pythonPath = "C:\Users\LENOVO\AppData\Local\Programs\Python\Python313\python.exe"

if (-not (Test-Path $pythonPath)) {
    # Try finding another python
    if (Get-Command "python" -ErrorAction SilentlyContinue) {
        $pythonPath = "python"
    }
    elseif (Get-Command "python3" -ErrorAction SilentlyContinue) {
        $pythonPath = "python3"
    }
    else {
        Write-Error "Python is not installed or not in PATH. Please install Python."
        exit 1
    }
}

Write-Host "Using Python: $pythonPath" -ForegroundColor Cyan

# Create local venv if not exists
$venvDir = ".venv_local"
if (-not (Test-Path $venvDir)) {
    Write-Host "Creating local virtual environment (.venv_local)..." -ForegroundColor Yellow
    & $pythonPath -m venv $venvDir
}

# Use venv python
$venvPython = "$venvDir/Scripts/python.exe"

# Install dependencies
Write-Host "Installing Python dependencies into venv..." -ForegroundColor Green
& $venvPython -m pip install -r requirements.txt | Out-Null

# Train model if model.pkl doesn't exist
if (-not (Test-Path "model.pkl")) {
    Write-Host "model.pkl not found. Training AI model (this may take 1-2 minutes)..." -ForegroundColor Yellow
    & $venvPython train_model.py
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Model training failed. Predictions may not work."
    } else {
        Write-Host "AI model trained and saved!" -ForegroundColor Green
    }
} else {
    Write-Host "AI model already trained (model.pkl found)." -ForegroundColor Green
}

# Kill any existing process on port 5000
$existingPy = Get-NetTCPConnection -LocalPort 5000 -ErrorAction SilentlyContinue
if ($existingPy) {
    Write-Host "Stopping existing process on port 5000..." -ForegroundColor Yellow
    $existingPy | ForEach-Object { Stop-Process -Id (Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue).Id -Force -ErrorAction SilentlyContinue }
    Start-Sleep -Seconds 2
}

# Start Python API in background
Write-Host "Starting Python Flask API on port 5000..." -ForegroundColor Green
$pythonJob = Start-Process -FilePath $venvPython -ArgumentList "budgetmodel_api.py" -PassThru -WindowStyle Hidden
Write-Host "Python API started (PID: $($pythonJob.Id))" -ForegroundColor Green

Pop-Location

# 2. Setup Java Spring Boot
Write-Host "Setting up Spring Boot Application..." -ForegroundColor Yellow
$javaDir = "nextgendemo"
if (-not (Test-Path $javaDir)) {
    Write-Error "Java directory not found at $javaDir"
    Stop-Process -Id $pythonJob.Id -Force
    exit 1
}

Push-Location $javaDir

# Use Maven Wrapper
if (Test-Path "mvnw.cmd") {
    $mvnCmd = ".\mvnw.cmd"
}
else {
    $mvnCmd = "mvn"
}

# Kill any existing process on port 8081
$existingJava = Get-NetTCPConnection -LocalPort 8081 -ErrorAction SilentlyContinue
if ($existingJava) {
    Write-Host "Stopping existing process on port 8081..." -ForegroundColor Yellow
    $existingJava | ForEach-Object { Stop-Process -Id (Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue).Id -Force -ErrorAction SilentlyContinue }
    Start-Sleep -Seconds 3
}

# Clean compile to pick up all Java changes
Write-Host "Compiling Java sources (clean build)..." -ForegroundColor Yellow
& $mvnCmd clean compile -q
if ($LASTEXITCODE -ne 0) {
    Write-Error "Maven compilation FAILED. Check the errors above."
    Stop-Process -Id $pythonJob.Id -Force
    exit 1
}
Write-Host "Compilation successful!" -ForegroundColor Green

# Start Spring Boot in a new window so user can see logs
Write-Host "Starting Spring Boot App on port 8081..." -ForegroundColor Green
Start-Process -FilePath "cmd.exe" -ArgumentList "/c $mvnCmd spring-boot:run" -WorkingDirectory $PWD

# 3. Wait for Spring Boot to become ready (poll port 8081)
Write-Host "Waiting for Spring Boot to become ready..." -ForegroundColor Yellow
$maxWait = 90   # seconds
$waited = 0
$ready = $false

while ($waited -lt $maxWait) {
    Start-Sleep -Seconds 3
    $waited += 3
    $conn = Get-NetTCPConnection -LocalPort 8081 -State Listen -ErrorAction SilentlyContinue
    if ($conn) {
        $ready = $true
        break
    }
    Write-Host "  Still starting... ($waited/$maxWait s)" -ForegroundColor DarkGray
}

Pop-Location

if ($ready) {
    Write-Host "Spring Boot is ready on port 8081!" -ForegroundColor Green
    # 4. Open Browser
    Write-Host "Opening Browser at http://localhost:8081 ..." -ForegroundColor Cyan
    Start-Process "http://localhost:8081"
} else {
    Write-Warning "Spring Boot did not start within $maxWait seconds. Check the Java window for errors."
    Write-Warning "You can still try opening http://localhost:8081 manually."
}

Write-Host ""
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "  NextGen Finance is RUNNING!" -ForegroundColor Green
Write-Host "  Web App:    http://localhost:8081" -ForegroundColor White
Write-Host "  Python API: http://localhost:5000" -ForegroundColor White
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "  To stop the Python API: Stop-Process -Id $($pythonJob.Id) -Force" -ForegroundColor DarkGray
Write-Host "  To stop Spring Boot:    Close the Java console window" -ForegroundColor DarkGray
