import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/services.dart';
import 'package:staggered_gallery/models/photos_model.dart';

class StaggeredScreen extends StatefulWidget {
  const StaggeredScreen({Key? key}) : super(key: key);

  @override
  State<StaggeredScreen> createState() => _StaggeredScreenState();
}

class _StaggeredScreenState extends State<StaggeredScreen> {
  List<Photos>? photos;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Photos>?> loadPhotos()async{
    String res = await rootBundle.loadString("assets/json/photos_json.json");
    photos = photosFromJson(res);
    print("Length => ${photos!.length}");
    return photos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffA8A8A8),
      appBar: AppBar(
        title: const Text('Staggered RecyclerView'),
        backgroundColor: const Color(0xff018577),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child:
          FutureBuilder(
            future: loadPhotos(),
            builder: (context, AsyncSnapshot snapshot) {

              if(snapshot.hasError){
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if(snapshot.hasData){
                List<Photos> photos = snapshot.data;

                return StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 2.5,
                      child: staggeredImage(photo: photos[0]),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1.3,
                      child: staggeredImage(photo: photos[1]),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 2,
                      child: staggeredImage(
                        photo: photos[2],
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: staggeredImage(photo: photos[3]),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 2,
                      child: staggeredImage(photo: photos[4]),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 2,
                      child: staggeredImage(photo: photos[5]),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 2.5,
                      child: staggeredImage(photo: photos[6]),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1.3,
                      child: staggeredImage(photo: photos[7]),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: staggeredImage(photo: photos[8]),
                    ),

                  ],
                );

              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          )
        ),
      ),
    );
  }

  Widget staggeredImage({required Photos photo}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed('carousel_slider_screen', arguments: photo);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8,8,8,0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: photo.catPhotoUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>  Image.asset("assets/images/placeholder.jpg",fit: BoxFit.cover),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                photo.catName ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
