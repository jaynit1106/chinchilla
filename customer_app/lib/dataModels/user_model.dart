class User {
  String id;
  String firstName;
  String lastName;
  String phone;
  String routeID;
  String hubID;

  String email;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.routeID,
    required this.hubID,
    this.email = '',
  });
}
