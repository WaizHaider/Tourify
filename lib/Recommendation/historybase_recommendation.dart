import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryBase extends StatefulWidget {
  const HistoryBase({Key? key}) : super(key: key);

  @override
  _HistoryBaseState createState() => _HistoryBaseState();
}

class _HistoryBaseState extends State<HistoryBase> {
  String? currentUserID;
  DatabaseReference paymentReference = FirebaseDatabase.instance.ref().child("Payments");
  List<Map<String, dynamic>> paymentData = [];

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
          if (value is Map<String, dynamic> && value['id'] == userID) {
            // Access the 'category' value directly
            String category = value['category'];
            print("Category for user ID $userID: $category");

            // If you need to store the entire payment details, you can still add it to the list
            userPayments.add({key: value});
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

  @override
  Widget build(BuildContext context) {
    print("Building HistoryBase screen. Payment data: $paymentData");
    return Scaffold(
      appBar: AppBar(
        title: Text('History Base Recommendations', style: GoogleFonts.abel(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xff1034A6),
        elevation: 0,
      ),
      body: Center(
        child: paymentData.isNotEmpty
            ? ListView.builder(
          itemCount: paymentData.length,
          itemBuilder: (context, index) {
            final userPaymentData = paymentData[index].values.first;
            return Column(
              children: [
                ListTile(
                  title: Text("Category: ${userPaymentData['category']}"),
                  // Add other ListTile content based on your data structure
                ),
                // Add more ListTile widgets or other UI elements based on your data structure
              ],
            );
          },
        )
            : Text("No payment data available"),
      ),
    );
  }
}
