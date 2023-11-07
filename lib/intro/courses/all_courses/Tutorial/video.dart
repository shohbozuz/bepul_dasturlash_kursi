import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/Colors/color.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/api/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Video extends StatefulWidget {
  final int? topicId;

  const Video({this.topicId});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  Map<String, dynamic>? topicDetails;

  late VideoPlayerController _videoPlayerController;

  CustomVideoPlayerController? _customVideoPlayerController;
  late CustomVideoPlayerWebController _customVideoPlayerWebController;

  final CustomVideoPlayerSettings _customVideoPlayerSettings =
  const CustomVideoPlayerSettings(showSeekButtons: true);

  @override
  void initState() {
    super.initState();
    initializeVideo();
  }

  Future<void> initializeVideo() async {
    try {
      await fetchDetails();
    } catch (e) {
      print('Error initializing video: $e');
    }
  }

  Future<void> fetchDetails() async {
    try {
      final response = await http.get(
        Uri.parse(Constants.apiUrl + 'api/topics/${widget.topicId}/'),
      );

      if (response.statusCode == 200) {
        final List<int> bytes = response.bodyBytes;
        final String responseBody = utf8.decode(bytes);

        final Map<String, dynamic> responseData = json.decode(responseBody);
        final String topicVideoUrl = responseData['topic_video_url'];

        _videoPlayerController = VideoPlayerController.network(
          topicVideoUrl,
        )..initialize().then((value) {
          _customVideoPlayerController = CustomVideoPlayerController(
            context: context,
            videoPlayerController: _videoPlayerController,
            customVideoPlayerSettings: _customVideoPlayerSettings,
          );

          _customVideoPlayerWebController = CustomVideoPlayerWebController(
            webVideoPlayerSettings: CustomVideoPlayerWebSettings(
              src: topicVideoUrl,
            ),
          );

          setState(() {}); // Trigger a rebuild after initialization

          // Save topic details for later use
          setState(() {
            topicDetails = responseData;
          });
        });
      } else {
        throw Exception('Failed to load details');
      }
    } catch (e) {
      print('Error fetching details: $e');
    }
  }

  @override
  void dispose() {
    _customVideoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bar_color,
        title: Padding(
          padding: EdgeInsets.only(left: 90.0),
          child: Text("Video"),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: CupertinoPageScaffold(
        child: SafeArea(
          child: ListView(
            children: [
              kIsWeb
                  ? Expanded(
                child: CustomVideoPlayerWeb(
                  customVideoPlayerWebController:
                  _customVideoPlayerWebController,
                ),
              )
                  : _customVideoPlayerController != null
                  ? CustomVideoPlayer(
                customVideoPlayerController:
                _customVideoPlayerController!,
              )
                  : Container(),
              Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          topicDetails?['topic_video_title'] ?? '',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      topicDetails?['topic_video_description'] ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
              if (topicDetails == null)
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 150),
                      CircularProgressIndicator(
                        color: AppColors.bar_color,
                      ),
                      SizedBox(height: 10),
                      Text("Yuklanmoqda 🙃",style: TextStyle(color: AppColors.bar_color),),
                    ],
                  )
                ),
            ],
          ),
        ),
      ),
    );
  }
}
