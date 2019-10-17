import 'dart:html';

import 'Scene.dart';

class ShipBreaks extends Scene{
  static const sceneID = "ship_breaks";
  static const longName = "Catastrophic Failure";

  @override
  Future<void> makeHtml(DivElement sceneDiv, postSnapshots, preSnapshots) {
    String show =
    '''Broken life support, a busted engine, a crack in the hull, so many things can break
    As the ship falls out of warp space, the stress of warpjumping cracks some critical component
    The crew has failed, and all that left is an empty derelict, floating listlessly, lost in space forever''';
    sceneDiv.setInnerHtml(show);
    return Future.value(null);
  }

  @override
  Future doNext(world, worldList, container, debug, manual) {
    return Future.value(worldList);
  }
}