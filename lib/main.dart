import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerestock/authentification/connexion.dart';
import 'package:gerestock/authentification/informations_supplementaire.dart';
import 'package:gerestock/authentification/inscription.dart';
import 'package:gerestock/pages/abonnement_settings.dart';
import 'package:gerestock/pages/accueil.dart';
import 'package:gerestock/pages/caisse/caisse.dart';
import 'package:gerestock/pages/caisse/encaissement.dart';
import 'package:gerestock/pages/clients/clients.dart';
import 'package:gerestock/pages/clients/ficheClient.dart';
import 'package:gerestock/pages/caisse/decaissement.dart';
import 'package:gerestock/pages/depenses/depenses.dart';
import 'package:gerestock/pages/depenses/nouvelleDepense.dart';
import 'package:gerestock/pages/mouvementsDeStock/confirmEntrees.dart';
import 'package:gerestock/pages/mouvementsDeStock/entrees.dart';
import 'package:gerestock/pages/facturations/facturation1.dart';
import 'package:gerestock/pages/facturations/facturation2.dart';
import 'package:gerestock/pages/inventaire/inventaire.dart';
import 'package:gerestock/pages/mouvementsDeStock/mouvementDeStock.dart';
import 'package:gerestock/pages/nouveauProduit/familles.dart';
import 'package:gerestock/pages/parametres.dart';
import 'package:gerestock/pages/mouvementsDeStock/sorties.dart';
import 'package:gerestock/pages/payement/select_test_mode_or_payement.dart';
import 'package:gerestock/spash_screen.dart';
import 'package:gerestock/test.dart';
import 'package:gerestock/widgets/fournisseurs/fournisseursClientsWidget.dart';
import 'constantes/hexadecimal.dart';
import 'pages/mouvementsDeStock/ficheEntrees.dart';







Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gerestock',
      theme: ThemeData(
        primaryColor:HexColor("#3675BD"),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: SplashScreen(),
      routes: <String, WidgetBuilder> {
        '/inscription': (BuildContext context) => Inscription(),
        '/connexion': (BuildContext context) => Connexion(),
        '/accueil': (BuildContext context) =>Accueil(),
        '/Clients': (BuildContext context) => Clients(),
        '/FicheClient': (BuildContext context) => FicheClient(),
        '/Produits': (BuildContext context) => Produits(),
        '/Mouvement de Stock': (BuildContext context) => MouvementDeStock(),
        '/Facturation': (BuildContext context) => Facturation1(),
        '/Facturation2': (BuildContext context) => Facturation2(),
        '/Caisse': (BuildContext context) => Caisse(),
        '/Inventaire': (BuildContext context) => Inventaire(),
        '/Abonnement': (BuildContext context) => AbonnementSettings(),
        '/Dépenses': (BuildContext context) => Depenses(),
        '/Paramètres': (BuildContext context) => Parametres(),
        '/Entrées': (BuildContext context) => Entrees(),
        '/Sorties': (BuildContext context) => Sorties(),
        '/Encaissement': (BuildContext context) => Encaissement(),
        '/Décaissement': (BuildContext context) => Decaissement(),
        '/FicheEntrees': (BuildContext context) => FicheEntrees(),
        '/ConfirmEntrees': (BuildContext context) => ConfirmEntrees(),
        '/NouvelleDepense': (BuildContext context) => NouvelleDepense(),
        '/HomePage': (BuildContext context) => HomePage(),
        '/SpashScreen': (BuildContext context) => SplashScreen(),
        '/InformationSupplementaires': (BuildContext context) => InformationSupplementaire(),
        '/ClientsFournisseurs': (BuildContext context) => FournisseursClientsWidget(),
        '/TestModeOrPayement': (BuildContext context) => TestModeOrPayement(),
      },
      builder: (BuildContext context, Widget child) {
        /// make sure that loading can be displayed in front of all other widgets
        return FlutterEasyLoading(child: child);
      },
    );
  }
}

/*import 'dart:io';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


void main() {
  runApp(CreatePdfWidget());
}

/// Represents the PDF widget class.
class CreatePdfWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CreatePdfStatefulWidget(title: 'Create PDF document'),
    );
  }
}

/// Represents the PDF stateful widget class.
class CreatePdfStatefulWidget extends StatefulWidget {
  /// Initalize the instance of the [CreatePdfStatefulWidget] class.
  const CreatePdfStatefulWidget({Key key, this.title}) : super(key: key);

  /// title.
  final String title;
  @override
  _CreatePdfState createState() => _CreatePdfState();
}

class _CreatePdfState extends State<CreatePdfStatefulWidget> {

  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    //loadDocument();
  }

  loadDocument(String path) async {
    await PDFDocument.fromAsset(path);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: const Text(
                'Generate PDF',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: generateInvoice,
            ),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : PDFViewer(
              document: document,
              zoomSteps: 1,
            ),
          ],
        ),
      ),
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
    final Directory directory =
    await path_provider.getApplicationDocumentsDirectory();
    final String path = directory.path;
    print(path);
    final File file = File('$path/output.pdf');
    await file.writeAsBytes(bytes);
    //Launch the file (used open_file package)
    loadDocument(file.path);

  }

  //Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215, 255)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(
        'INVOICE', PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));

    page.graphics.drawString('\$' + getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Amount', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber = 'Invoice Number: 2058557939\r\n\r\nDate: ' +
        format.format(DateTime.now());
    final Size contentSize = contentFont.measureString(invoiceNumber);
    const String address = '''Bill To: \r\n\r\nAbraham Swearegin, 
        \r\n\r\nUnited States, California, San Mateo, 
        \r\n\r\n9920 BridgePointe Parkway, \r\n\r\n9365550136''';

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
    page.graphics.drawString('Grand Total',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds.left,
            result.bounds.bottom + 10,
            quantityCellBounds.width,
            quantityCellBounds.height));
    page.graphics.drawString(getTotalAmount(grid).toString(),
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

    const String footerContent =
    '''800 Interchange Blvd.\r\n\r\nSuite 2501, Austin,
         TX 78721\r\n\r\nAny Questions? support@adventure-works.com''';

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
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Product Id';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Product Name';
    headerRow.cells[2].value = 'Price';
    headerRow.cells[3].value = 'Quantity';
    headerRow.cells[4].value = 'Total';
    //Add rows
    addProducts('CA-1098', 'AWC Logo Cap', 8.99, 2, 17.98, grid);
    addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
    addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2, 19, grid);
    addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
    addProducts('FK-5136', 'ML Fork', 175.49, 6, 1052.94, grid);
    addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);
    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Set gird columns width
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void addProducts(String productId, String productName, double price,
      int quantity, double total, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = productId;
    row.cells[1].value = productName;
    row.cells[2].value = price.toString();
    row.cells[3].value = quantity.toString();
    row.cells[4].value = total.toString();
  }

  //Get the total amount.
  double getTotalAmount(PdfGrid grid) {
    double total = 0;
    for (int i = 0; i < grid.rows.count; i++) {
      final String value = grid.rows[i].cells[grid.columns.count - 1].value;
      total += double.parse(value);
    }
    return total;
  }
}*/

