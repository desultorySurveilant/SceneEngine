import 'dart:html';
import 'dart:math';

import 'Scene.dart';
import 'StartScene.dart';

void main() {
  var paramSearcher = UrlSearchParams(window.location.search);
  bool debug = paramSearcher.has("debug");
  bool manual = paramSearcher.has("manual");
  Element output = querySelector('#output');
  Scene start = StartScene();
  start([World.rand()], container: output, debug:debug, manual: manual);
}
class World{//all worlds _must_ have a random
  final int seed;
  final Random random;
  String toEncounter;
  World(this.seed):
        random = Random(seed);
  World.rand(): this(Random().nextInt(2^16));
  toString() =>
      '''Seed: $seed
      toEncounter: $toEncounter''';
}