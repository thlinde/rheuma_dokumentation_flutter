// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:json_theme/json_theme.dart';

import 'model/store.dart';
import 'model/utility.dart';
import 'widgets/stateful_wrapper.dart';
import 'widgets/top_bar.dart';
import 'pages/settings.dart';
import 'pages/page01.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  await GetStorage.init();
  final ProgController prog = Get.put(ProgController());

  final themeStr = await rootBundle.loadString('assets/thlinde_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  windowManager.waitUntilReadyToShow().then((_) async{
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    await windowManager.setMinimumSize(const Size(1024, 800));
    await windowManager.setSize(Size(prog.width, prog.height));
    await windowManager.setPosition(Offset(prog.xPos, prog.yPos));
    await windowManager.setPreventClose(true);
    await windowManager.show();
    await windowManager.setSkipTaskbar(false);
  });

  runApp(ThlindeApp(theme: theme));
}

class ThlindeApp extends StatelessWidget {
  final ThemeData theme;

  const ThlindeApp({Key? key, required this.theme}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: StoreBinding(),
      // scrollBehavior: AppScrollBehavior(),
      title: 'thlindeApp',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      theme: theme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('de', ''),
      ],
      home: MainLayout(),
    );
  }
}

// ignore: must_be_immutable
class MainLayout extends GetView<StoreController> with WindowListener {
  MainLayout({Key? key}) : super(key: key);
  void initWidget() {
    windowManager.addListener(this);
    store.gdtPathController.text = prog.gdtFilePath;
    store.textDataFilePathController.text = prog.textdataDirectoryPath;
    store.rheumadokFilePathController.text = prog.rheumadokFilePath;
  }

  void disposeWidget() {
    windowManager.removeListener(this);
  }

  final ProgController prog = Get.find();
  final StoreController store = Get.put(StoreController());

  @override
  Widget build(BuildContext context) {

    PageController page = PageController();
    // thlinde:Initialize Items for NavigatenSideBar
    final navContentPages = navItemsContentPages();

    return StatefulWrapper(
        onInit: () {
          // controller.setAppointmentDateStr(todayDate());
          initWidget();
        },
        onDispose: () {
          disposeWidget();
        },
        chid: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const DragToMoveArea(
                  child: TopBar()
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // thlinde:SideBar
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: 250.0,
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300,
                            ))),
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: navContentPages.length,
                              itemBuilder: (context, index) =>
                                  Card(
                                    elevation: 0.0,
                                    color: Colors.grey[200],
                                    key: ValueKey(navContentPages[index].index),
                                    child: ListTile(
                                      onTap: () {
                                        // page.jumpToPage(navList[index].index);
                                        // page.animateToPage(
                                        //     navContentPages[index].index,
                                        //     curve: Curves.ease,
                                        //     duration: const Duration(
                                        //         milliseconds: 400)
                                        // );
                                        page.jumpToPage(navContentPages[index].index);
                                      },
                                      title: Text(
                                        navContentPages[index].title,
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                      leading: Icon(navContentPages[index].icon),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 250,
                              height: 220,
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                        width: 1.0,
                                        color: Colors.grey.shade300,
                                      ))),
                              child: ListView(
                                padding: const EdgeInsets.all(8),
                                children: [
                                  const Divider(),
                                  Card(
                                    elevation: 0.0,
                                    color: Colors.grey[200],
                                    child: ListTile(
                                      onTap: () {
                                        // page.animateToPage(
                                        //     currentIndex,
                                        //     curve: Curves.ease,
                                        //     duration: const Duration(
                                        //         milliseconds: 400)
                                        // );
                                        page.jumpToPage(navContentPages.length);
                                      },
                                      title: Text(
                                        "Einstellungen",
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                      leading: const Icon(
                                        LineIcons.cog,
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0.0,
                                    color: Colors.grey[200],
                                    child: ListTile(
                                      onTap: () {
                                        // page.animateToPage(
                                        //     navContentPages.length + 1,
                                        //     curve: Curves.ease,
                                        //     duration: const Duration(
                                        //         milliseconds: 400)
                                        // );
                                        page.jumpToPage(navContentPages.length + 1);
                                      },
                                      title: Text(
                                        "Information",
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                      leading: const Icon(
                                        LineIcons.infoCircle,
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0.0,
                                    color: Colors.red[300],
                                    // color: Theme.of(context).errorColor,
                                    child: ListTile(
                                      textColor: Colors.grey[100],
                                      onTap: () {
                                        windowManager.close();
                                      },
                                      title: const Text(
                                        "Programm beenden",
                                        style: TextStyle(
                                            fontSize: 14,
                                        ),
                                      ),
                                      leading: Icon(LineIcons.powerOff,
                                          color: Colors.grey[100]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Ⓒ thlinde 2022',
                                          style: Theme.of(context).textTheme.caption,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    // thlinde:Pages
                    Expanded(
                      // Todo here comes the pages
                      child: PageView(
                        controller: page,
                        children: const [
                          GeneralPage(title: 'Patientendaten'),
                          GeneralPage(title: 'Anamnese'),
                          GeneralPage(title: 'Untersuchung'),
                          GeneralPage(title: 'Scores'),
                          GeneralPage(title: 'Therapie'),
                          GeneralPage(title: 'Epikrise'),
                          SettingsPage(title: 'Einstellungen'),
                          GeneralPage(title: 'Programminformation'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      Get.defaultDialog(
        title: 'Beendigung des Programms',
        titleStyle: const TextStyle(fontWeight: FontWeight.w700),
        middleText: 'Soll das Programm wirklich beendet werden?',
        middleTextStyle: const TextStyle(fontWeight: FontWeight.w400),
        textCancel: 'Nein',
        textConfirm: 'Ja',
        cancelTextColor: Colors.grey[800],
        confirmTextColor: Colors.grey[100],
        buttonColor: Colors.red[300],
        backgroundColor: Colors.grey[300],
        radius: 4,
        onConfirm: () async {
          await saveProgSettings();
          windowManager.destroy();
          // thlinde:closes Dialog, here not neccessary because of destroying
          // Get.back();
        },
      );
    }
  }

  saveProgSettings() async {
    // window
    final pos = await windowManager.getPosition();
    prog.setXPos(pos.dx);
    prog.setyPos(pos.dy);
    final size = await windowManager.getSize();
    prog.setHeight(size.height);
    prog.setWidth(size.width);

    // settings
    prog.setGdtFilePath(store.gdtPathController.text);
    prog.setTextdataDirectoryPath(store.textDataFilePathController.text);
    prog.setRheumadokFilePath(store.rheumadokFilePathController.text);
  }
}



