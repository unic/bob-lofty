@echo off
@powershell -NoProfile -ExecutionPolicy Bypass -Command ""Start-Process PowerShell.exe -ArgumentList '-ExecutionPolicy Bypass -NoProfile -Command ""%~dp0\install.ps1"""' -Verb RunAs"
