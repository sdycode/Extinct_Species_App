import 'package:extinct_animals/providers/provider_data.dart';
import 'package:extinct_animals/screens/grid_screen.dart';
import 'package:extinct_animals/screens/sliver_screen.dart';
import 'package:extinct_animals/widgets/app_drawer.dart';
import 'package:extinct_animals/widgets/sample_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExtinctAnimals extends StatefulWidget {
   static const routeName = '/extinct';
   ExtinctAnimals({Key? key}) : super(key: key);

  @override
  _ExtinctAnimalsState createState() => _ExtinctAnimalsState();
}

class _ExtinctAnimalsState extends State<ExtinctAnimals> {
  double card_height = 250;
  int colorslidervalue = 0;
  int blendslidervalue = 0;
  bool isExpanded = false;
  bool isGridView = false;
  int _currentIndex = 0;
  Color color = Colors.yellow;
  List colors = [
    Colors.yellow,
    Colors.green,
    Colors.orange,
    Colors.orangeAccent,
    Colors.deepOrange,
    Colors.deepOrangeAccent,
    Colors.yellow,
    Colors.yellowAccent,
    Colors.lightGreen,
    Colors.greenAccent,
    Colors.green,
    Colors.lightGreenAccent,
    Colors.blueAccent,
    Colors.blueGrey,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.blue,
    Colors.purple,
    Colors.purpleAccent,
    Colors.deepPurpleAccent,
  ];

  @override
  Widget build(BuildContext context) {
    var animalsList = Provider.of<Data>(context);

    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    final tabs = [
      
      TabBarView(children: [
        _verticalAnimals(animalsList, sw, sh),
        _verticalAmphs(animalsList, sw, sh),
        _verticalBirds(animalsList, sw, sh),
        _verticalPlants(animalsList, sw, sh),
        Container(
          width: sw,
          height: sh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Animals",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                _animals(animalsList, sw),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Birds",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                _birds(animalsList, sw),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Amphibians",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                _snakes(animalsList, sw),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Plants",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                _plants(animalsList, sw),
                // sliderBox(true, colors.length)
              ],
            ),
          ),
        ),
      ]),
       Container(
           height: sh,
           child:  WebView(
             initialUrl: "https://www.google.com/",
           )),
         Container(
           height: sh,
           child:  WebView(
             initialUrl: "https://www.wikipedia.com/",
           )),
          
    ];
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text("Extincts"),
              flexibleSpace: const Text("Flexible"),
              bottom: _currentIndex!=0?null: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(MdiIcons.cow),
                    text: "Animal",
                  ),
                  Tab(
                    icon: Icon(MdiIcons.snake),
                    text: "Amphs",
                  ),
                  Tab(
                    icon: Icon(MdiIcons.bird),
                    text: "Birds",
                  ),
                  Tab(icon: Icon(MdiIcons.leaf), text: "Plants"),
                  Tab(icon: Icon(MdiIcons.allInclusive), text: "All"),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (c) => SliverScreen()));
                  },
                  icon: const Icon(Icons.list_alt_rounded),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (c) => const GridScreen()));
                    setState(() {
                      isGridView = !isGridView;
                    });
                  },
                  icon: const Icon(Icons.grid_3x3_outlined),
                ),
              ],
            ),
            drawer: AppDrawer(),
            body: tabs[_currentIndex],
            bottomNavigationBar:
             BottomNavigationBar(
                currentIndex: _currentIndex,
                backgroundColor: color,
                selectedLabelStyle: const TextStyle(color: Colors.black),
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                    color = colors.elementAt(index);
                  });
                },
                items: const [
                      BottomNavigationBarItem(
                    icon: Icon(
                      MdiIcons.home,
                      color: Colors.black38,
                      size: 22,
                    ),
                    label: "Home",
                    activeIcon: Icon(
                      MdiIcons.home,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      MdiIcons.googleChrome,
                      color: Colors.black38,
                      size: 22,
                    ),
                    label: "google",
                    activeIcon: Icon(
                      MdiIcons.googleChrome,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      MdiIcons.wikipedia,
                      color: Colors.black,
                      size: 22,
                    ),
                    label: "wiki",
                    activeIcon: Icon(
                      MdiIcons.wikipedia,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ]),
         
          ),
        ));
  }

  Widget sliderBox(bool isColorBlend, int divisions) {
    int selectedvalue = 0;
    double vl = 0.0;
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Slider(
              value: vl,
              onChanged: (double v) {
                setState(() {
                  selectedvalue = v.toInt();
                  vl = v;
                  if (isColorBlend) {
                    colorslidervalue = selectedvalue.toInt();
                  } else {
                    blendslidervalue = selectedvalue.toInt();
                  }
                });
              },
              min: 0.0,
              max: divisions.toDouble() - 1.0,
              divisions: divisions,
              label: isColorBlend ? "Color" : "Blend"),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                isExpanded = false;
                selectedvalue = 50;
                print("se" + selectedvalue.toString());
              });
            },
            icon: const Icon(Icons.close)),
        SafeArea(child: Text(selectedvalue.toString())),
      ],
    ));
  }

  Widget _animals(Data animalsList, double sw) {
    return Container(
      height: card_height,
      width: sw,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return SampleCard(
            area: animalsList.allAnimals.elementAt(index).area,
            img: animalsList.allAnimals.elementAt(index).imgurl,
            name: animalsList.allAnimals.elementAt(index).name,
            wikiurl: animalsList.allAnimals.elementAt(index).wikiurl,
          );
        },
        itemCount: animalsList.allAnimals.length,
      ),
    );
  }

  Widget _birds(Data animalsList, double sw) {
    return Container(
      width: sw,
      height: card_height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return SampleCard(
            area: animalsList.allBirds.elementAt(index).area,
            img: animalsList.allBirds.elementAt(index).imgurl,
            name: animalsList.allBirds.elementAt(index).name,
            wikiurl: animalsList.allBirds.elementAt(index).wikiurl,
          );
        },
        itemCount: animalsList.allBirds.length,
      ),
    );
  }

  Widget _snakes(Data animalsList, double sw) {
    return Container(
      width: sw,
      height: card_height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return SampleCard(
            area: animalsList.allAmphs.elementAt(index).area,
            img: animalsList.allAmphs.elementAt(index).imgurl,
            name: animalsList.allAmphs.elementAt(index).name,
            wikiurl: animalsList.allAmphs.elementAt(index).wikiurl,
          );
        },
        itemCount: animalsList.allAmphs.length,
      ),
    );
  }

  Widget _plants(Data animalsList, double sw) {
    return Container(
      width: sw,
      height: card_height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return SampleCard(
            area: animalsList.allPlants.elementAt(index).area,
            img: animalsList.allPlants.elementAt(index).imgurl,
            name: animalsList.allPlants.elementAt(index).name,
            wikiurl: animalsList.allPlants.elementAt(index).wikiurl,
          );
        },
        itemCount: animalsList.allPlants.length,
      ),
    );
  }

  Widget _verticalAnimals(Data animalsList, double sw, double h) {
    return Container(
      height: h,
      width: sw,
      child: Container(
        height: h * 0.9,
        width: sw,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: SampleCard(
                area: animalsList.allAnimals.elementAt(index).area,
                img: animalsList.allAnimals.elementAt(index).imgurl,
                name: animalsList.allAnimals.elementAt(index).name,
                wikiurl: animalsList.allAnimals.elementAt(index).wikiurl,
              ),
            );
          },
          itemCount: animalsList.allAnimals.length,
        ),
      ),
    );
  }

  Widget _verticalAmphs(Data animalsList, double sw, double sh) {
    return Container(
      height: sh,
      width: sw,
      child: Container(
        height: sh * 0.9,
        width: sw,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: SampleCard(
                area: animalsList.allAmphs.elementAt(index).area,
                img: animalsList.allAmphs.elementAt(index).imgurl,
                name: animalsList.allAmphs.elementAt(index).name,
                wikiurl: animalsList.allAmphs.elementAt(index).wikiurl,
              ),
            );
          },
          itemCount: animalsList.allAmphs.length,
        ),
      ),
    );
  }

  Widget _verticalBirds(Data animalsList, double sw, double sh) {
    return Container(
      height: sh,
      width: sw,
      child: Container(
        height: sh * 0.9,
        width: sw,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: SampleCard(
                area: animalsList.allBirds.elementAt(index).area,
                img: animalsList.allBirds.elementAt(index).imgurl,
                name: animalsList.allBirds.elementAt(index).name,
                wikiurl: animalsList.allBirds.elementAt(index).wikiurl,
              ),
            );
          },
          itemCount: animalsList.allBirds.length,
        ),
      ),
    );
  }

  Widget _verticalPlants(Data animalsList, double sw, double sh) {
    return Container(
      height: sh,
      width: sw,
      child: Container(
        height: sh * 0.9,
        width: sw,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: SampleCard(
                area: animalsList.allPlants.elementAt(index).area,
                img: animalsList.allPlants.elementAt(index).imgurl,
                name: animalsList.allPlants.elementAt(index).name,
                wikiurl: animalsList.allPlants.elementAt(index).wikiurl,
              ),
            );
          },
          itemCount: animalsList.allPlants.length,
        ),
      ),
    );
  }
}
