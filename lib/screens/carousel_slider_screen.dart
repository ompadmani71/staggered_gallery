import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:staggered_gallery/models/photos_model.dart';
class CarouselSliderScreen extends StatefulWidget {
  const CarouselSliderScreen({Key? key}) : super(key: key);

  @override
  State<CarouselSliderScreen> createState() => _CarouselSliderScreenState();
}

class _CarouselSliderScreenState extends State<CarouselSliderScreen> {
  CarouselController carouselController = CarouselController();
  int initialSliderPage = 0;

  @override
  Widget build(BuildContext context) {
    Photos photosArg = ModalRoute.of(context)!.settings.arguments as Photos;
    return Scaffold(
      backgroundColor: const Color(0xffA8A8A8),
      appBar: AppBar(
        title: Text("${photosArg.catName}'s Photos"),
        backgroundColor: const Color(0xff018577),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 7),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                initialPage: initialSliderPage,
                onPageChanged: (val, _) {
                  setState(() {
                    initialSliderPage = val;
                  });
                },
                scrollDirection: Axis.horizontal,
                height: 300,
                viewportFraction: 0.7,
                enlargeCenterPage: true,
                autoPlayCurve: Curves.easeInOut,
              ),
              items: photosArg.photos
                  .map(
                    (photo) => Container(
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: photo,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>  Image.asset("assets/images/placeholder.jpg",fit: BoxFit.cover),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
