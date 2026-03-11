import 'package:flutter/material.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/utils/simple_translator.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';

Future<int?> openSelectCompetitionBottomSheet({
  required BuildContext context,
  required int selectedCompetitionId,
  required List<Map<String, dynamic>> competitions,
}) {
  final int totalItems = competitions.length;
  final bool useDraggableScrollable = totalItems > 4;
  final double heightFactor = totalItems <= 2 ? 0.30 : 0.44;

  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.transparent,
    builder: (_) {
      if (useDraggableScrollable) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          child: DraggableScrollableSheet(
            initialChildSize: 0.62,
            minChildSize: 0.38,
            maxChildSize: 0.85,
            expand: false,
            builder: (_, ScrollController controller) {
              return Material(
                color: AppColors.screenBackground,
                child: _SelectCompetitionBody(
                  selectedCompetitionId: selectedCompetitionId,
                  competitions: competitions,
                  scrollController: controller,
                ),
              );
            },
          ),
        );
      }

      return FractionallySizedBox(
        heightFactor: heightFactor,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          child: Material(
            color: AppColors.screenBackground,
            child: _SelectCompetitionBody(
              selectedCompetitionId: selectedCompetitionId,
              competitions: competitions,
            ),
          ),
        ),
      );
    },
  );
}

class SelectCompetitionScreen extends StatelessWidget {
  const SelectCompetitionScreen({
    super.key,
    required this.selectedCompetitionId,
    required this.competitions,
  });

  final int selectedCompetitionId;
  final List<Map<String, dynamic>> competitions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: const CommonAppBar(
        title: 'Select Competition',
        showBack: true,
        showNotification: false,
        backgroundColor: AppColors.whiteColors,
        showBottomDivider: true,
      ),
      body: _SelectCompetitionBody(
        selectedCompetitionId: selectedCompetitionId,
        competitions: competitions,
      ),
    );
  }
}

class _SelectCompetitionBody extends StatelessWidget {
  const _SelectCompetitionBody({
    required this.selectedCompetitionId,
    required this.competitions,
    this.scrollController,
  });

  final int selectedCompetitionId;
  final List<Map<String, dynamic>> competitions;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      itemCount: competitions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, int index) {
        final Map<String, dynamic> item = competitions[index];
        final int id = (item['id'] as num?)?.toInt() ?? -1;
        final bool isSelected = id == selectedCompetitionId;

        return Material(
          color: AppColors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => Navigator.pop(context, id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor.withOpacity(.08)
                    : AppColors.whiteColors,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.scheduleCardBorder),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TrText(
                      item['label']?.toString() ?? '',
                      style: FTextStyle.helloTxt.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.bottomSheetHandle,
                        width: 1.5,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            size: 12,
                            color: AppColors.whiteColors,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
