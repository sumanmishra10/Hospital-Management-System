import 'package:flutter/material.dart';
import 'package:hospital/login/login_page.dart';
import 'package:hospital/screens/doctor_depart.dart';
import 'package:hospital/screens/opdtime.dart';
import 'package:hospital/util/drawer.dart';
import 'package:intl/intl.dart';

class MyProfile extends StatefulWidget {
  final String username;

  const MyProfile({
    super.key,
    required this.username,
  });

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  // bool isLoggin = true;
  String selectedPage = 'My Profile';
  List<Map<String, dynamic>> Appointment = [
    {
      'name': 'Upcomming Appointment',
    },
    {
      'name': 'Past Appointment',
    },
    {
      'name': 'OPD Time',
    },
    {
      'name': 'Lab Report',
    },
    {
      'name': 'My Prescriptions',
    },
    {
      'name': 'My Medical Records',
    },
    {
      'name': 'My Friends & Family',
    },
    {
      'name': 'Change Password',
    },
    //'DENTAL',
    //'CARDIOLOGY',
    //'NEUROLOGY',
    //'DERMATOLOGY',
  ];

  // List<Map<String, dynamic>> Details = [
  //   {
  //     'name': 'My Prescriptions',
  //   },
  //   {
  //     'name': 'My Medical Records',
  //   },
  //   {
  //     'name': 'My Friends & Family',
  //   },
  //   {
  //     'name': 'Change Password',
  //   },
  // ];
  @override
  Widget build(BuildContext context) {
    String getFormattedDate() {
      DateTime now = DateTime.now();
      return DateFormat.yMd().format(now);
    }

    //if (isLoggin) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Profile'),
          backgroundColor: Color.fromARGB(255, 116, 135, 255),
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.edit),
          //   ),
          // ],
        ),
        drawer: AppDrawer(
          username: widget.username,
          selectedPage: 'Profile', // Replace with actual username
        ),
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Column(
          children: [
            Container(
              height: 220,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                                'images/doctor2.jpg'), // Replace with your image path
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  widget
                                      .username, // Replace with the actual username
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Login/Signup',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Appointment',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: Appointment.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Determine which page to navigate to based on the appointment item clicked
                      switch (index) {
                        case 0:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoctorDepart(
                                      departmentDetail: '',
                                    )),
                          );
                          break;
                        case 1:
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => PastAppointmentPage()),
                          // );
                          break;
                        case 2:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OptTime()),
                          );
                          break;
                        case 3:
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => LabReportPage()),
                          // );
                          break;
                        // Add more cases for other appointment items as needed
                        default:
                          break;
                      }
                    },
                    child: Card(
                      elevation: 1,
                      shadowColor: Colors.blueAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              Appointment[index]['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.symmetric(horizontal: 30),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => (LoginPage())),
            //       );
            //     },
            //     child: Text(
            //       'Sign Out',
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 25,
            )
          ],
        )),
      ),
    );
    // } else {
    //   return LoginPage();
    // }
  }
}
