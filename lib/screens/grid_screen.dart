import 'dart:math';

import 'package:extinct_animals/providers/provider_data.dart';
import 'package:extinct_animals/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridScreen extends StatefulWidget {
     static const routeName = '/gridscreen';

  const GridScreen({Key? key}) : super(key: key);

  @override
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  double w = 140;
  int d = 2;
  @override
  Widget build(BuildContext context) {
    var animalsList = Provider.of<Data>(context);

    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Grid View"),
      ),
      drawer: AppDrawer(),
      body: Container(
        height: sh,
        width: sw,
        child: Column(
          children: [
            Expanded(
              // height: sh * 0.77,
              child: Scrollbar(
                isAlwaysShown: true,
                thickness: 5,
                hoverThickness: 8,
                scrollbarOrientation: ScrollbarOrientation.right,
                showTrackOnHover: true,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      "Animals : " + animalsList.allAnimals.length.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Container(
                      height: min((animalsList.allAnimals.length / (sw/w).toInt())*100+20, sh*0.6),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                          itemCount: animalsList.allAnimals.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: w,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemBuilder: (BuildContext ctx, index) {
                            return Container(
                              height:100,
                              alignment: Alignment.center,
                              child: Image.network(
                                animalsList.allAnimals.elementAt(index).imgurl,
                                fit: BoxFit.scaleDown,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                            );
                          }),
                    ),
                    Text(
                      "Birds : " + animalsList.allBirds.length.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Container(
                      height: min((animalsList.allBirds.length / (sw/w).toInt())*100+20, sh*0.6),
                      child: GridView.builder(
                          itemCount: animalsList.allBirds.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: w,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemBuilder: (BuildContext ctx, index) {
                            return Container(
                              height: 100,
                              alignment: Alignment.center,
                              child: Image.network(
                                animalsList.allBirds.elementAt(index).imgurl,
                                fit: BoxFit.scaleDown,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                            );
                          }),
                    ),
                    Text(
                      "Amphibians : " + animalsList.allAmphs.length.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Container(
                      height:  min((animalsList.allAmphs.length / (sw/w).toInt())*100+20, sh*0.6),
                      child: GridView.builder(
                          itemCount: animalsList.allAmphs.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: w,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemBuilder: (BuildContext ctx, index) {
                            return Container(
                              height: 100,
                              alignment: Alignment.center,
                              child: Image.network(
                                animalsList.allAmphs.elementAt(index).imgurl,
                                fit: BoxFit.scaleDown,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                            );
                          }),
                    ),
                    Text(
                      "Plants : " + animalsList.allPlants.length.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Container(
                      height: min((animalsList.allPlants.length / (sw/w).toInt())*100+20, sh*0.6),
                      child: GridView.builder(
                          itemCount: animalsList.allPlants.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: w,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemBuilder: (BuildContext ctx, index) {
                            return Container(
                              height: 100,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onPanStart: (drag) {},
                                child: Image.network(
                                  animalsList.allPlants.elementAt(index).imgurl,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (d>1) {
                          d--;
                          w = sw/d;
                        }
                      });
                    },
                    icon: const Icon(Icons.remove_circle_outline_rounded)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (sw / (d + 1) > 1) {
                          d++;
                          w = sw/d;
                        }

                        print("w add $w");
                        print("sw  $sw");
                      });
                    },
                    icon: const Icon(Icons.add_circle_outline_rounded))
              ],
            )
          ],
        ),
      ),
    );
  }
}
