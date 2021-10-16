class Transaction {
  bool isDebit;
  int subTotal;
  String comment;
  DateTime date;
  Transaction({
    required this.isDebit,
    required this.subTotal,
    required this.date,
    required this.comment,
  });
}
