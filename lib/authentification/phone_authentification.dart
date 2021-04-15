import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerestock/authentification/register_password.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/repository.dart';
import 'package:http/io_client.dart';

import 'connexion_phone.dart';
import 'informations_supplementaire.dart';





class   PhoneAuthentification extends StatefulWidget {
  static String id ="PhoneAuthentification";


  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<PhoneAuthentification> {
  final _codeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _nameUser;
  String numUser;
  String numero;
  String code="+229";
  String email='';
  String motDePass= '';
  String confirmation = '';
  String numeroAvecCode = "";

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();






  Future<bool> loginUser(String phone, BuildContext context) async{
    print(phone);
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async{
        await _auth.signInWithCredential(credential).then((value) {
          if(value.user!=null){
            EasyLoading.dismiss();
            setNumeroUser(numeroAvecCode);
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => RegisterPassword(numeroDeTelephone: numeroAvecCode )
            ));

          } else {
            print("Errorr");
            displaySnackBarNom(context, "Vous n'avez pas réussi à vous inscrire", Colors.red);

          }
        });
      },
      verificationFailed: (FirebaseAuthException exception){
        if (exception.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          displaySnackBarNom(context, "Le numéro entré n'est pas correct", Colors.red);
        }
      },
      codeSent: (String verificationId, [int forceResendingToken]){
        EasyLoading.dismiss();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: TextClasse(text: "Entrer le code", family: "MonserratSemiBold",),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color:Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontFamily: "MonserratSemiBold"
                        ),
                        controller: _codeController,
                        // ignore: missing_return
                        validator: (String value) {
                          if(value.isEmpty) {
                            return ("Entrer le code de vérification");
                          } else if (value.length!=6) {
                            return ("Le code de vérification est inconrect ");
                          }
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: TextClasse(text: "Confirmer", family: "MonserratSemiBold", fontSize: 15,),
                    textColor: Colors.white,
                    color: HexColor("#119600"),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        EasyLoading.show(status: 'Chargement', dismissOnTap: false);
                        final code = _codeController.text.trim();
                        try {
                          AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);

                          await _auth.signInWithCredential(credential).then((value) {
                            if(value.user!=null){
                              setNumeroUser(numeroAvecCode);
                              EasyLoading.dismiss();
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => RegisterPassword(numeroDeTelephone: numeroAvecCode)
                              ));

                            } else {
                              print("Error");
                              displaySnackBarNom(context, "Vous n'avez pas réussi à vous inscrire", Colors.red);
                            }
                          });
                        } catch(e){
                          EasyLoading.dismiss();
                          Navigator.pop(context);
                          displaySnackBarNom(context, "Code Invalide. Veuillez reconfirmer votre numéro", Colors.red);
                        }

                      }
                    },
                  )
                ],
              );
            }
        );
      },
      codeAutoRetrievalTimeout:  (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }





  displaySnackBarNom(BuildContext context, String text, Color couleur) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: couleur, fontSize: 13)),
      duration: Duration(seconds: 2),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: ListView(
          children: [
            /*Container(
              height: longueurPerCent(125, context),
              padding: EdgeInsets.only(top: 75, left: 20),
              color:  HexColor("#119600"),
              child: Text("Activez l'application", style: TextStyle(color: Colors.white, fontFamily: "OSemiBold", fontSize: 20),),
            ),*/
            SizedBox(height: longueurPerCent(100, context),),
            Image.asset("lib/assets/images/gerestock_logo.jpg", height: 190, width: 300,),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex:1,
                    child: Text("")
                ),
                Expanded(
                  flex:2,
                  child:
                  Column(
                    children: [
                      SizedBox(height: 15,),
                      CountryCodePicker(
                       textStyle: TextStyle(
                            color:Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontFamily: "MonserratSemiBold"
                        ),
                        onChanged: (e)  {
                          print(e.code.toString());
                          code = e.code.toString();
                        },
                        initialSelection: 'BJ',
                        showCountryOnly: true,
                        showOnlyCountryWhenClosed: false,
                        favorite: ['+229', 'FR'],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    style: TextStyle(
                        color:Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontFamily: "MonserratSemiBold"
                    ),
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        labelText: "Entrez votre numéro",
                        labelStyle: TextStyle(color: HexColor("#119600"), fontFamily: "MonserratBold", fontSize: 10)
                    ),
                    onChanged: (value){
                      numero=_phoneController.text;
                    },
                  ),
                ),
                Expanded(
                    flex:1,
                    child: Text("")
                ),
              ],
            ),
            SizedBox(height: longueurPerCent(20, context),),
          /*  Padding(
              padding: EdgeInsets.symmetric(horizontal: 42),
              child: Text("Nous vous enverrons un code par message pour vérifier votre numéro de téléphone", style: TextStyle(color: HexColor("#707070"), fontFamily: "ORegular", fontSize: 13, ), textAlign: TextAlign.center,),
            ),*/
            SizedBox(height: longueurPerCent(100, context),),
            submitButton(context, "Continuer", (){
              if(code!=null && numero!=null){
                setState(() {
                  numeroAvecCode = code+numero;
                });
                verifyPhoneIsAlreadyExist();
              } else {
                displaySnackBarNom(context, "Veuillez entrer votre numéro de téléphone", Colors.white);
              }
            }),
            SizedBox(height: longueurPerCent(20, context),),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: FlatButton(
                  color: Colors.white,
                  onPressed: ()  {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ConnexionPhone()
                    ));
                  },
                  child: TextClasse(text: "SE CONNECTER", color: bleuPrincipale, fontSize: 15, family: "MonserratBold",)
              ),
            ),
            SizedBox(height: longueurPerCent(20, context),),
          ],
        ),

    );
  }

  void verifyPhoneIsAlreadyExist(){
    EasyLoading.show(status: 'Chargement', dismissOnTap: false);
    Firestore.instance.collection("Utilisateurs").doc(numeroAvecCode).get().then((value) {
      if(value.exists) {
        EasyLoading.dismiss();
        displaySnackBarNom(context, "Ce numéro existe déjà. Il ne peut plus être utilisé", Colors.white);
      }
      else {
        loginUser(numeroAvecCode, context);
      }
    });
  }
}