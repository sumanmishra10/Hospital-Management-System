import 'package:flutter/material.dart';
import 'package:hospital/login/login_page.dart';
import 'package:hospital/models/department.dart';
import 'package:hospital/screens/doctor_depart.dart';
import 'package:hospital/screens/department_page.dart';
import 'package:hospital/screens/profile.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:hospital/services/specialities.service.dart';
import 'package:hospital/util/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class SpecialityDt {
//   String? detail;

//   SpecialityDt({this.detail});

//   SpecialityDt.fromJson(Map<String, dynamic> json) {
//     detail = json['detail'];
//   }
// }

class MyHomePage extends StatefulWidget {
  final String username;
  //final String email;
  MyHomePage({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SpecialityDt> filteredSpecialities = [];
  String? searchQuery;
  final textsearch = TextEditingController();
  Future<List<filter_SpecialityDt>>? specialities;
  String selectedPage = 'Home';

  // Function to check if the user is logged in
  Future<bool> isUserLoggedIn() async {
    // Implement your logic to check if the user is logged in.
    // For example, check if a token exists in shared preferences.
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return (token != null && token != "");
  }

  @override
  void initState() {
    super.initState();
    refresh(null);
  }

  void refresh(String? search) {
    setState(() {
      specialities = (search == null || search == "")
          ? SpecialistiesServices.getCategories(null)
          : SpecialistiesServices.getCategories(search);
    });
  }

  // void filterSpecialities(String query) {
  //   setState(() {
  //     searchQuery = query;
  //     if (query.isNotEmpty) {
  //       filteredSpecialities = specialities
  //           .where((speciality) =>
  //               speciality.detail
  //                   ?.toLowerCase()
  //                   .contains(query.toLowerCase()) ??
  //               false)
  //           .toList();
  //     } else {
  //       filteredSpecialities.clear();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Koshi Hospital'),
          backgroundColor: Color.fromARGB(255, 116, 135, 255),
          actions: [
            FutureBuilder<bool>(
              future: isUserLoggedIn(),
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return CircularProgressIndicator();

                // if (snapshot.hasError) {
                //   return Text('Error: ${snapshot.error}');
                // } else {
                final isLoggedIn = snapshot.data;
                if (isLoggedIn == true) {
                  // User is logged in, show profile button
                  return IconButton(
                    onPressed: () {
                      // Navigate to the profile page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MyProfile(username: widget.username),
                          // Replace 'Username' with the actual username
                        ),
                      );
                    },
                    icon: Icon(Icons.person_3_outlined),
                  );
                } else {
                  // User is not logged in, show login button
                  return IconButton(
                    onPressed: () {
                      // Navigate to the login page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    icon: Icon(Icons.login),
                  );
                }
              },
            ),
          ],
        ),
        drawer: AppDrawer(
          username: widget.username, selectedPage: 'Home',
          // Replace with actual username
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Container(
              //   height: 80,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.all(8),
              //           child: Container(
              //             height: 50,
              //             width: 50,
              //             decoration: BoxDecoration(
              //               color: Colors.deepPurple[100],
              //               borderRadius: BorderRadius.circular(20),
              //             ),
              //             child: ClipOval(
              //               child: Image.asset(
              //                 'images/koshilogo.png',
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(8),
              //           child: Container(
              //               height: 40,
              //               //width: 60,
              //               child: Text(
              //                 "Koshi Hospital",
              //                 style: TextStyle(fontWeight: FontWeight.bold),
              //               )),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(12),
              //           child: Container(
              //             height: 40,
              //             width: 40,
              //             decoration: BoxDecoration(
              //               color: Color.fromARGB(255, 244, 249, 249),
              //               borderRadius: BorderRadius.circular(12),
              //             ),
              //             child: GestureDetector(
              //               onTap: () {
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                     builder: (context) => MyProfile(),
              //                   ),
              //                 );
              //               },
              //               child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(12),
              //                 child: Image.asset(
              //                   'images/profile.png', // Replace 'your_image.png' with your image asset path
              //                   fit: BoxFit
              //                       .cover, // You can adjust the fit mode as needed
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(12),
              //           child: Container(
              //             height: 40,
              //             width: 40,
              //             decoration: BoxDecoration(
              //               color: Color.fromARGB(255, 244, 249, 249),
              //               borderRadius: BorderRadius.circular(12),
              //             ),
              //             child: GestureDetector(
              //               onTap: () {
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) => ContactUs()),
              //                 );
              //               },
              //               child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(12),
              //                 child: Image.asset(
              //                   'images/hospitallogo.png', // Replace 'your_logo.png' with your logo image asset path
              //                   fit: BoxFit
              //                       .cover, // You can adjust the fit mode as needed
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(12),
              //           child: Row(
              //             children: [
              //               GestureDetector(
              //                 onTap: () {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                         builder: (context) => LoginPage()),
              //                   );
              //                 },
              //                 child: Icon(
              //                   Icons.login,
              //                   size: 24, // Set the size of the icon as needed
              //                   color: Color.fromARGB(255, 218, 16,
              //                       16), // Set the color of the icon as needed
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              CarouselSlider(
                items: [
                  Image.asset('images/koshi.jpg',
                      fit: BoxFit.fill, height: 200, width: 1000),
                  Image.asset('images/koshi1.jpg',
                      fit: BoxFit.fill, height: 200, width: 1000),
                  Image.asset('images/koshi.jpg',
                      fit: BoxFit.fill, height: 200, width: 1000),
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  // Adjust other options as needed
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available Specialities',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (DepartmentPage(
                                    username: widget.username,
                                  ))),
                        );
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 20, 19, 19),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextField(
                  controller: textsearch,
                  onTap: () {},
                  onChanged: (value) {
                    if (value.length != 0) {
                      refresh(value);
                    } else {}
                    // if (value.length == 0) {
                    //   fetchSpecialities(null);
                    // } else {
                    //   fetchSpecialities(value);
                    // } // showSearch(
                    //   context: context,
                    //   delegate: SearchDelegateWidget(filterSpecialities),
                    // );
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 35, 34, 34), width: 0.0),
                    ),
                    fillColor: Colors.grey[50],
                    alignLabelWithHint: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                    filled: true,
                    hintText: "Search for Medicine/Health Products..",
                    hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        // showSearch(
                        //  context: context,
                        //  delegate: SearchDelegateWidget(filterSpecialities),
                        //);
                      },
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: FutureBuilder<List<filter_SpecialityDt>?>(
                  future: specialities,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      List<filter_SpecialityDt>? specialitiesData =
                          snapshot.data;
                      return ListView.builder(
                        itemCount: searchQuery == null || searchQuery!.isEmpty
                            ? specialitiesData!.length
                            : filteredSpecialities.length,
                        itemBuilder: (BuildContext context, int index) {
                          final speciality = specialitiesData![index];
                          return GestureDetector(
                            onTap: () {
                              print(speciality.sp_id.toString() + "hello1");
                              // Navigate to the DoctorDepartPage with the selected speciality
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorDepart(
                                    departmentDetail:
                                        (speciality.sp_id.toString()), // Pass the detail
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              child: ListTile(
                                  leading: ClipOval(
                                    child: Image.asset(
                                      speciality.image!,
                                      width: 35,
                                      height: 35,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                      searchQuery == null ||
                                              searchQuery!.isEmpty
                                          ? speciality.detail ?? ''
                                          : filteredSpecialities[index]
                                                  .detail ??
                                              '',
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                  trailing: Icon(Icons.keyboard_arrow_right)),
                            ),
                          );
                        },
                      );
                    }
                    // if(snapshot.data!.length==0){
                    //   return SizedBox(
                    //     child: Center(child: Text('No Specialities found,')),
                    //   )
                    // }
                    else {
                      return SizedBox(
                          child: Center(child: CircularProgressIndicator()));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
