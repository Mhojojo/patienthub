import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/login/login_bloc.dart';

class LoginBtn extends StatelessWidget {
  const LoginBtn(
      {Key? key,
      required this.focusNode,
      required this.userName,
      required this.password})
      : super(key: key);

  final FocusNode focusNode;
  final TextEditingController userName;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: OutlinedButton(
        focusNode: focusNode,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(
                color: Color.fromARGB(255, 1, 4, 32), width: 1),
            minimumSize: const Size(double.infinity, 54),
            backgroundColor: Color.fromARGB(255, 13, 1, 104)),
        onPressed: () {
          print('clicked');
          BlocProvider.of<AuthBloc>(context)
              .add(Login(userName.text, password.text));
        },
        child: const Text(
          'LOGIN',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }
}
