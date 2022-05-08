// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:rheuma_dokumentation/model/store.dart';
import 'package:rheuma_dokumentation/services/calculate_age.dart';
import 'package:get/get.dart';
import 'package:charset_converter/charset_converter.dart';

void readGdt() async {
  StoreController store = Get.find();

  final _file = File(store.gdtPathController.text);
  if (await _file.exists()) {
    final List<int> _content = await _file.readAsBytes();
    final gdtTxt = await CharsetConverter.decode(
        "windows1250", Uint8List.fromList(_content));
    LineSplitter.split(gdtTxt).forEach((line) {
      if (line.isNotEmpty) {
        String fieldname = line.substring(3, 7);
        if(fieldname == '3000') {
          store.setPatId(line.substring(7).trim());
        }
        if(fieldname == '3102') {
          store.setPatSurname(line.substring(7).trim());
        }
        if(fieldname == '3101') {
          store.setPatLastName(line.substring(7).trim());
        }
        if (fieldname == '3103') {
          final birthdayStr =
              '${line.substring(7, 9)}.${line.substring(9, 11)}.${line.substring(11, 15)}';
          store.setPatBirthday(birthdayStr);
        }
        if(fieldname == '3110') {
          final gd = line.substring(7).trim() == '1' ? 'männlich' : 'weiblich';
          store.setPatGender(gd);
        }
        if(fieldname == '3106') {
          store.setPatZipCity(line.substring(7).trim());
        }
        if(fieldname == '3107') {
          store.setPatStreetNo(line.substring(7).trim());
        }
      }
    });
    calculateAge();
  }
}