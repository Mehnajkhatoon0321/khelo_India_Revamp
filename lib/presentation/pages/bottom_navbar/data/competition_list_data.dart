import 'package:flutter/foundation.dart';

const List<Map<String, dynamic>> kCompetitionList = <Map<String, dynamic>>[
  <String, dynamic>{
    'id': 1,
    'label': 'Khelo India Water Sports Festival Games 2026',
  },
  <String, dynamic>{
    'id': 2,
    'label': 'Khelo India Winter Sports Festival Games 2026',
  },
  <String, dynamic>{
    'id': 3,
    'label': 'Khelo India University Games 2026',
  },
  <String, dynamic>{
    'id': 4,
    'label': 'Accred Centers',
  },
];

final ValueNotifier<int> selectedCompetitionIdNotifier = ValueNotifier<int>(0);

String getCompetitionLabelById(int selectedId) {
  if (selectedId <= 0) return 'Select Competition';

  final Map<String, dynamic> selectedItem = kCompetitionList.firstWhere(
    (item) => item['id'] == selectedId,
    orElse: () => <String, dynamic>{'label': 'Select Competition'},
  );
  return selectedItem['label']?.toString() ?? 'Select Competition';
}
