import 'package:flutter/material.dart';
import 'package:hospital/services/appointment.services.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentPage extends StatefulWidget {
  final String doctor;
  final String referer;
  final String detail;

  DoctorAppointmentPage({
    required this.doctor,
    required this.referer,
    required this.detail,
  });

  @override
  _DoctorAppointmentPageState createState() => _DoctorAppointmentPageState();
}

class _DoctorAppointmentPageState extends State<DoctorAppointmentPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      DoctorAppointmentContent(
        doctor: widget.doctor,
        referer: widget.referer,
        detail: widget.detail,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text('Doctor Appointment'),
          backgroundColor: Color.fromARGB(255, 116, 135, 255),
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}

class DoctorAppointmentContent extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _refeerController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final String doctor;
  final String referer;
  final String detail;

  void _submitAppointment() {
    if (_formKey.currentState!.validate()) {
      // You can handle the submission of feedback here
      // Send the feedback data to your desired backend or process it as needed
    }
  }

  DoctorAppointmentContent({
    required this.doctor,
    required this.referer,
    required this.detail,
  });

  @override
  _DoctorAppointmentContentState createState() =>
      _DoctorAppointmentContentState();
}

class _DoctorAppointmentContentState extends State<DoctorAppointmentContent> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedGender;

  final _formKey = GlobalKey<FormState>();
  Future<String?> _fetchData() async {
    // Simulate an asynchronous operation (replace with your actual data fetching logic)
    await Future.delayed(Duration(seconds: 2));
    return 'data_loaded_successfully';
  }

  // @override
  // void initState() {
  //   super.initState();
  //   AppointmentService.submitAppointment("payload" as Map<String, dynamic>);
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.dateController.text =
            DateFormat('yyyy-MM-dd').format(selectedDate!);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        widget.timeController.text = selectedTime!.format(context);
      });
    }
  }

  Future<void> _submitAppointment() async {
    // Gather data from the form
    String pname = widget.nameController.text;
    String address = widget._addressController.text;
    String sex = selectedGender ?? '';
    String contact = widget._mobileNumberController.text;
    String age = widget._ageController.text;
    String date = widget.dateController.text;
    String time = widget.timeController.text;
    String email = widget.emailController.text;
    String remark = widget._textController.text;

    final appointmentResult = await AppointmentService.submitAppointment(
      pname: pname,
      address: address,
      sex: sex,
      contact: contact,
      age: age,
      referer: widget.doctor,
      speciality: widget.detail,
      date: date,
      time: time,
      email: email,
      remarks: remark,
    );

    // Create a JSON payload
    // final Map<String, dynamic> payload = {
    //   'pname': pname,
    //   'address': address,
    //   'sex': sex,
    //   'mobile': contact,
    //   'age': age,
    //   'referer': widget.doctor,
    //   'speciality': widget.detail,
    //   'date': date,
    //   'time': time,
    //   'email': email,
    //   'remarks': remark,
    // };

    // // Convert the payload to JSON

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString('token');
    // final String payloadJson = json.encode(payload);

    // final Uri apiUrl = Uri.parse(
    //     'https://mediprocomputers.com/mediprowebapi/api/onlineappointment');

    // final Map<String, String> headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer $token', // Replace with your actual API token
    // };

    // final response = await http.post(
    //   apiUrl,
    //   headers: headers,
    //   body: payloadJson,
    // );

    // Handle the response here
    if (appointmentResult == 'success') {
      // Successful response
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Appointment submitted successfully.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Handle other response codes or errors
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content:
                Text('An error occurred while submitting the appointment.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // Adjust alignment as needed
                      children: [
                        ElevatedButton(
                          child: Text('Old User'),
                          onPressed: () {},
                        ),
                        ElevatedButton(
                          child: Text('New User'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: widget.nameController,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your full name.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          Text('Gender', style: TextStyle(fontSize: 16.0)),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Male',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                              ),
                              Text('Male'),
                              Radio<String>(
                                value: 'Female',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                              ),
                              Text('Female'),
                              Radio<String>(
                                value: 'Other',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                              ),
                              Text('Other'),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: widget._addressController,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter address.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: widget._ageController,
                            decoration: InputDecoration(
                              labelText: 'Age',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null && value!.isEmpty) {
                                return 'Please enter age.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: widget._mobileNumberController,
                            decoration: InputDecoration(
                              labelText: 'Mobile no.',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter number.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: widget.emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller:
                                TextEditingController(text: widget.detail),
                            decoration: InputDecoration(
                              labelText: 'Speciality',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            enabled: false,
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller:
                                TextEditingController(text: widget.doctor),
                            decoration: InputDecoration(
                              labelText: 'Referer',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            enabled: false,
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: widget.dateController,
                            decoration: InputDecoration(
                              labelText: 'Date',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () => _selectDate(context),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please select date.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: widget.timeController,
                            decoration: InputDecoration(
                              labelText: 'Time',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.access_time),
                                onPressed: () => _selectTime(context),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please select time.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          TextField(
                            controller: widget._textController,
                            decoration: InputDecoration(
                              labelText: 'Remarks',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            child: Text('Submit'),
                            onPressed: _submitAppointment,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            // Handle other states, e.g., when there's an error or no data.
            return Text('No data available');
          }
        });
  }

  bool _validateFields(
    String name,
    String contact,
    String date,
    String time,
    String email,
  ) {
    bool isEmailValid =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(email);

    bool isPhoneNumberValid =
        RegExp(r'^\d{10}$').hasMatch(contact.replaceAll(RegExp(r'[^\d]'), ''));

    if (name.isEmpty ||
        date.isEmpty ||
        time.isEmpty ||
        !isEmailValid ||
        !isPhoneNumberValid) {
      return false;
    }
    return true;
  }
}
