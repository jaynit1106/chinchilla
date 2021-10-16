String locationQuery = """
query LocationQuery {
  regions {
    id
    name
    locations {
      id
      name
    }
  }
}
""";

String userByPhone = """
query customerByPhone(\$phone: String) {
  customerByPhone(phone: \$phone) {
    firstName
    lastName
    phone
  }
}
""";
