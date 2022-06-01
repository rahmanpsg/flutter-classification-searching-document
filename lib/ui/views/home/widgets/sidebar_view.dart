import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:stacked/stacked.dart';

import '../home_viewmodel.dart';

class SideBar extends ViewModelWidget<HomeViewModel> {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Ink(
      width: 200,
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
              selected: viewModel.sidebarActiveIndex == index,
              leading: Icon(item.icon),
              title: Text(item.title),
              onTap: () => viewModel.setSidebarActiveIndex(index),
            );
          },
        ),
      ),
    );
  }
}
