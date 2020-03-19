import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
                  height: 120,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 13.0, right: 5),
                                child: IconButton(
                                  icon: Icon(Icons.menu), 
                                  onPressed: (){}
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text("Pokedex",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28
                              ),),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                );
  }
}