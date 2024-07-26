import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hospital/util/drawer.dart';

class ContactUs extends StatefulWidget {
  final String username;

  const ContactUs({super.key, required this.username});
  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  String selectedPage = 'Contact US';
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      // You can handle the submission of feedback here
      // Send the feedback data to your desired backend or process it as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Contact US'),
          backgroundColor: Color.fromARGB(255, 116, 135, 255),
        ),
        drawer: AppDrawer(
          username: widget.username, selectedPage: '',
          // Replace with actual username
        ),
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  items: [
                    Image.asset('images/koshi.jpg',
                        fit: BoxFit.fill, height: 200, width: 1500),
                    Image.asset('images/koshi1.jpg',
                        fit: BoxFit.fill, height: 200, width: 1500),
                    Image.asset('images/koshi.jpg',
                        fit: BoxFit.fill, height: 200, width: 1500),
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
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Send us a Message',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Colors.black, // You can change the border color here
                      //   width: 2.0, // You can change the border width here
                      // ),
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            "FEEDBACK",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                color: Colors.grey, // Color of the label text
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(
                                  color: Colors.grey), // Color of the hint text
                              fillColor: Colors
                                  .white, // Background color of the text field
                              filled: true,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              // You can add more email validation logic here
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Colors.grey, // Color of the label text
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(
                                  color: Colors.grey), // Color of the hint text
                              fillColor: Colors
                                  .white, // Background color of the text field
                              filled: true,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: messageController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your message';
                              }
                              return null;
                            },
                            maxLines: 2,
                            decoration: InputDecoration(
                              labelText: 'Message',
                              labelStyle: TextStyle(
                                color: Colors.grey, // Color of the label text
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(
                                  color: Colors.grey), // Color of the hint text
                              fillColor: Colors
                                  .white, // Background color of the text field
                              filled: true,
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: 250,
                            child: ElevatedButton(
                              onPressed: _submitFeedback,
                              child: Text('Send Message'),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Container(
                //   height: 250,
                //   color: Color.fromARGB(255, 218, 218, 218),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         Padding(
                //           padding: EdgeInsets.all(8.0),
                //           child: Column(
                //             children: [
                //               Container(
                //                 child: Text(
                //                   "Contact Us",
                //                   style: TextStyle(
                //                       fontSize: 25,
                //                       fontWeight: FontWeight.bold),
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 16,
                //               ),
                //               Container(
                //                 child: Row(
                //                   children: [
                //                     Icon(
                //                       Icons
                //                           .local_hospital, // You can change this to any desired icon
                //                       size: 30,
                //                       color: Colors.black,
                //                     ),
                //                     SizedBox(width: 40),
                //                     Text(
                //                       'Koshi Hospital',
                //                       style: TextStyle(
                //                         fontSize: 16,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 10,
                //               ),
                //               Container(
                //                 child: Row(
                //                   children: [
                //                     Icon(
                //                       Icons
                //                           .email, // You can change this to any desired icon
                //                       size: 30,
                //                       color: Colors.black,
                //                     ),
                //                     SizedBox(width: 40),
                //                     Text(
                //                       'EMAIL@EMAIL.COM',
                //                       style: TextStyle(
                //                         fontSize: 16,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 10,
                //               ),
                //               Container(
                //                 child: Row(
                //                   children: [
                //                     Icon(
                //                       Icons
                //                           .phone, // You can change this to any desired icon
                //                       size: 30,
                //                       color: Colors.black,
                //                     ),
                //                     SizedBox(width: 40),
                //                     Text(
                //                       '021-5652124',
                //                       style: TextStyle(
                //                         fontSize: 16,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 10,
                //               ),
                //               Container(
                //                 child: Row(
                //                   children: [
                //                     Icon(
                //                       Icons
                //                           .location_city, // You can change this to any desired icon
                //                       size: 30,
                //                       color: Colors.black,
                //                     ),
                //                     SizedBox(width: 40),
                //                     Text(
                //                       'Biratnagar, Nepal',
                //                       style: TextStyle(
                //                         fontSize: 16,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
