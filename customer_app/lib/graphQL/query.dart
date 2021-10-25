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
    id
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

String last7Transactions = """
query last7Transactions(\$customerID: String, \$startDate: Date, \$endDate: Date) {
  transactionsByCustomerIDAndDate(customerID: \$customerID, startDate: \$startDate, endDate: \$endDate) {
    isDebit
    subTotal
    comment
    date
  }
}
""";

String customerHome = """
query customerHome(\$id: ID){
  customer(id: \$id) {
    ordersForToday {
      id
      items
      status
      deliveryDate
    }
    subscriptions{
      id
      items
      nextDeliveryDate
      frequency
      endDate
      status
    }
  }
}
""";
