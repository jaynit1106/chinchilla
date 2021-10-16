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
    wallet
    location {
      routeID
      region {
        hubID
      }
    }
  }
}

""";

String products = """
query Products(\$hubID: ID) {
  hub(id: \$hubID) {
    products {
      id
      name
      price
      photoURL
    }
  }
}

""";
