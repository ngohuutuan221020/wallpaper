import 'package:flutter/material.dart';
import 'package:photo_app/model/wallpaper_model.dart';
import 'package:photo_app/view/home.dart';
import 'package:photo_app/view/image_view.dart';

//Ten Title
Widget BrandName (){
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      GestureDetector(
        onTap: ()=>Home(),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500 ),
            children: const <TextSpan>[
              TextSpan(text: 'Hình Nền ', style: TextStyle(color: Colors.black)),
              TextSpan(text: 'HD', style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
      ),
    ],
  );
}
// Widget BrandName (){
//   return Row (
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       Text("Wallpaper", style: TextStyle(color: Colors.black),),
//       Text("Hub", style: TextStyle(color: Colors.blue),)
//     ],
//   );
// }
//Danh sach Wallpapers
Widget wallpapersList({required List<WallpaperModel> wallpapers, context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        crossAxisCount: 2,
    childAspectRatio: 0.6,
    mainAxisSpacing: 6.0,
    crossAxisSpacing: 6.0,
    children: wallpapers.map((wallpaper){
      return GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context)=> ImageView(
                      imgUrl: wallpaper.src!.portrait,
                  ))
              );
            },
            child: Hero(
              tag: wallpaper.src!.portrait,
              child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      wallpaper.src!.portrait,
                      fit: BoxFit.cover,
                    ),
                  )
              ),
            ),
          )
      );
    }
    ).toList()
    ),
  );
}