# AgroVision Mobile

App móvil de AgroVision, desarrollada en Flutter (Dart) para Android. La versión para iPhone se agregará más adelante.

La app no se publica en tiendas (Google Play ni App Store). Se distribuye directamente desde la web de AgroVision.

> Estado: proyecto en etapa inicial. Por ahora solo tiene la estructura base generada por Flutter.

## Requisitos

- Flutter (canal stable), con `flutter` y `dart` en el PATH.
- Android SDK, con las licencias aceptadas (`flutter doctor --android-licenses`).
- JDK 17.
- Un dispositivo Android con depuración USB activada, o un emulador.

Para verificar el entorno:

```bash
flutter doctor -v
```

## Cómo correr la app

1. Clonar el repositorio:

   ```bash
   git clone https://github.com/marcegon13/agrovision_mobile.git
   cd agrovision_mobile
   ```

2. Instalar las dependencias:

   ```bash
   flutter pub get
   ```

3. Correr la app en un dispositivo o emulador conectado:

   ```bash
   flutter run
   ```

Para ver los dispositivos disponibles, usar `flutter devices`.

## Cómo generar el APK

Para generar el APK de release:

```bash
flutter build apk --release
```

El archivo queda en:

```
build/app/outputs/flutter-apk/app-release.apk
```

Para instalarlo en un teléfono, copiar el archivo al dispositivo y abrirlo. Hay que permitir la instalación desde fuentes desconocidas en el teléfono.

> Nota: por ahora el build de release se firma con la clave de depuración (`signingConfig = signingConfigs.getByName("debug")` en `android/app/build.gradle.kts`). Antes de distribuir el APK públicamente hay que configurar una clave de firma propia. Esa clave y el archivo `key.properties` no se versionan (están en el `.gitignore`).

## Estructura

- `lib/`: código fuente de la app.
- `test/`: pruebas automatizadas.
- `android/`: proyecto nativo de Android.
- `pubspec.yaml`: dependencias y metadatos de la app.

## Pruebas

```bash
flutter test
```

## Identificadores

- Organización: `com.agrovision`
- ID de la aplicación Android: `com.agrovision.agrovision_mobile`
