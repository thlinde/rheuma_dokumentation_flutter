// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/store.dart';
import 'package:intl/intl.dart';

openSetDateDlg(BuildContext context) async {
  final StoreController store = Get.put(StoreController());
  DateTime currentDate;
  currentDate = store.appointmentDateStr.value != ''
      ? DateFormat('dd.MM.yyyy').parse(store.appointmentDateStr.value)
      : DateTime.now();
  final DateTime? _selected = await showDatePicker(
      locale: const Locale('de', 'DE'),
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030)
  );
  if (_selected != null && _selected != currentDate) {
    store.setAppointmentDateStr(DateFormat('dd.MM.yyyy').format(_selected));
  }
}
