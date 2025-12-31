# 🚀 Gestor de Tareas - Reto Técnico Flutter

[![Flutter](https://img.shields.io/badge/Flutter-3.9+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9+-blue.svg)](https://dart.dev)

**Aplicación completa de gestión de tareas con Clean Architecture, demostrando las mejores prácticas de desarrollo Flutter.**

---

## ⚡ INICIO RÁPIDO

### Windows:
```bash
run.bat
```

### Linux/Mac:
```bash
chmod +x run.sh
./run.sh
```

### Manual:
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## ✅ REQUERIMIENTOS CUMPLIDOS

- [x] **Flutter** para Mobile/Desktop
- [x] **go_router** con 3 rutas + Deep Links (`/task/:id`)
- [x] **flutter_riverpod** con code generation
- [x] **drift** (SQLite) con migraciones v1→v2
- [x] **UI Responsive** (móvil y escritorio)
- [x] **CRUD completo** de tareas
- [x] **Clean Architecture** (data/domain/presentation)

---

## 📱 CARACTERÍSTICAS

✅ Crear, editar, eliminar y marcar tareas como completadas  
✅ Persistencia local con SQLite (Drift)  
✅ Deep Links: `/task/1` abre directamente una tarea  
✅ Diseño adaptable a móvil (ListView) y escritorio (GridView)  
✅ Gestión de estado reactiva con Riverpod  
✅ Migraciones de base de datos (v1→v2: agregado campo `createdAt`)  

---

## 📁 ESTRUCTURA

```
lib/
├── core/
│   ├── database/app_database.dart     # Drift + Migraciones
│   ├── router/app_router.dart         # GoRouter + Deep Links
│   └── theme/app_theme.dart           # Tema responsive
├── features/tasks/
│   ├── data/repositories/             # Implementación
│   ├── domain/
│   │   ├── entities/                  # Entidades
│   │   └── repositories/              # Interfaces
│   └── presentation/
│       ├── pages/                     # 3 rutas
│       ├── providers/                 # Riverpod
│       └── widgets/                   # UI components
└── main.dart
```

---

## 🎯 RUTAS

| Ruta | Path | Deep Link | Descripción |
|------|------|-----------|-------------|
| Home | `/` | No | Lista de tareas |
| Formulario | `/task-form` | No | Crear/editar |
| Detalle | `/task/:id` | ✅ Sí | Vista detalle |

**Ejemplo de Deep Link:** `http://localhost:XXXX/#/task/1`

---

## 🏗️ ARQUITECTURA

**Clean Architecture en 3 capas:**
- **Presentation**: UI + Providers
- **Domain**: Entidades + Interfaces
- **Data**: Implementación + BD

**Ventajas:**
- Fácil de testear
- Independiente de frameworks
- Escalable para equipos grandes

---

## 📚 DOCUMENTACIÓN

- **[DOCUMENTATION.md](DOCUMENTATION.md)**: Documentación técnica completa
- **[VIDEO_GUIDE.md](VIDEO_GUIDE.md)**: Script para video de presentación
- **[PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)**: Resumen ejecutivo

---

## 🎓 TECNOLOGÍAS

- Flutter 3.9+
- go_router ^14.7.1
- flutter_riverpod ^2.6.1
- riverpod_annotation ^2.6.1 (code generation)
- drift ^2.22.0 (SQLite)
- Material Design 3

---

## 📱 DEMO

1. **Crear tareas**: Botón flotante "Nueva Tarea"
2. **Editar**: Click en botón editar de cualquier tarea
3. **Completar**: Checkbox en cada tarea
4. **Ver detalle**: Click en una tarea
5. **Deep Link**: Copiar link desde detalle y pegar en navegador

---

## 🔄 MIGRACIÓN DE BASE DE DATOS

**Versión 1 → Versión 2:**
```dart
// Se agregó campo createdAt
if (from == 1) {
  await m.addColumn(tasks, tasks.createdAt);
}
```

---

## 💡 DECISIONES DE DISEÑO

**Riverpod:** Type-safety + code generation  
**Drift:** Queries SQL verificadas en compile-time  
**GoRouter:** Deep Links nativos sin config compleja  
**Clean Architecture:** Facilita testing y escalabilidad  

---

## 🎬 PARA LA ENTREVISTA

Revisar **VIDEO_GUIDE.md** con script detallado para presentación

---

**Desarrollado como demostración de habilidades en Flutter y Clean Architecture**

**¡Éxito en tu entrevista! 🚀**
