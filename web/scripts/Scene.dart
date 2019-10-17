import 'dart:async';
import 'dart:html';

import 'ReturnScene.dart';
import 'ShipBreaks.dart';
import 'StartScene.dart';
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
    } else if(ID == "return_scene"){
      return ReturnScene();
    } else if(ID == "start"){
      return StartScene();
    } else if(ID == "ship_breaks"){
      return ShipBreaks();
    }
    throw "Tried to make nonexistant Scene $ID";
  }

  String nameFromID(String ID) {
    if(ID == "test_scene"){
      return TestScene.longName;
    }else if(ID == "return_scene"){
      return ReturnScene.longName;
    }else if(ID == "start"){
      return StartScene.longName;
    }else if(ID == "ship_breaks"){
      return ShipBreaks.longName;
    }
    throw "Tried to get the name of nonexistent Scene $ID";
  }

  Future<String> handleButtons(List<String> sceneList, DivElement container){

    List<ButtonElement> buttonList = List.from(sceneList.map(
            (String sceneID) =>
              ButtonElement()
                ..text = nameFromID(sceneID)
                ..setAttribute("data-scene", sceneID)
        )
    );//make a button for each scene in list
    buttonList.forEach((ButtonElement button){
      container.append(button);
    });//append all of the buttons
    List<Future<MouseEvent>> buttonFutures = List.from(
        buttonList.map((ButtonElement b) => b.onClick.first)
    );
    //get the futures of the first clicks of each of the buttons
    Future<MouseEvent> firstClick = Future.any(buttonFutures);
    //get the first button clicked
    return firstClick.then((e) =>
      (e.target as ButtonElement).getAttribute("data-scene")
    );//execute the scene assigned to the first button pressed
  }

  Future doNext(world, worldList, container, debug, manual){
    WeighList<String> possibleSceneList = getPossibleSceneList(world);
    String newScene = possibleSceneList.pickRandom(world.random);
    if(debug || manual){//this section lets it advance one at a time
      List<String> buttonSceneList = List<String>();
      if(debug){
        container.appendText(worldList.toString());
        buttonSceneList.add(newScene);
      }//in debug mode it shows the worldstate and lets you advance one scene at a time
      if(manual){
        buttonSceneList.addAll(possibleSceneList.items);
      }//in manual mode it lets you pick which scene's next //query can this preserve randomness?
      Future<String> futureScene = handleButtons(buttonSceneList, container);
      //handles messing with the buttons
      return futureScene.then((s)=>//continuing after stuff
          Scene.fromID(s)(worldList, container: container, debug: debug, manual: manual)
      );
    }//if it's automatic, just go right on agead
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