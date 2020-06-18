class EmployeeRes {
  final String status;
  final List<Employee> list;

  EmployeeRes({this.status, this.list});

  factory EmployeeRes.fromJson(Map<String, dynamic> json) {
    return EmployeeRes(status: json['status'], list: json['data']);
  }
}

class Employee {
  final int id;
  final String name;
  final String salary;
  final String image;
  final int age;

  Employee(this.id, this.name, this.salary, this.image, this.age);

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        json['id'],
        json['employee_name'],
        json['employee_salary'],
        json['profile_image'],
        json['employee_age']
    );
  }
}
