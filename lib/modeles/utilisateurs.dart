class Utilisateur {
  String email;
  String logo;
  String companyName;
  String activitySector;
  String ifu;
  String country;
  String telephoneNumber;
  String address;
  String created;



  Utilisateur(
      {this.email,
      this.logo,
      this.companyName,
      this.activitySector,
      this.ifu,
      this.country,
      this.telephoneNumber,
      this.address,
      this.created
      });

  Utilisateur.fromMap(Map<String, dynamic> donnees, String id)
      : email = donnees["email"],
        logo = donnees["logo"],
        companyName = donnees["companyName"],
        activitySector= donnees["activitySector"],
        ifu = donnees["ifu"],
        country = donnees["country"],
        telephoneNumber = donnees["telephoneNumber"],
        created = donnees["created"],
        address = donnees["address"];


      Map<String, dynamic> toMap() {
    return {
      "email": email,
      "logo": logo,
      "companyName": companyName,
      "activitySector": activitySector,
      "ifu": ifu,
      "country": country,
      "telephoneNumber": telephoneNumber,
      "created": created,
      "address": address,
    };
  }
}
