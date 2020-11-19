class Utilisateur {
  String email;
  String logo;
  String nomDeLentreprise;
  String secteurActivite;
  String ifu;
  String pays;
  String numeroTelephone;
  String adresse;


  Utilisateur(
      {this.email,
      this.logo,
      this.nomDeLentreprise,
      this.secteurActivite,
      this.ifu,
      this.pays,
      this.numeroTelephone,
      this.adresse
      });

  Utilisateur.fromMap(Map<String, dynamic> donnees, String id)
      : email = donnees["email"],
        logo = donnees["logo"],
        nomDeLentreprise = donnees["nomDeLentreprise"],
        secteurActivite = donnees["secteurActivite"],
        ifu = donnees["ifu"],
        pays = donnees["pays"],
        numeroTelephone = donnees["numeroTelephone"],
        adresse = donnees["adresse"];


      Map<String, dynamic> toMap() {
    return {
      "email": email,
      "logo": logo,
      "nomDeLentreprise": nomDeLentreprise,
      "secteurActivite": secteurActivite,
      "ifu": ifu,
      "pays": pays,
      "numeroTelephone": numeroTelephone,
      "adresse": adresse,
    };
  }
}
