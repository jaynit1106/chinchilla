class User {
  String id;
  String firstName;
  String lastName;
  String phone;
  String routeID;
  String hubID;
  int wallet;
  String email;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.wallet,
    required this.routeID,
    required this.hubID,
    this.email = '',
  });
}
