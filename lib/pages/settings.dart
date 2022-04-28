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
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PageHeader(title: title),
            Container(
              color: Colors.grey.shade200,
              child: TabBar(
                labelColor: Colors.grey.shade700,
                labelStyle: const TextStyle(fontWeight: FontWeight.w700),
                tabs: const [
                  Tab(
                    text: 'Dateien/Verzeichnisse',
                  ),
                  Tab(
                    text: 'Textkürzel',
                  ),
                  Tab(
                    text: 'Laboreinstellungen',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                  // child: TabFilesFolder(controller: controller)
                children: [
                  TabFilesFolder(controller: controller),
                  const TextData(),
                  const LaboratorySettings(),
                ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabFilesFolder extends StatelessWidget {
  const TabFilesFolder({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final StoreController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          PathChooser(
              title: 'Pfad zur GDT-Datei',
              label: 'GDT-Datei',
              icon: const Icon(LineIcons.file),
              itemCtr: controller.gdtPathController,
          ),
          const Divider(),
          PathChooser(
              title: 'Pfad zum Verzeichnis der Textkürzel-Datei',
              label: 'textdata.json',
              icon: const Icon(LineIcons.folderOpen),
              itemCtr: controller.textDataFilePathController,
          ),
          const Divider(),
          PathChooser(
            title: 'Pfad zur Datenbank-Datei',
            label: 'RheumaDok',
            icon: const Icon(LineIcons.file),
            itemCtr: controller.dbFilePathController,
          ),
        ],
      ),
    );
  }
}

class TextData extends StatelessWidget {
  const TextData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            color: Colors.yellow,
            height: 500,
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
    );
  }
}

class LaboratorySettings extends StatelessWidget {
  const LaboratorySettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            height: 500,
          ),
          Container(
            color: Colors.yellow,
            height: 500,
          ),
          Container(
            color: Colors.green,
            height: 500,
          ),
        ],
      ),
    );
  }
}
