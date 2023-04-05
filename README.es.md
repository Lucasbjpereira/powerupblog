# 👨‍💻 Activa la aplicación de blogs

>*Read this in other languages: [Pt-BR](README.md), [English](README.en.md) and [Spanish](README.es.md).*

Esta es una aplicación de Flutter que tiene como objetivo enumerar las publicaciones de blog [Power Up] (https://powerupblog3.wordpress.com/) provenientes de la API de WordPress. La aplicación tiene dos pantallas principales: la pantalla de inicio (**HomePage**) 🏠 y la pantalla de detalles de una publicación específica (**PostPage**) 📄.

Para la comunicación con la API se utiliza el paquete [`http`](https://pub.dev/packages/http) 🌐. Además, para mostrar las imágenes de las publicaciones en caché, evitando así la demora en mostrarlas, se utiliza el paquete [`cached_network_image`](https://pub.dev/packages/cached_network_image) 📸. El paquete [`shimmer`](https://pub.dev/packages/shimmer) ✨ se usa para mostrar un efecto de carga (también conocido como "**Skeleton**") mientras se cargan los datos.

La clase **HomePage** es un StatefulWidget que representa la pantalla de inicio de la aplicación. En esta pantalla, se muestra una lista de blogs, cada elemento representado por una 'Tarjeta'. Al final de la lista, se muestra un efecto de carga (usando `shimmer`) mientras se cargan nuevos blogs. El usuario puede actualizar la lista de blogs mediante el gesto de "desplegar".

El método `fetchBlogs` es responsable de obtener datos de la API y actualizar la lista de blogs que se muestran en la pantalla. Cada vez que el usuario llega al final de la lista, se realiza una nueva solicitud para buscar más blogs (si los hay).

Finalmente, la pantalla de detalles de un blog específico se muestra a través de la clase `PostPage`. En esta pantalla se muestran el **título** y el **contenido** del blog seleccionado. Además, se muestra información adicional, como **nombre del autor** y **fecha de publicación**. La imagen principal del blog se muestra en un [`Hero widget`](https://docs.flutter.dev/development/ui/animations/hero-animations), lo que permite una animación fluida entre las transiciones de pantalla. 🚀

## Cómo generar el APK o .IPA del proyecto

#### Requisitos previos 🔧

Antes de comenzar, asegúrese de que las siguientes herramientas estén instaladas en su máquina:

- 🚀 [SDK de Flutter](https://flutter.dev/docs/get-started/install)
- 📱 [Android Studio](https://developer.android.com/studio) (para generar un archivo APK)
- 🍎 [Xcode](https://developer.apple.com/xcode/) (para generar un archivo IPA)

#### Generando un archivo APK 📦

Para generar un archivo APK a partir de un proyecto Flutter existente, siga estos pasos:

1. Abra la terminal y navegue hasta el directorio del proyecto Flutter usando el comando `cd /path/to/project`.

2. Ejecute el comando `flutter build apk --`. Esto compilará la aplicación y generará un archivo APK en el directorio del proyecto `build/app/outputs/flutter-apk/app-release.apk`. (Si no funciona, asegúrese de que se hayan instalado todas las dependencias de Flutter. Para verificar, ejecute `flutter doctor` en la terminal).

3. Conecte un dispositivo Android a la computadora usando un cable USB.

4. Ejecute el comando `flutter devices` para enumerar los dispositivos Android conectados.

5. Identifique la identificación del dispositivo Android que desea usar para ejecutar la aplicación.

6. Ejecute el comando `flutter run -d <device-id>` para instalar y ejecutar la aplicación en el dispositivo Android conectado.

#### Generando un archivo IPA 📦

Para generar un archivo IPA a partir de un proyecto Flutter existente, siga estos pasos:

1. Abra la terminal y navegue hasta el directorio del proyecto Flutter usando el comando `cd /path/to/project`.

2. Ejecute el comando `flutter build ios`. Esto compilará la aplicación y generará un archivo IPA en el directorio `build/ios/archive`.

3. Abra el archivo `.xcworkspace` que se generó en el paso anterior en Xcode.

4. Conecte un dispositivo iOS a la computadora usando un cable USB.

5. En Xcode, seleccione el dispositivo iOS conectado como destino de lanzamiento.

6. Haga clic en el botón "Ejecutar" para instalar y ejecutar la aplicación en el dispositivo iOS.

Si tiene alguna pregunta o sugerencia, no dude en crear un _problema_ o enviar una _solicitud de extracción_.

Si te gustó este proyecto, deja un ⭐️ para apoyarlo.

¡Gracias de nuevo por su interés y esperamos verle pronto! 👋

<br><br>

>_Hecho con :corazón: por Lucas Pereira_