// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rheuma_dokumentation/model/store.dart';

class PathChooser extends GetView<StoreController> {
  const PathChooser({
    Key? key,
    required this.title,
    required this.label,
    required this.icon,
    required this.itemCtr,
  }) : super(key: key);

  final String title;
  final String label;
  final Icon icon;
  final TextEditingController itemCtr;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
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
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  ),
                  controller: itemCtr,
                  readOnly: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                  onPressed: () {},
                  icon: icon,
                  // color: Colors.grey.shade700,
                  color: Colors.blue.shade700,
                  splashRadius: 25,
                  iconSize: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// IconButton(
// onPressed: () => {},
// splashRadius: 25,
// icon: Icon(
// LineIcons.fileDownload,
// color: Colors.grey[100],
// size: 20,
// ),
// ),