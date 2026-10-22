# CLAUDE.md: AgroVision Mobile

App móvil de AgroVision en Flutter (Dart). Se distribuye como APK desde la web de AgroVision, no por tiendas.

## Alcance

- Solo Android por ahora. No agregar ni tocar plataformas iOS hasta que el dueño del proyecto lo confirme.
- Código nuevo desde cero. No copiar código de versiones anteriores de la app, de otros proyectos de AgroVision ni de plantillas externas sin revisarlo.

## Tema visual

- Hay un único tema en `lib/core/theme`.
- Colores, tipografía y espaciados salen solo de ese módulo. No usar colores, tamaños de fuente ni espaciados literales en pantallas o widgets.

## Git

- No hacer commit ni push sin aprobación explícita del dueño del proyecto, en cada caso.
- No cambiar el remoto `origin` sin preguntar.

## Dependencias

- No instalar dependencias nuevas sin mencionarlas en la entrega.

## Verificación antes de entregar

- `flutter analyze` sin errores.
- `flutter test` en verde.
- Si el cambio afecta la interfaz, correr la app en Android y mostrar la pantalla afectada.
- Si analyze o test fallan, no seguir: explicar la causa y esperar instrucciones.
