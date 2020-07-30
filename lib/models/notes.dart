import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Note {
  String vehicleNotes_string;
  bool ownerNotes;
  bool paymentNotes;

  Map<String, dynamic> toJson() => <String, dynamic>{
    "vehicleNotes_string":vehicleNotes_string,
    "ownerNotes":ownerNotes,
    "paymentNotes":paymentNotes,
  };

  Note({
  @required this.vehicleNotes_string,
    this.ownerNotes,
    this.paymentNotes
  });

  factory Note.fromJson(Map<String, dynamic> json) =>
      _towedVehicleNotesFromJson(json);
}

Note _towedVehicleNotesFromJson(Map<String, dynamic> parsedJson) {
  return Note(
      vehicleNotes_string: parsedJson["vehicleNotes_string"],
      ownerNotes: _convertTobool(parsedJson["ownerNotes"]),
      paymentNotes: _convertTobool(parsedJson["paymentNotes"]));
}

  bool _convertTobool(value) {
    if (value is String) {
      if (value.toLowerCase() == "true")
        return true;
      else
        return false;
    } else
      return value;
  }