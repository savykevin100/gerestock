import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/pages/accueil.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class FactureViewPdf extends StatefulWidget {
 String pdf;
  FactureViewPdf({this.pdf});
  @override
  _FactureViewPdfState createState() => _FactureViewPdfState();
}

class _FactureViewPdfState extends State<FactureViewPdf> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    //print(widget.pathPdf);
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromFile(File(widget.pdf));

    setState(() => _isLoading = false);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, "Facture pdf"),
        body: Center(
          child: PDF.file(
            File(widget.pdf),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            placeHolder:Container(
              height: 200,
              width: 200,
              color: Colors.red,
            )
          ),
        ),
        floatingActionButton: Center(
          child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height - 60),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Accueil()));
              },
              child: Container(
                height: 38,
                width: 160,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(7)),
                child: Center(
                  child: Text(
                    "IMPRIMER",
                    style: TextStyle(
                        color: white,
                        fontFamily: "MonserratBold",
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}