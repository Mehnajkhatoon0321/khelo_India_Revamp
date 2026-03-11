import 'package:flutter/material.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/utils/simple_translator.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';
import 'package:gms_application/presentation/pages/bottom_navbar/schedule/schedule_events_athletes_list.dart';

const List<Map<String, dynamic>> _scheduleEventListData =
    <Map<String, dynamic>>[
  {
    'scheduleId': '1',
    'eventId': '1_1',
    'eventTitle': 'ITBP Vs. Rajasthan - Team(F)',
    'groupName': 'Group B',
    'startTime': '09:00:00',
  },
  {
    'scheduleId': '1',
    'eventId': '1_2',
    'eventTitle': 'ITBP Vs. Rajasthan - Team(F)',
    'groupName': 'Group B',
    'startTime': '09:00:00',
  },
  {
    'scheduleId': '1',
    'eventId': '1_3',
    'eventTitle': 'ITBP Vs. Rajasthan - Team(F)',
    'groupName': 'Group B',
    'startTime': '09:00:00',
  },
  {
    'scheduleId': '2',
    'eventId': '2_1',
    'eventTitle': 'ITBP Vs. Rajasthan - Team(F)',
    'groupName': 'Group B',
    'startTime': '09:00:00',
  },
  {
    'scheduleId': '2',
    'eventId': '2_2',
    'eventTitle': 'ITBP Vs. Rajasthan - Team(F)',
    'groupName': 'Group B',
    'startTime': '09:00:00',
  },
  {
    'scheduleId': '3',
    'eventId': '3_1',
    'eventTitle': 'ITBP Vs. Rajasthan - Team(F)',
    'groupName': 'Group B',
    'startTime': '09:00:00',
  },
];

class ScheduleEventList extends StatefulWidget {
  const ScheduleEventList({
    super.key,
    this.scheduleId,
    this.sportTitle,
    this.scheduleDateRange,
    this.venue,
  });

  final String? scheduleId;
  final String? sportTitle;
  final String? scheduleDateRange;
  final String? venue;

  @override
  State<ScheduleEventList> createState() => _ScheduleEventListState();
}

class _ScheduleEventListState extends State<ScheduleEventList> {
  static const String _defaultScheduleId = '1';
  static const String _defaultSportTitle = 'Ice Hockey';
  static const String _defaultDateRange = '20-Jan-26 - 26-Jan-26';
  static const String _defaultVenue = 'NDS Stadium Leh';

  late _ScheduleHeaderData _headerData;
  late List<_EventItem> _eventItems;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitialized) return;
    _headerData = _resolveHeaderData();
    _eventItems = _buildEventItems();
    _isInitialized = true;
  }

  _ScheduleHeaderData _resolveHeaderData() {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    final Map<String, dynamic>? mapArgs =
        args is Map<String, dynamic> ? args : null;

    final String id = widget.scheduleId ??
        mapArgs?['scheduleId']?.toString() ??
        _defaultScheduleId;
    final String title = widget.sportTitle ??
        mapArgs?['sportTitle']?.toString() ??
        _defaultSportTitle;
    final String dateRange = widget.scheduleDateRange ??
        mapArgs?['scheduleDateRange']?.toString() ??
        _defaultDateRange;
    final String venue =
        widget.venue ?? mapArgs?['venue']?.toString() ?? _defaultVenue;

    return _ScheduleHeaderData(
      scheduleId: id,
      sportTitle: title,
      scheduleDateRange: dateRange,
      venue: venue,
    );
  }

  List<_EventItem> _buildEventItems() {
    final List<_EventItem> allItems = _scheduleEventListData
        .map((Map<String, dynamic> item) => _EventItem.fromJson(item))
        .toList();
    final List<_EventItem> filteredItems = allItems
        .where((event) => event.scheduleId == _headerData.scheduleId)
        .toList();

    if (filteredItems.isNotEmpty) return filteredItems;
    if (allItems.isNotEmpty) return allItems;
    return _fallbackEventItems();
  }

  List<_EventItem> _fallbackEventItems() {
    return List<_EventItem>.generate(
      6,
      (int index) => _EventItem(
        scheduleId: _headerData.scheduleId,
        eventId: '${_headerData.scheduleId}_${index + 1}',
        eventTitle: 'ITBP Vs. Rajasthan - Team(F)',
        groupName: 'Group B',
        startTime: '09:00:00',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: const CommonAppBar(
        title: 'Schedule Details',
        showBack: true,
        showNotification: false,
        backgroundColor: AppColors.whiteColors,
        showBottomDivider: true,
      ),
      body: Column(
        children: <Widget>[
          _ScheduleTopCard(data: _headerData),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.scheduleSectionBg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              ),
              child: _eventItems.isEmpty
                  ? Center(
                      child: TrText(
                        'No events available',
                        style: FTextStyle.scheduleDetailsMetaStyle.copyWith(
                          color: AppColors.scheduleMutedText,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                      itemCount: _eventItems.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (BuildContext context, int index) {
                        final _EventItem event = _eventItems[index];
                        return _EventCard(
                          event: event,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ScheduleEventsAthletesList(
                                  eventId: event.eventId,
                                  eventTitle: event.eventTitle,
                                  sportTitle: _headerData.sportTitle,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleTopCard extends StatelessWidget {
  const _ScheduleTopCard({required this.data});

  final _ScheduleHeaderData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.whiteColors,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.scheduleCardBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 82,
            width: 82,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.sports_hockey_rounded,
              color: AppColors.whiteColors,
              size: 44,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TrText(
                  data.sportTitle,
                  style: FTextStyle.scheduleUnifiedHeadingStyle
                      .copyWith(fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    // const Icon(
                    //   Icons.location_on_outlined,
                    //   size: 14,
                    //   color: AppColors.scheduleLabelMuted,
                    // ),
                    // const SizedBox(width: 4),
                    Expanded(
                      child: TrText(
                        data.venue,
                        style: FTextStyle.scheduleDetailsMetaStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  children: <Widget>[
                    // const Icon(
                    //   Icons.brightness_1,
                    //   size: 10,
                    //   color: AppColors.scheduleCardBorder,
                    // ),
                    // const SizedBox(width: 8),
                    Expanded(
                      child: TrText(
                        data.scheduleDateRange,
                        style: FTextStyle.scheduleDetailsMetaStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event, required this.onTap});

  final _EventItem event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColors,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.scheduleCardBorder),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TrText(
                      event.eventTitle,
                      style: FTextStyle.scheduleUnifiedHeadingStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.groups_2_outlined,
                          color: AppColors.textPrimary,
                          size: 14,
                        ),
                        const SizedBox(width: 8),
                        TrText(
                          event.groupName,
                          style: FTextStyle.scheduleDetailsEventMetaStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.access_time_rounded,
                          color: AppColors.textPrimary,
                          size: 14,
                        ),
                        const SizedBox(width: 8),
                        TrText(
                          event.startTime,
                          style: FTextStyle.scheduleDetailsEventMetaStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 26,
                width: 26,
                decoration: const BoxDecoration(
                  color: AppColors.appBarIconBg,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.primaryColor,
                  size: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScheduleHeaderData {
  const _ScheduleHeaderData({
    required this.scheduleId,
    required this.sportTitle,
    required this.scheduleDateRange,
    required this.venue,
  });

  final String scheduleId;
  final String sportTitle;
  final String scheduleDateRange;
  final String venue;
}

class _EventItem {
  const _EventItem({
    required this.scheduleId,
    required this.eventId,
    required this.eventTitle,
    required this.groupName,
    required this.startTime,
  });

  final String scheduleId;
  final String eventId;
  final String eventTitle;
  final String groupName;
  final String startTime;

  factory _EventItem.fromJson(Map<String, dynamic> json) {
    return _EventItem(
      scheduleId: (json['scheduleId'] ?? '').toString(),
      eventId: (json['eventId'] ?? '').toString(),
      eventTitle: json['eventTitle'] as String? ?? '',
      groupName: json['groupName'] as String? ?? '',
      startTime: json['startTime'] as String? ?? '',
    );
  }
}
