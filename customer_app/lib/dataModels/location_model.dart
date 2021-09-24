class Region {
  String id;
  String name;
  List<Location> locations;
  Region({
    required this.id,
    required this.name,
    required this.locations,
  });
}

class Location {
  String id;
  String name;
  Location({
    required this.id,
    required this.name,
  });
}
