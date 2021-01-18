

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/firestore_service.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/helper.dart';
import 'package:gerestock/modeles/facture.dart';
import 'package:gerestock/pages/facturations/factureViewPdf.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';





class Facturation2 extends StatefulWidget {
  static String id = "Facturation2";
  String dateInput;
  String client;
  List<Map<String, dynamic>> products;
  bool typeFacturation;
  String emailEntreprise;

  Facturation2({
    this.dateInput,
    this.client,
    this.products,
    this.typeFacturation,
    this.emailEntreprise
   });

  @override
  _Facturation2State createState() => _Facturation2State();
}

class _Facturation2State extends State<Facturation2> {
  String _emailEntreprise;
  Map<String, dynamic> _userData;
  int _amountTotal =0;
  String pathPDF = "";
  String ifu;




  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> fetchDataUser(){
    FirebaseFirestore.instance.collection("Utilisateurs").doc(_emailEntreprise).get().then((value) {
      print(value.data());
      if(this.mounted)
        setState(() {
          _userData = value.data();
          ifu=_userData["ifu"];
        });
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value){
      if(value!=null){
        setState(()  {
          _emailEntreprise = value.email;
        });
        fetchDataUser();
      }
    });
    widget.products.forEach((element) {
      setState(() {
        _amountTotal=_amountTotal + int.tryParse(element["quantite"]) * int.tryParse(element["sellPriceProduct"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextClasse(text: "Facturation", color: white, fontSize: 20, textAlign: TextAlign.center, family: "MonserratBold",),
        backgroundColor: primaryColor,
      ),
      body: Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: largeurPerCent(9, context), vertical: longueurPerCent(50, context)),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: white,
          child: bodyInCard(),
        ),
      ),
        floatingActionButton: Center(
          child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height - 60),
            child:InkWell(
              onTap:(){
                addFacture();
              },
              child: Padding(
                padding:  EdgeInsets.only(left:15,right:5,),
                child: Container(
                  height: 38,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: primaryColor,
                  ),
                  child: Center(
                      child: Text(
                        "VALIDER LA FACTURE",
                        style: TextStyle(
                            color: white,
                            fontFamily: "MonserratBold",
                            fontSize: 15),
                      )
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }


  Widget bodyInCard(){
    return ListView(
      children: [
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Container(
                height:80,
                width: 80,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: HexColor("#C9C9C9"),)
                ),
                child: //(_userData["logo"]=="")?Center(child: TextClasse(text: "Logo", family: "MonserratBold", fontSize: 20,))/
                (_userData!=null)?CachedNetworkImage(
                  imageUrl: _userData["logo"],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color:Colors.red, height: 110, width: largeurPerCent(210, context),),
                ):Center(child: TextClasse(text: "Logo", family: "MonserratBold", fontSize: 20,))
            ),
            /* RichText(
                    text: TextSpan(
                      text: 'FACTURE N° ',
                      style: TextStyle(fontSize: 10,color: HexColor("#C9C9C9"), fontFamily: "MonserratBold"),
                      children: <TextSpan>[
                        TextSpan(text: '1487', style: TextStyle(fontFamily: "MonserratBold", color: HexColor("#000000"))),
                      ],
                    ),
                  ),*/
            /*Column(
              children: [
                SizedBox(height: 10,),
                displayText(Helper.currentFormatDate(widget.dateInput)),
                SizedBox(height: 10,),
                (_userData!=null)?displayText(_userData["address"]):Text(""),
                /*SizedBox(height: 10,),
                displayText(_userData["ifu"]),*/
                SizedBox(height: 10,),
                (_userData!=null)?displayText(_userData["telephoneNumber"]):Text(""),
                SizedBox(height: 10,),
                (_userData!=null)?displayText(_userData["ifu"]):Text(""),
              ],
            ),*/
          ],
        ),
        SizedBox(height: 20,),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              RichText(
                text: TextSpan(
                  text: "Nom du client:     ",
                  style: TextStyle(fontSize: 10,color: HexColor("#C9C9C9"), fontFamily: "MonserratBold"),
                  children: <TextSpan>[
                    TextSpan(text: '${widget.client}', style: TextStyle(fontFamily: "MonserratBold", color: HexColor("#000000"))),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 56,),
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex:1,
                        child: (widget.typeFacturation==false)?displayRecapTextBold("Nom du produit"):displayRecapTextBold("Service")),
                    (widget.typeFacturation==false)?Expanded(
                        flex:1,
                        child: displayRecapTextBold("Quantité")):Text(""),
                    (widget.typeFacturation==false)?Expanded(
                        flex: 1,
                        child: displayRecapTextBold("Prix Unitaire")):Text(""),
                    (widget.typeFacturation==true)?SizedBox(width: 50,):Text(""),
                    Expanded(
                        flex: 1,
                        child: displayRecapTextBold("Montant")),
                  ],
                ),
                SizedBox(height: 20,),
                StaggeredGridView.countBuilder(
                  crossAxisCount: 1,
                  itemCount: widget.products.length,
                  itemBuilder: (context, i) {
                    return Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          (widget.typeFacturation==false)?Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              (widget.typeFacturation==false)?autoSizeTextGrey(widget.products[i]["productName"]):autoSizeTextGrey(widget.products[i]["service"]),
                              (widget.typeFacturation==false)?autoSizeTextGrey(widget.products[i]["quantite"]):autoSizeTextGrey("1"),
                              autoSizeTextGrey(Helper.currenceFormat(int.tryParse(widget.products[i]["sellPriceProduct"]))),
                              autoSizeTextGrey(Helper.currenceFormat(int.tryParse(widget.products[i]["sellPriceProduct"])*int.tryParse(widget.products[i]["quantite"]))),
                            ],
                          ):Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              autoSizeTextGrey(widget.products[i]["service"]),
                              SizedBox(width: 50,),
                              autoSizeTextGrey(Helper.currenceFormat(int.tryParse(widget.products[i]["sellPriceProduct"]))),
                            ],
                          ),
                          Divider(color: HexColor("#ADB3C4"),)
                        ],
                      ),

                    );
                  },
                  staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 0.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                )
              ],
            )
        ),

        SizedBox(height: longueurPerCent(20, context),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextClasse(text: "Montant", family: "MonserratBold", fontSize: 25, color: HexColor("#001C36"),),
            TextClasse(text:Helper.currenceFormat(_amountTotal), family: "MonserratBold", fontSize: 15, color: HexColor("#001C36"),),
          ],
        )
      ],
    );
  }


  Future<void> generateInvoice() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219, 255)));
    //Generate PDF grid.
    final PdfGrid grid = getGrid();
    //Draw the header section by creating text element
    final PdfLayoutResult result = drawHeader(page, pageSize, grid);
    //Draw grid
    drawGrid(page, grid, result);
    //Add invoice footer
    drawFooter(page, pageSize);
    //Save and launch the document
    final List<int> bytes = document.save();
    //Dispose the document.
    document.dispose();
    //Get the storage folder location using path_provider package.
    final Directory directory = await getExternalStorageDirectory();
    final String path = directory.path;
    final File file = File('$path/${DateTime.now()}.pdf');
    await file.writeAsBytes(bytes);
    //Launch the file (used open_file package)
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => FactureViewPdf(pdf: file.path)));

  }

  //Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215, 255)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width , 90));
    //Draw string
    page.graphics.drawString(
        _userData["companyName"], PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    /*page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));*/

   /* page.graphics.drawString("100 000 FCFA",
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));*/

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    /*page.graphics.drawString('Montant total', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));*/
    //Create data foramt and convert it to text.

   // final DateFormat format = DateFormat.yMMMMd('fr');
    final String invoiceNumber = 'Numéro de facture: 2058557939\r\n\r\nDate: ' +
        /*format.format(DateTime.now())*/DateTime.now().toString().substring(0, 19);
    final Size contentSize = contentFont.measureString(invoiceNumber);

     String address = '''N°IFU: ${_userData["ifu"]} \r\n\r\nAdresse: ${_userData["country"]}, \r\n\r\nNuméro: ${_userData["telephoneNumber"]}''';

    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));

    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120));
  }

  //Draws the grid
  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect totalPriceCellBounds;
    Rect quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0));

    //Draw grand total.
    page.graphics.drawString('Montant Total:',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds.left,
            result.bounds.bottom + 10,
            quantityCellBounds.width,
            quantityCellBounds.height));
    page.graphics.drawString("$_amountTotal FCFA",
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds.left,
            result.bounds.bottom + 10,
            totalPriceCellBounds.width,
            totalPriceCellBounds.height));
  }

  //Draw the invoice footer data.
  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
    PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));

     String footerContent =
    '''Des questions? ${_userData["email"]}''';

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }

  //Create PDF grid and return
  PdfGrid getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 4);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    //headerRow.cells[0].value = 'Product Id';
    headerRow.cells[0].value = (widget.typeFacturation==false)?'Nom du produit': "Service";
    headerRow.cells[1].value = 'Prix';
    headerRow.cells[2].value = 'Quantité';
    headerRow.cells[3].value = 'Montant';
    //Add rows
    for(int i=0; i<widget.products.length; i++){
      addProducts((widget.typeFacturation==false)?widget.products[i]["productName"]:widget.products[i]["service"], int.tryParse(widget.products[i]["sellPriceProduct"]),
          int.tryParse(widget.products[i]["quantite"]),int.tryParse(widget.products[i]["sellPriceProduct"])*int.tryParse(widget.products[i]["quantite"]),
          grid);
    }
   /* addProducts('AWC Logo Cap', 8.99, 2, 17.98, grid);
    addProducts( 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
    addProducts('Mountain Bike Socks,M', 9.5, 2, 19, grid);
    addProducts('Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
    addProducts('ML Fork', 175.49, 6, 1052.94, grid);
    addProducts('Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);*/
    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Set gird columns width
    grid.columns[1].width = 100;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        /*if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }*/
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void addProducts(/*String productId*/ String productName, int price,
      int quantity, int total, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
   // row.cells[0].value = productId;
    row.cells[0].value = productName;
    row.cells[1].value = price.toString();
    row.cells[2].value = quantity.toString();
    row.cells[3].value = total.toString();
  }



  TextClasse  displayRecapTextBold(String text){
    return TextClasse(text: text, color: HexColor("#001C36"), family: "MonserratBold", fontSize: 9,);
  }

  TextClasse  displayRecapTextGrey(String text){
    return TextClasse(text: text, color: HexColor("#C9C9C9"), family: "MonserratBold", fontSize: 12,);
  }




  Expanded autoSizeTextGrey(String titre){
   return Expanded(
       flex: 1,
       child: AutoSizeText(
     titre,
     style: TextStyle(fontSize: 10.0, fontFamily: "MonserratBold", color: HexColor("C9C9C9")),
     maxLines:(widget.typeFacturation==false)? 3:6,
     minFontSize: 9,
    )
   );
  }

  Future<void> addFacture() {
    // On ajoute la facture
    try {
      EasyLoading.show(status: 'Chargement', dismissOnTap: false);
      FirestoreService().addFacture(Facture(
          customerName: widget.client,
          created: widget.dateInput,
          amountTotal: _amountTotal,
          billingType: (widget.typeFacturation==false)?"Ventes":"Services",
          products: widget.products
      ), widget.emailEntreprise);

      // On parcourt le tableau des produits et on met à jour les quantités dans la base de données

      for(int i=0; i<widget.products.length;i++) {
        print(widget.products[i]);
        FirebaseFirestore.instance.collection("Utilisateurs").doc(_emailEntreprise).collection("TousLesProduits").doc(widget.products[i]["idProduct"]).update({"theoreticalStock": widget.products[i]["remainingQuantity"]}).then((value){
          print("Réussie");
        });
      }
      EasyLoading.dismiss();
      EasyLoading.showSuccess("L'ajout a réussie");
      generateInvoice();
    } catch (e){
      print(e);
      EasyLoading.dismiss();
      EasyLoading.showError("L'ajout a échoué");
      EasyLoading.dismiss();
    }
  }
}
