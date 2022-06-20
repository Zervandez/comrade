import 'package:flutter/material.dart';

class SingleEvent extends StatelessWidget {
  const SingleEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        // image + title & @author
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(4),
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/sabba_profile_pic.jpg'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
            Column(
              children: const [
                Text("TITLE"),
                Text("@author "),
              ],
            ),
          ],
        ),

        // wann? + wo?
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
          Text('Do. 23.06 - 17:45'),
          Text('Nibelungenplatz 1'),
        ])
      ]),
    );
  }
}
