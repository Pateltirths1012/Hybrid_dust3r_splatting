@echo off
:: -------------------------------------
:: Script: setup_environment.bat
:: Purpose: Setup project environment for a specific CUDA version
:: -------------------------------------

:: Checking if the CUDA version is a valid one or not
if "%~1"=="" (
    echo.
    echo [ERROR] Usage: setup_environment.bat ^<cuda_version^>
    echo Example: setup_environment.bat 11.8
    exit /b 1
)

set CUDA_VERSION=%~1
echo -------------------------------------
echo Setting up environment with CUDA version: %CUDA_VERSION%
echo -------------------------------------

:: Validate CUDA version
if "%CUDA_VERSION%"=="10.2" (
    set CUDA_URL=https://download.pytorch.org/whl/cu102/torch_stable.html
) else if "%CUDA_VERSION%"=="11.8" (
    set CUDA_URL=https://download.pytorch.org/whl/cu111/torch_stable.html
) else if "%CUDA_VERSION%"=="12.1" (
    set CUDA_URL=https://download.pytorch.org/whl/cu121/torch_stable.html
) else (
    echo.
    echo [ERROR] Unsupported CUDA version: %CUDA_VERSION%. Exiting.
    exit /b 2
)

:: Install PyTorch and its dependencies
echo.
echo [INFO] Installing PyTorch and dependencies for CUDA %CUDA_VERSION%...
pip install torch torchvision torchaudio -f %CUDA_URL%
if errorlevel 1 (
    echo [ERROR] Failed to install PyTorch. Exiting.
    exit /b 3
)

:: Installing very general dependencies
echo.
echo [INFO] Installing general dependencies...
pip install ipywidgets==8.0.2 jupyterlab==3.4.2 lovely-tensors==0.1.15
if errorlevel 1 (
    echo [ERROR] Failed to install general dependencies. Exiting.
    exit /b 4
)

:: Navigate to Dust3r and install its dependencies
echo.
echo [INFO] Installing Dust3r dependencies...
cd dust3r
pip install -r requirements.txt
pip install -r requirements_optional.txt
if errorlevel 1 (
    echo [ERROR] Failed to install Dust3r dependencies. Exiting.
    exit /b 5
)

:: Compile RoPE positional embeddings
echo.
echo [INFO] Compiling RoPE positional embeddings...
cd croco\models\curope
python setup.py build_ext --inplace
if errorlevel 1 (
    echo [ERROR] Compilation of RoPE positional embeddings failed. Exiting.
    exit /b 6
)
cd ..\..\..

:: Download pre-trained model
echo.
echo [INFO] Downloading pre-trained model...
if not exist checkpoints mkdir checkpoints
curl -o checkpoints\DUSt3R_ViTLarge_BaseDecoder_512_dpt.pth https://download.europe.naverlabs.com/ComputerVision/DUSt3R/DUSt3R_ViTLarge_BaseDecoder_512_dpt.pth
if errorlevel 1 (
    echo [ERROR] Failed to download pre-trained model. Exiting.
    exit /b 7
)
cd ..

:: Setup Gaussian splatting dependencies
echo.
echo [INFO] Setting up Gaussian splatting dependencies...
pip install -r requirements.txt
pip install -e gaussian-splatting\submodules\diff-gaussian-rasterization
pip install -e gaussian-splatting\submodules\simple-knn
if errorlevel 1 (
    echo [ERROR] Failed to setup Gaussian splatting dependencies. Exiting.
    exit /b 8
)

:: Completion message
echo -------------------------------------
echo [SUCCESS] Environment Setup Successful!!
echo -------------------------------------
