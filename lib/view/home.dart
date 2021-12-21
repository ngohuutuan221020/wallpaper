import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:photo_app/data/data.dart';
import 'package:photo_app/model/categories_model.dart';
import 'package:photo_app/model/wallpaper_model.dart';
import 'package:photo_app/view/categorie.dart';
import 'package:photo_app/view/image_view.dart';
import 'package:photo_app/view/search.dart';
import 'package:photo_app/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // categories_model
  List<CategoriesModel> categories = [];
  // wallpaper_model
  List<WallpaperModel> wallpapers = [];
  //Search
  TextEditingController searchController = new TextEditingController();
  //API
  // final apiKey = "563492ad6f91700001000001ae250348a8944839880da60a6ae3662b";
  final url = "https://api.pexels.com/v1/curated?per_page=80&page1";
  getTrendingWallpapers() async{
    Response response ;
    response = await http.get(Uri.parse(url),
        headers: {
          "Authorization" : apiKey
        });
    // print(response.body.toString());
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
    // API
    getTrendingWallpapers();
    // Categories
    categories = getCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: BrandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container (
          child: Column(
            children: <Widget> [
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
                            hintText: "Tim kiem",
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget> [
                    Text("By ", style: TextStyle(color: Colors.blue),),
                    Text("Ngô Hữu Tuấn",style: TextStyle(color: Colors.black, fontSize: 14)),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                    return CategoriesTitle(
                      //show title
                      title: categories[index].catrgoriesNmae,
                      //show categories
                      imgUrl: categories[index].imgUrl
                    );
                    }
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
class CategoriesTitle extends StatelessWidget {
   late String imgUrl, title;
   CategoriesTitle ({required this.imgUrl, required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Categorie(
          categorieName: title.toLowerCase(),
        )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: <Widget> [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imgUrl, height: 50, width: 100, fit: BoxFit.cover,),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),

              height: 50, width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
