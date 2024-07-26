import 'package:flutter/material.dart';
import 'package:hospital/login/login_page.dart';
import 'package:http/http.dart' as http; // Import the http package

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  bool isEmailValid = true;
  String errorMessage = ''; // Add a variable to store error messages

  // Function to validate email format
  bool _validateEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  // Function to handle password reset
  void _sendPasswordResetEmail() async {
    final email = emailController.text;

    if (!_validateEmail(email)) {
      setState(() {
        isEmailValid = false;
        errorMessage = 'Invalid email format';
      });
      return;
    }

    // Make an HTTP POST request to your authentication API
    final response = await http.post(
      Uri.parse(
          'https://pharmacy.norvichospital.com/mediprowebapi/api/accounts/generateresetpasswordcode/'),
      body: {'email': email},
    );

    if (response.statusCode == 200) {
      // Password reset email sent successfully
      // You can navigate to a success page or show a confirmation dialog here
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      // Error occurred while sending the email
      setState(() {
        errorMessage = 'Failed to send reset email. Please try again later.';
      });
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
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'Please Enter Your Email!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
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
                SizedBox(
                  height: 40,
                ),
                Text(
                  errorMessage,
                  style: TextStyle(
                    color: Colors.red, // Show error message in red
                  ),
                ),
                ElevatedButton(
                  onPressed: _sendPasswordResetEmail,
                  child: Text('Reset Password'),
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
