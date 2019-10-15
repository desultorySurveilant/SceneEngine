import 'dart:html';

import 'Scene.dart';

class ReturnScene extends Scene{

  static const sceneID = "return_scene";

  static const longName = "Return Scene";

  @override
  Future<void> makeHtml(DivElement sceneDiv, postSnapshots, preSnapshots) {
    sceneDiv.setInnerHtml("ending now");
    return Future.value(null);
  }
  @override
  Future doNext(world, worldList, container, debug, manual) {
    return Future.value(null);
  }
}