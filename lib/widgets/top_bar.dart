// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';
import '../model/store.dart';
import '../model/utility.dart';
import 'set_date_dlg.dart';
import 'package:rheuma_dokumentation/services/read_gdt.dart';

class TopBar extends GetView<StoreController> {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // thlinde:init appointment date
    controller.setAppointmentDateStr(todayDate());

    return Container(
      height: 70,
      decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 7.0,
                offset: Offset(0.0, 0.75)
            )
          ]
      ),
      child: Ink(
        color: Theme
            .of(context)
            .appBarTheme
            .backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(left: 16)),
            SizedBox(
              height: 40,
              width: 40,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                child: IconButton(
                  icon: const Icon(
                    LineIcons.user,
                    size: 25,
                  ),
                  onPressed: () => readGdt(),
                  splashRadius: 25,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return Text(
                    controller.patDataPart1,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color:
                        Theme
                            .of(context)
                            .appBarTheme
                            .foregroundColor
                    ),
                  );
                }),
                Obx(() {
                  return Text(
                    controller.patDataPart2,
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme
                            .of(context)
                            .appBarTheme
                            .foregroundColor
                    ),
                  );
                }),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 250,
                  height: 30,
                  child: WindowCaption(
                    brightness: Brightness.dark,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(
                  width: 250,
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() =>
                          Text(
                            controller.appointmentDateStr,
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme
                                  .of(context)
                                  .appBarTheme
                                  .foregroundColor,
                            ),
                          ),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 16)),
                      IconButton(
                        onPressed: () => openSetDateDlg(context),
                        icon: const Icon(LineIcons.calendarWithDayFocus),
                        color: Theme
                            .of(context)
                            .appBarTheme
                            .foregroundColor,
                      ),
                      const Padding(padding: EdgeInsets.only(right: 4)),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
