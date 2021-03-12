import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:gerestock/widgets/fournisseurs/fournisseursClientsDetails.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../app_controller.dart';
import 'formFournisseursClientsWidget.dart';





// ignore: must_be_immutable
class FournisseursClientsWidget extends StatefulWidget {
  static String id = "FournisseursClientsWidget";
  String title;

  FournisseursClientsWidget({this.title});
  @override
  _FournisseursClientsWidgetState createState() => _FournisseursClientsWidgetState();
}

class _FournisseursClientsWidgetState extends StateMVC<FournisseursClientsWidget> {

  bool _firstSearch = true;
  String _query = "";
  var _searchview = new TextEditingController();
  List<String> nameSearch = [];
  List<String> _nebulae = [];

  List<String> _filterList;
  AppController _con ;

  

  _FournisseursClientsWidgetState() : super(AppController()) {
    _con = controller;
  }




  //Create a SearchView
  Widget _createSearchView() {
    return new Container(
      decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: new TextField(
        controller: _searchview,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: new TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _performSearch() {
    for (int i = 0; i < _nebulae.length; i++) {
      var item = _nebulae[i];

      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
      }
    }
    return _createFilteredListView();
  }

  //Create the Filtered ListView
  Widget _createFilteredListView() {
    return (_con.userPhone!="")?StreamBuilder(
        stream: FirestoreService().getClientsFourniss(_con.userPhone, widget.title),
        builder: (BuildContext context,
            AsyncSnapshot<List<ClientsFounisseursModel>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else if(snapshot.data.isEmpty)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
                Text("Pas de nouveaux "+widget.title),
              ],
            );
          else {
            return ListView.builder(
              shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context,  i) {
                  ClientsFounisseursModel client = snapshot.data[i];
                  return Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FournisseursClientsDetails(clientsFouniss: client, title: widget.title,)),
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
    ):Center(child: CircularProgressIndicator(),);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.numeroUser();
    (_con.userPhone!="")?FirebaseFirestore.instance.collection("Utilisateurs").doc(_con.userPhone).collection(widget.title).get().then((value){
      value.docs.forEach((element) {
        print(element.data());
        setState(() {
          nameSearch.add(element.data()["name"]);
        });
      });
    }):null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, widget.title),
      body:Center(
        child: Card(
            margin: EdgeInsets.symmetric(horizontal: largeurPerCent(21, context), vertical: longueurPerCent(46, context)),
            child: Container(
                height: double.infinity,
                width: double.infinity,
                child: ListView(
                  children: [
                   // _createSearchView(),
                  //  _firstSearch ? _createFilteredListView() : _performSearch()
                    _createFilteredListView()
                  ],
                )
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(widget.title=="Clients")
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
              return FormFournisseursClientsWidget(title: "client", referenceDb: "Clients", userPhone: _con.userPhone,);
            }));
          else
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
              return FormFournisseursClientsWidget(title: "fournisseur", referenceDb: "Fournisseurs",  userPhone: _con.userPhone,);
            }));

        },
        child: Icon(Icons.add, color: white,),
        backgroundColor: primaryColor,
      ),
    );
  }
}
