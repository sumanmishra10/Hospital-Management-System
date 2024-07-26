// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Doctor {
//   final String name;
//   final String department;
//   final String image;

//   Doctor({
//     required this.name,
//     required this.department,
//     required this.image,
//   });

//   factory Doctor.fromJson(Map<String, dynamic> json) {
//     return Doctor(
//       name: json['name'],
//       department: json['department'],
//       image: json['image'],
//     );
//   }
// }

// class DoctorListPage extends StatelessWidget {
//   Future<List<Doctor>> fetchDoctorsFromApi() async {
//     final response = await http.get(Uri.parse(
//         'http://192.168.15.126/medipro.api.medipro/api/RefererSetup/Referer/Select'));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       final List<Doctor> doctors = data.map((item) {
//         return Doctor.fromJson(item);
//       }).toList();

//       return doctors;
//     } else {
//       throw Exception('Failed to load doctors');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Doctor List'),
//       ),
//       body: FutureBuilder<List<Doctor>>(
//         future: fetchDoctorsFromApi(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No doctors found.'));
//           } else {
//             final List<Doctor> doctors = snapshot.data!;
//             int crossAxisCount = calculateCrossAxisCount(context);

//             return GridView.builder(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: doctors.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: crossAxisCount,
//                 childAspectRatio: 1.5,
//                 crossAxisSpacing: 16.0,
//                 mainAxisSpacing: 16.0,
//               ),
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     navigateToAppointmentPage(context, doctors[index].name);
//                   },
//                   child: Card(
//                     elevation: 2.0,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Doctor Image
//                         Container(
//                           height: 100,
//                           width: 100,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage(doctors[index].image),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 8.0),
//                         // Doctor Name
//                         Text(
//                           doctors[index].name,
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 4.0),
//                         // Doctor Department
//                         Text(
//                           doctors[index].department,
//                           style: const TextStyle(
//                             fontSize: 14.0,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }

//   void navigateToAppointmentPage(BuildContext context, String doctor) {
//     // Add navigation logic to the appointment page here.
//   }

//   int calculateCrossAxisCount(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     int crossAxisCount = (screenWidth / 200).floor();
//     return crossAxisCount > 0 ? crossAxisCount : 1;
//   }
// }
