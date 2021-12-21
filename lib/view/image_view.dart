
import 'dart:typed_data';
import 'package:dio/dio.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  ImageView({required this.imgUrl}
);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:<Widget> [
          Hero(
            tag: widget.imgUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(widget.imgUrl, fit: BoxFit.cover,)),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget> [
                GestureDetector(
                  onTap: (){
                    setWallpaper();
                  },
                  child: Stack(
                    children: <Widget> [
                      Container(
                  decoration: BoxDecoration(
                    color: Color(0xff1C1818).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(30),),
                        width: MediaQuery.of(context).size.width/2,

                      ),
                      Container(

                        width: MediaQuery.of(context).size.width/2,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0x36FFFFFF),
                                  Color(0x0FFFFFFF),
                                ]
                            )
                        ),
                        child: Column(
                          children: <Widget> [
                            Text("Màn hình nền",
                                style: TextStyle(fontSize: 16, color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                GestureDetector(
                  onTap: (){
                    _save();
                  },
                  child: Stack(
                    children: <Widget> [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff1C1818).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30),),
                        width: MediaQuery.of(context).size.width/2,

                      ),
                      Container(

                        width: MediaQuery.of(context).size.width/2,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0x36FFFFFF),
                                  Color(0x0FFFFFFF),
                                ]
                            )
                        ),
                        child: Column(
                          children: <Widget> [
                            Text("Lưu hình ảnh",
                              style: TextStyle(fontSize: 16, color: Colors.white),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text (
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  _save() async {
    var response = await Dio().get(
      widget.imgUrl,
      options: Options(responseType: ResponseType.bytes)
    );
    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    Navigator.pop(context);
  }
  setWallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
    final result = await WallpaperManager.setWallpaperFromFile(file.path, location);
    Navigator.pop(context);
  }
}
