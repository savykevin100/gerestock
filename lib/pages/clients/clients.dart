import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/firestore_service.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/modeles/clients_fournisseurs.dart';
import 'package:gerestock/pages/clients/clientDetail.dart';





class Clients extends StatefulWidget {
  static String id = "Clients";
  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
String emailEntreprise;

  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }


  bool currentUser=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value) {
      setState(() {
        emailEntreprise = value.email;
      });
      print(emailEntreprise);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithSearch(context,"Clients"),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: largeurPerCent(21, context), vertical: longueurPerCent(46, context)),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: StreamBuilder(
                stream: FirestoreService().getClientsFourniss(emailEntreprise, "Clients"),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ClientsFounisseursModel>> snapshot) {
                    if (snapshot.hasError || !snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                    } else if(snapshot.data.isEmpty)
                      return Center(child:Text("Pas de nouveaux clients"));
                    else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,  i) {
                            ClientsFounisseursModel client = snapshot.data[i];
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ClientDetail(clientsFouniss: client,)),
                                    );
                                  },
                                  child: ListTile(
                                    title: TextClasse(
                                      text: client.name,
                                      family: "MonserratSemiBold",
                                    ),
                                    subtitle: TextClasse(text:client.telephoneNumber, family: "MonserratMedium", fontSize: 13,),
                                    trailing: Icon(
                                      Icons.navigate_next,
                                      color: HexColor("#ADB3C4"),
                                      size: 30,
                                    ),
                                  ),
                                ),
                                Divider(color: HexColor("#ADB3C4"),)
                              ],
                            );
                          }
                      );
                    }
                }
            )
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /*Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return FormFournisseursClientsWidget(title: title,);
          }));*/

        },
        child: Icon(Icons.add, color: white,),
        backgroundColor: primaryColor,
      ),
    );
  }
}
/* */