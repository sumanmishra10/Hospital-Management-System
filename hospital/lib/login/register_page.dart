import 'package:flutter/material.dart';
import 'package:hospital/login/login_page.dart';
import 'package:hospital/services/register.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController refidController = TextEditingController();

  String registrationResult = '';

  // Validation flags
  bool isEmailValid = true;
  bool isMobileValid = true;
  bool isPasswordMatch = true;
  bool isRegistering = false;

  // Future<void> registerUser() async {
  //   final String username = usernameController.text;
  //   final String firstname = firstnameController.text;
  //   final String lastname = lastnameController.text;
  //   final String email = emailController.text;
  //   final String mobile = mobileController.text;
  //   final String address = addressController.text;
  //   final String password = passwordController.text;
  //   final String confirmPassword = confirmPasswordController.text;
  //   final String refid = refidController.text;

  void _handleRegistration() async {
    final username = usernameController.text;
    final firstname = firstnameController.text;
    final lastname = lastnameController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final email = emailController.text;
    final mobile = mobileController.text;
    final address = addressController.text;
    final refid = refidController.text;

    // Reset validation flags
    setState(() {
      isEmailValid = true;
      isMobileValid = true;
      isPasswordMatch = true;
      isRegistering = true;
    });

    // Validate the form data
    if (username.isEmpty ||
        firstname.isEmpty ||
        lastname.isEmpty ||
        email.isEmpty ||
        mobile.isEmpty ||
        address.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        refid.isEmpty) {
      // Required field validation
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Required Fields'),
            content: Text('Please fill in all required fields.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email)) {
      // Email validation
      setState(() {
        isEmailValid = false;
      });
      return;
    }

    if (!RegExp(r'^\d{10}$')
        .hasMatch(mobile.replaceAll(RegExp(r'[^\d]'), ''))) {
      // Mobile number validation
      setState(() {
        isMobileValid = false;
      });
      return;
    }

    if (password != confirmPassword) {
      // Password match validation
      setState(() {
        isPasswordMatch = false;
      });
      return;
    }
    setState(() {
      isRegistering = false; // Set isRegistering to false
    });

    final Map<String, dynamic> userData = {
      'username': int.parse(username),
      'firstname': firstname,
      'lastName': lastname,
      'password': password,
      'confirmPassword': confirmPassword,
      'EmailAddress': email,
      'mobileNumber': int.parse(mobile.replaceAll(RegExp(r'[^\d]'), '')),
      'address': address,
      'refid': int.parse(refid),
    };

    final result = await RegisterService.registerUser(
      username: username,
      firstname: firstname,
      lastname: lastname,
      password: password,
      confirmPassword: confirmPassword,
      email: email,
      mobile: mobile,
      address: address,
      refid: refid,
    );

    setState(() {
      registrationResult = result;
    });

    // For example, if you want to check if registration was successful:
    if (result == 'success') {
      // Save user data to shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('username', username as int);
      prefs.setString('firstname', firstname);
      prefs.setString('lastname', lastname);
      prefs.setString('email', email);
      prefs.setInt('mobile', mobile as int);
      prefs.setString('address', address);
      prefs.setInt('refid', refid as int);

      // Show a success dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Registration Successful'),
            content: Text('You have successfully registered.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else if (result == 'badRequest') {
      // Bad Request - Registration failed due to invalid data
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content:
                Text('Invalid registration data. Please check your input.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Registration failed due to an unexpected error
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content: Text('An error occurred during registration.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                ClipOval(
                  child: Image.asset(
                    'images/koshilogo.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please Register Your Detail!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey), // Color of the hint text
                      fillColor:
                          Colors.white, // Background color of the text field
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: firstnameController,
                    decoration: InputDecoration(
                      hintText: 'First-Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey), // Color of the hint text
                      fillColor:
                          Colors.white, // Background color of the text field
                      filled: true,
                    ),
                  ),
                ),
                //const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: lastnameController,
                    decoration: InputDecoration(
                      hintText: 'Last-Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey), // Color of the hint text
                      fillColor:
                          Colors.white, // Background color of the text field
                      filled: true,
                    ),
                  ),
                ),
                //const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey), // Color of the hint text
                      fillColor:
                          Colors.white, // Background color of the text field
                      filled: true,
                      errorText: isEmailValid ? null : 'Invalid email format',
                    ),
                  ),
                ),
                //const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: mobileController,
                    decoration: InputDecoration(
                      hintText: 'Mobile-Number',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey), // Color of the hint text
                      fillColor:
                          Colors.white, // Background color of the text field
                      filled: true,
                      errorText:
                          isMobileValid ? null : 'Invalid mobile number format',
                    ),
                  ),
                ),
                //const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      prefixIcon: Icon(Icons.location_city),
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey), // Color of the hint text
                      fillColor:
                          Colors.white, // Background color of the text field
                      filled: true,
                      errorText: isEmailValid ? null : 'Invalid email format',
                    ),
                  ),
                ),
                //const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey), // Color of the hint text
                      fillColor:
                          Colors.white, // Background color of the text field
                      filled: true,
                    ),
                    obscureText: true,
                  ),
                ),
                //const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey), // Color of the hint text
                      fillColor:
                          Colors.white, // Background color of the text field
                      filled: true,
                      errorText:
                          isPasswordMatch ? null : 'Passwords do not match',
                    ),
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: refidController,
                    decoration: InputDecoration(
                      hintText: 'refid',
                      prefixIcon: Icon(Icons.location_city),
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey), // Color of the hint text
                      fillColor:
                          Colors.white, // Background color of the text field
                      filled: true,
                      errorText: isEmailValid ? null : 'Invalid email format',
                    ),
                  ),
                ),
                //const SizedBox(height: 20),
                Container(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: _handleRegistration,
                    child: Text('Register'),
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
