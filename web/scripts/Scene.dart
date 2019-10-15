import 'dart:async';
import 'dart:html';

import 'TestScene.dart';
import 'WeighList.dart';

class Scene{
  Future call(List worldList, {DivElement container, bool debug = false, bool manual = false}) {
    try{
      var world = worldList.last;
      final bool render = (container != null);
      if((debug || manual) && !render){
        throw "Manual and Debug mode must have containers!";
      }
      if(render){
        final Map preSnapshots = makePreSnapshots(world);
        changeWorld(world);
        final Map postSnapshots = makePostSnapshots(world);
        DivElement sceneDiv = DivElement();
        container.append(sceneDiv);
        makeHtml(sceneDiv, postSnapshots, preSnapshots);
      }else{
        changeWorld(world);
      }
      WeighList possibleSceneList = getPossibleSceneList(world);
      if(debug || manual){
        Future<Scene> futureScene = handleButtons(possibleSceneList.items, container);
        return futureScene.then((s)=>s(world, container: container, debug: debug, manual: manual));
      }
      Scene newScene = Scene.fromID(possibleSceneList.pickRandom(world.random));
      return newScene(world, container: container, debug: debug, manual: manual);
    }catch(e){
      print(worldList);
      print(this.getSceneID());
      rethrow;
    }
  }

  Scene();
  factory Scene.fromID(String ID){
    if(ID == "test_scene"){
      return TestScene();
    }
    throw "Tried to make nonexistant Scene $ID";
  }

  String nameFromID(String ID) {
    if(ID == "test_scene"){
      return TestScene.longName;
    }
  }

  Future<Scene> handleButtons(List<String> sceneList, DivElement container){
    List<ButtonElement> buttonList = sceneList.map((String sceneID){
      return ButtonElement()
        ..text = nameFromID(sceneID)
        ..setAttribute("data-scene", sceneID);
    });//make a button for each scene in list
    buttonList.forEach((ButtonElement button){
      container.append(button);
    });//append all of the buttons
    List<Future<MouseEvent>> buttonFutures = buttonList.map((ButtonElement b) => b.onClick.first);
    //get the futures of the first clicks of each of the buttons
    Future<MouseEvent> firstClick = Future.any(buttonFutures);
    //get the first button clicked
    return firstClick.then((e){
      Scene.fromID((e.target as ButtonElement).getAttribute("data-scene"));
    });//execute the scene assigned to the first button pressed
  }


  static const String sceneID = "default_scene";
  String getSceneID() => sceneID;

  static const String longName = "THIS SHOULD NEVER BE SEEN";

  void changeWorld(world) {
    return null;
  }

  WeighList getPossibleSceneList(world) {
    return WeighList();
  }

  Scene decideScene(){
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