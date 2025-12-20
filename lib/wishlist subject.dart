// import 'package:architecture_project/events_model.dart';
// import 'package:architecture_project/observer.dart';
//
// class WishlistSubject{
//   List <Events> _wishlistEvents=[];
//   List <Observer> ObserversList =[];
//   void addObservers(Observer observer){
//     ObserversList.add(observer);
//   }
//   void removeObserver(Observer observer){
//     ObserversList.remove(observer);
//   }
//   void notifyObservers(){
//     for(var observer in ObserversList){
//       observer.update();
//     }
//   }
//   void addEvent(Events e){
//     if(!_wishlistEvents.contains(e)){
//       _wishlistEvents.add(e);
//
//     }
//   }
//   void removeEvent(Events e){
//     if(_wishlistEvents.remove(e)){
//       notifyObservers();
//     }
//   }
//   List<Events> get wishlistEvents {
//     return _wishlistEvents;
//   }
//   bool isInWishlist(Events event) {
//     return _wishlistEvents.contains(event);
//   }
// }





import 'events_model.dart';
import 'observer.dart';

class WishlistSubject {
  // Singleton — only one instance
  static final WishlistSubject _instance = WishlistSubject._internal();
  factory WishlistSubject() => _instance;
  WishlistSubject._internal();

  List<Events> _wishlistEvents = [];
  List<Observer> ObserversList = [];

  void addObservers(Observer observer) {
    ObserversList.add(observer);
  }

  void removeObserver(Observer observer) {
    ObserversList.remove(observer);
  }

  void notifyObservers() {
    for (var observer in ObserversList) {
      observer.update();
    }
  }

  void addEvent(Events e) {
    if (!_wishlistEvents.contains(e)) {
      _wishlistEvents.add(e);
      notifyObservers();
    }
  }

  void removeEvent(Events e) {
    if (_wishlistEvents.remove(e)) {
      notifyObservers();
    }
  }

  List<Events> get wishlistEvents {
    return _wishlistEvents;
  }

  bool isInWishlist(Events event) {
    return _wishlistEvents.contains(event);
  }
}