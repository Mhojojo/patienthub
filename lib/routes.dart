import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/screens/signup.dart';
import 'package:todolist/screens/splash.dart';

import 'blocs/login/login_bloc.dart';
import 'blocs/dashboard/dashboard_bloc.dart';

import 'blocs/signup/signup_bloc.dart';
import 'blocs/splash/splash_bloc.dart';

import 'screens/dashboard.dart';
import 'screens/login.dart';

class RouteGenerator {
  final AuthBloc _authBloc = AuthBloc();
  final DashboardBloc _dashboardBloc = DashboardBloc();
  final SplashBloc _splashBloc = SplashBloc();
  final SignupBloc _signupBloc = SignupBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SplashBloc>.value(
            value: _splashBloc,
            child: const SplashPage(),
          ),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthBloc>.value(
            value: _authBloc,
            child: const MyHomePage(title: "Login"),
          ),
        );

      case '/signup':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SignupBloc>.value(
            value: _signupBloc,
            child: const Signup(title: "Sign Up"),
          ),
        );

      case '/dashboard':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider<DashboardBloc>.value(
              value: _dashboardBloc,
              child: Dashboard(title: "Dashboard", username: args),
            ),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR IN NAVIGATION'),
        ),
      );
    });
  }
}
