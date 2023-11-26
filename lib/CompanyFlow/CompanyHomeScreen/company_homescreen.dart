import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourify/CompanyFlow/CompanyHomeScreen/CompanyHomeScreenComponents/HomeScreenCard.dart';
import 'package:tourify/Utilities/Utils.dart';

class CompanyHomeScreen extends StatefulWidget {
  const CompanyHomeScreen({super.key});

  @override
  State<CompanyHomeScreen> createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  String? category;
  DateTime? selectedDate;
  DateTime? initialDate = DateTime.now();
  final DiscriptionController = TextEditingController();
  final BudgetController = TextEditingController();
  final DurationController = TextEditingController();
  final DepartureController = TextEditingController();
  final titleController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final reference = FirebaseDatabase.instance.ref('Tours');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Tourify"),
        centerTitle: true,
        backgroundColor: const Color(0xff1034A6),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color(0xff1034A6),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50.0),
                            bottomRight: Radius.circular(50.0))),
                  ),
                  const Positioned(
                    top: 50,
                    child: Text("Share your Tours",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ),
                  const Positioned(
                    bottom: -50,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Color(0xff1034A6),
                        backgroundImage: AssetImage('assets/Logo.png'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      "Select your tour category type : ",
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  category = 'Adventure';
                                });
                                debugPrint(category.toString());
                              },
                              child: const HomeCard(
                                imagetitle: 'assets/pageone.jpeg',
                                title: 'Adventure',
                              )),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  category = 'Religious';
                                });
                                 debugPrint(category.toString());
                              },
                              child: const HomeCard(
                                imagetitle: 'assets/religious.jpeg',
                                title: 'Religious',
                              )),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  category = 'Historical';
                                });
                                  debugPrint(category.toString());
                              },
                              child: const HomeCard(
                                  imagetitle: 'assets/historical.jpeg',
                                  title: 'Historical')),
                                 GestureDetector(
                              onTap: () {
                                setState(() {
                                  category = 'SightSeeing';
                                });
                                  debugPrint(category.toString());
                              },
                              child: const HomeCard(
                                  imagetitle: 'assets/sights.jpg',
                                  title: 'SightSeing')),
                                   GestureDetector(
                              onTap: () {
                                setState(() {
                                  category = 'Family and freinds';
                                });
                                  debugPrint(category.toString());
                              },
                              child: const HomeCard(
                                  imagetitle: 'assets/familyfriends.jpg',
                                  title: 'Family and Friends')),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        label: const Text('Title'),
                        prefixIcon: const Icon(Icons.place),
                        hintText: 'Enter Tour Destination point',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: DiscriptionController,
                      decoration: InputDecoration(
                        label: const Text('Discription'),
                        prefixIcon: const Icon(Icons.description),
                        hintText: 'Enter Tour Discription',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: BudgetController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: const Text('Budget '),
                        prefixIcon: const Icon(Icons.currency_rupee),
                        hintText: 'Enter Tour Budget',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: DurationController,
                      decoration: InputDecoration(
                        label: const Text('Duration'),
                        prefixIcon: const Icon(Icons.timer),
                        hintText: 'Enter Tour Duration',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: DepartureController,
                      decoration: InputDecoration(
                        label: const Text('Departure Location'),
                        prefixIcon: const Icon(Icons.place),
                        hintText: 'Enter Tour departure point',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff01e90ff),
                          elevation: 20,
                          shadowColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          selectedDate = await showDatePicker(
                            context: context,
                            initialDate: initialDate!,
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2025),
                          );
                          debugPrint(selectedDate.toString());
                        },
                        child: Text(
                          'Choose Date',
                          style: GoogleFonts.lato(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1034A6),
                          elevation: 20,
                          shadowColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          var random = Random();
                          var randomRating = random.nextInt(6);
                          var formattedDate = "${selectedDate?.day}-${selectedDate?.month}-${selectedDate?.year}";
                          await reference.child(category!).push().set({
                            'Discription': DiscriptionController.text,
                            'Budget': BudgetController.text,
                            'Duration': DurationController.text,
                            'Departure': DepartureController.text,
                            'Date': formattedDate.toString(),
                            'Category': category.toString(),
                            'Rating': randomRating,
                            'Title' : titleController.text,
                          }).then((value) => Utilities().show_Message('Your Tour has been Shared Successfully'));
                        },
                        child: Text(
                          'Submit',
                          style: GoogleFonts.lato(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
