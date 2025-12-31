#!/bin/bash

# Script para ejecutar el proyecto

echo "🚀 Gestor de Tareas - Flutter App"
echo "=================================="
echo ""

# Verificar dependencias
echo "📦 Instalando dependencias..."
flutter pub get

# Generar código
echo ""
echo "🔧 Generando código (Drift y Riverpod)..."
dart run build_runner build --delete-conflicting-outputs

# Ejecutar app
echo ""
echo "✅ Listo! Ejecutando aplicación..."
echo ""
flutter run
