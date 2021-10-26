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

OrderStatus parseOrderStatusEnum(String a) {
  return OrderStatus.values
      .firstWhere((e) => e.toString() == 'OrderStatus.' + a);
}

SubStatus parseSubsStatusEnum(String a) {
  return SubStatus.values.firstWhere((e) => e.toString() == 'SubStatus.' + a);
}
