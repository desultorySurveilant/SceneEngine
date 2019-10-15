import 'dart:html';

import 'Scene.dart';

class TestScene extends Scene{

  static const sceneID = "test_scene";

  static const longName = "Test Scene";

  @override
  Future<void> makeHtml(DivElement sceneDiv, postSnapshots, preSnapshots) {
    sceneDiv.setInnerHtml("hello");
    return Future.value(null);
  }
}