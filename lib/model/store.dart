// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StoreController extends GetxController {
  // global variables, getter, setter
  final _appointmentDateStr = ''.obs;
  String get appointmentDateStr => _appointmentDateStr.value;
  void setAppointmentDateStr(String str) => _appointmentDateStr.value = str;

  // textcontroller, getter, setter
  TextEditingController gdtPathController = TextEditingController();
  String get gdtPath => gdtPathController.text;
  void setGdtPath(String value) => gdtPathController.text = value;

  TextEditingController textDataFilePathController = TextEditingController();
  String get textDataFilePath => textDataFilePathController.text;
  void setTextDataFilePath(String value) => textDataFilePathController.text = value;

  TextEditingController rheumadokFilePathController = TextEditingController();
  String get rheumadokFilePath => rheumadokFilePathController.text;
  void setRheumadokFilePathController(String value) => rheumadokFilePathController.text = value;

  // patient data, getter, setter
  final _patId = ''.obs;
  String get patId => _patId.value;
  void setPatId(String val) => _patId.value = val;

  final _patSurname = ''.obs;
  String get patSurname => _patSurname.value;
  void setPatSurname(String val) => _patSurname.value = val;

  final _patLastName = ''.obs;
  String get patLastName => _patLastName.value;
  void setPatLastName(String val) => _patLastName.value = val;

  final _patBirthday = ''.obs;
  String get patBirthday => _patBirthday.value;
  void setPatBirthday(String val) => _patBirthday.value = val;

  final _patAge = ''.obs;
  String get patAge => _patAge.value;
  void setPatAge(String val) => _patAge.value = val;

  final _patGender = ''.obs;
  String get patGender => _patGender.value;
  void setPatGender(String val) => _patGender.value = val;

  String get patDataPart1 => patId.isNotEmpty
      ? '$patSurname $patLastName'
      : '';

  String get patDataPart2 => patId.isNotEmpty
      ? 'Pat-ID: $patId, geboren am $patBirthday ($patAge Jahre), $patGender'
      : '';

  final _patZipCity = ''.obs;
  String get patZipCity => _patZipCity.value;
  void setPatZipCity(String val) => _patZipCity.value = val;

  final _patStreetNo = ''.obs;
  String get patStreetNo => _patStreetNo.value;
  void setPatStreetNo(String val) => _patStreetNo.value = val;
}

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoreController>(() => StoreController());
  }
}

class ProgController extends GetxController {
  final storage = GetStorage();

  // window
  double get xPos => storage.read('xPos') ?? 50.0;
  void setXPos(double val) => storage.write('xPos', val);
  double get yPos => storage.read('yPos') ?? 50.0;
  void setyPos(double val) => storage.write('yPos', val);
  double get height => storage.read('height') ?? 800.0;
  void setHeight(double val) => storage.write('height', val);
  double get width => storage.read('width') ?? 1000.0;
  void setWidth(double val) => storage.write('width', val);

  // settings
  String get gdtFilePath => storage.read('gdtFilePath') ?? '';
  void setGdtFilePath(String val) => storage.write('gdtFilePath', val);
  String get textdataDirectoryPath => storage.read('textdataDirectoryPath') ?? '';
  void setTextdataDirectoryPath(String val) => storage.write('textdataDirectoryPath', val);
  String get rheumadokFilePath => storage.read('rheumadokFilePath') ?? '';
  void setRheumadokFilePath(String val) => storage.write('rheumadokFilePath', val);
}

