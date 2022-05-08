// ignore_for_file: avoid_print

import 'package:rheuma_dokumentation/model/store.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void calculateAge() {
  StoreController store = Get.find();
  DateTime birthday = DateFormat('dd.MM.yyyy').parse(store.patBirthday);
  DateTime today = DateFormat('dd.MM.yyyy').parse(store.appointmentDateStr);

  int yearDiff = today.year - birthday.year;
  int monthDiff = today.month - birthday.month;
  int dayDiff = today.day - birthday.day;

  if(dayDiff > 0 || (monthDiff > 0 && dayDiff >= 0)) {
    store.setPatAge((yearDiff + 1).toString());
  } else {
    store.setPatAge(yearDiff.toString());
  }
}