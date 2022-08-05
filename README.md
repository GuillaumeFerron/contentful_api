<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This package implements a wrapper around the Contentful Content Delivery api.
<https://www.contentful.com/developers/docs/references/content-delivery-api>

## Features

You can use the Contentful class to fetchDocuments by inputing your own queries, or use the wrappers such as fetchDocumentsByType, in which you can specify the ContentType.

## Getting started

`flutter pub add contentful_api`

## Usage

```dart
import Contentful from 'package:contentful_api/contentful_api.dart'
```
