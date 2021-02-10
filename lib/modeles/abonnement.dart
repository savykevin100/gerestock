class Abonnement {

  String dateBeginTestMode;
  String dateBeginAbonnement;
  bool activeTestMode;
  bool activeAbonnement;
  String id;
  String formule;



  Abonnement(
      {
        this.dateBeginTestMode,
        this.dateBeginAbonnement,
        this.id,
        this.activeAbonnement,
        this.activeTestMode,
        this.formule,
      });

  Abonnement.fromMap(Map<String, dynamic> donnees, String id)
      : dateBeginTestMode = donnees["dateBeginTestMode"],
        dateBeginAbonnement = donnees["dateBeginAbonnement"],
        id = donnees["id"],
        activeTestMode = donnees["activeTestMode"],
        activeAbonnement = donnees["activeAbonnement"],
        formule = donnees["formule"];

  Map<String, dynamic> toMap() {
    return {
      "dateBeginTestMode": dateBeginTestMode,
      "dateBeginAbonnement": dateBeginAbonnement,
      "id": id,
      "activeTestMode": activeTestMode,
      "activeAbonnement": activeAbonnement,
      "formule": formule,
    };
  }
}
