import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:photo_app/data/data.dart';
import 'package:photo_app/model/wallpaper_model.dart';
import 'package:photo_app/widgets/widget.dart';

class Search extends StatefulWidget {
  final String searchQuery;
  Search({required this.searchQuery});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallpaperModel> wallpapers = [];
  TextEditingController searchController = new TextEditingController();
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
    getSearchWallpapers(widget.searchQuery);
    super.initState();
    searchController.text= widget.searchQuery;
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
              Container(
                decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)
                ),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row (
                  children: <Widget> [
                    Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Tìm kiếm",
                            border: InputBorder.none,
                          ),
                        )
                    ),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => Search(
                                    searchQuery: searchController.text,
                                  )));
                        },
                        child: Container(
                            child: Icon(
                                Icons.search
                            )
                        )
                    )
                  ],
                ),
              ),
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
