import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medata/screen/analysis.dart';
import 'dart:math' as math;

import 'package:medata/screen/prescription.dart';
import 'package:medata/screen/schedule.dart';

class ProfilePage extends StatelessWidget {
  final String _id;

  ProfilePage(this._id);

  TextStyle _style() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  final List<Map> navigationList = [
    {
      'title': 'My Profile',
      'icon': Icons.person,
      'navy': '/profile',
    },
    {
      'title': 'My Presriptions',
      'icon': Icons.list,
      'navy': '/presriptions',
    },
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          Map<String, Object> data = snapshot.data.data;
          return Scaffold(
            appBar: CustomAppBar(data),
            drawer: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 3.5,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 2 / 3,
                    color: Colors.redAccent,
                    child: Padding(
                      child: Align(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.account_circle,
                              size: 100,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              data['name'],
                              style:
                              TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                        alignment: Alignment.bottomCenter,
                      ),
                      padding: EdgeInsets.only(left: 12, bottom: 8),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 2 / 3,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 2 / 3,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          child: InkWell(
                            child: ListTile(
                              leading: Icon(navigationList[index]['icon']),
                              title: Text(navigationList[index]['title']),
                            ),
                            onTap: () {
                              if (navigationList[index]['navy']== '/profile')
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                    builder: (context) => ProfilePage(_id)));
                              else if (navigationList[index]['navy'] == '/presriptions')
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                    builder: (context) => MyPrescription(_id)));
                              else if (navigationList[index]['navy'] == '/analysis')
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                    builder: (context) => MyAnalysis(_id)));
                              else if (navigationList[index]['navy'] == '/schedule')
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                    builder: (context) => MySchedule(_id)));
                            },
                          ),
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomLeft: Radius.circular(40))),
                        );
                      },
                      itemCount: navigationList.length,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 4),
                  ),
                ],
              ),
              color: Colors.white,
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Name:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          data['name'],
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Email:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          data['email'],
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Allergies:",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      data['allergies'],
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Chronic Diseases:",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      data['chronicDiseas'],
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
          );
        },
        future: Firestore.instance
            .collection('users')
            .document(_id)
            .get());
  }
}

final String url =
    "http://chuteirafc.cartacapital.com.br/wp-content/uploads/2018/12/15347041965884.jpg";

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Map<String, Object> data;

  CustomAppBar(this.data);

  @override
  Size get preferredSize => Size(double.infinity, 320);

  final List<Map> navigationList = [
    {
      'title': 'My Profile',
      'icon': Icons.person,
      'navy': '/profile',
    },
    {
      'title': 'My Presriptions',
      'icon': Icons.list,
      'navy': '/presriptions',
    },
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

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(top: 24),
        decoration: BoxDecoration(color: Colors.redAccent, boxShadow: [
          BoxShadow(color: Colors.red, blurRadius: 20, offset: Offset(0, 0))
        ]),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: Container()),
                  Text(
                    'My Profile',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(child: Container())
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(data['image']))),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      data['name'],
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Age",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '${data['age']}',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Height",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "${data['height']}cm",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Weight",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "${data['weight']}Kg",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Blood Type",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(data['bloodType'],
                        style: TextStyle(color: Colors.white, fontSize: 24))
                  ],
                ),
                SizedBox(
                  width: 16,
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  print("//TODO: button clicked");
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 8, 16, 0),
                  child: Transform.rotate(
                    angle: (math.pi * 0.05),
                    child: Container(
                      width: 110,
                      height: 32,
                      child: Center(
                        child: Text("Edit Profile"),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 20)
                          ]),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();

    p.lineTo(0, size.height - 70);
    p.lineTo(size.width, size.height);

    p.lineTo(size.width, 0);

    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
