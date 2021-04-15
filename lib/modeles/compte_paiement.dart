class ComptePaiement {

  String dateCreatedAccount;
  double amount;
  String dateExpiryPayment;
  bool activeAbonnement;
  String id;
  String formule;



  ComptePaiement(
      {
        this.dateCreatedAccount,
        this.amount,
        this.id,
        this.activeAbonnement,
        this.dateExpiryPayment,
        this.formule,
      });

  ComptePaiement.fromMap(Map<String, dynamic> donnees, String id)
      : dateCreatedAccount = donnees["dateCreatedAccount"],
        amount = donnees["amount"],
        id = donnees["id"],
        dateExpiryPayment = donnees["dateExpiryPayment"],
        activeAbonnement = donnees["activeAbonnement"],
        formule = donnees["formule"];

  Map<String, dynamic> toMap() {
    return {
      "dateCreatedAccount": dateCreatedAccount,
      "amount": amount,
      "id": id,
      "dateExpiryPayment": dateExpiryPayment,
      "activeAbonnement": activeAbonnement,
      "formule": formule,
    };
  }
}
