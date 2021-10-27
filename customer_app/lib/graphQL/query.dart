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

String transactionByDate = """
query transactionByDate(\$customerID: String, \$startDate: Date, \$endDate: Date) {
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

String past30DaysOneTimeOrders = """
query past30DaysOneTimeOrders(\$customerID: String, \$startDate: Date, \$endDate: Date) {
  OneTimeOrdersByCustomerIDAndDate(customerID: \$customerID, startDate: \$startDate, endDate: \$endDate) {
    id
    items
    deliveryDate
    status
  }
}

""";

String contactQuery = """
query contactQuery(\$customerID: ID) {
  customer(id: \$customerID) {
    location {
      route {
        executive {
          firstName
          lastName
          photoURL
          phone
        }
      }
      region {
        hub {
          hubName
          address
          mobileNo
          email
        }
      }
    }
  }
}

""";
