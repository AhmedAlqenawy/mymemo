import 'dart:convert';


Person barangFromMap(String str) => Person.fromMap(json.decode(str));

String barangToMap(Person data) => json.encode(data.toMap());


class Person {
  Person({
    this.name,
    this.memoNum,
    this.birthDate,
    this.notify,
    this.id,

  });
  String name ;
  int memoNum,notify,id;
  String birthDate;


  factory Person.fromMap(Map<dynamic, dynamic> json) => Person(
    name: json["name"] == null ? null : json["name"],
    memoNum: json["memoNum"] == null ? null : json["memoNum"],
    birthDate: json["birthDate"] == null ? null : json["birthDate"],
    notify: json["notify"] == null ? null : json["notify"],
    id: json["id"] == null ? null : json["id"],

  );

  Map<String, dynamic> toMap() => {
     "name": name == null ? null : name,
    "memoNum": memoNum == null ? null : memoNum,
    "birthDate": birthDate == null ? null : birthDate,
    "notify": notify == null ? null : notify,
    "id": id == null ? null : id,
  };
}
