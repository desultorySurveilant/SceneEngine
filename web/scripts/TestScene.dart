import 'dart:html';

import 'Scene.dart';
import 'WeighList.dart';

class TestScene extends Scene{

  static const sceneID = "test_scene";

  static const longName = "Test Scene";

  @override
  Future<void> makeHtml(DivElement sceneDiv, postSnapshots, preSnapshots) {
    sceneDiv.setInnerHtml("hello");
    return Future.value(null);
  }
  @override
  WeighList getPossibleSceneList(world){
    WeighList<String> wl = WeighList();
    wl.add("test_scene", 5);
    wl.add("return_scene", 1);
    return wl;
  }
}