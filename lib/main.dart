// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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

  windowManager.waitUntilReadyToShow().then((_) async{
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    await windowManager.setSize(Size(prog.width, prog.height));
    await windowManager.setPosition(Offset(prog.xPos, prog.yPos));
    await windowManager.setPreventClose(true);
    await windowManager.show();
    await windowManager.setSkipTaskbar(false);
  });

  runApp(const ThlindeApp());
}

class ThlindeApp extends StatelessWidget {
  const ThlindeApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: StoreBinding(),
      title: 'thlindeApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  }

  void disposeWidget() {
    windowManager.removeListener(this);
  }

  final ProgController prog = Get.find();
  PageController page = PageController();
  // thlinde:Initialize Items for NavigatenSideBar
  final navContentPages = navItemsContentPages();

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
        onInit: () {
          // controller.setAppointmentDateStr(todayDate());
          initWidget();
        },
        onDispose: () {
          disposeWidget();
        },
        chid: Scaffold(
          appBar: PreferredSize(
            child: WindowCaption(
              brightness: Theme
                  .of(context)
                  .brightness,
              title: const Text(
                // todo thlinde: change window title
                'Rheumatologische Dokumentation',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              backgroundColor: Colors.grey[500],
            ),
            preferredSize: const Size.fromHeight(kWindowCaptionHeight),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const TopBar(),
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
                          child: SizedBox(
                            width: 250.0,
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
                                        page.animateToPage(
                                            navContentPages[index].index,
                                            curve: Curves.ease,
                                            duration: const Duration(
                                                milliseconds: 400)
                                        );
                                      },
                                      title: Text(
                                        navContentPages[index].title,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      leading: Icon(navContentPages[index].icon),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 250,
                              height: 145,
                              child: ListView(
                                padding: const EdgeInsets.all(8),
                                children: [
                                  const Divider(),
                                  Card(
                                    elevation: 0.0,
                                    color: Colors.grey[200],
                                    child: ListTile(
                                      onTap: () {
                                        // thlinde:Settings is last Page: length+1
                                        page.animateToPage(
                                            navContentPages.length + 1,
                                            curve: Curves.ease,
                                            duration: const Duration(
                                                milliseconds: 400)
                                        );
                                      },
                                      title: const Text(
                                        "Einstellungen",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      leading: const Icon(
                                        Icons.settings,
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0.0,
                                    color: Colors.red[300],
                                    child: ListTile(
                                      textColor: Colors.grey[100],
                                      onTap: () {
                                        windowManager.close();
                                      },
                                      title: const Text(
                                        "Programm beenden",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      leading: Icon(Icons.exit_to_app,
                                          color: Colors.grey[100]),
                                    ),
                                  ),
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
                          GeneralPage(title: 'Testseite 1'),
                          GeneralPage(title: 'Testseite 2'),
                          GeneralPage(title: 'Testseite 3'),
                          SettingsPage(title: 'Einstellungen'),
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
    final pos = await windowManager.getPosition();
    prog.setXPos(pos.dx);
    prog.setyPos(pos.dy);
    final size = await windowManager.getSize();
    prog.setHeight(size.height);
    prog.setWidth(size.width);
  }
}



