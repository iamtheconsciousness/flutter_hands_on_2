// To parse this JSON data, do
//
//     final myLed = myLedFromJson(jsonString);

import 'dart:convert';

ReadTable myStructFromJson(String str) => ReadTable.fromJson(json.decode(str));

String myStructToJson(ReadTable data) => json.encode(data.toJson());

class ReadTable {
  ReadTable({
    required this.led,
    required this.success,
  });

  List<Led> led;
  int success;

  factory ReadTable.fromJson(Map<String, dynamic> json) => ReadTable(
    led: List<Led>.from(json["led"].map((x) => Led.fromJson(x))),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "led": List<dynamic>.from(led.map((x) => x.toJson())),
    "success": success,
  };
}

class Led {
  Led({
    required this.id,
    required this.state,
    required this.room,
  });

  String id;
  String state;
  String room;

  factory Led.fromJson(Map<String, dynamic> json) => Led(
    id: json["id"],
    state: json["state"],
    room: json["room"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "state": state,
    "room": room,
  };
}
