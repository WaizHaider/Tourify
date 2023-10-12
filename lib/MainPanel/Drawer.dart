import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPanelDrawer extends StatelessWidget {
  MainPanelDrawer({super.key});

  @override
  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  Widget build(BuildContext context) {
    return Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text(user!.displayName.toString()),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.black,
                ),
                accountEmail: Text(user!.email.toString())),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'CompanyRegistration');
              },
              leading: Icon(Icons.tour),
              title: Text(
                'Share your Tours',
                style: GoogleFonts.lato(fontSize: 20, color: Colors.blueGrey),
              ),
              
            ),
            ListTile(
              leading: const Icon(Icons.book_online),
              title: Text(
                'Your bookings',
                style: GoogleFonts.lato(fontSize: 20, color: Colors.blueGrey),
              )
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(
                'Account Settings',
                style: GoogleFonts.lato(fontSize: 20, color: Colors.blueGrey),
              ),
              
            ),
            const SizedBox(height: 200,),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(
                'Logout',
                style: GoogleFonts.lato(fontSize: 20, color: Colors.blueGrey),
              ),
              onTap: () {
                auth.signOut();
                Navigator.of(context).pushNamed('SignInScreen');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(
                'About Us',
                style: GoogleFonts.lato(fontSize: 20, color: Colors.blueGrey),
              ),
              onTap: () {
                
              },
            ),
          ],
        ));
  }
}
