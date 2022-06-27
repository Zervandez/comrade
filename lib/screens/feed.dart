import 'package:flutter/material.dart';
import '../widgets/single_event_feed_new.dart';
import 'package:comrade/constants/eventValues.dart';

void main() => runApp(Feed());
// The main() class is here for debbuging purposes

class Feed extends StatelessWidget {
  final List<EventValues> list = [
    EventValues(
        "https://www.tsv-jetzendorf.com/images/portfolio/fussball.jpg",
        "https://thumbs.dreamstime.com/z/default-avatar-profile-icon-vector-unknown-social-media-user-photo-default-avatar-profile-icon-vector-unknown-social-media-user-184816085.jpg",
        "Darius Seeger",
        "seegerdarius@yahoo.de",
        "30 April, 2019",
        "Soccer",
        "A nice game of soccer"),
    EventValues(
        "https://us.123rf.com/450wm/martialred/martialred1507/martialred150700258/42411192-volleyball-ball-line-art-icon-f%C3%BCr-sport-apps-und-websites.jpg",
        "https://thumbs.dreamstime.com/z/default-avatar-profile-icon-vector-unknown-social-media-user-photo-default-avatar-profile-icon-vector-unknown-social-media-user-184816085.jpg",
        "Mickey Obama",
        "mickey@yahoo.de",
        "30 April, 2019",
        "Volleyball",
        "A nice game of volleyball"),
    EventValues(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT13AU-qGJuyNXgPbjTY4MOCP1Ii3f_99P_Pw&usqp=CAU",
        "https://thumbs.dreamstime.com/z/default-avatar-profile-icon-vector-unknown-social-media-user-photo-default-avatar-profile-icon-vector-unknown-social-media-user-184816085.jpg",
        "Ariel der Große",
        "ariel@yahoo.de",
        "30 April, 2019",
        "Basketball",
        "A nice game of basketball"),
    EventValues(
        "https://i.ebayimg.com/images/g/PGUAAOSwQeZZz-f0/s-l500.jpg",
        "https://thumbs.dreamstime.com/z/default-avatar-profile-icon-vector-unknown-social-media-user-photo-default-avatar-profile-icon-vector-unknown-social-media-user-184816085.jpg",
        "Herbert Groenemeyer",
        "herby@yahoo.de",
        "30 April, 2019",
        "Darts",
        "A nice game of darts")
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Frankfurt'),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              EventCard(list.first),
              EventCard(list.elementAt(1)),
              EventCard(list.elementAt(2)),
              EventCard(list.elementAt(3)),
            ],
          ),
        ),
      ),
    );
  }
}
