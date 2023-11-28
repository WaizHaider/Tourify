import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Categories/tour_description.dart';
import '../components/advanture_card.dart';

class HistoryBase extends StatefulWidget {
  const HistoryBase({Key? key}) : super(key: key);

  @override
  _HistoryBaseState createState() => _HistoryBaseState();
}

class _HistoryBaseState extends State<HistoryBase> {
  String? currentUserID;
  DatabaseReference paymentReference = FirebaseDatabase.instance.ref().child("Payments");
  List<Map<String, dynamic>> paymentData = [];
  List<Map<String, dynamic>> tours = [];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      currentUserID = user?.uid;
    });

    if (currentUserID != null) {
      fetchPaymentDataForUser(currentUserID!);
    } else {
      print("User is not logged in.");
    }
  }

  void fetchPaymentDataForUser(String userID) async {
    print("Fetching payment data for user ID: $userID");
    try {
      final event = await paymentReference.orderByChild("id").equalTo(userID).once();

      final data = event.snapshot.value;

      print("Received payment data from the database: $data");

      if (data != null && data is Map) {
        List<Map<String, dynamic>> userPayments = [];

        data.forEach((key, value) {
          if (value is Map && value['id'] == userID) {
            // Access the 'category' value directly
            String category = value['category'];
            print("Category for user ID $userID: $category");
            loadData(category);
            print("++++++++++++++++++++++++++++++++++++++++++");
            // If you need to store the entire payment details, you can still add it to the list
            userPayments..add({key: value});
          }
        });

        setState(() {
          paymentData = userPayments;
        });

        print("Payment data for user ID $userID: $userPayments");
      } else {
        print("No payment data found for user ID: $userID");
      }
    } catch (e) {
      print("Error fetching payment data: $e");
    }
  }

  void loadData(String category) {
    tours.clear();
    final ref = FirebaseDatabase.instance.ref().child('Tours').child(category);
    ref.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        final currentDate = DateTime.now();

        data.forEach((key, value) {
          if (value is Map) {
            final adventureData = value as Map<Object?, Object?>;
            String dateStr = adventureData['Date']?.toString() ?? "";

            DateTime tripDate = parseCustomDate(dateStr);

            // Check if the trip date is today or in the future
            if (tripDate.isAtSameMomentAs(currentDate) || tripDate.isAfter(currentDate)) {
              tours.add({
                "imageUrl": "assets/adventure.jpg",
                "title": adventureData['Title']?.toString() ?? "",
                "ratings": int.parse(adventureData['Rating']?.toString() ?? '0'),
                "duration": adventureData['Duration']?.toString() ?? "",
                "departure": adventureData['Departure']?.toString() ?? "",
                "description": adventureData['Discription']?.toString() ?? "",
                "price": double.parse(adventureData['Budget']?.toString() ?? '0.0'),
                "Category": adventureData['Category']?.toString() ?? "",
                "date": adventureData['Date']?.toString() ?? "",
                "company": adventureData['Company']?.toString() ?? "",
              });
            }

          }
        });

        setState(() {});
      }
    });
  }

  DateTime parseCustomDate(String dateStr) {
    final parts = dateStr.split('-');
    if (parts.length == 3) {
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime(year, month, day);
    } else {
      return DateTime(2000, 1, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Building HistoryBase screen. Payment data: $paymentData");
    return Scaffold(
      appBar: AppBar(
        title: Text('History Base Recommendations', style: GoogleFonts.abel(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xff1034A6),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: tours.map((tourData) {
            return GestureDetector(
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
            );
          }).toList(),
        ),
      ),
    );
  }
}
