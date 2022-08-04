import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_card.dart';
import 'package:stacked/stacked.dart';

import 'jurnal_folder_viewmodel.dart';

class JurnalFolderView extends StatelessWidget {
  const JurnalFolderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JurnalFolderViewModel>.reactive(
      viewModelBuilder: () => JurnalFolderViewModel(),
      builder: (
        BuildContext context,
        JurnalFolderViewModel model,
        Widget? child,
      ) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: CustomCard(
                    title: "Daftar Jurnal",
                    // subtitle: "Silahkan tambahkan jurnal baru",
                    childExpanded: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        Text(
                          'Semua Folders',
                          style: boldTextStyle.copyWith(
                              fontSize: 24, color: secondaryColor),
                        ),
                        const SizedBox(height: 16),
                        Flexible(
                          child: Card(
                            margin: const EdgeInsets.all(0),
                            elevation: 0,
                            child: Column(
                              children: [
                                Flexible(
                                  child: Card(
                                    elevation: 0,
                                    margin: const EdgeInsets.all(0),
                                    child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 250,
                                          mainAxisSpacing: 16,
                                          crossAxisSpacing: 16,
                                          childAspectRatio: 3,
                                        ),
                                        itemCount: model.prodis.length,
                                        itemBuilder: (context, index) {
                                          final prodi = model.prodis[index];

                                          return ListTile(
                                            onTap: () =>
                                                model.toJurnalView(prodi),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: const BorderSide(
                                                color: greySecondaryColor,
                                                width: 1.5,
                                              ),
                                            ),
                                            leading: const Icon(
                                              Ionicons.folder,
                                              color: secondaryColor,
                                            ),
                                            title: Text(
                                              prodi.nama,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            subtitle: Text(
                                                '${prodi.jumlahJurnal} file | ${prodi.size}',
                                                style: greyTextStyle),
                                          );
                                        }),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  tileColor: secondaryColor,
                                  leading: const Icon(
                                    Ionicons.information_circle,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    'Klik disini untuk memulai proses dokumen',
                                    style: primaryTextStyle.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Colors.white)),
                                    icon: const Icon(
                                      Ionicons.send,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'Proses',
                                      style: primaryTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                    onPressed: model.toJurnalProsesView,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
