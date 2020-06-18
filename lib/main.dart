import 'dart:convert';

import 'package:flutter/material.dart';
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
  Future<List<Employee>> employeeList;

  @override
  void initState() {
    super.initState();
//    futureAlbum = fetchAlbum();
    employeeList = ApiService.getEmployees();
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
        body: Center(
          child: FutureBuilder<List<Employee>>(
            future: employeeList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final employees = snapshot.data;

                return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(employees[index].name),
                      subtitle: Text('Age ${employees[index].age}'),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 2,
                      color: Colors.black,
                    );
                  },
                  itemCount: employees.length,
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
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



}
