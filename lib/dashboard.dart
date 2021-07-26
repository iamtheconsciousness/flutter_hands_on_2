import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dataBase.dart';
import 'structure_model.dart';

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
  late List<Led> rLed;
  final DbManager dbManager = new DbManager();
  late List<Led> modelList;


  late SharedPreferences logindata;
  late String? username;
  late String? table;
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
      print("Database print : ");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hand's On 2"),
      ),
      body: FutureBuilder(
        future: dbManager.getModelList(),
        builder: (context,AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            print("no data");
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(snapshot.data.length>0) {
            print("data is present");
            print(snapshot.data.length);
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.black12,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text(
                    "${index + 1}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  title: Text(
                      "Room: ${snapshot.data[index].room}"),
                  subtitle: Text('state: ${snapshot.data[index].state}'),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}