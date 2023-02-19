import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:libraryapp/views/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

TextEditingController emailController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();

bool _validateEmail = false;
bool _validatePass = false;
Map userDataFetched = {};
bool canSwitchScreenlogin = false;
var obtainedToken;

Future<void> fetchUserTokenRegister(String email, String password) async {
  final response =
      await http.post(Uri.parse('http://10.0.2.2:8000/api/auth/login'), body: {
    "email": email,
    "password": password,
  });
  final Map loginInfoParsed = json.decode(response.body);
  if (loginInfoParsed['token'] == null) {
    canSwitchScreenlogin = false;
    //showToast();
  } else {
    final userResponse = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/user'),
      headers: {'Authorization': "Bearer " + loginInfoParsed['token']},
    );
    if (userResponse.statusCode == 200 || userResponse.statusCode == 201) {
      canSwitchScreenlogin = true;
      obtainedToken = loginInfoParsed['token'];
      userDataFetched = json.decode(userResponse.body);
      //var userData=UserWithToken.fromJson(parsedUserResponse);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', loginInfoParsed['token']);
    } else {
      canSwitchScreenlogin = false;
      WidgetsBinding.instance.addPostFrameCallback((_){
        //showToast();
      });
    }
  }
}

//Future<bool?> showToast() {
  // return Fluttertoast.showToast(
  //
  //     msg: 'Zadaný užívateľ neexistuje',
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: Colors.red,
  //     textColor: Colors.yellow);
//}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    emailController.clear();
  }
  @override
  Widget build(BuildContext context) {
    passwordController.clear();
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
              ),
              Text("Prihlásenie",style: TextStyle(fontWeight: FontWeight
                  .bold, fontSize: 50,color: Color.fromRGBO(2, 180, 215,
                  1)),),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'Email',
                      errorText: _validateEmail ? 'Zle zadaný email' : null,
                      hintText: 'abc@gmail.com'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 30, bottom: 20),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'Password',
                      errorText: _validatePass ? 'Prázdne pole' : null,
                      hintText: 'He5l0.+'),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),

                            )
                        ),backgroundColor: MaterialStateProperty.all<Color>
                      (Color.fromRGBO(2, 180, 215,
                        1)),
                    ),
                  onPressed: () async {

                    setState(() {
                      if (emailController.text.isEmpty ||
                          !emailController.text.contains("@") ||
                          !emailController.text.contains(".")) {
                        _validateEmail = true;
                      } else {
                        _validateEmail = false;
                      }
                      passwordController.text.isEmpty ||
                              passwordController.text.length < 7
                          ? _validatePass = true
                          : _validatePass = false;
                    });
                    await fetchUserTokenRegister(
                        emailController.text.toString(),
                        passwordController.text.toString());
                    //print('${userwtoke} as');
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) => Home()));
                    if (canSwitchScreenlogin) {
                      canSwitchScreenlogin=false;
                      Map map = {"userDataFetched":userDataFetched,"obtainedToken":obtainedToken};
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Welcome(map)),);
                    }

                  },
                  child: Text('Prihlásiť sa', style: TextStyle(fontSize: 22,
                      fontWeight: FontWeight.w600),),
                ),
              ),
              // ),
              SizedBox(
                height: 130,
              ),
            ],
          ),
        ),
        );
  }
}
