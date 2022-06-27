import 'dart:convert';
import 'dart:ui';

import 'package:comrade/constants/eventValues.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final EventValues event;
  EventCard(this.event);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6 / 3,
      child: Card(
        elevation: 2,
        child: Container(
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              _Event(event),
              Divider(color: Colors.grey),
              _EventDetails(event),
            ],
          ),
        ),
      ),
    );
  }
}

class _Event extends StatelessWidget {
  final EventValues event;
  _Event(this.event);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
          children: <Widget>[_EventImage(event), _EventTitleAndSummary(event)]),
    );
  }
}

class _EventTitleAndSummary extends StatelessWidget {
  final EventValues event;
  _EventTitleAndSummary(this.event);

  @override
  Widget build(BuildContext context) {
    final String title = event.postTitle;
    final String summary = event.postSummary;

    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextThemesTitle.display(context)),
            SizedBox(height: 2.0),
            Text(summary, style: TextThemesSubtitle.display(context)),
          ],
        ),
      ),
    );
  }
}

class _EventImage extends StatelessWidget {
  final EventValues event;
  _EventImage(this.event);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2, child: Image(image: NetworkImage(event.postImage)));
  }
}

class _EventDetails extends StatelessWidget {
  final EventValues event;
  _EventDetails(this.event);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _UserImage(event),
        _UserNameAndEmail(event),
        _EventTimeStamp(event),
      ],
    );
  }
}

class _UserNameAndEmail extends StatelessWidget {
  final EventValues event;
  _UserNameAndEmail(this.event);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(event.userName, style: TextThemesSubtitle.display(context)),
            SizedBox(height: 2.0),
            Text(event.userEmail, style: TextThemesBody.display(context)),
          ],
        ),
      ),
    );
  }
}

class _UserImage extends StatelessWidget {
  final EventValues event;
  _UserImage(this.event);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: CircleAvatar(
        child: Image(image: NetworkImage(event.userImage)),
      ),
    );
  }
}

class _EventTimeStamp extends StatelessWidget {
  final EventValues event;
  _EventTimeStamp(this.event);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Text(event.postTime, style: TextThemesDate.display(context)),
    );
  }
}

class TextThemesTitle {
  static TextStyle display(BuildContext context) {
    final TextStyle title = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
    );
    return title;
  }
}

class TextThemesSubtitle {
  static TextStyle display(BuildContext context) {
    final TextStyle title = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    return title;
  }
}

class TextThemesBody {
  static TextStyle display(BuildContext context) {
    final TextStyle title = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w300,
    );
    return title;
  }
}

class TextThemesDate {
  static TextStyle display(BuildContext context) {
    final TextStyle title = TextStyle(
        fontSize: 12, fontWeight: FontWeight.w500, color: Colors.green[900]);
    return title;
  }
}
