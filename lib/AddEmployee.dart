import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapicall/model/Employee.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'rest_api.dart';

class AddEmployee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddEmployeeState();
  }
}

class _AddEmployeeState extends State<AddEmployee> {
  Employee _employee;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle2;

    return MaterialApp(
      title: 'Add Employee',
      theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add Employee'),
        ),
        body: Form(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    style: textStyle,
                    onChanged: (value) => updateName(),
                    controller: titleController,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    style: textStyle,
                    onChanged: (value) => updateDescription(),
                    controller: descriptionController,
                    decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                RaisedButton(
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.deepOrangeAccent,
                  onPressed: () {
                    addEmployeeData();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addEmployeeData() async {
    Employee e = Employee(121, 'Test User', '12222', '', '23');
    var result = await  ApiService.addEmployee(body: e.tomap()) ;
    if (result) {
      Fluttertoast.showToast(
          msg: "Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      Fluttertoast.showToast(
          msg: "Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  void updateName() {
    _employee.name = titleController.text;
  }

  // Update the description of Note object
  void updateDescription() {
    _employee.salary = descriptionController.text;
  }
}
