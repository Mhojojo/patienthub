import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/login/login_bloc.dart';
import '../widgets/loader.dart';
import '../widgets/login_button.dart';
import '../widgets/text_form_field.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  FToast? fToast;

  late FocusNode usernameFocus;
  late FocusNode passwordFocus;
  late FocusNode loginBtnFocus;
  late TextEditingController userName;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast?.init(context);

    usernameFocus = FocusNode();
    passwordFocus = FocusNode();
    loginBtnFocus = FocusNode();
    userName = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    usernameFocus.dispose();
    passwordFocus.dispose();
    loginBtnFocus.dispose();
    userName.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            showErrorToast();
          } else if (state is AuthLoaded) {
            showSuccessLoginToast();
            clearTextData();
            Navigator.of(context)
                .pushNamed('/dashboard', arguments: state.username);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return LoadingWidget(child: buildInitialInput());
          } else {
            return Center(
              child: Container(
                width: 350,
                height: 600,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 255, 255, 255), // Set your desired box color
                  borderRadius: BorderRadius.circular(
                      10), // Set your desired border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.2), // Set your desired shadow color
                      spreadRadius: 5, // Set your desired spread radius
                      blurRadius: 7, // Set your desired blur radius
                      offset: Offset(0, 3), // Set your desired shadow offset
                    ),
                  ],
                ),
                child: buildInitialInput(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildInitialInput() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/sign_up_logo.png"),
                alignment: Alignment.topLeft,
              ),
            ),
            child: Column(
              children: [
                _header(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                _textButton(),
                LoginBtn(
                  focusNode: loginBtnFocus,
                  userName: userName,
                  password: password,
                ),
                _tex(),
                _createAccountButton(),
              ],
            ),
          ),
        ),
      );
  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 15),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Sign In',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 112, 112, 112),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Sign in to your account to access your patients',
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
      onPressed: () {},
      child: const Text(
        'Forgot Password',
        style: TextStyle(color: Color.fromARGB(255, 15, 15, 15), fontSize: 12),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _tex() {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'Dont have an Account. Sign up here!',
        style: TextStyle(color: Color.fromARGB(255, 15, 15, 15), fontSize: 12),
        textAlign: TextAlign.right,
      ),
    );
  }

  _createAccountButton() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(
                color: Color.fromARGB(255, 1, 4, 32), width: 1),
            minimumSize: const Size(double.infinity, 54),
            backgroundColor: Color.fromARGB(255, 248, 248, 248)),
        onPressed: () {
          Navigator.pushNamed(context, '/signup');
        },
        child: const Text(
          'SIGN UP',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 4, 0, 61)),
        ),
      ),
    );
  }

  clearTextData() {
    userName.clear();
    password.clear();
  }

  showErrorToast() {
    Widget toast = Padding(
      padding: const EdgeInsets.only(bottom: 400),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: const Color.fromARGB(255, 173, 0, 0),
        ),
        child: Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                Icons.warning,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                "Please enter user name or password!",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );

    fToast?.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
    );
  }

  showSuccessLoginToast() {
    Widget toast = Padding(
      padding: const EdgeInsets.only(bottom: 600),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Color.fromARGB(255, 0, 31, 54),
        ),
        child: Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                Icons.verified_user,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                "Login Successful!",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ],
        ),
      ),
    );

    fToast?.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
