import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterapicall/model/Employee.dart';
import 'package:http/http.dart' as http;

class URLS {
  static const String BASE_URL = 'http://dummy.restapiexample.com/api/v1';
}

class ApiService {
  static Future<List<Employee>> getEmployees() async {
    // RESPONSE JSON :
    // [{
    //   "id": "1",
    //   "employee_name": "",
    //   "employee_salary": "0",
    //   "employee_age": "0",
    //   "profile_image": ""
    // }]

    final response = await http.get("${URLS.BASE_URL}/employees");
    if (response.statusCode == 200) {

      var body = response.body;
      var jsonData = json.decode(body);
      final parsed = json.decode(jsonData['data']).cast<Map<String, dynamic>>();
//      final parsed = json.decode(body).cast<EmployeeRes>() as EmployeeRes;

      return parsed.map<Employee>((json) =>Employee.fromJson(json)).toList();

//      debugPrint('==>>${json.decode(response.body)}');
//      var jsonData = json.decode(response.body);
////      return EmployeeRes.fromJson(jsonData).list;
//      if (jsonData['status'] == 'success') {
//        return jsonData['data'];
//      } else {
//        return null;
//      }
    } else {
      throw Exception('Unable to fetch products from the REST API');

    }
  }


  static Future<bool> addEmployee(body) async {
    // BODY
    // {
    //   "name": "test",
    //   "age": "23"
    // }

    var response = await http.post('${URLS.BASE_URL}/create', body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
