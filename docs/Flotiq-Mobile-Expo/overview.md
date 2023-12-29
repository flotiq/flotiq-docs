title: Flotiq Mobile Expo app for Content Editors & Developers | Flotiq docs
description: Use the Flotiq Mobile Expo application to browse and manage your content directly from the mobile application

# Flotiq Mobile Expo app for Content Editors & Developers

![Flotiq Mobile Expo application](images/head-image.jpg)


[![Flotiq Mobile Expo on Apple App Store](https://user-images.githubusercontent.com/551004/29770691-a2082ff4-8bc6-11e7-89a6-964cd405ea8e.png)](https://apps.apple.com/app/flotiq-mobile-expo/id1505331246) [![Flotiq Mobile Expo on Google Play](https://user-images.githubusercontent.com/551004/29770692-a20975c6-8bc6-11e7-8ab0-1cde275496e0.png)](https://play.google.com/store/apps/details?id=com.flotiqmobiledemo)


## For Content Editors: Browse and manage your content

The Flotiq Expo app is a React Native application that allows you to browse and manage your content directly from the mobile.

Regardless of what data you store in the Flotiq, the mobile application can provide convenient and quick access to the data.

Main features:

* Login via QR ApiKey Code
* List current Content Type Definitions
* Manage Content Objects
* Search through the Content Objects
* Upload photos directly from your smartphone camera

A ready-to-use application is available on Google Play and Apple App Store. Install the app, use the QR code in your API keys to connect the app to Flotiq and browse through your content.

![](images/mobile-0.png){: .width25 }
![](images/mobile-1.png){: .width25 }
![](images/mobile-2.png){: .width25 }


## For Developers: Boilerplate for your new application


The Flotiq Mobile Expo is an MIT-licensed app, so you can modify it for your needs and use it in the next mobile project.

This project was implemented using:

* Expo
* React Native
* React Navigation
* React Native Elements
* Redux
* Flotiq as the data source


![](images/react-native.png){: .margin20 }
![](images/logo-expo.png){: .margin20 }
![](images/react-native-elements.png){: .margin20 }


### Start your project in 3 simple steps

Thanks to the [Expo.io](https://expo.dev) ecosystem, you can run your application without installing any complex
tools like Android SDK, XCode, or take care of your JDK version.

Follow these three steps to develop Flotiq based application:

1. Install expo
```shell
npm install --global expo-cli
```
{ data-search-exclude }

2. Clone [GitHub](https://github.com/flotiq/flotiq-mobile-demo) project
```shell
git clone https://github.com/flotiq/flotiq-mobile-demo
```
{ data-search-exclude }

3. Start developing
```shell
cd flotiq-mobile-demo/
npm install
npm start
```
{ data-search-exclude }

This will start Metro server [http://localhost:19002](http://localhost:19002/) where you can start the app on Android and iOS simulator or the real device.

![](images/metro.png){: .border}


To run the app on the real device, you have to have the Expo Go app installed ([Android app](https://play.google.com/store/apps/details?id=host.exp.exponent), [iOS app](https://apps.apple.com/us/app/expo-go/id982107779)).

When you open the Expo Go app, you have to scan the QR code presented on the [http://localhost:19002](http://localhost:19002/) page.

!!! note
    For more development tips, check the projects [GitHub repository](https://github.com/flotiq/flotiq-mobile-demo).

### Create your own products showcase mobile app

Check out our [simple guide](/docs/Deep-Dives/mobile-expo-product-showcase/) on how to adapt the Flotiq Mobile Expo application source code
to work as a product showcase app.

