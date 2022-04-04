import 'package:flutter_bonik_demo/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: color_home_bg,
          accentColor:color_accent,
        ),
        home: Scaffold(
          backgroundColor: color_home_bg,
            appBar: AppBar(
              elevation: 0.0,
              centerTitle: true,
              leading: IconButton(icon: Icon(Icons.menu, color: color_big_font, size: 30,),),
              title: Text("Bonik",
                style: GoogleFonts.openSans(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: color_big_font),
              ),
              actions: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/img/user.png'),
                )
              ],
            ),

          body: Column(
            children: [
              Container(
                height: 45,
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color_tf_bg),
                child: Stack(
                  children: <Widget>[
                    TextField(
                      maxLengthEnforced: true,
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: color_black,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15, bottom: 5),
                          border: InputBorder.none,
                          hintText: 'Search...',
                          hintStyle: GoogleFonts.openSans(
                              fontSize: 16,
                              color: color_grey,
                              fontWeight: FontWeight.w600)),
                    ),
                    Positioned(
                      right: 0,
                      child: new Image.asset(
                        'assets/img/background_search.png',
                        width: 45.0,
                        height: 45.0,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 9,
                      child: new Image.asset(
                        'assets/img/search.png',
                        width: 28.0,
                        height: 28.0,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StaggeredGridView.count(
                      crossAxisCount: 6,
                      staggeredTiles: _cardTile,
                      children: _listTile,
                      mainAxisSpacing: 24.0,
                      crossAxisSpacing: 12.0,
                    ),
                  ),
              ),
            ],
          ),
       )
    );
  }
}

class BackGroundTile extends StatelessWidget {
  final String imgName, title;
  final Color color;
  BackGroundTile({this.imgName, this.title,this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color_white,
      elevation: 2.0,
      shadowColor: color_shadow,
      borderRadius: BorderRadius.circular(5.0),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Material(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: new Image.asset(
                        "assets/img/${imgName}",
                        width: 45.0,
                        height: 45.0,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(title,
                        style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: color)),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

//List of Cards with size
List<StaggeredTile>  _cardTile = <StaggeredTile> [
  StaggeredTile.extent(3, 120.0),
  StaggeredTile.extent(3, 120.0),
  StaggeredTile.extent(2, 120.0),
  StaggeredTile.extent(2, 120.0),
  StaggeredTile.extent(2, 120.0),
];

//List of Cards with color and icon
List<Widget>_listTile = <Widget>[
  BackGroundTile(imgName: "buy.png", title:"Buy",color: color_header,),
  BackGroundTile(imgName: "sell.png",  title:"Sell",color: color_header,),
  BackGroundTile(imgName: "member.png",  title:"Merchants",color: color_accent,),
  BackGroundTile(imgName: "buyer.png",  title:"Buyer",color: color_accent,),
  BackGroundTile(imgName: "pricing.png",  title:"Pricing",color: color_accent,),
];
