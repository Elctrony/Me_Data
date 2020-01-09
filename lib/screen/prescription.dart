import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medata/drawer/home_drawer.dart';
import 'package:medata/screen/analysis.dart';
import 'package:medata/screen/profile_screen.dart';
import 'package:medata/screen/schedule.dart';
import 'package:medata/screen/schedule.dart';

class MyPrescription extends StatelessWidget {
  final primary = Color(0xff696b9e);
  final secondary = Colors.redAccent;
  final String _id;

  MyPrescription(this._id);

  final List<Map> actionsLists = [
    {
      "name": "Dr. Ahmed Samah",
      "type": "orthopedist",
      'diagnosis': 'romatizem',
      'description': 'The Patient has a romatizem in his leg',
      'drugs': ['Augmaniten', 'panadol'],
      "logo":
          "https://cdn2.iconfinder.com/data/icons/small-color-v13/512/anatomy_bones_orthopedics_skeleton-512.png"
    },
  ];
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        title: Padding(
          padding: EdgeInsets.only(left: 64),
          child: Text('My Prescriptions'),
        ),
      ),
      drawer: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width * 2 / 3,
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
                        'Ahmed Nada',
                        style: TextStyle(color: Colors.white, fontSize: 18),
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
              width: MediaQuery.of(context).size.width * 2 / 3,
              height: MediaQuery.of(context).size.height * 2 / 3,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      child: ListTile(
                        leading: Icon(navigationList[index]['icon']),
                        title: Text(navigationList[index]['title']),
                      ),
                      onTap: () {
                        if (navigationList[index] == '/profile')
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfilePage(_id)));
                        else if (navigationList[index] == '/presriptions')
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyPrescription(_id)));
                        else if (navigationList[index] == '/analysis')
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyAnalysis(_id)));
                        else if (navigationList[index] == '/schedule')
                          Navigator.of(context).push(MaterialPageRoute(
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
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 1.2,
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildList(
                        context, snapshot.data.documents[index].data);
                  },
                );
              },
              stream: Firestore.instance
                  .collection('users')
                  .document(_id)
                  .collection('prescriptions')
                  .snapshots(),
            )),
      ),
    );
  }

  Widget buildList(BuildContext context, Map<String, Object> data) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2, // has the effect of softening the shadow
              spreadRadius: 2, // has the effect of extending the shadow
              offset: Offset(
                4.0, // horizontal, move right 10
                4.0, // vertical, move down 10
              ),
            ),
          ],
        ),
        width: double.infinity,
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 3, color: secondary),
                image: DecorationImage(
                    image: NetworkImage(data['logo']), fit: BoxFit.fill),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data['name'],
                    style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.class_,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(data['type'],
                          style: TextStyle(
                              color: primary, fontSize: 14, letterSpacing: .3)),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Text(DateFormat.yMMMd().format(DateTime.now()),
                  style: TextStyle(
                      color: primary, fontSize: 14, letterSpacing: .3)),
            ),
          ],
        ),
      ),
      onTap: () {
        int x = 0;
        print('modal');
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                color: Colors.transparent,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        color: Colors.white),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(top: 12, left: 18),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Speciality: ' + data['type'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Diagnosis: ' + data['diagnosis'],
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text('Description: \n' + data['description']),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text('Drugs: \n' + data['drugs'].toString()),
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            )),
                            Container(
                              color: Colors.grey,
                              child: Image.network(
                                data['logo'],
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.height / 4,
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              );
            });
      },
    );
  }
}