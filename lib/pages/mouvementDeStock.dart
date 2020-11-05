import 'package:flutter/material.dart';
import 'package:gerestock/constantes/color.dart';

class MouvementDeStock extends StatefulWidget {
  @override
  _MouvementDeStockState createState() => _MouvementDeStockState();
}

class _MouvementDeStockState extends State<MouvementDeStock> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    double deviceHeight = queryData.size.height;
    return Scaffold(
      appBar: AppBar(
      backgroundColor: bleuPrincipale,
        elevation: 0.0,
        title: Text("Mouvements de stock",style: TextStyle(fontWeight: FontWeight.bold,
        fontSize: 20),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: <Widget>[
                _happyVeganCard( "Entrées",bleuPrincipale,Icons.arrow_downward,deviceHeight),
                _happyVeganCard( "Sorties", Color(0xFFB2C40F),Icons.arrow_upward,deviceHeight),
              ],
            ),
            Card(
              color: Colors.white,
              child: Column(
                children: [

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _happyVeganCard(String title, Color couleur,IconData icone ,double deviceHeight) {
    void moveToFoodDetailsScreen() {
      Navigator.of(context).pushNamed("/"+title);
    }
    return new GestureDetector(
      onTap: () => moveToFoodDetailsScreen(),
      child: Container(
          width: 175,
          padding:EdgeInsets.only(left: 5.0,right: 5.0),
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 0.0),
                      child: Container(
                        height: (deviceHeight/3.8),
                        width: MediaQuery.of(context).size.width/2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5.0),
                              topLeft: Radius.circular(5.0)),
                          color: couleur,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(icone,color: Colors.white,size: 80,),
                            SizedBox(height: 5.0),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(title,style:TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,fontSize: 15)),
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}