import 'package:flutter/cupertino.dart';
import 'package:flutter/semantics.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wsu_go/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import './drawer.dart';
// Import Cloud Firestore package
import 'package:cloud_firestore/cloud_firestore.dart';
import '../food_data.dart';


class FoodPage extends StatefulWidget {
  static const String id = 'food_page';

  @override
  _FoodPageState createState() => _FoodPageState();
}

/*
#######################################################

Main construction of page

#######################################################
*/

class _FoodPageState extends State<FoodPage> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: shockerBlack),
          title: Text(
            'Dining Options',
            style: GoogleFonts.josefinSans(
              fontWeight: FontWeight.w800,
              color: shockerBlack,
            ),
          ),
          backgroundColor: shockerYellow,
          bottom: TabBar(
            indicatorColor: shockerBlack,
            labelColor: shockerBlack,
            tabs: [
              Tab(
                icon: Icon(Icons.place),
                text: 'Food Truck Plaza',
              ),
              Tab(
                icon: Icon(Icons.fastfood),
                text: 'Other',
              ),
            ],
          ),
        ),
        drawer: CustomDrawer(),
        body: TabBarView(
          children: [
            TwitterAPI(),
            rscData(),
          ],
        ),
      ),
    );
  }
}

/*
#######################################################

Construction of Food Truck Plaza tab

#######################################################
*/

class TwitterAPI extends StatefulWidget {
  @override
  _TwitterAPIState createState() => _TwitterAPIState();
}

class _TwitterAPIState extends State<TwitterAPI> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      WebView(
        initialUrl: 'https://jtseiler15.github.io/',
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (finish) {
          setState(() {
            isLoading = false;
          });
        },
      ),
      isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(),
    ]);
  }
}

/*
#######################################################

Construction of rscData tab

#######################################################
*/

//Going to display the RSC data from Firestore
class rscData extends StatefulWidget {
  @override
  _rscDataState createState() => _rscDataState();
}

class _rscDataState extends State<rscData> {
  //List of Restaurant Objects that are waiting to be added when going through Restaurant Collection in Firestore
  List<Restaurant> restaurantObjects = [];

  @override
  Widget build(BuildContext context) {
    //Creating a stream variable that holds <QuerySnapshots> of 'rscData' collection
    Stream collectionStream = FirebaseFirestore.instance.collection('rscData').snapshots();

    //Using StreamBuilder widget to have app change data when Database is changed
    return StreamBuilder<QuerySnapshot>(
      //Passing our steam into stream property
      stream: collectionStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        //If Connection is done
        if (snapshot.hasData) {
          //Final variable to hold a List<QueryDocumentSnapshots>
          final restaurants = snapshot.data.docs;
          //Cycling through each Document (Restaurants)
          for (var restaurant in restaurants) {
            //Create a Restaurant Object and pass it to the restaurantObjects variable
            restaurantObjects.add(Restaurant(
                location: restaurant.data()['location'],
                mon: restaurant.data()['mon'],
                tue: restaurant.data()['tue'],
                wed: restaurant.data()['wed'],
                thu: restaurant.data()['thu'],
                fri: restaurant.data()['fri'],
                sat: restaurant.data()['sat'],
                sun: restaurant.data()['sun']));
          }
        }

        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Rhatigan Student Center',
                textAlign: TextAlign.left,
                style: GoogleFonts.josefinSans(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: shockerBlack,
                ),
              ),
            ),
            Divider(
              color: shockerBlack,
              height: 10,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: restaurantObjects.length,
                itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurantObjects[index].location,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.josefinSans(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: shockerBlack,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '\t\t\t\tSunday:',
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: shockerBlack,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: Text(
                                    restaurantObjects[index].sun,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: shockerBlack,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: SizedBox(width: 30),
                                  flex: 3,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '\t\t\t\tMonday:',
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: shockerBlack,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: Text(
                                    restaurantObjects[index].mon,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: shockerBlack,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: SizedBox(width: 30),
                                  flex: 3,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '\t\t\t\tTuesday:',
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: shockerBlack,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: Text(
                                    restaurantObjects[index].tue,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: shockerBlack,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: SizedBox(width: 30),
                                  flex: 3,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '\t\t\t\tWednesday:',
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: shockerBlack,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: Text(
                                    restaurantObjects[index].wed,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: shockerBlack,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: SizedBox(width: 30),
                                  flex: 3,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '\t\t\t\tThursday:',
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: shockerBlack,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: Text(
                                    restaurantObjects[index].thu,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: shockerBlack,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: SizedBox(width: 30),
                                  flex: 3,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '\t\t\t\tFriday:',
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: shockerBlack,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: Text(
                                    restaurantObjects[index].fri,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: shockerBlack,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: SizedBox(width: 30),
                                  flex: 3,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '\t\t\t\tSaturday:',
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: shockerBlack,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: Text(
                                    restaurantObjects[index].sat,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: shockerBlack,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: SizedBox(width: 30),
                                  flex: 3,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
