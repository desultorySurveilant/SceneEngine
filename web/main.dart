import 'dart:html';

import 'scripts/Scene.dart';
import 'scripts/TestScene.dart';

void main() {
  Element output = querySelector('#output');
  Scene start = TestScene();
  start([null], output);
}
