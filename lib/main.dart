import 'package:flutter/material.dart';
import 'package:flutter_hands_on_2_database/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dataBase.dart';
import 'structure_model.dart';
import 'package:flutter/cupertino.dart';
import 'drawer_widget.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IOT HOME AUTOMATION',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyDashboard(),
    );
  }
}

class MyDashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {

   List<Led> rLed;
  final DbManager dbManager = new DbManager();


   SharedPreferences logindata;
   String username;
   String table;
   List<String> test;

   TextEditingController nameController;
   TextEditingController passwordController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
      table = logindata.getString('table');
      nameController = TextEditingController();
      passwordController = TextEditingController();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(''),
      ),

      drawer: DrawerWidget(table),
      body :
      Container(
        padding: EdgeInsets.fromLTRB(0, 160, 0, 0), constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/1.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        child: Column(
            children : [

              Container(
                        child: Text('Welcome '+username,
                          style: TextStyle(
                            color: Colors.yellow,
                          ),
                        )
                    ),
              Container(
                  child:  RaisedButton(
                    child: new Text("Log Out"),
                    color: Colors.blue,
                    onPressed: (){
                      logindata.clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyApp()),(route) => false,
                      );
                    },
                  ),
                  )

            ]
        ),

      ),
    );
  }
}