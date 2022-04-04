import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bonik_demo/config/route_config.dart';
import 'package:flutter_bonik_demo/constants/color_constant.dart';
import 'package:flutter_bonik_demo/db_helper/database_handler.dart';
import 'package:flutter_bonik_demo/models/post_model.dart';
import 'package:flutter_bonik_demo/providers/buy_screen_provider.dart';
import 'package:flutter_bonik_demo/utility/image_utility.dart';
import 'package:flutter_bonik_demo/views/post_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class DetailsScreen extends StatelessWidget {
  int postId;

  DetailsScreen({Key key, @required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: color_home_bg,
        accentColor: color_accent,
      ),
      home: DetailsScreenDemo(postId: postId),
    );
  }
}

class DetailsScreenDemo extends StatelessWidget {
  int postId;

  DetailsScreenDemo({Key key, @required this.postId}) : super(key: key);
  final _handler = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_home_bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: false,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: color_black,
              size: 24,
            ),
            onPressed: () => RoutConfig().goBack(PostViewScreen())),
        title: Text(
          "Post Details",
          style: GoogleFonts.openSans(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: color_black),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                color: color_range_inactive,
              ),
              child: Column(children: [
                Expanded(
                  child: Container(
                    color: color_home_bg,
                    child: FutureBuilder(
                      future: _handler.getPostById(postId),
                      builder: (BuildContext context, AsyncSnapshot<
                          List<PostModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 100,
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.50,
                                          child: Stack(
                                              children: <Widget>[

                                                ImageUtility.imageFromBase64String(snapshot.data[index].photo),

                                                Align(
                                                  alignment: Alignment.topCenter,
                                                  child: Text(
                                                    snapshot.data[index].title,
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.w600,
                                                        color: color_big_font),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.bottomLeft,
                                                  child: Text(
                                                    "Qty: ${snapshot.data[index].qty}",
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.w600,
                                                        color: color_big_font),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: Text(
                                                    "Price: ${snapshot.data[index].price}",
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.w600,
                                                        color: color_big_font),
                                                  ),
                                                ),
                                              ]
                                          )

                                      ),
                                    ),

                                    Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.5,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                                                  child: Text(
                                                      'Category: ${snapshot.data[index].cat}',
                                                      style: GoogleFonts.openSans(
                                                          fontSize: 14,
                                                          color: color_black)
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.5,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                                                  child: Text(
                                                      'Genere: ${snapshot.data[index].gen}',
                                                      style: GoogleFonts.openSans(
                                                          fontSize: 14,
                                                          color: color_black)
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.5,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                                                  child: Text(
                                                      'Days: ${snapshot.data[index].days}',
                                                      style: GoogleFonts.openSans(
                                                          fontSize: 14,
                                                          color: color_black)
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.5,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
                                                    child:  Align(
                                                    alignment: Alignment.centerRight,
                                                      child: Text(
                                                          'Min order qty: ${snapshot.data[index].moq}',
                                                          style: GoogleFonts.openSans(
                                                              fontSize: 14,
                                                              color: color_black)
                                                      ),
                                                    )

                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.5,
                                                child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
                                                    child:  Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Text(
                                                          'Color variation: ${snapshot.data[index].scolor} - ${snapshot.data[index].ecolor}',
                                                          style: GoogleFonts.openSans(
                                                              fontSize: 14,
                                                              color: color_black)
                                                      ),
                                                    )

                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.5,
                                                child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
                                                    child:  Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Text(
                                                          'Size: ${snapshot.data[index].size}',
                                                          style: GoogleFonts.openSans(
                                                              fontSize: 14,
                                                              color: color_black)
                                                      ),
                                                    )

                                                ),
                                              ),
                                            ],
                                          ),
                                        ]
                                    )

                                  ],
                                ),

                              );
                            },
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),),
                Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.10,
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 200,
                            height: 50,
                            child: _buildNextButton(),
                          ),
                        ),
                      ),
                    ])),
              ]),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: color_header, // background
            onPrimary: color_white, // foreground
          ),

          onPressed: () => RoutConfig().replaceScreen(HomeScreen()),

          icon: Icon(Icons.arrow_back),
          label: Text("Go Home",
              style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: color_white,
                  fontWeight: FontWeight.w600)),
        ));
  }
}
