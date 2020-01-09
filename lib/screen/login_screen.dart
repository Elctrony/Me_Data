import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medata/screen/profile_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() {
    // TODO: implement createState
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  bool _loading = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                      height: 330,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                icon: Icon(Icons.vpn_key),
                                hintText: 'Type your Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.grey))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _loading
                              ? Center(child: CircularProgressIndicator())
                              : RaisedButton(
                            onPressed: () async {
                              setState(() {
                                _loading = true;
                              });
                              FirebaseAuth auth = FirebaseAuth.instance;
                              FirebaseUser user;
                              try {
                                user = (await auth
                                    .signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password:
                                    _passwordController.text))
                                    .user;
                                print(user.uid);
                              } catch (e) {
                                print(e.message);
                                showDialog<AlertDialog>(
                                    context: context,
                                    builder: (_) =>
                                        AlertDialog(
                                          title: Text(
                                              'Authentication Failed'),
                                          content: Text(
                                              'A Problem has been occured while you login!\n${e
                                                  .message}'),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(),
                                                child: Text('OK!'))
                                          ],
                                        ));
                                return;
                              } finally {
                                setState(() {
                                  _loading = false;
                                });
                              }
                              await showDialog<AlertDialog>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) =>
                                      AlertDialog(
                                        elevation: 24,
                                        title: Text(
                                            'Authentication Successed'),
                                        content: Text(
                                            'You have logged in Successfully!\nWelcome To My Pharmacy'),
                                        actions: <Widget>[
                                          FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(),
                                              child: Text('Let\'s Go'))
                                        ],
                                      ));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProfilePage(user.uid)));
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
                                  'OK',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Don\'t have an account?'),
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/signup');
                                },
                                child: Text(
                                  'Create a new one',
                                  style: TextStyle(color: Colors.blue[800]),
                                ),
                              )
                            ],
                          )
                        ],
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
