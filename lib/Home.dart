import 'package:flutter/material.dart';
import 'Navigator.dart';
import 'widgets/Maps.dart';
import 'package:carousel_slider/carousel_slider.dart';

class UberHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/img/uberi.png',
              width: 80.0,
              height: 80.0,
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
          ),
          Positioned(
            top: 0,
            left: 2,
            right: 5,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 5.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapSample()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 16.0,
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.search_sharp),
                                  SizedBox(width: 8.0),
                                  Text(
                                    '¿A dónde vas?',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 9.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 13.0,
                              vertical: 5.0,
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.access_time, color: Colors.black),
                                SizedBox(width: 12.0),
                                Text(
                                  'Ahora',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_down_outlined,
                                    color: Colors.black),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sugerencias',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Ver Todo',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 100.0,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 233, 230, 230),
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 184, 184, 184)
                                  .withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 9),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Image.asset('assets/img/cari.png',
                                width: 70.0, height: 60.0),
                            SizedBox(height: 0.0),
                            Text(
                              'Viaje',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100.0,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 233, 230, 230),
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 9),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Image.asset('assets/img/boxi.png',
                                width: 70.0, height: 60.0),
                            SizedBox(height: 0.0),
                            Text(
                              'Envíos',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100.0,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 233, 230, 230),
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 9),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Image.asset('assets/img/cale.png',
                                width: 70.0, height: 60.0),
                            SizedBox(height: 0.0),
                            Text(
                              'Reservar',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 130.0,
                      autoPlay: true,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: [
                      'assets/img/vista1.jpg',
                      'assets/img/vista2.jpg',
                    ].map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.only(left: 3),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                imagePath,
                                width: 350.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyNavBar(),
    );
  }
}
