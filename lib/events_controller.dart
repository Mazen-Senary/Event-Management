import 'events_model.dart';

class EventController {
  final List<Events> events = [
    Events(eventid: '1',
        eventTitle: 'food festival',
        category: 'Music',
        location: 'cairo'
        ,
        date: DateTime(2026, 1, 1,)
        ,
        price: 800,
      numberofSeats: 100,
    ),

    Events(eventid: '2',
        eventTitle: 'MACBETH Show',
        category: 'Arts & Culture',
        location: 'alexandria',
        date: DateTime(2025, 1, 21)
        ,
        price: 250,
      numberofSeats: 200,
    ),
    Events(eventid: '3',
        eventTitle: 'Movie night',
        category: 'Entertainment',
        location: 'alexandria',
        date: DateTime(2025, 12, 31),
        price: 50,
      numberofSeats: 70,
    ),
    Events(
      eventid: '4',
      eventTitle: 'Jazz Night',
      category: 'Music',
      location: 'Cairo',
      date: DateTime(2025, 11, 15),
      price: 300, numberofSeats: 60,
    ),

    Events(
      eventid: '5',
      eventTitle: 'Pyramids Sound & Light Show',
      category: 'Arts & Culture',
      location: 'Giza',
      date: DateTime(2025, 10, 10),
      price: 400,
      numberofSeats: 1000,
    ),

    Events(
      eventid: '6',
      eventTitle: 'Nile Boat Party',
      category: 'Entertainment',
      location: 'Cairo',
      date: DateTime(2026, 2, 20),
      price: 600,
      numberofSeats: 25,
    ),

    Events(
      eventid: '7',
      eventTitle: 'Luxor Temple Guided Tour',
      category: 'Tourism',
      location: 'Luxor',
      date: DateTime(2025, 9, 5),
      price: 150,
      numberofSeats: 20,
    ),

    Events(
      eventid: '8',
      eventTitle: 'Stand-up Comedy Night',
      category: 'Comedy',
      location: 'Alexandria',
      date: DateTime(2025, 8, 18),
      price: 120,
      numberofSeats: 50,
    ),

    Events(
      eventid: '9',
      eventTitle: 'Yoga at Sunrise',
      category: 'Health & Wellness',
      location: 'Giza',
      date: DateTime(2025, 7, 12),
      price: 100,
      numberofSeats: 30,
    ),

    Events(
      eventid: '10',
      eventTitle: 'Traditional Music Night',
      category: 'Music',
      location: 'Luxor',
      date: DateTime(2026, 3, 30),
      price: 200,
      numberofSeats: 500,
    ),
  ];
  List <Events>filteredEvents = []; //list el btzhr lel user ama ydkhol el homescreen
  String searchBarText = '';
  String chosenCategory = 'All';

  EventController() {
    filteredEvents = events;
  }

  void searchingEvent(String text) {
    searchBarText = text.toLowerCase();
    filterSearch();
  }

  void changeCategory(String category) {
    chosenCategory = category;
    filterSearch();
  }

  void filterSearch() {// bt3ml el filter nafsha
    filteredEvents = events.where((event) {   //where di btseeb el events el mwgoda mn el list bas el bt7a22 el condition el howa le body
      // Search match (title or location)
      bool matchesSearch = event.eventTitle.toLowerCase().contains(
          searchBarText) ||
          event.location.toLowerCase().contains(searchBarText);

      // Category match
      bool matchesCategory = chosenCategory == 'All' ||
          event.category == chosenCategory;

      return matchesSearch && matchesCategory;
    }).toList(); //bt3mlha ka list
  }

  List<String> get allCategories {
    return ['All', ...Set.from(events.map((e) => e.category))];
  }
}

