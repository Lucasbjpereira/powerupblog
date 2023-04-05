# 👨‍💻 Power Up Blog App

>*Read this in other languages: [Pt-BR](README.md), [English](README.en.md) and [Spanish](README.es.md).*

This is a Flutter app that aims to list the blog posts [Power Up](https://powerupblog3.wordpress.com/) coming from the WordPress API. The app has two main screens: the home screen (**HomePage**) 🏠 and the details screen of a specific post (**PostPage**) 📄.

For communication with the API, the package [`http`](https://pub.dev/packages/http) 🌐 is used. In addition, to display the images of cached posts, thus avoiding the delay in displaying them, the package [`cached_network_image`](https://pub.dev/packages/cached_network_image) 📸 is used. The [`shimmer`](https://pub.dev/packages/shimmer) ✨ package is used to display a loading effect (also known as "**Skeleton**") while data is being loaded.

The **HomePage** class is a StatefulWidget that represents the application's home screen. On this screen, a list of blogs is displayed, each item represented by a `Card`. At the end of the list, a loading effect (using `shimmer`) is displayed while new blogs are loaded. The user can update the list of blogs through the "pull down" gesture.

The `fetchBlogs` method is responsible for fetching data from the API and updating the list of blogs displayed on the screen. Each time the user reaches the end of the list, a new request is made to fetch more blogs (if any).

Finally, the detail screen of a specific blog is displayed through the `PostPage` class. On this screen, the **title** and **content** of the selected blog are displayed. In addition, additional information is displayed, such as **author's name** and **publication date**. The main blog image is displayed in a [`Hero widget`](https://docs.flutter.dev/development/ui/animations/hero-animations), allowing for smooth animation between screen transitions. 🚀

## How to generate the project's APK or .IPA

#### Prerequisites 🔧

Before you begin, make sure the following tools are installed on your machine:

- 🚀 [Flutter SDK](https://flutter.dev/docs/get-started/install)
- 📱 [Android Studio](https://developer.android.com/studio) (to generate an APK file)
- 🍎 [Xcode](https://developer.apple.com/xcode/) (to generate an IPA file)

#### Generating an APK file 📦

>If you want to download the apk directly, go to [Release](https://github.com/Lucasbjpereira/powerupblog/releases/tag/release) to download it.

To generate an APK file from an existing Flutter project, follow these steps:

1. Open the terminal and navigate to the Flutter project directory using the `cd /path/to/project` command.

2. Run the command `flutter build apk --`. This will build the app and generate an APK file in the `build/app/outputs/flutter-apk/app-release.apk` project directory. (If it doesn't work, make sure all Flutter dependencies have been installed. To check, run `flutter doctor` in the terminal).

3. Connect an Android device to the computer using a USB cable.

4. Run the `flutter devices` command to list the connected Android devices.

5. Identify the Android Device ID you want to use to run the app.

6. Run the command `flutter run -d <device-id>` to install and run the app on the connected Android device.

#### Generating an IPA file 📦
>If you want to download the .ipa directly, go to [Release](https://github.com/Lucasbjpereira/powerupblog/releases/tag/release) to download it.

>**Note:** Since the app is not yet on the App Store, for the .ipa to be installed via download on external sites, the .ipa needs to be uploaded on _Development & In-house_ sites such as [Diawi]( https://www.diawi.com/) for example.

To generate an IPA file from an existing Flutter project, follow these steps:

1. Open the terminal and navigate to the Flutter project directory using the `cd /path/to/project` command.

2. Run the `flutter build ios` command. This will build the app and generate an IPA file in the `build/ios/archive` directory (If it doesn't work, make sure all Flutter dependencies are installed. To check, run `flutter doctor` in the terminal).
_Note: Make sure you have the developer account activated in xcode_.

3. Connect an iOS device to the computer using a USB cable.

4. Run the `flutter devices` command to list the connected Android devices.

5. Identify the Android Device ID you want to use to run the app.

6. Run the command `flutter run -d <device-id>` to install and run the app on the connected Android device.

If you have any questions or suggestions, feel free to create an _issue_ or submit a _pull request_.

If you liked this project, please leave a ⭐️ to support it.

Thanks again for your interest and hope to see you soon! 👋

>_Created during the selection process of [_ModalGR_](https://modalgr.com.br/)_

<br><br>
_Made with :heart: by Lucas Pereira_