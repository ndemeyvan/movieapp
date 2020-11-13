import 'package:flutter/material.dart';
import '../home/home.page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.black12,
        resizeToAvoidBottomPadding: false,
        body: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: new BorderRadius.all(Radius.circular(8.0)),
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  image: AssetImage("assets/images/cine.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text('Seven',
                          style: TextStyle(
                              fontSize: 80.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                      child: Text('Video',
                          style: TextStyle(
                              fontSize: 80.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.white
                                )
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:  Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),

                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'nunito',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.white
                                )
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:  Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintStyle:TextStyle(color: Colors.white),
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                                fontFamily: 'nunito',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),),
                        obscureText: true,
                      ),
                      SizedBox(height: 70.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
//                      transitionDuration: Duration(milliseconds: 500),
                                  pageBuilder: (_, __, ___) => HomePage()));
                        },
                        child: Container(
                          height: 50.0,
                          color: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                    width: 1.0),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'nunito',
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'New to SevenVideo ?',
                    style: TextStyle(fontFamily: 'nunito', color: Colors.white),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.orange,
                        fontFamily: 'nunito',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
