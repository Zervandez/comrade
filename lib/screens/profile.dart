import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(UserProfile());
// The main() class is here for debbuging purposes

class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.flag_sharp),
        title: const Text(
          "Frankfurt",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(12),
            child: const Text(
              "M60",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: 140.0,
              width: 140.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/sabba_profile_pic.jpg'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              child: const Text(
                "@kk",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),

            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.male),
                  Text('27'),
                  Icon(Icons.settings),
                  ElevatedButton.icon(
                    onPressed: logUserOut,
                    icon: Icon(Icons.logout),
                    label: Text(''),
                  )
                ],
              ),
            ),

            //horizontal hobbies list
            // kur te lidhim backendin do bahen bashke kta
            Container(
              height: 40,
              margin: const EdgeInsets.all(8),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  hobbyItem(),
                  hobbyItem(),
                  hobbyItem(),
                  hobbyItem(),
                  hobbyItem(),
                  hobbyItem(),
                  hobbyItem(),
                  hobbyItem(),
                  hobbyItem(),
                  hobbyItem(),
                  hobbyItem(),
                  hobbyItem(),
                  hobbyItem()
                ],
              ),
            ),
            //horizontal hobbies list
            // kur te lidhim backendin do bahen bashke kta
            Container(
              child: const ElevatedButton(
                  child: Text('LOGOUT'), onPressed: logUserOut),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: 240,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.black,
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  singleChartColumn(),
                  singleChartColumn(),
                  singleChartColumn(),
                  singleChartColumn(),
                  singleChartColumn(),
                  singleChartColumn(),
                  singleChartColumn()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget hobbyItem() => Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
          border: Border.all(
            color: Colors.deepPurple,
            width: 2,
          )),
      child: const Text("Yoga"),
    );

Widget singleChartColumn() => Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          width: 30,
          height: 120,
          decoration: const BoxDecoration(
            color: Colors.amber,
          ),
        ),
        const Text('Mi'),
      ],
    );

Future<void> logUserOut() async {
  await FirebaseAuth.instance.signOut();
}
