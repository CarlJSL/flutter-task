@echo off
REM Script para ejecutar el proyecto en Windows

echo 🚀 Gestor de Tareas - Flutter App
echo ==================================
echo.

REM Verificar dependencias
echo 📦 Instalando dependencias...
call flutter pub get

REM Generar código
echo.
echo 🔧 Generando código (Drift y Riverpod)...
call dart run build_runner build --delete-conflicting-outputs

REM Ejecutar app
echo.
echo ✅ Listo! Ejecutando aplicación...
echo.
call flutter run
