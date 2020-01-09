import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() {
    // TODO: implement createState
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SignupScreen> {
  List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String spinnerValue = 'A+';

  bool loading = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _allergiesController = TextEditingController();
  TextEditingController _chronicController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  'assets/background.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Container(
                      width: 300,
                      height: 560,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'SignUp',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Stack(
                                  children: <Widget>[
                                    Icon(
                                      Icons.account_circle,
                                      color: Colors.grey,
                                      size: 90,
                                    ),
                                    Positioned(
                                      child: Icon(
                                        Icons.add_circle,
                                        size: 30,
                                        color: Colors.blue,
                                      ),
                                      bottom: 0,
                                      right: 0,
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                  labelText: 'Name',
                                  icon: Icon(Icons.account_box),
                                  hintText: 'Type your Name',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.grey))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  icon: Icon(Icons.email),
                                  hintText: 'Type your Email',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.grey))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  icon: Icon(Icons.vpn_key),
                                  hintText: 'Type your password',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.grey))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  icon: Icon(Icons.vpn_key),
                                  hintText: 'Type your password again',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.grey))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Text('Blood Type:'),
                                SizedBox(
                                  width: 15,
                                ),
                                DropdownButton<String>(
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  value: spinnerValue,
                                  items: bloodTypes
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String value) {
                                    setState(() {
                                      spinnerValue = value;
                                    });
                                  },
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _allergiesController,
                              decoration: InputDecoration(
                                  labelText: 'Allergies',
                                  hintText: 'Type your Allergies',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.grey))),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _chronicController,
                              decoration: InputDecoration(
                                  labelText: 'Chronic Diseases',
                                  hintText: 'Type your Chronic Diseases',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.grey))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _ageController,
                              decoration: InputDecoration(
                                  labelText: 'age',
                                  hintText: 'Type your age',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.grey))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _weightController,
                              decoration: InputDecoration(
                                  labelText: 'Weight',
                                  hintText: 'Type your weight',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.grey))),
                            ),
                            loading
                                ? CircularProgressIndicator()
                                : RaisedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      FirebaseAuth auth = FirebaseAuth.instance;
                                      if (_emailController.text.isEmpty ||
                                          _nameController.text.isEmpty ||
                                          _confirmPasswordController
                                              .text.isEmpty ||
                                          _passwordController.text.isEmpty ||
                                          _ageController.text.isEmpty ||
                                          _allergiesController.text.isEmpty ||
                                          _chronicController.text.isEmpty ||
                                          _weightController.text.isEmpty) {
                                        showDialog<AlertDialog>(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: Text('Validation Error'),
                                                content: Center(
                                                    child: Text(
                                                        'Completa all the Feilds, please!')),
                                                actions: <Widget>[
                                                  FlatButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                      child: Text('OK!'))
                                                ],
                                              );
                                            });
                                        setState(() {
                                          loading = false;
                                        });
                                        return;
                                      }
                                      if (_passwordController.text !=
                                          _confirmPasswordController.text) {
                                        showDialog<AlertDialog>(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: Text('Validation Error'),
                                                content: Center(
                                                    child: Text(
                                                        'Password feild and confirm feild must be matched, please!')),
                                                actions: <Widget>[
                                                  FlatButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                      child: Text('OK!'))
                                                ],
                                              );
                                            });
                                        setState(() {
                                          loading = false;
                                        });
                                        return;
                                      }
                                      FirebaseUser user = (await auth
                                              .createUserWithEmailAndPassword(
                                                  email: _emailController.text,
                                                  password:
                                                      _passwordController.text))
                                          .user;
                                      if (user == null) {
                                        showDialog<AlertDialog>(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Authentiaction Failed'),
                                                content: Text(
                                                    'A Problem has been occured, Try Again later!'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                      child: Text('OK!'))
                                                ],
                                              );
                                            });
                                        setState(() {
                                          loading = false;
                                        });
                                        return;
                                      }
                                      print('id:' + user.uid);
                                      print('email:' + user.uid);
                                      await Firestore.instance
                                          .collection('users')
                                          .document(user.uid)
                                          .setData({
                                        'name': _nameController.text,
                                        'age': _ageController.text,
                                        'allergies': _allergiesController.text,
                                        'chronicDiseas':
                                            _chronicController.text,
                                        'email': _emailController.text,
                                        'height': 172,
                                        'image':
                                            'https://www.thehealthy.com/wp-content/uploads/2017/09/02_doctor_Insider-Tips-to-Choosing-the-Best-Primary-Care-Doctor_519507367_Stokkete.jpg',
                                        'weight': _weightController.text,
                                        'bloodType':spinnerValue,
                                      });
                                      setState(() {
                                        loading = false;
                                      });
                                      showDialog<AlertDialog>(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Authentiaction Succeeded'),
                                              content: Text(
                                                  'You have been authorized successfully.'),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: Text('OK!'))
                                              ],
                                            );
                                          });
                                      Future.delayed(Duration(seconds: 5))
                                          .then((_) {
                                        Navigator.pushNamed(context, '/login');
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
                                    padding: const EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.greenAccent,
                                          Colors.orange
                                        ]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(80.0)),
                                      ),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 88.0, minHeight: 36.0),
                                        // min sizes for Material buttons
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Sign Up',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
