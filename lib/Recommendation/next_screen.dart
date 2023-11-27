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
  // List of matching tours should be or a single list
  List matchingTours = [];

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

          

            bool isCategoryMatch = value["Category"] == widget.category;
            bool isDepartureMatch = value["Departure"] == widget.departure;
            bool isTitleMatch = value["Title"] == widget.destination;
            bool isDurationMatch = value["Duration"] == widget.duration;

            int budget = int.parse(value["Budget"] ?? "0");
            int priceRange = int.parse(widget.priceRange);

            bool isBudgetMatch = budget <= priceRange;
            bool isDateMatch = value["Date"] == widget.selectedDate;

            debugPrint("Is Category Match: $isCategoryMatch");
            debugPrint("Is Departure Match: $isDepartureMatch");
            debugPrint("Is Title Match: $isTitleMatch");
            debugPrint("Is Duration Match: $isDurationMatch");
            debugPrint("Budget: $budget, Price Range: $priceRange");
            debugPrint("Is Budget Match: $isBudgetMatch");
            debugPrint("Is Date Match: $isDateMatch");

            if (isCategoryMatch && isTitleMatch && isDepartureMatch==true) {


              // This is a match, add to the list but see this list has nested structure

              //PROBLEM YAHA HAI YAKIAN IDHAR SAR RHI HAI
              
              setState(() {
                matchingTours.add(values);
              });
              debugPrint("Match TOURS LIST: $matchingTours");
            } else {
              print("Does not match all conditions");
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
                title: const Text("No Tours Available"),
                content: const Text("Sorry, no tours match your criteria."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
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
        backgroundColor: const Color(0xff1034A6),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (Map match in matchingTours)
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
              const Text("No matching tours available"),
          ],
        ),
      ),
    );
  }
}
