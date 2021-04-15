class Utilisateur {
  String password;
  String logo;
  String companyName;
  String activitySector;
  String ifu;
  String country;
  String telephoneNumber;
  String address;
  String created;
  double amount;
  String dateExpiryAmount;



  Utilisateur(
      {this.password,
      this.logo,
      this.companyName,
      this.activitySector,
      this.ifu,
      this.country,
      this.telephoneNumber,
      this.address,
      this.created,
      this.amount,
      this.dateExpiryAmount
      });

  Utilisateur.fromMap(Map<String, dynamic> donnees)
      : password = donnees["password"],
        logo = donnees["logo"],
        companyName = donnees["companyName"],
        activitySector= donnees["activitySector"],
        ifu = donnees["ifu"],
        country = donnees["country"],
        telephoneNumber = donnees["telephoneNumber"],
        created = donnees["created"],
        amount = donnees["amount"],
        dateExpiryAmount = donnees["dateExpiryAmount"],
        address = donnees["address"];


      Map<String, dynamic> toMap() {
    return {
      "password": password,
      "logo": logo,
      "companyName": companyName,
      "activitySector": activitySector,
      "ifu": ifu,
      "country": country,
      "telephoneNumber": telephoneNumber,
      "created": created,
      "amount": amount,
      "dateExpiryAmount": dateExpiryAmount,
      "address": address,
    };
  }
}
