import 'package:flutter/material.dart';

void main() => runApp(UserProfile());
// The main() class is here for debbuging purposes

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.flag_sharp),
          title: const Text("Frankfurt"),
          actions: const [
            Text("M26"),
          ],
        ),
        body: Column(
          children: [
            Container(
              child: Image.asset("aa"),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              child: const Text(
                "@ag",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),

            //horizontal hobbies list
            // kur te lidhim backendin do bahen bashke kta
            Container(
              height: 40,
              margin: EdgeInsets.all(8),
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

            Container(
              height: 240,
              margin: EdgeInsets.all(10),
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
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
          border: Border.all(
            color: Colors.deepPurple,
            width: 2,
          )),
      child: Text("Yogamano"),
    );

Widget singleChartColumn() => Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.all(8),
          width: 30,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.amber,
          ),
        ),
        Text('M'),
      ],
    );
