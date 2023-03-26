import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:libraryapp/views/welcome.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
bool _isChecked = false;

// Save the login data
Future<void> saveLoginData(String username, String password) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('username', username);
  prefs.setString('password', password);
}

// Retrieve the login data
Future<Map<String, String>?> getLoginData() async {
  final prefs = await SharedPreferences.getInstance();
  final username = prefs.getString('username');
  final password = prefs.getString('password');
  if (username != null && password != null) {
    return {'username': username, 'password': password};
  }
  return null;
}
Future<void> fetchUserTokenRegister(String email, String password) async {
  final response =
      await http.post(Uri.parse('http://10.0.2.2:8000/api/auth/login'), body: {
    "email": email,
    "password": password,
  });
  final Map loginInfoParsed = json.decode(response.body);
  if (loginInfoParsed['token'] == null) {
    canSwitchScreenlogin = false;
    showToast();
  } else {
    final userResponse = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/user'),
      headers: {'Authorization': "Bearer " + loginInfoParsed['token']},
    );
    if (userResponse.statusCode == 200 || userResponse.statusCode == 201) {
      canSwitchScreenlogin = true;
      obtainedToken = loginInfoParsed['token'];
      userDataFetched = json.decode(userResponse.body);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', loginInfoParsed['token']);
    } else {
      canSwitchScreenlogin = false;
      WidgetsBinding.instance.addPostFrameCallback((_){
        showToast();
      });
    }
  }
}

Future<bool?> showToast() {
  return Fluttertoast.showToast(

      msg: 'Zadaný užívateľ neexistuje',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.yellow);
}

class _LoginState extends State<Login> {
  late Box box1;
  bool fromChecked = false;
  @override
  void initState() {
    super.initState();
    emailController.clear();
    initHive();
    createOpenBox();
  }
  @override
  Widget build(BuildContext context) {
    if(fromChecked){
      fromChecked=false;
    }
    else{
      passwordController.clear();
    }
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      saveLoginData(emailController.text.toString(), passwordController.text
                          .toString());
                      setState(() {
                        _isChecked = value!;
                        fromChecked=true;
                      });
                    },
                  ),
                 Text('Zapamataj si ma'),
                ],
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
                    login();
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
  void login(){
    if(_isChecked){
      box1.put('email', emailController.value.text);
      box1.put('pass', passwordController.value.text);
    }
  }


  void initHive() async {
    await Hive.initFlutter();
  }
  void getData()async{
    if(box1.get('email')!=null){
      emailController.text = box1.get('email');

    }
    if(box1.get('pass')!=null){
      passwordController.text = box1.get('pass');
    }
  }
  void createOpenBox()async{
    await Hive.initFlutter();
    box1 = await Hive.openBox('logindata');
    getData();
  }

}
