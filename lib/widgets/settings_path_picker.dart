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
                    onPressed: () => print('User pressed!'),
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
}