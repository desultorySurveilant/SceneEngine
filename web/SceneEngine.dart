import 'dart:html';
import 'dart:math';

import 'scripts/Scene.dart';
import 'scripts/TestScene.dart';

void main() {
  var paramSearcher = UrlSearchParams(window.location.search);
  bool debug = paramSearcher.has("debug");
  bool manual = paramSearcher.has("manual");
  Element output = querySelector('#output');
  Scene start = TestScene();
  start([world()], container: output, debug:debug, manual: manual);
}
class world{//all worlds _must_ have a random
  Random random = Random();
  toString() => "A world";
}