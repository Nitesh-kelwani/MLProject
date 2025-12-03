# Check if conda is available
if (-not (Get-Command conda -ErrorAction SilentlyContinue)) {
    Write-Error "Conda is not found in PATH. Please ensure Conda is installed and added to PATH."
    exit 1
}

$EnvName = "venv_compatible"
$PythonVersion = "3.12"

Write-Host "Creating new Conda environment '$EnvName' with Python $PythonVersion..."
conda create -n $EnvName python=$PythonVersion -y

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to create environment."
    exit $LASTEXITCODE
}

Write-Host "Environment created successfully."
Write-Host "Installing dependencies from requirements.txt..."

# Activate environment and install dependencies
# Note: 'conda activate' might not work in a script without 'conda init' setup, 
# so we use 'conda run' to execute commands in the environment.

conda run -n $EnvName pip install -r requirements.txt

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to install dependencies."
    exit $LASTEXITCODE
}

Write-Host "Dependencies installed successfully."
Write-Host "To use this environment, run: conda activate $EnvName"
