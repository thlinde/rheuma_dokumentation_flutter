// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
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
      height: 70,
      child: Ink(
        color: Theme.of(context).colorScheme.inverseSurface,
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
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: IconButton(
                  icon: const Icon(
                    LineIcons.user,
                    size: 25,
                  ),
                  onPressed: () => print('User pressed!'),
                  splashRadius: 25,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thomas Linde',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color:
                          Theme.of(context).colorScheme.onInverseSurface
                  ),
                ),
                Text(
                  'Pat-ID: 55639, geboren am 25.11.1961, männlich',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onInverseSurface
                  ),
                ),
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
                                color: Theme.of(context).colorScheme.onInverseSurface
                            ),
                          ),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 16)),
                      IconButton(
                        onPressed: () => openSetDateDlg(context),
                        icon: const Icon(LineIcons.calendarWithDayFocus),
                        color: Theme.of(context).colorScheme.onInverseSurface,
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