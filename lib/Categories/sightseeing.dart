import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourify/Categories/religious.dart';
import 'package:tourify/Categories/tour_description.dart';

import '../components/advanture_card.dart';
import 'adventurous.dart';

class SightSeeing extends StatelessWidget {
  const SightSeeing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sight Seeing Tours'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            color: Colors.white,
            onPressed: () {
              // Handle three dots button press here
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            color: Colors.white,
            onPressed: () {
              // Handle three dots button press here
            },
          ),
        ],
        backgroundColor: Color(0xff1034A6),
      ),
      body: SingleChildScrollView(
        child:
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Positioned(
                    top: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xff1034A6),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0),
                        ),
                      ),
                    )),
                Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                ),
                Positioned(
                  top: 80,
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Pick an Adventure',style:
                                GoogleFonts.abel(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
                                // DropdownButton(items: , onChanged: onChanged)
                                Padding(
                                  padding: const EdgeInsets.only(left: 64.0),
                                  child: Icon(Icons.keyboard_arrow_down,color:Colors.white, size: 14,),
                                ),
                                Text('Filter',
                                  style:
                                  GoogleFonts.abel(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),),
                              ],
                            ),
                          ),
                          SizedBox(height: 70,),
                          StreamBuilder(
                            stream: FirebaseDatabase.instance
                                .ref()
                                .child('Tours')
                                .child('SightSeeing')
                                .onValue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                // Extract data from the snapshot
                                var data = snapshot.data!.snapshot.value;
                                if (data != null && data is Map) {
                                  // Create a list of AdventureCard widgets from the data
                                  List<Widget> adventureCards = [];
                                  data.forEach((key, value) {
                                    if(value is Map){
                                      var adventureData = value as Map<Object?, Object?>;
                                      adventureCards.add(
                                        GestureDetector(
                                          onTap: (){
                                            // Create a Map containing all the necessary data
                                            Map<String, dynamic> tourData = {
                                              "imageUrl": "assets/sightseeing.jpg",
                                              "title": adventureData['Title']?.toString() ?? "",
                                              "ratings": int.parse(adventureData['Rating']?.toString() ?? '0'),
                                              "duration": adventureData['Duration']?.toString() ?? "",
                                              "departure": adventureData['Departure']?.toString() ?? "",
                                              "description": adventureData['Discription']?.toString() ?? "",
                                              "price": double.parse(adventureData['Budget']?.toString() ?? '0.0'),
                                              "Category": adventureData['Category']?.toString() ?? "",
                                              "date": adventureData['Date']?.toString() ?? "",
                                            };

                                            // Navigate to the "tourDescription" screen with the data
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => TourDescriptionScreen(data: tourData),
                                              ),
                                            );
                                          },
                                          child: AdventureCard(
                                            imageUrl: "assets/sightseeing.jpg",
                                            title: adventureData['Title']?.toString() ?? "",
                                            ratings: int.parse(adventureData['Rating']?.toString() ?? '0'),
                                            duration: adventureData['Duration']?.toString() ?? "",
                                            departure: adventureData['Departure']?.toString() ?? "",
                                            description: adventureData['Discription']?.toString() ?? "",
                                            price: double.parse(adventureData['Budget']?.toString() ?? '0.0'),
                                            Category: adventureData['Category']?.toString() ?? "",
                                            date: adventureData['Date']?.toString() ?? "",
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                  return Column(
                                    children: adventureCards,
                                  );
                                } else {
                                  return Positioned(
                                      top: 200,
                                      child: Text("No data available"));
                                }
                              } else if (snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              } else {
                                return CircularProgressIndicator(
                                  color: Color(0xff1034A6),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ])
        ]),),);
  }
}
