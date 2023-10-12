import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Payment/payment.dart';
import '../components/custom_toast.dart';

class TourDescriptionScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  TourDescriptionScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tour Description'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    )),
                Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                ),
                Positioned(
                  top: 100,
                    child: Image.asset(data['imageUrl'] ?? 'assets/adventure.jpg', height: MediaQuery.sizeOf(context).height * 0.3, width: MediaQuery.sizeOf(context).width * 0.7,fit: BoxFit.cover,)),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.435,
                    left: 50,
                    child: Text('${data['title'] ?? ''}', style:
                        GoogleFonts.abel(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xff1034A6)),)),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.47,
                    left: 50,
                    child: Text('Category: ${data['Category'] ?? ''}', style:
                    GoogleFonts.abel(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),)),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.49,
                    left: 50,
                    child: Text('Ratings: ${data['ratings'] ?? 0}', style:
                    GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.47,
                    right: 50,
                    child: Text('Duration: ${data['duration'] ?? ''}', style:
                    GoogleFonts.abel(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),)),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.52,
                    left: 50,
                    child: Text('Departure: ${data['departure'] ?? ''}', style:
                    GoogleFonts.abel(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff1034A6)),)),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.545,
                    left: 50,
                    child: Text('Description: ${data['description'] ?? ''}', style:
                    GoogleFonts.abel(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),)),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.57,
                    right: 50,
                    child: Text('Price: PKR ${data['price'] ?? 0}', style:
                    GoogleFonts.abel(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff1034A6)),)),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.45,
                    right: 50,
                    child: Text('Date: ${data['date'] ?? ''}', style:
                    GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff1034A6)),)),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.64,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      backgroundColor: Color(0xff1034A6),
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                            title: data['title'] ?? '',
                            duration: data['duration'] ?? '',
                            departure: data['departure'] ?? '',
                            price: data['price'] ?? 0,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Book a Trip",
                      style: GoogleFonts.abel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  ,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
