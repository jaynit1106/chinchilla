String addSubs = """
mutation addSubscription(\$customerID: String!, \$items: [Item]!, \$startDate: DateTime!, \$endDate: DateTime, \$addressID: String!, \$frequency: Int!) {
  addSubscription(customerID: \$customerID, items: \$items, startDate: \$startDate, endDate: \$endDate, addressID: \$addressID, frequency: \$frequency) {
    id
    items
    nextDeliveryDate
    frequency
    endDate
    status
  }
}
""";
String addOrder = """
mutation addOrder(\$customerID: String!, \$routeID: String!, \$items: [Item]!, \$deliveryDate: DateTime!, \$addressID: String!){
  addOrder(customerID: \$customerID, items: \$items, routeID: \$routeID, deliveryDate: \$deliveryDate, addressID: \$addressID){
    id
    items
    status
    deliveryDate
  }
}
""";
String addAddress = """
mutation addAddress(\$customerID: String!, \$name: String!) {
  addAddress(name: \$name, customerID: \$customerID) {
    id
    name
  }
}
""";
String addTransaction = """
mutation addTransaction(\$subTotal: Int!, \$customerID: String!, \$date: DateTime!, \$isDebit: Boolean!, \$comment: String) {
  addTransaction(subTotal: \$subTotal, customerID: \$customerID, date: \$date, isDebit: \$isDebit, comment: \$comment) {
    isDebit
    subTotal
    comment
    date
  }
}

""";
String addCustomer = """
mutation addCustomer(\$firstName: String!, \$lastName: String!, \$phone: String!, \$locationID: String!, \$email: String) {
  addCustomer(firstName: \$firstName, lastName: \$lastName, phone: \$phone, locationID: \$locationID, email: \$email) {
    id
    firstName
    lastName
    phone
    location {
      routeID
      region {
        hubID
      }
    }
  }
}

""";
String editCustomer = """
mutation editCustomer(\$id: ID!, \$firstName: String, \$lastName: String, \$email: String) {
  editCustomer(id: \$id, firstName: \$firstName, lastName: \$lastName, email: \$email) {
    id
    firstName
    lastName
    phone
    location {
      routeID
      region {
        hubID
      }
    }
  }
}

""";
String editOrder = """
mutation editOrder(\$id: ID!, \$status: String, \$deliveryDate: DateTime, \$items: [Item]) {
  markOrder(id: \$id, status: \$status, deliveryDate: \$deliveryDate, comment: "Editted by customer", items: \$items) {
    id
    items
    deliveryDate
    status
  }
}

""";
