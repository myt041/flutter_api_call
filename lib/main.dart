import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapicall/AddEmployee.dart';
import 'package:flutterapicall/model/Album.dart';
import 'package:flutterapicall/model/Employee.dart';
import 'package:flutterapicall/rest_api.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
//  Future<Album> futureAlbum;
//  Future<List<Employee>> employeeList;
  List<Employee> employeeList = List();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
//    futureAlbum = fetchAlbum();
//    employeeList = ApiService.getEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api call',
      theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch data api'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:  Colors.deepOrangeAccent,
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddEmployee()));

          },
        ),
        body: isLoading ? Center(
          child: CircularProgressIndicator(),
        ) :ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(employeeList[index].name),
              subtitle: Text('Age ${employeeList[index].age}'),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 2,
              color: Colors.black,
            );
          },
          itemCount: employeeList.length,
        ),
      ),
    );
  }


  Future<Album> fetchAlbum() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums/1');

    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }


  fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get("http://dummy.restapiexample.com/api/v1/employees");
    if (response.statusCode == 200) {
      var body = response.body;
      final Map jsonData = json.decode(body);
      final empRes = EmployeeRes.fromJson(jsonData);

      employeeList = empRes.list;
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
