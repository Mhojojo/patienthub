import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/splash/splash_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashBloc _splashBloc = SplashBloc();

  @override
  void initState() {
    _splashBloc.add(SetSplash());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: BlocProvider(
              create: (_) => _splashBloc,
              child: BlocListener<SplashBloc, SplashState>(
                listener: (context, state) {
                  if (state is SplashLoaded) {
                    Navigator.of(context).pushNamed('/login');
                  }
                },
                child: _buildSplashWidget(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSplashWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Image.asset(
        'assets/logo.png',
        height: 5,
        width: 5,
      ),
    );
  }
}
