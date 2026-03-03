import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gms_application/core/constants/constant_text.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/constants/themes_height_width.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';
import 'package:gms_application/core/widgets/common_date_picker.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  static const Color _primaryColor = AppColors.primaryColor;

  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const List<String> _weekdayNames = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  late final ScheduleData _scheduleData;
  late final List<DateTime> _allDates;

  late DateTime _selectedDate;
  late DateTime _visibleMonth;

  @override
  void initState() {
    super.initState();

    // Local JSON parsing keeps data source independent from the UI.
    _scheduleData = ScheduleData.fromJson(
      jsonDecode(_localScheduleJson) as Map<String, dynamic>,
    );
    _allDates = _generateDateRange(_scheduleData.startDate, _scheduleData.endDate);

    final DateTime today = _stripTime(DateTime.now());
    final bool todayIsInRange = _allDates.any((date) => _isSameDay(date, today));
    _selectedDate =
        todayIsInRange ? today : (_allDates.length > 2 ? _allDates[2] : _allDates.first);
    _visibleMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  List<DateTime> get _visibleDates {
    return _allDates
        .where(
          (date) =>
              date.year == _visibleMonth.year && date.month == _visibleMonth.month,
        )
        .toList();
  }

  List<MatchItem> get _matchesForSelectedDate {
    return _scheduleData.matches
        .where((match) => _isSameDay(match.date, _selectedDate))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final double topCalendarHeight =
        (MediaQuery.sizeOf(context).height * 0.22).clamp(188.0, 228.0);
    final double selectorHeight = (topCalendarHeight * 0.34).clamp(68.0, 76.0);
    final String monthLabel =
        '${_monthNames[_visibleMonth.month - 1]} ${_visibleMonth.year}';

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: const CommonAppBar(
        title: Constants.gameScheduleTitle,
        showNotification: true,
        backgroundColor: AppColors.whiteColors,
        showBottomDivider: true,
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: topCalendarHeight,
              decoration: const BoxDecoration(
                color: AppColors.whiteColors,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            _MonthArrowButton(
                              icon: Icons.chevron_left_rounded,
                              onTap: _canMoveToPreviousMonth ? _goToPreviousMonth : null,
                            ),
                            SizedBoxConstant.widthSpace_12,
                            Text(
                              monthLabel,
                              style: FTextStyle.scheduleMonthHeadingStyle,
                            ),
                            SizedBoxConstant.widthSpace_12,
                            _MonthArrowButton(
                              icon: Icons.chevron_right_rounded,
                              onTap: _canMoveToNextMonth ? _goToNextMonth : null,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: _openDatePicker,
                          borderRadius: BorderRadius.circular(18),
                          child: const Padding(
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              Icons.calendar_today_outlined,
                              size: 18,
                              color: AppColors.scheduleIconMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: selectorHeight,
                    child: _buildDateSelector(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                    child: Container(
                      width: double.infinity,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE7E9EF)),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Broadcast',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 28 / 2,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
               ] ),

            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 2),
                decoration: const BoxDecoration(
                  color: Color(0xFFF4F5F7),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                ),
                child: _buildMatchesSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    final List<DateTime> monthDates = _visibleDates;
    if (monthDates.isEmpty) {
      return Center(
        child: Text(
          Constants.noDatesAvailable,
          style: FTextStyle.scheduleNoDateStyle,
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        const double horizontalPadding = 16;
        const double betweenCards = 8;
        final double availableWidth = constraints.maxWidth - (horizontalPadding * 2);
        final double cardWidth =
            ((availableWidth - (betweenCards * 4)) / 5).clamp(62.0, 76.0).toDouble();

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: monthDates.length,
          separatorBuilder: (_, __) => SizedBoxConstant.widthSpace_8,
          itemBuilder: (context, index) {
            final DateTime date = monthDates[index];
            final bool isSelected = _isSameDay(date, _selectedDate);
            final String day = _weekdayNames[date.weekday - 1];

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDate = date;
                });
              },
              child: Container(
                width: cardWidth,
                decoration: BoxDecoration(
                  color: isSelected ? _primaryColor : AppColors.scheduleCardGrey,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      date.day.toString(),
                      textAlign: TextAlign.center,
                      style: isSelected
                          ? FTextStyle.scheduleDateSelectedNumberStyle
                          : FTextStyle.scheduleDateUnselectedNumberStyle,
                    ),
                    SizedBoxConstant.heightSpace_2,
                    Text(
                      day,
                      textAlign: TextAlign.center,
                      style: isSelected
                          ? FTextStyle.scheduleDateSelectedMonthStyle
                          : FTextStyle.scheduleDateUnselectedMonthStyle,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMatchesSection() {
    final List<MatchItem> matches = _matchesForSelectedDate;

    if (matches.isEmpty) {
      return const Center(
        child: Text(
          Constants.noMatchesScheduled,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF6E7380),
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      itemCount: matches.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final MatchItem match = matches[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEDEFF3)),
          ),
          child: Row(
            children: [
              Container(
                height: 78,
                width: 78,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: match.showSportIcon
                    ? const Icon(
                        Icons.sports_hockey_outlined,
                        color: AppColors.primaryColor,
                        size: 42,
                      )
                    : null,
              ),
              SizedBoxConstant.widthSpace_12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      match.title,
                      style: FTextStyle.scheduleMatchTitleStyle.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBoxConstant.heightSpace_8,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Location',
                                style: FTextStyle.scheduleMonthChipStyle.copyWith(
                                  color: const Color(0xFFA4A8B3),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                match.location,
                                style: FTextStyle.scheduleMatchMetaStyle.copyWith(
                                  color: AppColors.textPrimary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 32,
                          color: const Color(0xFFE4E6EB),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: FTextStyle.scheduleMonthChipStyle.copyWith(
                                  color: const Color(0xFFA4A8B3),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                match.time,
                                style: FTextStyle.scheduleMatchMetaStyle.copyWith(
                                  color: AppColors.textPrimary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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
      },
    );
  }

  bool get _canMoveToPreviousMonth {
    final DateTime previous = DateTime(_visibleMonth.year, _visibleMonth.month - 1);
    return _hasDatesForMonth(previous);
  }

  bool get _canMoveToNextMonth {
    final DateTime next = DateTime(_visibleMonth.year, _visibleMonth.month + 1);
    return _hasDatesForMonth(next);
  }

  void _goToPreviousMonth() {
    final DateTime previous = DateTime(_visibleMonth.year, _visibleMonth.month - 1);
    if (!_hasDatesForMonth(previous)) return;

    setState(() {
      _visibleMonth = DateTime(previous.year, previous.month);
      _syncSelectionWithVisibleMonth();
    });
  }

  void _goToNextMonth() {
    final DateTime next = DateTime(_visibleMonth.year, _visibleMonth.month + 1);
    if (!_hasDatesForMonth(next)) return;

    setState(() {
      _visibleMonth = DateTime(next.year, next.month);
      _syncSelectionWithVisibleMonth();
    });
  }

  void _syncSelectionWithVisibleMonth() {
    final List<DateTime> monthDates = _visibleDates;
    if (monthDates.isEmpty) return;

    final bool selectedInMonth = monthDates.any((d) => _isSameDay(d, _selectedDate));
    if (!selectedInMonth) {
      _selectedDate = monthDates.first;
    }
  }

  bool _hasDatesForMonth(DateTime monthDate) {
    return _allDates.any(
      (date) => date.year == monthDate.year && date.month == monthDate.month,
    );
  }

  DateTime _stripTime(DateTime date) => DateTime(date.year, date.month, date.day);

  Future<void> _openDatePicker() async {
    final DateTime initial = _selectedDate.isBefore(_scheduleData.startDate)
        ? _scheduleData.startDate
        : (_selectedDate.isAfter(_scheduleData.endDate)
            ? _scheduleData.endDate
            : _selectedDate);

    final DateTime? pickedDate = await showCommonDatePicker(
      context: context,
      initialDate: initial,
      firstDate: _scheduleData.startDate,
      lastDate: _scheduleData.endDate,
      helpText: Constants.selectMatchDate,
    );

    if (pickedDate == null) return;
    final DateTime normalized = _stripTime(pickedDate);
    setState(() {
      _selectedDate = normalized;
      _visibleMonth = DateTime(normalized.year, normalized.month);
      _syncSelectionWithVisibleMonth();
    });
  }

  bool _isSameDay(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  // Date list is generated via List.generate between JSON start and end dates.
  List<DateTime> _generateDateRange(DateTime startDate, DateTime endDate) {
    final DateTime normalizedStart = _stripTime(startDate);
    final DateTime normalizedEnd = _stripTime(endDate);
    if (normalizedEnd.isBefore(normalizedStart)) return <DateTime>[];

    final int totalDays = normalizedEnd.difference(normalizedStart).inDays + 1;
    return List.generate(
      totalDays,
      (index) => DateTime(
        normalizedStart.year,
        normalizedStart.month,
        normalizedStart.day + index,
      ),
    );
  }
}

class _MonthArrowButton extends StatelessWidget {
  const _MonthArrowButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onTap != null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          icon,
          size: 20,
          color: enabled ? AppColors.scheduleIconEnabled : AppColors.scheduleIconDisabled,
        ),
      ),
    );
  }
}

class ScheduleData {
  ScheduleData({
    required this.startDate,
    required this.endDate,
    required this.matches,
  });

  final DateTime startDate;
  final DateTime endDate;
  final List<MatchItem> matches;

  factory ScheduleData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawMatches = json['matches'] as List<dynamic>? ?? [];

    return ScheduleData(
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      matches: rawMatches
          .map((item) => MatchItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class MatchItem {
  MatchItem({
    required this.date,
    required this.title,
    required this.time,
    required this.location,
    required this.showSportIcon,
  });

  final DateTime date;
  final String title;
  final String time;
  final String location;
  final bool showSportIcon;

  factory MatchItem.fromJson(Map<String, dynamic> json) {
    return MatchItem(
      date: DateTime.parse(json['date'] as String),
      title: json['title'] as String? ?? '',
      time: json['time'] as String? ?? '',
      location: json['location'] as String? ?? '',
      showSportIcon: json['showSportIcon'] as bool? ?? false,
    );
  }
}

const String _localScheduleJson = '''
{
  "startDate": "2026-03-27",
  "endDate": "2026-08-22",
  "matches": [
    {
      "date": "2026-03-29",
      "title": "Ice Hockey",
      "time": "20-Jan-26 - 26-Jan-26",
      "location": "NDS Stadium Leh",
      "showSportIcon": true
    },
    {
      "date": "2026-03-29",
      "title": "Ice Hockey",
      "time": "20-Jan-26 - 26-Jan-26",
      "location": "NDS Stadium Leh"
    },
    {
      "date": "2026-03-29",
      "title": "Ice Hockey",
      "time": "20-Jan-26 - 26-Jan-26",
      "location": "NDS Stadium Leh"
    },
    {
      "date": "2026-03-29",
      "title": "Ice Hockey",
      "time": "20-Jan-26 - 26-Jan-26",
      "location": "NDS Stadium Leh"
    } ,{
      "date": "2026-03-27",
      "title": "Ice Hockey",
      "time": "20-Jan-26 - 26-Jan-26",
      "location": "NDS Stadium Leh"
    },
    {
      "date": "2026-03-28",
      "title": "Ice Hockey",
      "time": "20-Jan-26 - 26-Jan-26",
      "location": "NDS Stadium Leh"
    },
    {
      "date": "2026-03-30",
      "title": "Ice Hockey",
      "time": "20-Jan-26 - 26-Jan-26",
      "location": "NDS Stadium Leh bghrthnttyt  t"
    }
  ]
}
''';
