// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  //const DrugCard({super.key});

  final String drugImagePath;
  final String rating;
  final String drugName;
  final String department;

  DoctorCard({
    required this.drugImagePath,
    required this.rating,
    required this.drugName,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 244, 249, 249),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            //picture of drug
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child:
                    Image.network(drugImagePath, height: 70, fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            //doctor name
            Text(
              drugName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),

            //doctor title
            Text(department)
          ],
        ),
      ),
    );
  }
}
