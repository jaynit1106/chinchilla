enum OrderStatus {
  DELIVERED,
  UNDELIVERED,
  ACTIVE,
  PENDING,
}

enum SubStatus {
  ACTIVE,
  PENDING,
  COMPLETED,
}

String parseEnum(String a) {
  return a.split(".")[1];
}
