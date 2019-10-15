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
      return doNext(world, worldList, container, debug, manual);
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
    throw "Tried to get the name of nonexistent Scene $ID";
  }

  Future<String> handleButtons(List<String> sceneList, DivElement container){

    List<ButtonElement> buttonList = List.from(sceneList.map((String sceneID){
      return ButtonElement()
        ..text = nameFromID(sceneID)
        ..setAttribute("data-scene", sceneID);
    }));//make a button for each scene in list
    buttonList.forEach((ButtonElement button){
      container.append(button);
    });//append all of the buttons
    List<Future<MouseEvent>> buttonFutures = List.from(
        buttonList.map((ButtonElement b) => b.onClick.first)
    );
    //get the futures of the first clicks of each of the buttons
    Future<MouseEvent> firstClick = Future.any(buttonFutures);
    //get the first button clicked
    return firstClick.then((e)=>
      (e.target as ButtonElement).getAttribute("data-scene")
    );//execute the scene assigned to the first button pressed
  }

  Future doNext(world, worldList, container, debug, manual){
    WeighList<String> possibleSceneList = getPossibleSceneList(world);
    String newScene = possibleSceneList.pickRandom(world.random);
    if(debug || manual){
      List<String> buttonSceneList = List<String>();
      if(debug){
        buttonSceneList.add(newScene);
      }
      if(manual){
        buttonSceneList.addAll(possibleSceneList.items);
      }
      Future<String> futureScene = handleButtons(buttonSceneList, container);
      return futureScene.then((s)=>
          Scene.fromID(s)(worldList, container: container, debug: debug, manual: manual)
      );
    }
    return Scene.fromID(newScene)(worldList, container: container, debug: debug, manual: manual);
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