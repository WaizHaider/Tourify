import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourify/Categories/tour_description.dart';
import '../components/advanture_card.dart';

class FriendsNFamily extends StatefulWidget {
  const FriendsNFamily({super.key});

  @override
  _FriendsNFamilyState createState() => _FriendsNFamilyState();
}

class _FriendsNFamilyState extends State<FriendsNFamily> {
  String selectedFilter = "Low to High"; // Default filter

  // Define your filter options
  List<String> filterOptions = [
    "Low to High",
    "High to Low",
    "New",
    // Add more filter options as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friends N Family Tours" , style: GoogleFonts.abel(fontWeight: FontWeight.bold),),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            color: Colors.white,
            onPressed: () {
              // Handle share button press here
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                // Handle logout here
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
        backgroundColor: Color(0xff1034A6),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pick an Adventure',
                            style: GoogleFonts.abel(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Filter: ',
                                style: GoogleFonts.abel(
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: 29,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white),
                                child: DropdownButton<String>(
                                  value: selectedFilter,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedFilter = newValue!;
                                    });
                                  },
                                  style: TextStyle(color: Colors.black), // Set the text color for the selected item
                                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                                  items: filterOptions.map((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                          fontSize: 10, // Set the font size for the dropdown menu items
                                          color: Colors.black, // Set the text color for the dropdown menu items
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child('Tours')
                  .child('FriendsNFamily')
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.snapshot.value;
                  if (data != null && data is Map) {
                    List<Map<String, dynamic>> tours = [];

                    data.forEach((key, value) {
                      if (value is Map) {
                        var adventureData = value as Map<Object?, Object?>;
                        String dateStr = adventureData['Date']?.toString() ?? "";

                        DateTime tripDate = parseCustomDate(dateStr);
                        DateTime currentDate = DateTime.now();

                        if (tripDate.isAfter(currentDate) || tripDate.isAtSameMomentAs(currentDate)) {
                          tours.add({
                            "imageUrl": "assets/historical.jpg",
                            "title": adventureData['Title']?.toString() ?? "",
                            "ratings": int.parse(adventureData['Rating']?.toString() ?? '0'),
                            "duration": adventureData['Duration']?.toString() ?? "",
                            "departure": adventureData['Departure']?.toString() ?? "",
                            "description": adventureData['Discription']?.toString() ?? "",
                            "price": double.parse(adventureData['Budget']?.toString() ?? '0.0'),
                            "Category": adventureData['Category']?.toString() ?? "",
                            "date": adventureData['Date']?.toString() ?? "",
                          });
                        }
                      }
                    });

                    // Sort tours based on the selected filter
                    if (selectedFilter == "Low to High") {
                      tours.sort((a, b) => a["price"].compareTo(b["price"]));
                    } else if (selectedFilter == "High to Low") {
                      tours.sort((a, b) => b["price"].compareTo(a["price"]));
                    }

                    List<Widget> adventureCards = [];
                    for (var tourData in tours) {
                      adventureCards.add(
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TourDescriptionScreen(data: tourData),
                              ),
                            );
                          },
                          child: AdventureCard(
                            imageUrl: tourData["imageUrl"],
                            title: tourData["title"],
                            duration: tourData["duration"],
                            departure: tourData["departure"],
                            price: tourData["price"],
                            Category: tourData["Category"],
                            date: tourData["date"],
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: adventureCards,
                    );
                  } else {
                    return Text("No data available");
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
    );
  }

  DateTime parseCustomDate(String dateStr) {
    List<String> parts = dateStr.split('-');
    if (parts.length == 3) {
      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);
      return DateTime(year, month, day);
    } else {
      return DateTime(2000, 1, 1);
    }
  }
}
