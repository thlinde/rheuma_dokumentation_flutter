// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rheuma_dokumentation/model/store.dart';
import '../widgets/page_header.dart';
import '../widgets/settings_path_picker.dart';

class SettingsPage extends GetView<StoreController> {
  const SettingsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PageHeader(title: title),
          Expanded(
            child: SingleChildScrollView(
              controller: ScrollController(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  PathChooser(
                      title: 'Pfad zur GDT-Datei',
                      label: 'GDT',
                      icon: const Icon(LineIcons.file),
                      itemCtr: controller.gdtPathController,
                  ),
                  Container(
                    color: Colors.blue,
                    height: 500,
                  ),
                  Container(
                    color: Colors.green,
                    height: 500,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
