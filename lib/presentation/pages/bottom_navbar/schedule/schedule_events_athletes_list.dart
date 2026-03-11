import 'package:flutter/material.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/utils/simple_translator.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';

const List<Map<String, dynamic>> _athletesListData = <Map<String, dynamic>>[
  {
    'eventId': '1_1',
    'athleteName': 'STANZIM CHOTSO',
    'sportName': 'Ice Hockey',
    'kid': 'IHAA001F99',
    'status': 'Present',
  },
  {
    'eventId': '1_1',
    'athleteName': 'TSERING DOLMA',
    'sportName': 'Ice Hockey',
    'kid': 'IHAA001F98',
    'status': 'Absent',
  },
  {
    'eventId': '1_1',
    'athleteName': 'RINCHEN ANGMO',
    'sportName': 'Ice Hockey',
    'kid': 'IHAA001F97',
    'status': 'Present',
  },
  {
    'eventId': '1_2',
    'athleteName': 'STANZIM CHOTSO',
    'sportName': 'Ice Hockey',
    'kid': 'IHAA001F99',
    'status': 'Present',
  },
  {
    'eventId': '1_2',
    'athleteName': 'DECHEN NORZIN',
    'sportName': 'Ice Hockey',
    'kid': 'IHAA001F96',
    'status': 'Absent',
  },
  {
    'eventId': '2_1',
    'athleteName': 'STANZIM CHOTSO',
    'sportName': 'Ice Hockey',
    'kid': 'IHAA001F99',
    'status': 'Present',
  },
  {
    'eventId': '2_1',
    'athleteName': 'SONAM ANGCHUK',
    'sportName': 'Ice Hockey',
    'kid': 'IHAA001F95',
    'status': 'Absent',
  },
  {
    'eventId': '3_1',
    'athleteName': 'STANZIM CHOTSO',
    'sportName': 'Ice Hockey',
    'kid': 'IHAA001F99',
    'status': 'Present',
  },
];

class ScheduleEventsAthletesList extends StatefulWidget {
  const ScheduleEventsAthletesList({
    super.key,
    this.eventId,
    this.eventTitle,
    this.sportTitle,
  });

  final String? eventId;
  final String? eventTitle;
  final String? sportTitle;

  @override
  State<ScheduleEventsAthletesList> createState() =>
      _ScheduleEventsAthletesListState();
}

class _ScheduleEventsAthletesListState
    extends State<ScheduleEventsAthletesList> {
  static const String _defaultEventId = '1_1';
  static const String _defaultEventTitle = 'ITBP Vs. Rajasthan - Team(F)';
  static const String _defaultSportTitle = 'Ice Hockey';
  static const String _defaultAthleteName = 'STANZIM CHOTSO';
  static const String _defaultKid = 'IHAA001F99';

  late _AthleteScreenData _screenData;
  late List<_AthleteItem> _allAthletes;
  bool _isInitialized = false;
  String _searchText = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitialized) return;
    _screenData = _resolveScreenData();
    _allAthletes = _buildAthletes();
    _isInitialized = true;
  }

  _AthleteScreenData _resolveScreenData() {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    final Map<String, dynamic>? mapArgs =
        args is Map<String, dynamic> ? args : null;

    return _AthleteScreenData(
      eventId:
          widget.eventId ?? mapArgs?['eventId']?.toString() ?? _defaultEventId,
      eventTitle: widget.eventTitle ??
          mapArgs?['eventTitle']?.toString() ??
          _defaultEventTitle,
      sportTitle: widget.sportTitle ??
          mapArgs?['sportTitle']?.toString() ??
          _defaultSportTitle,
    );
  }

  List<_AthleteItem> _buildAthletes() {
    final List<_AthleteItem> allItems = _athletesListData
        .map((Map<String, dynamic> item) => _AthleteItem.fromJson(item))
        .toList();

    final List<_AthleteItem> byEvent = allItems
        .where((athlete) => athlete.eventId == _screenData.eventId)
        .toList();
    if (byEvent.isNotEmpty) return byEvent;

    final List<_AthleteItem> bySport = allItems
        .where(
          (athlete) =>
              athlete.sportName.toLowerCase() ==
              _screenData.sportTitle.toLowerCase(),
        )
        .toList();
    if (bySport.isNotEmpty) return bySport;

    if (allItems.isNotEmpty) return allItems;
    return _fallbackAthletes();
  }

  List<_AthleteItem> _fallbackAthletes() {
    return List<_AthleteItem>.generate(
      10,
      (int index) => _AthleteItem(
        eventId: _screenData.eventId,
        athleteName: _defaultAthleteName,
        sportName: _screenData.sportTitle,
        kid: _defaultKid,
        status: index.isEven ? 'Present' : 'Absent',
      ),
    );
  }

  List<_AthleteItem> get _filteredAthletes {
    final String key = _searchText.trim().toLowerCase();
    if (key.isEmpty) return _allAthletes;
    return _allAthletes
        .where(
          (_AthleteItem item) =>
              item.athleteName.toLowerCase().contains(key) ||
              item.kid.toLowerCase().contains(key),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<_AthleteItem> athletes = _filteredAthletes;

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: const CommonAppBar(
        title: 'Athletes Details',
        showBack: true,
        showNotification: false,
        backgroundColor: AppColors.whiteColors,
        showBottomDivider: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: AppColors.whiteColors,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TrText(
                  _screenData.eventTitle,
                  style: FTextStyle.scheduleUnifiedHeadingStyle
                      .copyWith(fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 18),
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.scheduleCardGrey,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: SimpleTranslator.instance.selectedLanguage,
                    builder: (_, __, ___) {
                      return FutureBuilder<String>(
                        future: tr('Search By Name/KID'),
                        builder: (context, snapshot) {
                          return TextField(
                            onChanged: (String value) {
                              setState(() {
                                _searchText = value;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.search_rounded,
                                color: AppColors.primaryColor,
                              ),
                              hintText: snapshot.data ?? 'Search By Name/KID',
                              hintStyle:
                                  FTextStyle.scheduleMatchMetaStyle.copyWith(
                                color: AppColors.scheduleMutedText,
                                fontSize: FTextStyle
                                    .scheduleDetailsMetaStyle.fontSize,
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 12),
                            ),
                            style: FTextStyle.scheduleMatchMetaStyle.copyWith(
                              color: AppColors.textPrimary,
                              fontSize:
                                  FTextStyle.scheduleDetailsMetaStyle.fontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: athletes.isEmpty
                ? Center(
                    child: TrText(
                      'No athletes available',
                      style: FTextStyle.scheduleDetailsMetaStyle.copyWith(
                        color: AppColors.scheduleMutedText,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
                    itemCount: athletes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, int index) =>
                        _AthleteCard(item: athletes[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _AthleteCard extends StatelessWidget {
  const _AthleteCard({required this.item});

  final _AthleteItem item;

  @override
  Widget build(BuildContext context) {
    final bool isPresent = item.status.toLowerCase() == 'present';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.whiteColors,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.scheduleCardBorder),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: AppColors.whiteOffColors,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: AppColors.scheduleIconMuted,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TrText(
                  item.athleteName,
                  style: FTextStyle.scheduleUnifiedHeadingStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 7),
                Row(
                  children: <Widget>[
                    TrText(
                      'Sport  ',
                      style: FTextStyle.scheduleAthleteLabelStyle,
                    ),
                    Expanded(
                      child: TrText(
                        item.sportName,
                        style: FTextStyle.scheduleAthleteValueStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          TrText(
                            'KID  ',
                            style: FTextStyle.scheduleAthleteLabelStyle,
                          ),
                          Expanded(
                            child: TrText(
                              item.kid,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: FTextStyle.scheduleAthleteKIdValueStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 0.5,
                      height: 12,
                      color: AppColors.scheduleAthleteDivider,
                    ),
                    const SizedBox(width: 8),
                    TrText(
                      'Status  ',
                      style: FTextStyle.scheduleAthleteLabelStyle,
                    ),
                    TrText(
                      item.status,
                      style: isPresent
                          ? FTextStyle.scheduleAthleteStatusPresentStyle
                          : FTextStyle.scheduleAthleteStatusAbsentStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AthleteScreenData {
  const _AthleteScreenData({
    required this.eventId,
    required this.eventTitle,
    required this.sportTitle,
  });

  final String eventId;
  final String eventTitle;
  final String sportTitle;
}

class _AthleteItem {
  const _AthleteItem({
    required this.eventId,
    required this.athleteName,
    required this.sportName,
    required this.kid,
    required this.status,
  });

  final String eventId;
  final String athleteName;
  final String sportName;
  final String kid;
  final String status;

  factory _AthleteItem.fromJson(Map<String, dynamic> json) {
    return _AthleteItem(
      eventId: (json['eventId'] ?? '').toString(),
      athleteName: json['athleteName'] as String? ?? '',
      sportName: json['sportName'] as String? ?? '',
      kid: json['kid'] as String? ?? '',
      status: json['status'] as String? ?? 'Absent',
    );
  }
}
