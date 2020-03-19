import 'package:flutter/material.dart';
import 'package:pokedex_mobx/views/home_page/home_page.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pokedex",
      home: HomePage(),
      
    )
  );
}