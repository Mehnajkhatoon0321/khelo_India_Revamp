import 'package:flutter/material.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/utils/simple_translator.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';
import 'package:gms_application/presentation/pages/bottom_navbar/medal_tally/medal_athletes.dart';

const List<Map<String, dynamic>> kMedalSportsListData = [
  {
      'rank': 1,
      'sport': 'Nordic Ski',
      'sportIcon': '',
      'gold': 58,
      'silver': 27,
      'bronze': 30,
      'total': 158,
      'events': [
        {
          'sNo': '01',
          'event': 'Sprint',
          'athletes': [
            {
              'sNo': '1',
              'name': 'Sunny Singh',
              'kid': 'NSAA000M99',
              'medal': '-',
            },
            {
              'sNo': '2',
              'name': 'Shubam Parihar',
              'kid': 'NSAA000M94',
              'medal': '-',
            },
            {
              'sNo': '3',
              'name': 'Manjeet',
              'kid': 'NSAA000M01',
              'medal': '-',
            },
          ],
        },
        {
          'sNo': '02',
          'event': 'Distance 10Km',
          'athletes': []
        },
        {
          'sNo': '03',
          'event': 'Distance 15Km',
          'athletes': []
        },
      ],
    },
    {
      'rank': 2,
      'sport': 'Alpine Ski',
      'sportIcon': '',
      'gold': 58,
      'silver': 27,
      'bronze': 30,
      'total': 158,
      'events': [],
    },
    {
      'rank': 3,
      'sport': 'Ski Mountain',
      'sportIcon': '',
      'gold': 58,
      'silver': 27,
      'bronze': 30,
      'total': 158,
      'events': [],
    },
    {
      'rank': 4,
      'sport': 'Snow Boarding',
      'sportIcon': '',
      'gold': 58,
      'silver': 27,
      'bronze': 30,
      'total': 158,
      'events': [],
    },
    {
      'rank': 5,
      'sport': 'Ice Hockey',
      'sportIcon': '',
      'gold': 58,
      'silver': 27,
      'bronze': 30,
      'total': 158,
      'events': [],
    },
];

class MedalSportsList extends StatefulWidget {
  const MedalSportsList({
    super.key,
    required this.teamTitle,
  });

  final String teamTitle;

  @override
  State<MedalSportsList> createState() => _MedalSportsListState();
}

class _MedalSportsListState extends State<MedalSportsList> {
  int? _expandedIndex;

  List<Map<String, dynamic>> get _sports => kMedalSportsListData;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool compact = screenWidth < 360;
    final double horizontalPadding = compact ? 10 : 14;
    final double topPadding = compact ? 18 : 22;

    return Scaffold(
      backgroundColor: AppColors.whiteColors,
      appBar: CommonAppBar(
        title: widget.teamTitle,
        showBack: true,
        showNotification: true,
        backgroundColor: AppColors.whiteColors,
        showBottomDivider: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(horizontalPadding, topPadding, horizontalPadding, 16),
        child: Column(
          children: <Widget>[
            SizedBox(height: compact ? 4 : 6),
            _buildStaticHeader(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: _sports.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, int index) {
                  final Map<String, dynamic> sport = _sports[index];
                  final bool expanded = _expandedIndex == index;
                  return _buildSportCard(sport, expanded, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaticHeader() {
    return Container(
      width: double.infinity,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8),
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

      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool compact = constraints.maxWidth < 360;
          final double rankWidth = compact ? 44 : 52;
          final double medalWidth = compact ? 32 : 38;
          final double totalWidth = compact ? 42 : 48;
          return
            Row(
            children: <Widget>[
              SizedBox(
                width: rankWidth,
                child: const TrText('Rank', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              const Expanded(
                child: TrText('Sport', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                width: medalWidth,
                child: Center(
                  child: Image.asset(
                    'assets/images/medal_total_gold.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: medalWidth,
                child: Center(
                  child: Image.asset(
                    'assets/images/medal_total_silver.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: medalWidth,
                child: Center(
                  child: Image.asset(
                    'assets/images/medal_total_bronze.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: totalWidth,
                child: const TrText('Total', textAlign: TextAlign.end),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSportCard(
    Map<String, dynamic> sport,
    bool expanded,
    int index,
  ) {
    final List<Map<String, dynamic>> events =
        (sport['events'] as List<dynamic>).cast<Map<String, dynamic>>();

    return Container(
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
      child: Column(
        children: <Widget>[
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              setState(() {
                _expandedIndex = expanded ? null : index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool compact = constraints.maxWidth < 360;
                  final double rankWidth = compact ? 32 : 40;
                  final double medalWidth = compact ? 32 : 38;
                  final double totalWidth = compact ? 42 : 48;
                  return Row(
                    children: <Widget>[
                      SizedBox(
                        width: rankWidth,
                        child: TrText(
                          '${sport['rank']}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            _buildSportIcon(sport['sportIcon']?.toString()),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Tooltip(
                                message: '${sport['sport']}',
                                child: TrText(
                                  '${sport['sport']}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    height: 1.13,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ),
                      SizedBox(
                        width: medalWidth,
                        child: Center(
                          child: SizedBox(
                            width: 16.88,
                            height: 15,
                            child: TrText(
                              '${sport['gold']}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: AppColors.black, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: medalWidth,
                        child: Center(
                          child: SizedBox(
                            width: 16.88,
                            height: 15,
                            child: TrText(
                              '${sport['silver']}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: AppColors.black, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: medalWidth,
                        child: Center(
                          child: SizedBox(
                            width: 16.88,
                            height: 15,
                            child: TrText(
                              '${sport['bronze']}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: AppColors.black,fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: totalWidth,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 16.88,
                            height: 15,
                            child: TrText(
                              '${sport['total']}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(color: AppColors.black, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          if (expanded && events.isNotEmpty) _buildExpandedEvents(events),
        ],
      ),
    );
  }

  Widget _buildExpandedEvents(List<Map<String, dynamic>> events) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Column(
        children: <Widget>[
          const Divider(height: 1, thickness: 1, color: AppColors.scheduleCardBorder),
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            // color: AppColors.primaryColor,
            decoration: BoxDecoration(
              // color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primaryColor,
            ),
            child: const Row(
              children: <Widget>[
                SizedBox(
                    width: 70,
                    child: TrText('S.No.',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600))),
                Expanded(
                    child: TrText('Event',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600))),
              ],
            ),
          ),
          ...events.map((Map<String, dynamic> event) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MedalAthletes(
                      title: '${event['event']}',
                      athletes: (event['athletes'] as List<dynamic>)
                          .cast<Map<String, dynamic>>(),
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 70, child: TrText('${event['sNo']}', style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,fontSize: 13
                ),)),
                    Expanded(
                      child: TrText(
                        '${event['event']}',
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,fontSize: 13
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSportIcon(String? iconSource) {
    const double iconSize = 20;
    final String source = (iconSource ?? '').trim();

    if (source.isEmpty) return _sportIconFallback(iconSize);

    final bool isNetworkImage =
        source.startsWith('http://') || source.startsWith('https://');

    if (isNetworkImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          source,
          width: iconSize,
          height: iconSize,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return _sportIconFallback(iconSize);
          },
          errorBuilder: (_, __, ___) => _sportIconFallback(iconSize),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.asset(
        source,
        width: iconSize,
        height: iconSize,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _sportIconFallback(iconSize),
      ),
    );
  }

  Widget _sportIconFallback(double iconSize) {
    return Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        color: AppColors.appBarIconBg,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.sports,
        size: 13,
        color: AppColors.primaryColor,
      ),
    );
  }
}
