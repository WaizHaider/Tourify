import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../components/trip_card.dart';

class YourTrips extends StatefulWidget {
  const YourTrips({Key? key});

  @override
  _YourTripsState createState() => _YourTripsState();
}

class _YourTripsState extends State<YourTrips> {
  final dbRef = FirebaseDatabase.instance.ref().child('Payments');
  final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Trips"),
        backgroundColor: Colors.blue, // You can customize the color
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: loadUserTrips(),
                builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No trips found."));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        final tripData = snapshot.data?[index];
                        return GestureDetector(
                          onTap: () {
                            // Handle the tap on a specific trip
                          },
                          child: TripCard(
                            company: tripData?['company'],
                            title: tripData?['title'],
                            price: tripData?['price'],
                            duration: tripData?['duration'],
                            departure: tripData?['departure'],
                            status: tripData?['status'],
                            // Add more properties as needed
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Future<List<Map<String, dynamic>>> loadUserTrips() async {
    final userTrips = <Map<String, dynamic>>[];

    try {
      final snapshot = await dbRef.once();
      final tripsData = snapshot.value as Map<dynamic, dynamic>?;

      if (tripsData != null) {
        tripsData.forEach((key, value) {
          if (value is Map<String, dynamic> && value['id'] == currentUserId) {
            userTrips.add(value);
          }
        });
      }
    } catch (e) {
      print("Error loading trips: $e");
    }

    return userTrips;
  }*/
}
