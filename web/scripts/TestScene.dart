import 'dart:html';

import 'Scene.dart';

class TestScene extends Scene{
  @override
  Future<void> makeHtml(DivElement sceneDiv, postSnapshots, preSnapshots) {
    sceneDiv.setInnerHtml("hello");
    return Future.value(null);
  }
}