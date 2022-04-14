// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

class NavItem {
  int index;
  String title;
  IconData icon;
  bool isSelected;
  NavItem(this.index, this.title, this.icon, {this.isSelected = false});
}

List<NavItem> navItemsContentPages() {
  List<NavItem> _list = [];
  _list.add(NavItem(0, 'Patient', LineIcons.userAlt));
  _list.add(NavItem(1, 'Anamnese', LineIcons.history));
  _list.add(NavItem(2, 'Untersuchung', LineIcons.stethoscope));
  _list.add(NavItem(3, 'Scores', LineIcons.star));
  _list.add(NavItem(4, 'Therapie', LineIcons.tablets));
  _list.add(NavItem(5, 'Epikrise', LineIcons.envelopeOpenText));
  return _list;
}

List<NavItem> navItemsUtilityPages() {
  List<NavItem> _list = [];
  _list.add(NavItem(0, 'Information', LineIcons.infoCircle));
  _list.add(NavItem(1, 'Einstellungen', LineIcons.cog));
  return _list;
}

todayDate() => DateFormat('dd.MM.yyyy').format(DateTime.now());