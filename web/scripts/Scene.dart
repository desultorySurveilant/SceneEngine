import 'dart:html';

class Scene{
  Future<List> call(List worldList, [DivElement container]) {
    var world = worldList.last;
    checkInvalid(world);
    final bool render = (container != null);
    if(render){
      Map preSnapshots = makePreSnapshots(world);
      changeWorld(world);
      Map postSnapshots = makePostSnapshots(world);
      DivElement sceneDiv = DivElement();
      container.append(sceneDiv);
      makeHtml(sceneDiv, postSnapshots, preSnapshots);
    }else{
      changeWorld(world);
    }
    var newScene = getNextScene(world);
    if(newScene == null){
      return Future.value(world);
    }
    return newScene(world, container);
  }

  bool checkInvalid(world) {
    return false;
  }

  void changeWorld(world) {
    return null;
  }

  Scene getNextScene(world) {
    return null;
  }

  Future<void> makeHtml(DivElement sceneDiv, postSnapshots, preSnapshots) {
    return Future.value(null);
  }

  Map makePostSnapshots(world) {
    return Map();
  }

  Map makePreSnapshots(world) {
    return Map();
  }
}