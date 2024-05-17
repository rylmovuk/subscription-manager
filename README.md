# Subscriptions Manager

## How to build

### Dependencies

* [Flutter](https://flutter.dev/) (*stable*)
  Refer to Flutter documentation for installation.
  
  E.g. to install on Arch Linux from the AUR (assuming `yay` for your AUR helper):
  ```sh
  yay -S flutter
  ```

* For testing **web** version:  Any static server
  Probably the quickest way is to use the PHP server (all non `*.php` files are served as-is).

  E.g. on Arch Linux:
  ```sh
  sudo pacman -S php
  ```

* For testing **Android** version:  [Android SDK](https://developer.android.com/)
  Refer to Android documentation for installation.
  
  E.g. to install on Arch Linux from the AUR (assuming `yay` for your AUR helper):
  ```sh
  yay -S android-sdk android-sdk-platform-tools android-sdk-cmdline-tools-latest
  ```

### Option 1: Use FlutterFlow

The project was developed using [FlutterFlow](https://flutterflow.io/), a powerful web-based IDE.

[Link to the FlutterFlow project]

Unfortunately, access on FlutterFlow is granted on a per-account basis, and there is no way to
import an existing repo (e.g. if you fork this one), so *you will have to request access*.

### Option 2: Run locally

1. Build the app

```sh
flutter build web    # to build the web version
```

2. To test the app, start a server in the build output directory

```sh
cd build/web
php -S localhost:31337
firefox http://localhost:31337/
```

Use the browser dev tools (F12) to view the page as if on mobile (Unfortunately it is only optimized for small screens now!)

3. You can also do an Android build with:
```sh
flutter build apk
```
