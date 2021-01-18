class Utilisateur {
  String email;
  String logo;
  String companyName;
  String activitySector;
  String ifu;
  String country;
  String telephoneNumber;
  String address;



  Utilisateur(
      {this.email,
      this.logo,
      this.companyName,
      this.activitySector,
      this.ifu,
      this.country,
      this.telephoneNumber,
      this.address
      });

  Utilisateur.fromMap(Map<String, dynamic> donnees, String id)
      : email = donnees["email"],
        logo = donnees["logo"],
        companyName = donnees["companyName"],
        activitySector= donnees["activitySector"],
        ifu = donnees["ifu"],
        country = donnees["country"],
        telephoneNumber = donnees["telephoneNumber"],
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
      "address": address,
    };
  }
}
