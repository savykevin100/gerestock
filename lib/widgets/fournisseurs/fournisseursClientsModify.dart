
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/firestore_service.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/modeles/clients_fournisseurs.dart';

// ignore: must_be_immutable
class ModifyClientOrFournisseur extends StatefulWidget {

String title;
ClientsFounisseursModel clientsFouniss = ClientsFounisseursModel();
String userPhone;


ModifyClientOrFournisseur({this.title, this.clientsFouniss, this.userPhone});

  @override
  _ModifyClientOrFournisseurState createState() =>
      _ModifyClientOrFournisseurState();
}

class _ModifyClientOrFournisseurState extends State<ModifyClientOrFournisseur> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _telephone = TextEditingController();
  TextEditingController _email = TextEditingController();




  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _name.text = widget.clientsFouniss.name;
      _address.text=widget.clientsFouniss.address;
      _telephone.text = widget.clientsFouniss.telephoneNumber;
      _email.text = widget.clientsFouniss.email;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:appBar(context, "Modifié"),
        body: Card(
          margin: EdgeInsets.symmetric(
            horizontal: largeurPerCent(16, context),
          ),
          elevation: 5.0,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: 28),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(height: 50,),
                    TextFormField(
                      controller: _name,
                      decoration: InputDecoration(
                          hintText: widget.clientsFouniss.name,
                          hintStyle: TextStyle(fontFamily: "MonserratRegular", fontSize: 15, color: HexColor("#ADB3C4"))
                      ),
                      // ignore: missing_return
                      validator: (value){
                        // ignore: missing_return
                        if(value.isEmpty)
                          return ("Veuillez entrer le nom ");
                      },
                    ),
                    SizedBox(height: 40,),
                    TextFormField(
                      controller: _address,
                      decoration: InputDecoration(
                          hintText: widget.clientsFouniss.address,
                          hintStyle: TextStyle(fontFamily: "MonserratRegular", fontSize: 15, color: HexColor("#ADB3C4"))
                      ),
                      // ignore: missing_return
                      validator: (value){
                        // ignore: missing_return
                        if(value.isEmpty)
                          return ("Veuillez entrer l'addresse");
                      },
                    ),
                    SizedBox(height: 40,),
                    TextFormField(
                      controller: _telephone,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: widget.clientsFouniss.telephoneNumber,
                          hintStyle: TextStyle(fontFamily: "MonserratRegular", fontSize: 15, color: HexColor("#ADB3C4"))
                      ),
                      // ignore: missing_return
                      validator: (value){
                        // ignore: missing_return
                        if(value.isEmpty)
                          return ("Veuillez entrer le numero de téléphone");
                      },
                    ),
                    SizedBox(height: 40,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
                      decoration: InputDecoration(
                        labelText: widget.clientsFouniss.email,
                        labelStyle: TextStyle(fontFamily: "MonserratBold", fontSize: 12, color: HexColor("#001C36")),
                      ),
                      // ignore: missing_return
                      validator: (String value) {
                        if (EmailValidator.validate(_email.text) == false ) {
                          return ("Entrer un email valide");
                        }
                      },
                    ),
                    SizedBox(height: 40,),
                  submitButton(context, "ENREGISTRER", (){
                      setState(() {
                        registerClientOrFournisseur();
                      });
                    }),
                    SizedBox(height: 40,),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }



  void registerClientOrFournisseur() {
    if(_formKey.currentState.validate()){
      print(_address.text);
      print(widget.title);
      try{
       if(widget.title == "Clients")
        addInDb("Clients");
       else
         addInDb("Fournisseurs");
      } catch (e){
        EasyLoading.dismiss();
        EasyLoading.showError("L'ajout a échoué");
      }
    }
  }

  void addInDb(String table){
    EasyLoading.show(status: 'Chargement', dismissOnTap: false);
    Firestore.instance
        .collection("Utilisateurs")
        .doc(widget.userPhone)
        .collection(table)
        .doc(widget.clientsFouniss.id)
        .update({
        "name":_name.text,
         "email": _email.text,
        "telephoneNumber":_telephone.text,
        "address": _address.text
    });
    EasyLoading.dismiss();
    EasyLoading.showSuccess('Modification réussie!', maskType: EasyLoadingMaskType.custom);
  }
}
