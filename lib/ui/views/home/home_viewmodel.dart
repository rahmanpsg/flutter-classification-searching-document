import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/ui/views/dashboard/dashboard_view.dart';
import 'package:pencarian_jurnal/ui/views/jurnal_folder/jurnal_folder_view.dart';
import 'package:pencarian_jurnal/ui/views/klasifikasi/klasifikasi_view.dart';
import 'package:pencarian_jurnal/ui/views/pencarian/pencarian_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'widgets/sidebar_view.dart';

class HomeViewModel extends IndexTrackingViewModel {
  final _navigationService = locator<NavigationService>();

  final List<SidebarItem> _sidebarItems = [
    SidebarItem(title: "Dashboard", icon: Ionicons.home),
    SidebarItem(title: "Jurnal", icon: Ionicons.document_text),
    SidebarItem(title: "Klasifikasi", icon: Ionicons.library),
    SidebarItem(title: "Pencarian", icon: Ionicons.search),
  ];

  List<SidebarItem> get sidebarItems => _sidebarItems;

  void handleNavigation(int index) {
    if (currentIndex == index) return;

    setIndex(index);
    switch (index) {
      case 0:
        _navigationService.replaceWithTransition(
          const DashboardView(),
          transitionStyle: Transition.rightToLeft,
          id: 0,
        );
        break;
      case 1:
        _navigationService.replaceWithTransition(
          const JurnalFolderView(),
          transitionStyle: Transition.rightToLeft,
          id: 0,
        );
        break;
      case 2:
        _navigationService.replaceWithTransition(
          const KlasifikasiView(),
          transitionStyle: Transition.rightToLeft,
          id: 0,
        );
        break;
      case 3:
        _navigationService.replaceWithTransition(
          const PencarianView(),
          transitionStyle: Transition.rightToLeft,
          id: 0,
        );
        break;
      default:
    }

    notifyListeners();
  }
}
