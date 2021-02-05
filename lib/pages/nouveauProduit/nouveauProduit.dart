import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/firestore_service.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/modeles/produits.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;



class NouveauProduit extends StatefulWidget {
  static String id="Nouveau Produit";
  @override
  _NouveauProduit createState() => _NouveauProduit();
}

class _NouveauProduit extends State<NouveauProduit> {
  // MUST BE MAINTAINED, SEPARATELY.
  int currentIndex = 0;

  // THESE MUST BE USED TO CONTROL THE STEPPER FROM EXTERNALLY.
  bool goNext = false;
  bool goPrevious = false;
  List<String> numberSelect = ["0"];

  TextEditingController nomFamille=TextEditingController();
  TextEditingController nomDuProduitController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController libelleController = TextEditingController();
  TextEditingController prixAchatController = TextEditingController();
  TextEditingController prixVenteController = TextEditingController();
  TextEditingController stockAlerteController = TextEditingController();

  String emailEntreprise;
  String selectFamily;
  // ignore: deprecated_member_use
  FirebaseFirestore _db = Firestore.instance;
  bool currentUser=false;
  List<String> familles=[];
  String productImageUrl = "";
  File _image;



  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }



  Future<void> getNomFamille(String email) async {
    print(emailEntreprise);
    _db.collection("Utilisateurs").
    doc(email).collection("Familles").
    get().then((value) {
      print("Ici");
      print(value.size);
       value.docs.forEach((element) {
         print(element.id);
           setState(() {
             familles.add(element.data()["familyName"]);
           });
       });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value) {
      setState(() {
        emailEntreprise = value.email;
      });
      getNomFamille(value.email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:appBar(context,"Nouveau Produit"),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 17,),
            Card(
              elevation: 5.0,
              margin: EdgeInsets.symmetric(horizontal: longueurPerCent(10, context)),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: largeurPerCent(60, context)),
                    child: IconStepper.externallyControlled(
                      activeStepBorderColor: Colors.white,
                      goNext: goNext,
                      goPrevious: goPrevious,
                      direction: Axis.horizontal,
                      stepColor:  (numberSelect.length==2)?secondaryColor:Colors.grey,
                      activeStepColor:secondaryColor,
                      lineColor: secondaryColor,
                      lineLength: 75,
                      scrollingDisabled: true,
                      icons: [
                        Icon(Icons.looks_one, color: Colors.white,),
                        Icon(Icons.looks_two, color: Colors.white,),
                      ], upperBound: null,
                    ),
                  )
              ),
            ),
            SizedBox(height: longueurPerCent(20, context),),
            Center(child: header()),
            SizedBox(height: longueurPerCent(50, context),),
          ],
        )
      );
  }

  // ignore: missing_return
  Widget header() {
    switch (currentIndex) {
      case 0:
        return createOrSelectFamily();

      case 1:
        return createProduct();

    }
  }


  Widget createOrSelectFamily(){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: longueurPerCent(20, context),),
          TextClasse(text: "Créer ou choisir une famille", color: secondaryColor, family: "MonserratBold", fontSize: 15,),
          SizedBox(height: longueurPerCent(50, context),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              nameOfFieldWithPadding("Famille", context),
              Container(
                height: longueurPerCent(41, context),
                width: largeurPerCent(210, context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(width: 1.0, color: HexColor("#707070")),
                ),
                child: (familles.length>0)?DropdownButton(
                  underline: Text(""),
                  hint:selectFamily == null
                      ? Text(
                    "",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                      : Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          selectFamily,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                    ),
                  ),
                      ),
                  isExpanded: true,
                  iconSize: 30.0,
                  items:
                  familles.map(
                        (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val,),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectFamily=val;
                    });
                  },
                ):Text("")
              )
            ],
          ),
          SizedBox(height: longueurPerCent(50, context),),
          textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Nom de la famille", context), context, nomFamille, TextInputType.text),
          SizedBox(height: longueurPerCent(150, context),),
          submitButton(context, "SUIVANT", (){
           addFamillyOrNot();
          },)
        ],
      );

  }


  Widget createProduct(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: longueurPerCent(20, context),),
        Center(child: Column(
          children: [
            TextClasse(text: "Créer un nouveau produit", color: secondaryColor, family: "MonserratBold", fontSize: 15, textAlign: TextAlign.center,),
            SizedBox(height: longueurPerCent(20, context),),
            _displayLogo(),
            SizedBox(height: longueurPerCent(10, context),),
            displayText("Image")
          ],
        )),
        SizedBox(height: longueurPerCent(20, context),),
        formProduct()
      ],
    );
  }


  void addFamillyOrNot(){
    if (currentIndex == 0 && nomFamille.text!="" && selectFamily==null) {
      try {
        EasyLoading.show(status: 'Chargement', dismissOnTap: false);
        Firestore.instance.collection("Utilisateurs").doc(emailEntreprise).collection("Familles").add({
          "familyName":nomFamille.text,
          "numberOfProduct": 0,
        }).then((value) {
          Firestore.instance.collection("Utilisateurs").doc(emailEntreprise).collection("Familles").doc(value.id).update(
              {"id": value.id}
           );
        });
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Famille ajoutée', maskType: EasyLoadingMaskType.custom);
      } catch(e){
        EasyLoading.showError("L'ajout a échoué", maskType: EasyLoadingMaskType.custom);
        print(e);
      }
      setState(() {
        goNext = true;
        currentIndex++;
        numberSelect.add("1");
      });
    } else if(currentIndex == 0 && nomFamille.text=="" && selectFamily!=null) {
      setState(() {
        goNext = true;
        currentIndex++;
        numberSelect.add("1");
      });
    }
    else if(nomFamille.text=="" && selectFamily==null)
      EasyLoading.showError('Veuillez choisir une famille', maskType: EasyLoadingMaskType.custom);
  }


  void addProduct(){
    if(nomFamille.text!="" && selectFamily==null)
       sendProductDb(nomFamille.text);
    else if(nomFamille.text=="" && selectFamily!=null)
     sendProductDb(selectFamily);
  }


  void sendProductDb(String famille){
    if(famille!=null && prixAchatController.text!="" && prixVenteController.text!="" && stockAlerteController.text!="null" && _image!=null){
      try {
        EasyLoading.show(status: 'Chargement', dismissOnTap: false);
        firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
            .ref(emailEntreprise + "/$famille" + "/" + "${nomDuProduitController.text}")
            .putFile(_image);
        task.whenComplete(() async {
          productImageUrl = await firebase_storage.FirebaseStorage.instance
              .ref(emailEntreprise + "/$famille" + "/" + "${nomDuProduitController.text}")
              .getDownloadURL();
          if(productImageUrl!=null){
            try {
              FirestoreService().addProductInTousLesProduits(
                  Produit(
                      productName: nomDuProduitController.text,
                      familyName: famille,
                      buyingPrice: prixAchatController.text,
                      sellPrice: prixVenteController.text,
                      stockAlert: int.tryParse(stockAlerteController.text),
                      physicalStock: 0,
                      theoreticalStock: 0,
                      image: productImageUrl
                  )
                  , emailEntreprise);
            } catch(e){
              EasyLoading.dismiss();
              print(e);
              EasyLoading.showError("L'ajout a échoué");
              EasyLoading.dismiss();
            }
          }
        });
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Enregistrement réussie!', maskType: EasyLoadingMaskType.custom);
        Navigator.pop(context);
      } catch (e){
        print(e);
        EasyLoading.dismiss();
        EasyLoading.showError("L'ajout a échoué", maskType: EasyLoadingMaskType.custom);
      }
    } else if(famille!=null && prixAchatController.text!="" && prixVenteController.text!="" && stockAlerteController.text!="null" && _image==null){
      try {
        FirestoreService().addProductInTousLesProduits(
            Produit(
                productName: nomDuProduitController.text,
                familyName: famille,
                buyingPrice: prixAchatController.text,
                sellPrice: prixVenteController.text,
                stockAlert: int.tryParse(stockAlerteController.text),
                physicalStock: 0,
                theoreticalStock: 0,
                image: productImageUrl
            )
            , emailEntreprise);
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Enregistrement réussie!', maskType: EasyLoadingMaskType.custom);
        Navigator.pop(context);
      } catch(e){
        EasyLoading.dismiss();
        print(e);
        EasyLoading.showError("L'ajout a échoué");
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Enregistrement réussie!', maskType: EasyLoadingMaskType.custom);
        Navigator.pop(context);
      }
    }
    else {
      EasyLoading.showError("Veuillez remplir tous les champs", maskType: EasyLoadingMaskType.custom);
    }
  }



  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => _image = tempImg);
        break;
    }
  }

  Widget _displayLogo() {
    if (_image == null) {
      return InkWell(
        onTap: () {
          _selectImage(
            // ignore: deprecated_member_use
              ImagePicker.pickImage(
                  source: ImageSource.gallery),
              1);
        },
        child: Container(
          height: 99,
          width: 122,
          child:  Icon(Icons.add, color: secondaryColor,),
          decoration: BoxDecoration(
              border: Border.all(
                color: HexColor("#707070"),
              )),
        ),
      );
    } else {
      return Container(
        height: 140,
        width: 140,
        child: Image.file(
          _image,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  Widget formProduct(){
    return Column(
      children: [
        textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Nom du produit", context), context, nomDuProduitController, TextInputType.text),
        SizedBox(height: longueurPerCent(20, context),),
        textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Prix d'achat", context), context, prixAchatController, TextInputType.number),
        SizedBox(height: longueurPerCent(20, context),),
        textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Prix de vente", context), context, prixVenteController, TextInputType.number),
        SizedBox(height: longueurPerCent(20, context),),
        textFieldWidgetWithNameOfField(nameOfFieldWithPadding("Stock alerte", context), context, stockAlerteController, TextInputType.number), SizedBox(height: longueurPerCent(20, context),),
        SizedBox(height: longueurPerCent(20, context),),
        submitButton(context, "ENREGISTRER", (){
          addProduct();
          setState(() {
            goNext = true;
            if (currentIndex < 1) {
              currentIndex++;
              numberSelect.add("1");
            }
          });
        },)
      ],
    );
  }

}