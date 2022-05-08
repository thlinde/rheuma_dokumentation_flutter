// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rheuma_dokumentation/model/store.dart';
import 'package:file_picker/file_picker.dart';

//ignore: must_be_immutable
class PathChooser extends GetView<StoreController> {
  PathChooser({
    Key? key,
    required this.title,
    required this.label,
    required this.icon,
    required this.itemCtr,
    required this.isDirectory,
  }) : super(key: key);

  final String title;
  final String label;
  final Icon icon;
  final TextEditingController itemCtr;
  final bool isDirectory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SizedBox(
                  width: 100,
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: itemCtr,
                  readOnly: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: IconButton(
                    icon: icon,
                    onPressed: () => _pickPath(),
                    splashRadius: 25,
                    iconSize: 25,
                    autofocus: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PlatformFile>? _filePaths;
  String? _directoryPath;

  void _pickPath() async {
    try {
      if(isDirectory) {
        _directoryPath = await FilePicker.platform.getDirectoryPath();
      } else {
        _filePaths = (await FilePicker.platform.pickFiles(
          allowMultiple: false,
        ))?.files;
      }
    } on PlatformException catch (e) {
      _logException('Unsupported operation:' + e.toString());
    } catch (e){
      _logException(e.toString());
    }
    if(isDirectory) {
      itemCtr.text = _directoryPath != null ? _directoryPath! : '';
    } else {
      itemCtr.text = (_filePaths != null ? _filePaths?.first.path : '')!;
    }
  }

  void _logException(String message) {
    print(message);
    Get.snackbar(
        'Fehler',
        message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
    );
  }
}