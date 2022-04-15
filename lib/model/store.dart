// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StoreController extends GetxController {
  var appointmentDateStr = ''.obs;
  String getAppointmentDateStr() => appointmentDateStr.value;
  setAppointmentDateStr(String str) => appointmentDateStr.value = str;

  TextEditingController gdtPathController = TextEditingController();
}

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoreController>(() => StoreController());
  }
}

class ProgController extends GetxController {
  final storage = GetStorage();
  double get xPos => storage.read('xPos') ?? 50.0;
  void setXPos(double val) => storage.write('xPos', val);
  double get yPos => storage.read('yPos') ?? 50.0;
  void setyPos(double val) => storage.write('yPos', val);
  double get height => storage.read('height') ?? 800.0;
  void setHeight(double val) => storage.write('height', val);
  double get width => storage.read('width') ?? 1000.0;
  void setWidth(double val) => storage.write('width', val);
}

