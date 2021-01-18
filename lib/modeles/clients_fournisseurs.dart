class ClientsFounisseursModel {
 String telephoneNumber;
 String name;
 String address;
 String email;
 String id;


 ClientsFounisseursModel(
      {
        this.email,
        this.name,
        this.telephoneNumber,
        this.address,
        this.id
      });

 ClientsFounisseursModel.fromMap(Map<String, dynamic> donnees, String id)
      : email = donnees["email"],
        name = donnees["name"],
        telephoneNumber = donnees["telephoneNumber"],
        id = donnees["id"],
        address = donnees["address"];


  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "name": name,
      "telephoneNumber": telephoneNumber,
      "address": address,
      "id": id,
    };
  }
}
