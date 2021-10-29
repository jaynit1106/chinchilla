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
