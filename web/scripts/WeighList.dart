import 'dart:math';

class WeighList<T>{
  List<T> items = [];
  List<int> weights = [];

  T pickRandom(Random rand){
    int totalWeight = weights.reduce((int a, int b) => a+b);
    int targetItemDistance = rand.nextInt(totalWeight);
    return items[weights.indexWhere((int weight){
      targetItemDistance -= weight;
      return targetItemDistance < 0;
    })];
  }

  void add(T a, int b){
    items.add(a);
    weights.add(b);
  }

  void remove(T a){
    int index = items.indexOf(a);
    items.removeAt(index);
    weights.removeAt(index);
  }
}