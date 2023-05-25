import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/dashboard/dashboard_bloc.dart';


import '../widgets/drawer.dart';
import '../widgets/loader.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key, required this.title, required this.username})
      : super(key: key);

  final String title;
  final String username;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  SharedPreferences? _prefs;
  int _numberOfTasks = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 79, 109),
        title: Text(widget.title),
      ),
      drawer: const ShowDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/home_background.jpg"),
              fit: BoxFit.cover),
        ),
        child: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is DashboardNav) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is DashboardLoading) {
              return LoadingWidget(
                child: initialLayout(context),
              );
            } else {
              return initialLayout(context);
            }
          },
        ),
      ),
    );
  }

  Widget initialLayout(BuildContext context) => Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Hi ${widget.username}! View Patients",
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Card(
                color: const Color.fromARGB(255, 29, 79, 109),
                child: SizedBox(
                  width: 300,
                  height: 80,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.alarm,
                          size: 50.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      const Text(
                        'Urgent task: 0',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Card(
                color: const Color.fromARGB(255, 254, 91, 121),
                child: SizedBox(
                  width: 300,
                  height: 80,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.pending,
                          size: 50.0,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      const Text(
                        'Pending Task 4',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Card(
                color: Color.fromARGB(255, 29, 79, 109),
                child: SizedBox(
                  width: 300,
                  height: 80,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.list,
                          size: 50.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Text(
                        'Number of Task: $_numberOfTasks',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class DashboardNav {}
