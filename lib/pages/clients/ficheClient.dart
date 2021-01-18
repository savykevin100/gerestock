import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';





class FicheClient extends StatefulWidget {
  static String id ="FicheClient";
  @override
  _FicheClientState createState() => _FicheClientState();
}

class _FicheClientState extends State<FicheClient> {

  TextEditingController _nomDuclient = TextEditingController();
  TextEditingController _adresse = TextEditingController();
  TextEditingController _telephone = TextEditingController();
  TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
      appBar: appBar(context,"Fiche client"),
      body: Center(
        child:SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: longueurPerCent(20, context),),
                Icon(Icons.person, color: primaryColor, size: 120,),
                SizedBox(height: longueurPerCent(30, context),),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: largeurPerCent(22, context)),
                  child: TextFormField(
                    controller: _nomDuclient,
                    decoration: InputDecoration(
                      labelText: "Nom du client",
                      labelStyle: TextStyle(fontFamily: "MonserratBold", fontSize: 12, color: HexColor("#001C36")),
                    ),
                    // ignore: missing_return
                    validator: (value){
                      // ignore: missing_return
                      if(value.isEmpty){
                        // ignore: missing_return
                        return "Entrer le nom du client";
                      }
                    },
                  ),
                ),
                SizedBox(height: longueurPerCent(20, context),),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: largeurPerCent(22, context)),
                  child: TextFormField(
                    controller: _adresse,
                    decoration: InputDecoration(
                      labelText: "Adresse",
                      labelStyle: TextStyle(fontFamily: "MonserratBold", fontSize: 12, color: HexColor("#001C36")),
                    ),
                    // ignore: missing_return
                    validator: (value){
                      // ignore: missing_return
                      if(value.isEmpty){
                        // ignore: missing_return
                        return "Entrer l'adresse du client";
                      }
                    },
                  ),
                ),
                SizedBox(height: longueurPerCent(20, context),),

                Padding(
                  padding:EdgeInsets.symmetric(horizontal: largeurPerCent(22, context)),
                  child: TextFormField(
                    controller: _telephone,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Téléphone",
                      labelStyle: TextStyle(fontFamily: "MonserratBold", fontSize: 12, color: HexColor("#001C36")),
                    ),
                    // ignore: missing_return
                    validator: (value){
                      // ignore: missing_return
                      if(value.isEmpty){
                        // ignore: missing_return
                        return "Entrer le numéro de téléphone";
                      }
                    },
                  ),
                ),
                SizedBox(height: longueurPerCent(20, context),),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: largeurPerCent(22, context)),
                  child: TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(fontFamily: "MonserratBold", fontSize: 12, color: HexColor("#001C36")),
                    ),
                    // ignore: missing_return
                    validator: (String value) {
                      if (EmailValidator.validate(_email.text) == false ) {
                        return ("Entrer un email valide");
                      }
                    },
                  ),
                ),
                SizedBox(height: longueurPerCent(50, context),),
                submitButton(context, "AJOUTER", (){
                  registerClient();
                }),
                SizedBox(height: longueurPerCent(20, context),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registerClient() {
    if(_formKey.currentState.validate()){
      try{
        EasyLoading.show(status: 'Chargement', dismissOnTap: false);
        print("Eaaaa");
        /*FirestoreService().addClient(
            ClientsFouniss(
                email: _email.text,
                adresse: _adresse.text,
                numeroTelephone: _telephone.text,
                nom: _nomDuclient.text
            )
            , emailEntreprise);*/
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Enregistrement réussie!', maskType: EasyLoadingMaskType.custom);
        Navigator.pop(context);
      } catch (e){
        EasyLoading.dismiss();
        EasyLoading.showError("L'ajout a échoué");
      }
    }
  }
}
