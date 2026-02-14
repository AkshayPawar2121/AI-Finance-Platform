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

# Start Python API in background
Write-Host "Starting Python Flask API on port 5000..." -ForegroundColor Green
$pythonJob = Start-Process -FilePath $venvPython -ArgumentList "budgetmodel_api.py" -PassThru -WindowStyle Hidden
Write-Host "Python API started (PID: $($pythonJob.Id))"

Pop-Location

# 2. Setup Java Spring Boot
Write-Host "Setting up Spring Boot Application..." -ForegroundColor Yellow
$javaDir = "nextgendemo"
if (-not (Test-Path $javaDir)) {
    Write-Error "Java directory not found at $javaDir"
    # Clean up python process before exiting
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

Write-Host "Starting Spring Boot App with Maven..." -ForegroundColor Green
# We use cmd /c to run the batch file and keep it running
# Using Start-Process to run it in a new window so the user can see the logs
Start-Process -FilePath "cmd.exe" -ArgumentList "/c $mvnCmd spring-boot:run" -WorkingDirectory $PWD

Write-Host "Spring Boot is starting... Waiting for a few seconds before opening browser..."
Start-Sleep -Seconds 15

# 3. Open Browser
Write-Host "Opening Browser..." -ForegroundColor Cyan
Start-Process "http://localhost:8081"

Write-Host "Setup running. Python API is in background. Java App is in a new window." -ForegroundColor Cyan
Write-Host "To stop the Python API later, use Task Manager or 'Stop-Process -Id $($pythonJob.Id)'"
