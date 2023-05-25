import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../model/users.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Signup> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String username = '';
  String email = '';
  String password = '';

  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 650,
          decoration: BoxDecoration(
            color: const Color.fromARGB(
                255, 255, 255, 255), // Set your desired box color
            borderRadius:
                BorderRadius.circular(10), // Set your desired border radius
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.2), // Set your desired shadow color
                spreadRadius: 5, // Set your desired spread radius
                blurRadius: 7, // Set your desired blur radius
                offset: const Offset(0, 3), // Set your desired shadow offset
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/sign_up_logo.png"),
                  alignment: Alignment.topLeft,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _header(), // Place the _header() widget here
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'First Name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Last Name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 270, // Set the desired width
                        height: 50, // Set the desired height
                        child: ElevatedButton(
                          onPressed: () {
                            addUser(
                              firstname: firstName,
                              lastname: lastName,
                              email: email,
                              userName: username,
                              password: password,
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 0, 5,
                                    48)), // Set the desired background color
                          ),
                          child: Text('Sign Up'),
                        ),
                      ),
                      _textButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 112, 112, 112),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Create a new account to access your Patients',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context,
            '/login'); // Replace '/login' with the route name of your login tab
      },
      child: const Text(
        'Already have an account? Login',
        style: TextStyle(color: Color.fromARGB(255, 15, 15, 15), fontSize: 12),
        textAlign: TextAlign.right,
      ),
    );
  }

  Future<void> addUser({
    required String firstname,
    required String lastname,
    required String email,
    required String userName,
    required String password,
  }) async {
    const url = 'http://192.168.56.1:7030/api/Auth/register';
    final uri = Uri.parse(url);

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final body = jsonEncode({
      'firstname': firstname,
      'lastname': lastName,
      'email': email,
      'username': userName,
      'password': password,
    });

    try {
      final client = HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      final request = await client.postUrl(uri);
      headers.forEach((name, value) => request.headers.add(name, value));
      request.write(body);
      final response = await request.close();

      if (response.statusCode == 201) {
        final json = await response.transform(utf8.decoder).join();
        final result = jsonDecode(json);
        final user = User.fromJson(result);
        print('Added user successfully');
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } on SocketException catch (e) {
      print('SocketException: $e');
    } on HttpException catch (e) {
      print('HttpException: $e');
    } on TimeoutException catch (e) {
      print('TimeoutException: $e');
    } catch (e) {
      print('Error adding user: $e');
    }
  }
}
