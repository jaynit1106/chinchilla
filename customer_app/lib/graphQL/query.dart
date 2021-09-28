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
