import 'package:flutter/material.dart';
import 'package:hospital/configs/config.dart';
import 'package:hospital/login/login_page.dart';
import 'package:hospital/screens/about_us.dart';
import 'package:hospital/screens/contact_Us.dart';
import 'package:hospital/screens/department_page.dart';
import 'package:hospital/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  final String username;
  String selectedPage;

  AppDrawer({
    required this.username,
    required this.selectedPage,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  //String selectedPage = 'Home';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Config.bgColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              widget.username.toLowerCase(),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('images/koshilogo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 136, 121, 160),
              image: DecorationImage(
                image: AssetImage('images/koshi1.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            accountEmail: null,
          ),
          ListTile(
            leading: Icon(Icons.add_home),
            title: Text('Home'),
            // Check if the 'Home' page is selected and apply a different style
            tileColor: widget.selectedPage == 'Home' ? Colors.blue : null,
            onTap: () {
              // Update the selected page when you navigate to 'Home'
              // setState(() {
              //   widget.selectedPage = 'Home';
              // });

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MyHomePage(
                    username: '',
                  ),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: Text('My Profile'),
          //   // Check if the 'My Profile' page is selected and apply a different style
          //   tileColor: selectedPage == 'My Profile' ? Colors.blue : null,
          //   onTap: () {
          //     // Update the selected page when you navigate to 'My Profile'
          //     setState(() {
          //       selectedPage = 'My Profile';
          //     });

          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (BuildContext context) => ProfileLoginPage(),
          //       ),
          //     );
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.medical_services),
            title: Text('Departments'),
            tileColor:
                widget.selectedPage == 'Departments' ? Colors.blue : null,
            onTap: () {
              // setState(() {
              //   widget.selectedPage = 'Departments';
              // });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => DepartmentPage(
                    username: widget.username,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.badge_outlined),
            title: Text('About US'),
            tileColor: widget.selectedPage == 'About US' ? Colors.blue : null,
            onTap: () {
              // setState(() {
              //   widget.selectedPage = 'About US';
              // });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AboutUsPage(
                    username: '',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Contact Us'),
            tileColor: widget.selectedPage == 'Contact US' ? Colors.blue : null,
            onTap: () {
              // setState(() {
              //   widget.selectedPage = 'Contact US';
              // });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ContactUs(
                    username: '',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            tileColor: widget.selectedPage == 'Logout' ? Colors.blue : null,
            onTap: () async {
              // setState(() {
              //   widget.selectedPage = 'Logout';
              // });

// final prefs =  SharedPreferences.getInstance();
// SharedPreferences.resetStatic()
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('token', "");

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
