class EmployeeRes {
  final String status;
  final List<Employee> list;

  EmployeeRes({this.status, this.list});

  factory EmployeeRes.fromJson(Map<String, dynamic> json) {
    final List parsedList = json['data'];
    List<Employee> list = List();
    if (parsedList != null) {
      list = parsedList.map((val) => Employee.fromJson(val)).toList();
    }
    return EmployeeRes(status: json['status'], list: list);
  }
}

class Employee {
  int id;
  String name;
  String salary;
  String image;
  String age;

  Employee(this.id, this.name, this.salary, this.image, this.age);

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        int.parse(json['id']), json['employee_name'], json['employee_salary'],
        json['profile_image'], json['employee_age']);
  }

  Map tomap() {
    var map = new Map<String, dynamic>();
    map['id'] = id.toString();
    map["employee_name"] = name;
    map["employee_salary"] = salary;
    map["profile_image"] = image;
    map["employee_age"] = age;
    return map;
  }

  set _name(String name) {
    this.name = name;
  }
  set _salary(String salary) {
    this.salary = salary;
  }
}
