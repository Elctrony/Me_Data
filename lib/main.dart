import 'package:flutter/material.dart';
import 'package:medata/screen/analysis.dart';
import 'package:medata/screen/login_screen.dart';
import 'package:medata/screen/prescription.dart';
import 'package:medata/screen/profile_screen.dart';
import 'package:medata/screen/schedule.dart';
import 'package:medata/screen/signup_screen.dart';

void main() => runApp(RootApp());

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Container(
        child: LoginScreen(),
      ),
      routes: {
        '/login':(context)=>LoginScreen(),
        '/signup':(context)=>SignupScreen(),
      },
    );
  }
}

final List<Map> navigationList = [
  {
    'title': 'My Analysis',
    'icon': Icons.search,
    'navy': '/analysis',
  },
  {
    'title': 'My Schedule',
    'icon': Icons.access_time,
    'navy': '/schedule',
  },
];
