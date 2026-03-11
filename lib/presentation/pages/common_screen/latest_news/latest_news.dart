import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/widgets/no_data_available.dart';
import 'package:gms_application/core/widgets/shimmer_screen.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';
import 'package:gms_application/core/widgets/responsive_layout.dart';
import 'package:gms_application/core/utils/simple_translator.dart';
import 'package:gms_application/presentation/pages/common_screen/latest_news/latest_view_details.dart';
import 'package:video_player/video_player.dart';

class LatestNewsScreen extends StatelessWidget {
  final Map<String, dynamic>? data;
  final bool isLoading;

  const LatestNewsScreen({
    super.key,
    this.data,
    this.isLoading = false,
  });

  // Dummy data
  static final Map<String, dynamic> _dummyData = {
    "today": {
      "title": "Dr. Niraj K. Pawan, Chairman, Rajasthan State Chairman Pawan",
      "date": "March 2, 2026",
      "type": "video", // Change to "image" for image display
      "media":
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      "description":
          "The 2nd Edition Khelo India Beach Games (KIBG) is scheduled to be held in UT Diu from 5th January to 10th January 2026.\n\nThe key features of the Khelo India Beach Games (KIBG) 2026 are as follows:\n\nNo. of Sports Discipline: 8 (6 Competitive & 2 Demo) sports disciplines including sports like Beach Soccer, Beach Volleyball, Beach Pencak Competitive and Beach Mallakhamb & Beach Tug of war as Demo are part of the program.",
      // "media": "https://picsum.photos/400/300", // Use this for image
    },
    "more": [
      {
        "id": 1,
        "title": "Dr. Niraj K. Pawan, Chairman, Rajasthan State Conference",
        "date": "March 1, 2026",
        "type": "image",
        "media": "https://picsum.photos/200/200?random=1",
        "description":
            "This is the detailed latest news content for conference update.",
      },
      {
        "id": 2,
        "title": "Annual General Meeting Announcement 2026",
        "date": "February 28, 2026",
        "type": "image",
        "media": "https://picsum.photos/200/200?random=2",
        "description":
            "This is the detailed latest news content for meeting announcement.",
      },
      {
        "id": 3,
        "title": "New Guidelines for Accreditation Centers",
        "date": "February 27, 2026",
        "type": "image",
        "media": "https://picsum.photos/200/200?random=3",
        "description":
            "This is the detailed latest news content for new guidelines.",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    // Use dummy data if no data is provided
    final Map<String, dynamic> safeData = data ?? _dummyData;
    final Map today =
        (safeData["today"] is Map) ? (safeData["today"] as Map) : const {};
    final List moreNews =
        (safeData["more"] is List) ? (safeData["more"] as List) : const [];

    final String todayTitle = (today["title"] ?? "").toString();
    final String todayDate = (today["date"] ?? "").toString();
    final String todayType = (today["type"] ?? "image").toString();
    final String todayMedia = (today["media"] ?? "").toString();
    final bool hasToday =
        todayTitle.trim().isNotEmpty || todayDate.trim().isNotEmpty;
    final bool hasMore = moreNews.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.whiteColors,
      appBar: const CommonAppBar(
        title: "Latest News",
        showBack: true,
        showNotification: true,
        backgroundColor: AppColors.whiteColors,
        showBottomDivider: true,
      ),
      body: ResponsiveContent(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveLayout.adaptiveHorizontalPadding(context),
          vertical: 14.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TrText(
                "Today News",
                style: FTextStyle.textSecBlackStylePrimary
                    .copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: 12.h),
              if (isLoading)
                ShimmerCard.large()
              else if (hasToday)
                _TodayNewsCard(
                  title: todayTitle,
                  date: todayDate,
                  type: todayType,
                  media: todayMedia,
                  onTap: () {
                    _openNewsDetails(
                      context,
                      title: todayTitle,
                      date: todayDate,
                      type: todayType,
                      media: todayMedia,
                      description: (today["description"] ?? "").toString(),
                    );
                  },
                )
              else
                const NoDataAvailable(
                  title: "No data found",
                  subtitle: "Latest news will appear here",
                ),
              SizedBox(height: 22.h),
              TrText(
                "More News",
                style: FTextStyle.textSecBlackStylePrimary
                    .copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: 12.h),
              if (isLoading)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (_, __) => ShimmerCard.tile(),
                )
              else if (hasMore)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: moreNews.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    final raw = moreNews[index];
                    final Map item = raw is Map ? raw : const {};
                    return _MoreNewsTile(
                      item: item,
                      onTap: () {
                        _openNewsDetails(
                          context,
                          title: (item["title"] ?? "").toString(),
                          date: (item["date"] ?? "").toString(),
                          type: (item["type"] ?? "image").toString(),
                          media: (item["media"] ?? "").toString(),
                          description: (item["description"] ?? "").toString(),
                        );
                      },
                    );
                  },
                )
              else
                const NoDataAvailable(
                  title: "No data found",
                  subtitle: "More news will appear here",
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _openNewsDetails(
    BuildContext context, {
    required String title,
    required String date,
    required String type,
    required String media,
    required String description,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LatestViewDetails(
          title: title,
          date: date,
          type: type,
          media: media,
          description: description,
        ),
      ),
    );
  }
}

class _TodayNewsCard extends StatefulWidget {
  final String title;
  final String date;
  final String type;
  final String media;
  final VoidCallback onTap;

  const _TodayNewsCard({
    required this.title,
    required this.date,
    required this.type,
    required this.media,
    required this.onTap,
  });

  @override
  State<_TodayNewsCard> createState() => _TodayNewsCardState();
}

class _TodayNewsCardState extends State<_TodayNewsCard> {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.type.toLowerCase() == "video" && widget.media.isNotEmpty) {
      _initializeVideo();
    }
  }

  void _initializeVideo() async {
    try {
      _videoController =
          VideoPlayerController.networkUrl(Uri.parse(widget.media));
      await _videoController!.initialize();
      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
        _videoController!.setLooping(true);
        _videoController!.play();
      }
    } catch (e) {
      print("Video initialization error: $e");
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.whiteColors,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.latestNewsCardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  height: 160.h,
                  width: double.infinity,
                  color: AppColors.black,
                  child: widget.type.toLowerCase() == "video"
                      ? _isVideoInitialized && _videoController != null
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                AspectRatio(
                                  aspectRatio:
                                      _videoController!.value.aspectRatio,
                                  child: VideoPlayer(_videoController!),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (_videoController!.value.isPlaying) {
                                        _videoController!.pause();
                                      } else {
                                        _videoController!.play();
                                      }
                                    });
                                  },
                                  child: Container(
                                    color: AppColors.transparent,
                                    child: Center(
                                      child: _videoController!.value.isPlaying
                                          ? const SizedBox.shrink()
                                          : Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: AppColors.black
                                                    .withOpacity(.54),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.play_arrow,
                                                color: AppColors.whiteColors,
                                                size: 40,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            )
                      : widget.media.isNotEmpty
                          ? Image.network(
                              widget.media,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: AppColors.black,
                                child: Icon(
                                  Icons.broken_image,
                                  color: AppColors.whiteColors.withOpacity(.54),
                                  size: 50,
                                ),
                              ),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),
                                );
                              },
                            )
                          : Container(color: AppColors.black),
                ),
              ),
              SizedBox(height: 12.h),
              TrText(
                widget.title,
                style: FTextStyle.latestNewsTitleStyle,
              ),
              SizedBox(height: 6.h),
              TrText(
                widget.date,
                style: FTextStyle.latestNewsDateStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoreNewsTile extends StatelessWidget {
  final Map item;
  final VoidCallback onTap;

  const _MoreNewsTile({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String title = (item["title"] ?? "").toString();
    final String date = (item["date"] ?? "").toString();
    final String media = (item["media"] ?? "").toString();

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.whiteColors,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  height: 64.w,
                  width: 64.w,
                  color: AppColors.black,
                  child: media.isNotEmpty
                      ? Image.network(
                          media,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: AppColors.black,
                            child: Icon(
                              Icons.broken_image,
                              color: AppColors.whiteColors.withOpacity(.54),
                              size: 30,
                            ),
                          ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        )
                      : Container(color: AppColors.black),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TrText(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: FTextStyle.cardTileText.copyWith(
                        fontSize: 13.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TrText(
                      date,
                      style: FTextStyle.latestNewsDateStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: AppColors.latestNewsArrowBg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.arrow_forward_ios,
                    size: 14, color: AppColors.textPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
