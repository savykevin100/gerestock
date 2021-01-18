class DecaissementModels {
  String operationDate;
  String created;
  int amount;
  String expenseTitle;
  String id;
  String etat;


  DecaissementModels({
    this.operationDate,
    this.created,
    this.amount,
    this.expenseTitle,
    this.id,
    this.etat,
  });

  DecaissementModels.fromMap(Map<String, dynamic> donnees, id)
      : operationDate = donnees["operationDate"],
        created = donnees["created"],
        id = donnees["id"],
        amount = donnees["amount"],
        etat= donnees["etat"],
        expenseTitle = donnees["expenseTitle"];


  Map<String, dynamic> toMap() {
    return {
      "operationDate": operationDate,
      "created": created,
      "id": id,
      "expenseTitle": expenseTitle,
      "amount": amount,
      "etat": etat,
    };
  }
}
