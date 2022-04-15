// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';
import '../model/store.dart';
import '../model/utility.dart';
import 'set_date_dlg.dart';

class TopBar extends GetView<StoreController> {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // thlinde:init appointment date
    controller.setAppointmentDateStr(todayDate());

    return SizedBox(
      height: 60,
      child: Ink(
        color: Colors.grey.shade700,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(left: 16)),
            Ink(
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: Colors.blue.shade700,
              ),
              child: IconButton(
                onPressed: () {},
                iconSize: 25,
                splashRadius: 25,
                icon: Icon(
                  LineIcons.user,
                  color: Colors.grey.shade300,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
            Text(
              '',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade100
              ),
            ),
            const Expanded(child: SizedBox()),
            Obx(() =>
                Text(
                  controller.getAppointmentDateStr(),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade100
                  ),
                ),
            ),
            const Padding(padding: EdgeInsets.only(right: 16)),
            Ink(
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: Colors.blue.shade700,
              ),
              child: IconButton(
                onPressed: () => openSetDateDlg(context),
                splashRadius: 25,
                iconSize: 25,
                icon: Icon(
                  LineIcons.calendarWithDayFocus,
                  color: Colors.grey[300],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 16)),
          ],
        ),
      ),
    );
  }
}