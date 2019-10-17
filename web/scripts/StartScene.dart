import 'dart:html';

import 'Scene.dart';
import 'WeighList.dart';

class StartScene extends Scene{

  static const sceneID = "start";

  static const longName = "Begin Adventure";

  @override
  Future<void> makeHtml(DivElement sceneDiv, postSnapshots, preSnapshots) {
    String show =
    '''A small scouting vessel was pushing the boundries of the known star chart when they detected a mysterious anomaly confounding all of their sensors
    They moved closer to investigate, but as they approached, disaster struck
    A burst of uncontrolled WARP ENERGY washed over their ship
    Without the chance to engage warp-navigation engine, the ship was sent hopelessly tumbilng through WARP SPACE
    An emergency uncontrolled warp dephasing has left the ship greatly damaged and lost in uncharted space
    While some heroic repairs have restored life support and rendered the ship warp-capable, it's only a matter of time before some critical component breaks and the entire ship and all it's crew are lost
    Will they be able to chart a course back to known space, or will they fail, lost and forgotten in the vast void of Space?''';
    sceneDiv.setInnerHtml(show);
    return Future.value(null);
  }
  @override
  WeighList getPossibleSceneList(world){
    WeighList<String> wl = WeighList();
    wl.add("ship_breaks", 5);
    return wl;
  }
}
