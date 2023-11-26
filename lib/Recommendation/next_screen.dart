import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/advanture_card.dart';

class NextScreen extends StatefulWidget {
  final String category;
  final String departure;
  final String destination;
  final String duration;
  final String priceRange;
  final String selectedDate;

  NextScreen({
    required this.category,
    required this.departure,
    required this.destination,
    required this.duration,
    required this.priceRange,
    required this.selectedDate,
  });

  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  List<Map<String, dynamic>> matchingTours = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    DatabaseReference reference = FirebaseDatabase.instance.ref();

    reference.child("Tours").child(widget.category).onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;

      print("Fetching data...");

      if (values != null) {
        print("Received data from the database: $values");

        values.forEach((key, value) {
          print("Checking data: $value");

          if (value is Map<String, dynamic>) {
            print("Checking data types...");

            bool isCategoryMatch = value["Category"]?.toString() == widget.category.toString();
            /*bool isDepartureMatch = value["Departure"]?.toString().trim().toLowerCase() == widget.departure.toLowerCase();
            bool isTitleMatch = value["Title"]?.toString().trim().toLowerCase() == widget.destination.toLowerCase();
            bool isDurationMatch = value["Duration"]?.toString().trim().toLowerCase() == widget.duration.toLowerCase();
            int budget = int.parse(value["Budget"]?.toString() ?? "0");
            int priceRange = int.parse(widget.priceRange);
            bool isBudgetMatch = budget <= priceRange;*/
       //     bool isDateMatch = value["Date"]?.toString().trim().toLowerCase() == widget.selectedDate.toLowerCase();

            print("Widget Category: ${widget.category}");
            print("Widget Departure: ${widget.departure}");
         //       isDateMatch;
            bool isMatch = isCategoryMatch /*&&
                isDepartureMatch &&
                isTitleMatch &&
                isDurationMatch &&
                isBudgetMatch*/;// &&

            print("Is Match: $isMatch");

            if (isMatch) {
              // This is a match, add to the list
              setState(() {
                matchingTours.add(value);
              });
            } else {
              print("Does not match all conditions");
            }
          }
        });

        if (matchingTours.isNotEmpty) {
          print("Matching tours found: $matchingTours");
        } else {
          print("No matching tours found");
          // Handle the case where no matching tours are found
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("No Tours Available"),
                content: Text("Sorry, no tours match your criteria."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Next Screen',
          style: GoogleFonts.abel(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Color(0xff1034A6),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var match in matchingTours.take(3))
              AdventureCard(
                imageUrl: "assets/adventure.jpg",
                title: match["Title"] ?? "",
                duration: match["Duration"] ?? "",
                departure: match["Departure"] ?? "",
                price: match["Budget"] ?? 0.0,
                Category: match["Category"] ?? "",
                date: match["Date"] ?? "",
              ),
            if (matchingTours.isEmpty)
              Text("No matching tours available"),
          ],
        ),
      ),
    );
  }
}
