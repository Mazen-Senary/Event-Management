class Events{
  final String eventid;
  final String eventTitle;
  final String category;
  final String location;
  final DateTime date;
  final double price;
  int numberofSeats;

  Events({required this.eventid, required this.eventTitle, required this.category, required this.location, required this.date,
    required this.price,required this.numberofSeats});

}