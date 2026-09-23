@echo off
setlocal

cd /d "%~dp0"

set "AWS_PROFILE=sci02304-park-sandbox"

echo.
echo [1/6] Checking AWS login...
aws sts get-caller-identity --profile "%AWS_PROFILE%" >nul 2>&1

if errorlevel 1 (
echo AWS login is required. (aws sso login)
aws sso login --profile "%AWS_PROFILE%"

if errorlevel 1 goto :failed
)

echo.
echo [2/6] Confirming AWS account... (aws sts get-caller-identity)
aws sts get-caller-identity --profile "%AWS_PROFILE%"

if errorlevel 1 goto :failed

echo.
echo [3/6] Initializing Terraform... (terraform init)
terraform init -input=false

if errorlevel 1 goto :failed

echo.
echo [4/6] Formatting Terraform... (terraform fmt)
terraform fmt
if errorlevel 1 goto :failed

echo.
echo [5/6] Validating Terraform... (terraform validate)
terraform validate
if errorlevel 1 goto :failed

echo.
echo [6/6] Creating Terraform plan... (terraform plan)
terraform plan

if errorlevel 1 goto :failed

echo.
echo Completed successfully.
echo Review the plan, then run: terraform apply
exit /b 0

:failed
echo.
echo Failed. Fix the error above before applying changes.
exit /b 1
