import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/chat_message.dart';

class MessageWidget extends StatelessWidget {
  final ChatMessage message;
  final bool isMine;

  MessageWidget({
    @required this.message,
    @required this.isMine,
  });

  void showLocation() {
    String latLng = message.message.split('|')[1];
    String url = 'https://www.google.com/maps/search/?api=1&query=$latLng';
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return message.isLocation ? _buildLocationMessage() : _buildTextMessage();
  }

  Widget _buildLocationMessage() {
    Widget messageBody = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: showLocation,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Image.asset('assets/images/gmap.png', width: 50, height: 50),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  message.message,
                  style: Get.textTheme.subtitle1.copyWith(),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return _buildContainer(messageBody: messageBody);
  }

  Widget _buildTextMessage() {
    Widget messageBody = Padding(
      padding: EdgeInsets.all(10),
      child: RichText(
        text: TextSpan(
          children: highlightOccurrences(message.message),
        ),
      ),
    );

    return _buildContainer(messageBody: messageBody);
  }

  Widget _buildContainer({
    @required Widget messageBody,
  }) {
    String time = DateFormat("HH:mm").format(message.createdAt);

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isMine
                  ? Get.theme.primaryColor.withAlpha(50)
                  : Colors.grey[300],
              borderRadius: BorderRadius.only(
                bottomLeft: !isMine ? Radius.zero : Radius.circular(10),
                bottomRight: isMine ? Radius.zero : Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            clipBehavior: Clip.hardEdge,
            constraints: BoxConstraints(maxWidth: Get.width * 0.8),
            child: messageBody,
          ),
          SizedBox(height: 5),
          Text(
            time,
            style: Get.textTheme.bodyText1.copyWith(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  TextSpan _buildNormalText(String text) {
    return TextSpan(
      text: text,
      style: Get.textTheme.bodyText1.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
    );
  }

  TextSpan _buildUrlLinkText(String text) {
    String url = text;
    if (!url.contains('https://')) {
      url = 'http://' + url;
    }

    return TextSpan(
      text: text,
      recognizer: new TapGestureRecognizer()..onTap = () => launch(url),
      style: Get.textTheme.bodyText1.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 14,
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
    );
  }

  List<TextSpan> highlightOccurrences(String source) {
    RegExp urlRegex = RegExp(
        r'(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)');

    final List<Match> matches = <Match>[];
    matches.addAll(urlRegex.allMatches(source));

    if (matches.isEmpty) {
      return <TextSpan>[_buildNormalText(source)];
    }
    matches.sort((Match a, Match b) => a.start.compareTo(b.start));

    int lastMatchEnd = 0;
    final List<TextSpan> children = <TextSpan>[];

    for (final Match match in matches) {
      if (match.end <= lastMatchEnd) {
        // already matched -> ignore
      } else if (match.start <= lastMatchEnd) {
        children.add(_buildUrlLinkText(
          source.substring(lastMatchEnd, match.end),
        ));
      } else {
        children.add(_buildNormalText(
          source.substring(lastMatchEnd, match.start),
        ));

        children.add(_buildUrlLinkText(
          source.substring(match.start, match.end),
        ));
      }

      if (lastMatchEnd < match.end) {
        lastMatchEnd = match.end;
      }
    }

    if (lastMatchEnd < source.length) {
      children.add(_buildNormalText(
        source.substring(lastMatchEnd, source.length),
      ));
    }

    return children;
  }
}
