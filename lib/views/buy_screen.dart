import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bonik_demo/config/route_config.dart';
import 'package:flutter_bonik_demo/constants/color_constant.dart';
import 'package:flutter_bonik_demo/providers/buy_screen_provider.dart';
import 'package:flutter_bonik_demo/utility/image_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class BuyScreen extends StatelessWidget {
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
            ChangeNotifierProvider(create: (context) => BuyScreeProvider()),
          ],
          child: BuyScreenDemo(),
        ),
     );
  }
}

class BuyScreenDemo extends StatefulWidget {
  @override
  BuyScreenDemoState createState() => BuyScreenDemoState();
}

class BuyScreenDemoState extends State<BuyScreenDemo> {
  PageController pageController = PageController(
    initialPage: 0,
  );
  int currentIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_header,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
          "Create Post",
          style: GoogleFonts.openSans(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: color_white),
        ),
      ),
      body: Builder(
        builder: (context) =>
        Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                      color: color_home_bg,
                    ),
                    child: Column(children: [
                      Container(
                        // color:Colors.grey,
                          height: 90,
                          child: Container(
                          )),
                      Expanded(
                          child: PageView(
                            controller: pageController,
                            pageSnapping: false,
                            onPageChanged: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            children: [
                              PageOneWidget(),
                              PageTwoWidget(),
                              PageThreeWidget(),
                              PageFourWidget(),
                            ],
                          )),
                      Container(
                        // color:Colors.grey,
                          height: 70,
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Row(children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  child: _buildPreviousButton(),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  child: _buildNextButton(context),
                                ),
                              ),
                            ),
                          ])),
                    ]),
                  ),
                )
              ],
            ),
      ),
    );
  }

  Widget _buildPreviousButton() {
    return currentIndex > 0
        ? Directionality(
            textDirection: TextDirection.ltr,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: color_header, // background
                onPrimary: color_white, // foreground
              ),
              onPressed: () {
                pageController.animateToPage(--currentIndex,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.bounceInOut);
              },
              icon: Icon(Icons.arrow_back),
              label: Text("Previous",
                  style: GoogleFonts.openSans(
                      fontSize: 16,
                      color: color_white,
                      fontWeight: FontWeight.w600)),
            ))
        : Container();
  }
  Widget _buildNextButton(BuildContext context) {
   var buyScreenProvider= context.watch<BuyScreeProvider>();
    if(currentIndex < 3){
      return Directionality(
          textDirection: TextDirection.rtl,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: color_header, // background
              onPrimary: color_white, // foreground
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              pageController.animateToPage(++currentIndex,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.bounceInOut);
            },
            icon: Icon(Icons.arrow_back),
            label: Text("Next",
                style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: color_white,
                    fontWeight: FontWeight.w600)),
          ));
    }if(currentIndex == 3){
      return Directionality(
          textDirection: TextDirection.rtl,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: color_header, // background
              onPrimary: color_white, // foreground
            ),
            onPressed: ()  async {
              int res = 0;
              FocusScope.of(context).unfocus();
              if(buyScreenProvider.isValid){
                 res= await buyScreenProvider.submitData();
              }else{
                res=-1;
              }
              if(res==-1){
                _showSnackBar(context);
              }else{
                RoutConfig().navigateToScreen(HomeScreen());
              }
            },
            icon: Icon(Icons.mail_sharp),
            label: Text("Post",
                style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: color_white,
                    fontWeight: FontWeight.w600)),
          ));
    }else{
      return Container();
    }
  }
  _showSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("Something wrong please try again",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
          duration: Duration(seconds: 1), backgroundColor: color_red,)
    );
  }
}

class PageOneWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var buyScreenProvider= context.watch<BuyScreeProvider>();
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            text: 'Title',
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: color_big_font),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: color_red,
                                  ))
                            ]),
                      ),
                    ),
                  ),
                  TextField(
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: color_black),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      hintText: "Write Title",
                      hintStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: color_big_font),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color_tf_border_focused, width: 1.0),
                        borderRadius: BorderRadius.circular(12)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color_tf_border_enabled, width: 1.0),
                        borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                    onChanged: (String value) {
                      buyScreenProvider.setTitle(value);
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            text: 'How long the post will appear',
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: color_big_font),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: color_red,
                                  ))
                            ]),
                      ),
                    ),
                  ),
                  TextField(
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: color_black),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      hintText: "Write Days",
                      hintStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: color_big_font),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color_tf_border_focused, width: 1.0),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color_tf_border_enabled, width: 1.0),
                          borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                    onChanged: (String value) {
                      buyScreenProvider.setDays(value);
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            text: 'Category',
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: color_big_font),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: color_red,
                                  ))
                            ]),
                      ),
                    ),
                  ),
                  Consumer<BuyScreeProvider>(
                    builder: (_, provider, __) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                        decoration: BoxDecoration(
                            border: Border.all(color: color_tf_border_enabled, width: 1.0),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: provider.getSelectedCat,
                          hint: Text("Select Category"),
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          iconSize: 36,
                          onChanged: (String newValue) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            provider.setSelectedCat(newValue);
                          },
                          items: provider.getItemCat.
                          map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            text: 'Genre',
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: color_big_font),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: color_red,
                                  ))
                            ]),
                      ),
                    ),
                  ),
                  Consumer<BuyScreeProvider>(
                    builder: (_, provider, __) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                        decoration: BoxDecoration(
                            border: Border.all(color: color_tf_border_enabled, width: 1.0),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: provider.getSelectedGen,
                          hint: Text("Select Genre"),
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          iconSize: 36,
                          onChanged: (String newValue) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            provider.setSelectedGen(newValue);
                          },
                          items: provider.getItemGen.
                          map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageTwoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var buyScreenProvider= context.watch<BuyScreeProvider>();
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            text: 'Qty',
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: color_big_font),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: color_red,
                                  ))
                            ]),
                      ),
                    ),
                  ),
                  TextField(
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: color_black),
                    decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          hintText: "Write Qty",
                          hintStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: color_big_font),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color_tf_border_focused, width: 1.0),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color_tf_border_enabled, width: 1.0),
                          borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                    onChanged: (String value) {
                      buyScreenProvider.setQty(value);
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            text: 'Unit Price',
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: color_big_font),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: color_red,
                                  ))
                            ]),
                      ),
                    ),
                  ),
                  TextField(
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: color_black),
                    decoration: InputDecoration(
                         contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      hintText: "Write Unit Price",
                      hintStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: color_big_font),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color_tf_border_focused, width: 1.0),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color_tf_border_enabled, width: 1.0),
                          borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                    onChanged: (String value) {
                      buyScreenProvider.setUPrice(value);
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            text: 'Minimum Order Qty',
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: color_big_font),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: color_red,
                                  ))
                            ]),
                      ),
                    ),
                  ),
                  TextField(
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: color_black),
                        decoration: InputDecoration(
                     contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      hintText: "Write Oder Qty",
                      hintStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: color_big_font),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color_tf_border_focused, width: 1.0),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color_tf_border_enabled, width: 1.0),
                          borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                    onChanged: (String value) {
                      buyScreenProvider.setMoq(value);
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            text: 'Color variation',
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: color_big_font),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: color_red,
                                  ))
                            ]),
                      ),
                    ),
                  ),

                  RangeSlider(
                    min: 0.0,
                    max: 10.0,
                    divisions: 5,
                    activeColor: color_range_active,
                    inactiveColor: color_range_inactive,
                    labels: RangeLabels(
                      buyScreenProvider.getStartColorValue.round().toString(),
                      buyScreenProvider.getEndColorValue.round().toString(),
                    ),
                    values: RangeValues( buyScreenProvider.getStartColorValue, buyScreenProvider.getEndColorValue),
                    onChanged: (values) {
                      buyScreenProvider.setStartColorValue= values.start;
                      buyScreenProvider.setEndColorValue= values.end;
                    },
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 12.0, right: 12.0),
                    height: 25,
                      child: Row(children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Text(
                                buyScreenProvider.getStartColorValue.round().toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child:Text(
                                buyScreenProvider.getEndColorValue.round().toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageThreeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BuyScreeProvider>(
      builder: (_, provider, __) {
        return Container(
          child: ListView.builder(
              itemCount: provider.getItemSize.length,
              itemBuilder: (context, index){
                return Container(
                  child: RadioListTile<int>(
                    groupValue: provider.getSelectedSizeIndex,
                    title: Text(provider.getItemSize[index].value),
                    value: provider.getItemSize[index].id,
                    onChanged: (newValue) {
                      provider.setSelectedSizeValue(provider.getItemSize[newValue].value);
                      provider.setSelectedSizeIndex(newValue);
                    },
                  )
                );
              }
          ),
        );
      },
    );
  }
}

class PageFourWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Container(
            child: RaisedButton.icon(
              onPressed: (){
                pickImageFromGallery(context);
              },
              icon:Icon(Icons.folder_open),
              label: Text("CHOOSE IMAGE"),
              color: color_header,
              colorBrightness: Brightness.dark,
            ),
          ),
        )
    );
  }

  pickImageFromGallery(BuildContext context) {
    var buyScreenProvider=  Provider.of<BuyScreeProvider>(context, listen: false);;

    ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile) {
      String imgString = ImageUtility.base64String(imgFile.readAsBytesSync());
      buyScreenProvider.setPhoto(imgString);
    });
  }
}