import 'package:almohad_design_system/almohad_design_system.dart';
import 'package:almohad_design_system/src/widgets/audio_message/audio_time_status.dart';
import 'package:audioplayers/audioplayers.dart' as player;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AudioMessage extends StatefulWidget {
  final String audioUrl;
  final String audioTitle;
  final ChatStatus status;
  final Color backgroundColor;
  final Color doneColor;
  final Color? accentColor;
  final bool isSender;
  final DateTime time;
  final TextStyle? timeTextStyle;
  final TextStyle? titleStyle;
  final bool showUserAvatar;
  final dynamic userAvatar;

  const AudioMessage({
    super.key,
    required this.audioUrl,
    required this.audioTitle,
    required this.status,
    required this.backgroundColor,
    required this.doneColor,
    required this.isSender,
    required this.time,
    this.accentColor,
    this.timeTextStyle,
    this.titleStyle,
    this.showUserAvatar = true,
    this.userAvatar,
  });

  @override
  State<AudioMessage> createState() => _AudioMessageState();
}

class _AudioMessageState extends State<AudioMessage> {
  final AudioPlayer _audioPlayer = player.AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;

  Future<void> _loadAudio() async {
    await _audioPlayer.setSourceUrl(widget.audioUrl);
    _audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        _totalDuration = event;
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes);
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void initState() {
    _loadAudio().then((_) async {
      await _audioPlayer.getDuration().then((d) {
        setState(() {
          _totalDuration = d ?? Duration.zero;
        });
      });

      _audioPlayer.onPositionChanged.listen((event) {
        setState(() {
          _currentDuration = event;
        });
      });

      _audioPlayer.onPlayerStateChanged.listen((event) {
        setState(() {
          if (event == player.PlayerState.completed) {
            _isPlaying = false;
            _currentDuration = Duration.zero;
          } else {
            _isPlaying = event == player.PlayerState.playing;
          }
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _audioPlayer.dispose();
    }
    super.dispose();
  }

  void _playPause() {
    if (_audioPlayer.state == player.PlayerState.completed ||
        _currentDuration >= _totalDuration) {
      _audioPlayer.seek(Duration.zero);
      _audioPlayer.resume();
    } else if (_audioPlayer.state == player.PlayerState.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.resume();
    }
  }

  Widget _buildAvatar() {
    if (!widget.showUserAvatar || widget.isSender) return SizedBox.shrink();

    if (widget.userAvatar is String) {
      return CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(widget.userAvatar),
        backgroundColor: Colors.grey[300],
      );
    } else if (widget.userAvatar is Widget) {
      return widget.userAvatar;
    } else {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.person, color: widget.accentColor ?? Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!widget.isSender)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: _buildAvatar(),
          ),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: Card(
            margin: EdgeInsets.zero,
            color: widget.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.isSender ? 12 : 6),
                topRight: Radius.circular(widget.isSender ? 6 : 12),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 8,
                leading: GestureDetector(
                  onTap: _playPause,
                  child: SizedBox(
                    height: 45,
                    width: 45,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              _isPlaying ? Iconsax.pause : Iconsax.play,
                              color: widget.accentColor ?? Colors.white,
                            ),
                          ),
                          if (_isPlaying)
                            Center(
                              child: CircularProgressIndicator(
                                value:
                                    _totalDuration.inMilliseconds > 0
                                        ? _currentDuration.inMilliseconds /
                                            _totalDuration.inMilliseconds
                                        : 0,
                                valueColor: AlwaysStoppedAnimation(
                                  widget.doneColor,
                                ),
                                backgroundColor:
                                    widget.accentColor ?? Colors.white,
                                strokeCap: StrokeCap.round,
                                strokeWidth: 1.5,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                title: Text(
                  widget.audioTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      widget.titleStyle ??
                      TextStyle(
                        color: widget.accentColor ?? Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        "${_formatDuration(_totalDuration)} - ${_formatDuration(_currentDuration)}",
                        style:
                            widget.timeTextStyle ??
                            TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ),
                    AudioTimeStatus(
                      time: widget.time,
                      isSender: widget.isSender,
                      doneColor: widget.doneColor,
                      status: widget.status,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
