import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:stacked/stacked.dart';

import '../home_viewmodel.dart';

class SidebarItem {
  final String title;
  final IconData icon;

  SidebarItem({required this.title, required this.icon});
}

class SideBar extends ViewModelWidget<HomeViewModel> {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return SizedBox(
      width: 300,
      child: Ink(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: ListView.builder(
            itemCount: viewModel.sidebarItems.length,
            itemBuilder: (context, index) {
              final item = viewModel.sidebarItems[index];
              return ListTile(
                iconColor: greyColor,
                textColor: fontColor,
                selectedColor: primaryColor,
                selected: viewModel.currentIndex == index,
                leading: Icon(item.icon),
                title: Text(item.title),
                onTap: () => viewModel.handleNavigation(index),
              );
            },
          ),
        ),
      ),
    );
  }
}
