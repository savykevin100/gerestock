class Abonnement {

  String dateBeginTestMode;
  String dateBeginAbonnement;
  bool activeTestMode;
  bool activeAbonnement;
  String id;



  Abonnement(
      {
        this.dateBeginTestMode,
        this.dateBeginAbonnement,
        this.id,
        this.activeAbonnement,
        this.activeTestMode
      });

  Abonnement.fromMap(Map<String, dynamic> donnees, String id)
      : dateBeginTestMode = donnees["dateBeginTestMode"],
        dateBeginAbonnement = donnees["dateBeginAbonnement"],
        id = donnees["id"],
        activeTestMode = donnees["activeTestMode"],
        activeAbonnement = donnees["activeAbonnement"];

  Map<String, dynamic> toMap() {
    return {
      "dateBeginTestMode": dateBeginTestMode,
      "dateBeginAbonnement": dateBeginAbonnement,
      "id": id,
      "activeTestMode": activeTestMode,
      "activeAbonnement": activeAbonnement,
    };
  }
}
