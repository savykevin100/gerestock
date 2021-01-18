class Depense {
  String operationDate;
  String expenseTitle;
  int amount;
  String id;
  String created;



  Depense(
      {
       this.operationDate,
        this.expenseTitle,
        this.amount,
        this.id,
        this.created
      });

  Depense.fromMap(Map<String, dynamic> donnees, String id)
      : operationDate = donnees["operationDate"],
        expenseTitle = donnees["expenseTitle"],
        id = donnees["id"],
        created = donnees["created"],
        amount = donnees["amount"];

  Map<String, dynamic> toMap() {
    return {
      "operationDate": operationDate,
      "expenseTitle": expenseTitle,
      "id": id,
      "created": created,
      "amount": amount,
    };
  }
}
