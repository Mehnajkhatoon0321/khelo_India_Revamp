import 'package:flutter/material.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/utils/simple_translator.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';
import 'package:gms_application/core/widgets/no_data_available.dart';

class MedalAthletes extends StatelessWidget {
  const MedalAthletes({
    super.key,
    required this.title,
    required this.athletes,
  });

  final String title;
  final List<Map<String, dynamic>> athletes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColors,
      appBar: CommonAppBar(
        title: title,
        showBack: true,
        showNotification: true,
        backgroundColor: AppColors.whiteColors,
        showBottomDivider: true,
      ),
      body: athletes.isEmpty
          ? const NoDataAvailable(
              title: 'No data available',
              illustration: EmptyMedalIllustration(size: 180),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(14, 22, 14, 16),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 6),
                  Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: AppColors.whiteOffColors,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.scheduleCardBorder),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x12000000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: <Widget>[
                        SizedBox(
                            width: 52,
                            child: TrText('S.No.',
                                style: TextStyle(fontWeight: FontWeight.w600))),
                        Expanded(
                            child: TrText('Name',
                                style: TextStyle(fontWeight: FontWeight.w600))),
                        SizedBox(
                            width: 64,
                            child: TrText('Medal',
                                textAlign: TextAlign.end,
                                style: TextStyle(fontWeight: FontWeight.w600))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      itemCount: athletes.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, int index) {
                        final Map<String, dynamic> athlete = athletes[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColors,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.scheduleCardBorder),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Color(0x1A000000),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 52,
                                child: TrText(
                                  '${athlete['sNo'] ?? index + 1}',
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TrText(
                                      '${athlete['name'] ?? ''}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 20 * 0.68,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    TrText(
                                      'KID: ${athlete['kid'] ?? '-'}',
                                      style: const TextStyle(
                                        color: AppColors.scheduleMutedText,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 64,
                                child: TrText(
                                  '${athlete['medal'] ?? '-'}',
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
