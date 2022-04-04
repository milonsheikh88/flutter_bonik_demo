import 'package:flutter_bonik_demo/config/route_config.dart';
import 'package:flutter_bonik_demo/constants/color_constant.dart';
import 'package:flutter_bonik_demo/db_helper/database_handler.dart';
import 'package:flutter_bonik_demo/models/post_model.dart';
import 'package:flutter_bonik_demo/providers/home_screen_provider.dart';
import 'package:flutter_bonik_demo/views/post_view_screen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'buy_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: color_home_bg,
        accentColor:color_accent,
      ),
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => HomeScreeProvider()),
          ],
          child: HomeScreenDemo(),
      ),
    );
  }
}

class HomeScreenDemo extends StatefulWidget {
  @override
  HomeScreenDemoState createState() => HomeScreenDemoState();
}

class HomeScreenDemoState extends State<HomeScreenDemo> {
  int currentIndex = 0;
  List<Widget> bodyList = [
    Container(child: PageOneWidget(),),
    Container(child: PageTwoWidget(),),
    Container(child: PageThreeWidget(),),
    Container(child: PageFourWidget(),),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_home_bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      body: bodyList[currentIndex],
      bottomNavigationBar: BottomNavyBar(
        animationDuration: Duration(milliseconds: 400),
        selectedIndex: currentIndex,
        onItemSelected: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('Chat'),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.circle_notifications),
            title: Text('Notification'),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}

class PageOneWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
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
                    autofocus: false,
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
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:buildRowOne(context),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:buildRowTwo(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRowOne(BuildContext context) => Row(
    children: [
      Expanded(child: buyBtn(context)),
      const SizedBox(width: 15),
      Expanded(child: sellBtn(context)),
    ],
  );
  Widget buildRowTwo(BuildContext context) => Row(
    children: [
      Expanded(child: postsBtn(context)),
      const SizedBox(width: 15),
      Expanded(child: buyerBtn(context)),
      const SizedBox(width: 15),
      Expanded(child: pricingBtn(context)),
    ],
  );

  Widget buyBtn(BuildContext context) {
    return InkWell(
       onTap: () =>_showSnackBar(context, "Click Buy Button"),
      child: Material(
        color: color_white,
        elevation: 1.0,
        shadowColor: color_shadow,
        borderRadius: BorderRadius.circular(5.0),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Material(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new Image.asset(
                            "assets/img/buy.png",
                            width: 45.0,
                            height: 45.0,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Buy",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: color_header)),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget sellBtn(BuildContext context) {
    return InkWell(
      onTap: () =>RoutConfig().navigateToScreen(BuyScreen()),
      child: Material(
        color: color_white,
        elevation: 1.0,
        shadowColor: color_shadow,
        borderRadius: BorderRadius.circular(5.0),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Material(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new Image.asset(
                            "assets/img/sell.png",
                            width: 45.0,
                            height: 45.0,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Sell",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: color_header)),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget postsBtn(BuildContext context) {
    return GestureDetector(
      onTap: () =>RoutConfig().navigateToScreen(PostViewScreen()),
      child:Material(
        color: color_white,
        elevation: 1.0,
        shadowColor: color_shadow,
        borderRadius: BorderRadius.circular(5.0),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Material(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new Image.asset(
                            "assets/img/member.png",
                            width: 45.0,
                            height: 45.0,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Posts",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: color_header)),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buyerBtn(BuildContext context) {
    return InkWell(
      onTap: () =>_showSnackBar(context, "Click Buyer Button"),
      child: Material(
        color: color_white,
        elevation: 1.0,
        shadowColor: color_shadow,
        borderRadius: BorderRadius.circular(5.0),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Material(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new Image.asset(
                            "assets/img/buyer.png",
                            width: 45.0,
                            height: 45.0,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Buyer",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: color_header)),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget pricingBtn(BuildContext context) {
    return InkWell(
      onTap: () =>_showSnackBar(context, "Click Pricing Button"),
      child: Material(
        color: color_white,
        elevation: 1.0,
        shadowColor: color_shadow,
        borderRadius: BorderRadius.circular(5.0),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Material(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new Image.asset(
                            "assets/img/pricing.png",
                            width: 45.0,
                            height: 45.0,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Pricing",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: color_header)),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  _showSnackBar(BuildContext context, message) {
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
          duration: Duration(seconds: 1), backgroundColor: color_tf_border_focused,)
    );
  }

}

class PageTwoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color_home_bg,
      child: Align(
        alignment: Alignment.center,
        child: Text("This is Chat Page",
            style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: color_black)),
      ),
    );
  }
}
class PageThreeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color_home_bg,
      child: Align(
        alignment: Alignment.center,
        child: Text("This is Notification Page",
            style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: color_black)),
      ),
    );
  }
}
class PageFourWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color_home_bg,
      child: Align(
        alignment: Alignment.center,
        child: Text("This is Settings Page",
            style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: color_black)),
      ),
    );
  }
}