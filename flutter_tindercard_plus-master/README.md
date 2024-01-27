# flutter_tindercard_plus

[![Pub](https://img.shields.io/pub/v/flutter_tindercard_plus.svg?color=%233CB371)](https://pub.dartlang.org/packages/flutter_tindercard_plus)
[![Closed](https://img.shields.io/github/issues-closed-raw/tonini46/flutter_tindercard_plus.svg?color=%23FF69B4)](https://github.com/tonini46/flutter_tindercard_plus/issues?q=is%3Aissue+is%3Aclosed)

Tinder Card Widget.

## Screenshots

![screenshot](./assets/example_tindercard.gif)

## Getting Started

1. Depend on it by adding this to your pubspec.yaml file: ```flutter_tindercard_plus: ^x.x.x```

2. Import it: ```import 'package:flutter_tindercard_plus.dart'```

3. Add TinderSwapCard in your widget layout and write the single card layout builder you need, then you get a Tinder like swap card widget!

4. Use `CardSwipeCompleteCallback` for the swiped orientation and index!

5. Use `CardController` to trigger swap from outside. Init a CardController as param for widget, and invoke method `triggerLeft/Right` of your `CardController` to trigger swipe!

6. Use `CardDragUpdateCallback` to get swiping card's detail.

## Example
[See Here](./example/lib)

