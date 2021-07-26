import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';
import 'services.dart';
import 'login_model.dart';
import 'dataBase.dart';
import 'structure_model.dart';
import 'structure_service.dart';

late List<Led> rLed;
final DbManager dbManager = new DbManager();
String readUrl='https://newdoonchemist.ml/read_all.php';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hands On 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  var isLoading = false;
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => MyDashboard()));
    }
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preferences"),
      ),
      body: isLoading ?Center(
        child: CircularProgressIndicator(),
      ):Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login Form",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              "To show Example of Shared Preferences",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: username_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: password_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                isLoading=true;
                Future.delayed(Duration(milliseconds: 2000), () {
                  // Do something
                });
                String username = username_controller.text;
                String password = password_controller.text;
                late MyLed _access;

                if (username != '' && password != '') {
                  String login_url='https://newdoonchemist.ml/login.php?user=$username&pass=$password';


                  services.getAccess(login_url).then((access)  {

                    _access=access;
                    if(_access.success==404){
                      isLoading=false;
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Incorrect Credentials"),
                          content: Text("The username or password is incorrect"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text("okay"),
                            ),
                          ],
                        ),
                      );

                    }
                    else if(_access.success==200){
                      isLoading=false;
                      struct_services.getAccess(readUrl).then((tab)  async {
                        rLed=tab;
                        dbManager.insertModel(rLed);
                        print('Successfull');
                        logindata.setBool('login', false);
                        logindata.setString('username', username);
                        logindata.setString('table',_access.table);
                        await Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyDashboard()));

                      });



                    }
                  });

                }
              },
              child: Text("Log-In"),
            )
          ],
        ),
      ),
    );
  }
}

