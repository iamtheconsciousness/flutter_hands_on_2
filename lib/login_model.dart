// To parse this JSON data, do
//
//     final myLed = myLedFromJson(jsonString);

import 'dart:convert';

MyLed myLedFromJson(String str) => MyLed.fromJson(json.decode(str));

String myLedToJson(MyLed data) => json.encode(data.toJson());

class MyLed {
  MyLed({
     this.room,
     this.roomDetail,
     this.table,
     this.success,
  });

  List<String> room;
  List<RoomDetail> roomDetail;
  String table;
  int success;

  factory MyLed.fromJson(Map<String, dynamic> json) => MyLed(
    room: List<String>.from(json["room"].map((x) => x)),
    roomDetail: List<RoomDetail>.from(json["room_detail"].map((x) => RoomDetail.fromJson(x))),
    table: json["table"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "room": List<dynamic>.from(room.map((x) => x)),
    "room_detail": List<dynamic>.from(roomDetail.map((x) => x.toJson())),
    "table": table,
    "success": success,
  };
}

class RoomDetail {
  RoomDetail({
     this.devices,
  });

  List<Device> devices;


  factory RoomDetail.fromJson(Map<String, dynamic> json) => RoomDetail(
    devices: List<Device>.from(json["devices"].map((x) => Device.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "devices": List<dynamic>.from(devices.map((x) => x.toJson())),
  };
}

class Device {
  Device({
     this.id,
     this.type,
  });

  String id;
  String type;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    id: json["id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
  };
}
