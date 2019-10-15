import 'dart:html';
import 'dart:math';

import 'scripts/Scene.dart';
import 'scripts/TestScene.dart';

void main() {
  Element output = querySelector('#output');
  Scene start = TestScene();
  start([world()], container: output, debug: true);
}
class world{//all worlds _must_ have a random
  Random random = Random();
}