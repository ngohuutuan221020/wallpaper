import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:photo_app/data/data.dart';
import 'package:photo_app/model/wallpaper_model.dart';
import 'package:photo_app/widgets/widget.dart';
class Categorie extends StatefulWidget {
  final String categorieName;
  Categorie({
    required this.categorieName
  });

  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {

  List<WallpaperModel> wallpapers = [];

  getSearchWallpapers(String query) async{
    //API
    // final apiKey = "563492ad6f91700001000001ae250348a8944839880da60a6ae3662b";
    final url = "https://api.pexels.com/v1/search?query=$query&per_page=80&page=1";
    Response response ;
    response = await http.get(Uri.parse(url),
        headers: {
          "Authorization" : apiKey
        });
    print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    // Lay hinh anh
    jsonData["photos"].forEach((element){
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getSearchWallpapers(widget.categorieName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: BrandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children:<Widget> [

              SizedBox(
                height: 16,
              ),
              wallpapersList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
