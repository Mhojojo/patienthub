import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String userName;
  final String password;

  User({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      userName: json['userName'],
      password: json['password'],
    );
  }
}
