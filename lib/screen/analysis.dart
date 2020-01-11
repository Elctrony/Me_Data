import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medata/screen/prescription.dart';
import 'package:medata/screen/profile_screen.dart';
import 'package:medata/screen/schedule.dart';

class MyAnalysis extends StatelessWidget {
  final primary = Color(0xff696b9e);
  final secondary = Colors.redAccent;
  final String _id;
  MyAnalysis(this._id);

  final List<Map> _actionsLists = [
    {
      "name": "AlBorg Laboratories",
      "type": "Sugar Test",
      "logoText":
          "http://thebestcare-eg.com/wp-content/uploads/2019/04/mzl.bafhkuut-1.png"
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
            padding: EdgeInsets.only(left: 64), child: Text('My Analysis')),
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
                  });
            },
            stream: Firestore.instance
                .collection('users')
                .document(_id)
                .collection('analysis')
                .snapshots(),
          ),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, Map<String, Object> actionsLists) {
    return Container(
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
      height: 90,
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
              border: Border.all(width: 2, color: secondary),
              image: DecorationImage(
                  image: NetworkImage(actionsLists['logoText']),
                  fit: BoxFit.fill),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  actionsLists['name'],
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
                    Text(actionsLists['type'],
                        style: TextStyle(
                            color: primary, fontSize: 14, letterSpacing: .3)),
                  ],
                ),
              ],
            ),
          ),
          Center(child: Icon(Icons.arrow_forward),)
        ],
      ),
    );
  }
}
