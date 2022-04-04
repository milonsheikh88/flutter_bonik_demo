import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bonik_demo/config/route_config.dart';
import 'package:flutter_bonik_demo/constants/color_constant.dart';
import 'package:flutter_bonik_demo/db_helper/database_handler.dart';
import 'package:flutter_bonik_demo/models/post_model.dart';
import 'package:flutter_bonik_demo/utility/image_utility.dart';
import 'package:flutter_bonik_demo/views/dtails_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class PostViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: color_home_bg,
        accentColor:color_accent,
      ),
      home: PostViewScreenDemo(),
     );
  }
}

class PostViewScreenDemo extends StatelessWidget{
  final _handler = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_header,
        elevation: 0.0,
        centerTitle: false,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: color_white,
              size: 24,
            ),
            onPressed: () => RoutConfig().goBack(HomeScreen())),
        title: Text(
          "Post List",
          style: GoogleFonts.openSans(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: color_white),
        ),
      ),
      body: Container(
        color: color_home_bg,
        // padding: EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: _handler.getAllPost(),
          builder: (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 100.00,
                    child:GestureDetector(
                      onTap: () => _showDetails(context,snapshot.data[index]),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        color: Colors.white,
                        elevation: 10,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.28,
                                  maxHeight: MediaQuery.of(context).size.width * 0.28,
                                ),
                                child:ImageUtility.imageFromBase64String(snapshot.data[index].photo),
                              ),
                            ),

                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.42,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                                      child: Text(
                                        snapshot.data[index].title,
                                        style: GoogleFonts.openSans(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: color_big_font),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.42,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                      child: Text(
                                          'Category: ${snapshot.data[index].cat}',
                                          style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              color: color_black)
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.42,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                      child: Text(
                                          'Qty: ${snapshot.data[index].qty}',
                                          style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              color: color_black)
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            Column(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.25,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Day: ${snapshot.data[index].days}',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.25,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Price: ${snapshot.data[index].price}',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
               },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  _showDetails(BuildContext context, PostModel item) {
    RoutConfig().navigateToScreen(DetailsScreen(postId: item.id));
  }
}