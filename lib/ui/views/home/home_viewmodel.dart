import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/ui/views/dashboard/dashboard_view.dart';
import 'package:pencarian_jurnal/ui/views/jurnal/jurnal_view.dart';
import 'package:pencarian_jurnal/ui/views/klasifikasi/klasifikasi_view.dart';
import 'package:pencarian_jurnal/ui/views/pencarian/pencarian_view.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  int _sidebarActiveIndex = 1;

  final List<SidebarItem> _sidebarItems = [
    SidebarItem(title: "Dashboard", icon: Ionicons.home),
    SidebarItem(title: "Jurnal", icon: Ionicons.document_text),
    SidebarItem(title: "Klasifikasi", icon: Ionicons.library),
    SidebarItem(title: "Pencarian", icon: Ionicons.search),
  ];

  int get sidebarActiveIndex => _sidebarActiveIndex;
  List<SidebarItem> get sidebarItems => _sidebarItems;

  void setSidebarActiveIndex(int index) {
    _sidebarActiveIndex = index;
    notifyListeners();
  }

  Widget get viewForIndex => [
        const DashboardView(),
        const JurnalView(),
        const KlasifikasiView(),
        const PencarianView(),
      ][sidebarActiveIndex];
}

class SidebarItem {
  final String title;
  final IconData icon;

  SidebarItem({required this.title, required this.icon});
}
