import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../data/carousel_images.dart';

class CarouselWindow extends StatefulWidget {
  @override
  State<CarouselWindow> createState() => _CarouselWindowState();
}

class _CarouselWindowState extends State<CarouselWindow> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 10),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            
            scrollDirection: Axis.horizontal,
          ),
          carouselController: buttonCarouselController,
          
          items: carousel_images.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    image['imageUrl'] as String,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }).toList(),
        ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             ElevatedButton(
               style: ElevatedButton.styleFrom(minimumSize: const Size(20, 40),primary: Colors.black54),
              onPressed: () => buttonCarouselController.previousPage(
                  duration: Duration(milliseconds: 300), curve: Curves.linear),
              child: Text('<'),
      ),
             ElevatedButton(
               style: ElevatedButton.styleFrom(minimumSize: const Size(20, 40),primary: Colors.black54),
              onPressed: () => buttonCarouselController.nextPage(
                  duration: Duration(milliseconds: 300), curve: Curves.linear),
              child: Text('>'),
      ),
           ],
         ),
        
      ],
    );
  }
}
