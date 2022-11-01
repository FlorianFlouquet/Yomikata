import 'package:flutter/material.dart';

class FlashCardsPage extends StatelessWidget {
  const FlashCardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Container(
            padding: const EdgeInsets.all(12),
            alignment: AlignmentDirectional.centerStart,
            child: const Icon(
              Icons.menu,
              size: 40,
            ),
          ),
          backgroundColor: Color(0xff670D0D),
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 500,
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Stack(
                    children: [
                      Transform(
                        transform: Matrix4.rotationZ(3),
                        alignment: FractionalOffset.center,
                        child: Container(
                          width: 250,
                          height: 400,
                          child: Card(
                            color: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Transform(
                        transform: Matrix4.rotationZ(0.2),
                        alignment: FractionalOffset.center,
                        child: Container(
                          width: 250,
                          height: 400,
                          child: Card(
                            color: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        height: 400,
                        child: Card(
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                                width: 1,
                              )
                          ),
                          child: Center(
                            child: Text(
                              "漢字",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "click on the card to flip it",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
