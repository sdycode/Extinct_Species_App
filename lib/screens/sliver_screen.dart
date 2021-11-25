import 'dart:math';

import 'package:extinct_animals/models/animal_model.dart';
import 'package:extinct_animals/providers/provider_data.dart';
import 'package:extinct_animals/widgets/app_drawer.dart';
import 'package:extinct_animals/widgets/sample_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// For slivers
// https://youtu.be/E3-WdYBrEDc
//https://github.com/bizz84/slivers_demo_flutter/tree/master/lib/pages
class SliverScreen extends StatefulWidget {
  const SliverScreen({Key? key}) : super(key: key);

  @override
  _SliverScreenState createState() => _SliverScreenState();
}

class _SliverScreenState extends State<SliverScreen> {
  double w = 140;
  int d = 2;
  Color? gridColor = null;
  List colors = [
    Colors.red,
    Colors.redAccent,
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

  List<Widget> list = [
    SliverAppBar(
      foregroundColor: null,
      centerTitle: true,
      automaticallyImplyLeading: false,
      pinned: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Click on Animal',
          textAlign: TextAlign.center,
        ),
        collapseMode: CollapseMode.parallax,
        stretchModes: const [StretchMode.fadeTitle, StretchMode.zoomBackground],
        background: Image.network(
            "https://images.ctfassets.net/hrltx12pl8hq/3MbF54EhWUhsXunc5Keueb/60774fbbff86e6bf6776f1e17a8016b4/04-nature_721703848.jpg?fit=fill&w=480&h=270",
            fit: BoxFit.fill),
      ),
    ),
    SliverAppBar(
      foregroundColor: null,
      centerTitle: true,
      automaticallyImplyLeading: false,
      pinned: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Click on any button',
          textAlign: TextAlign.center,
        ),
        collapseMode: CollapseMode.parallax,
        stretchModes: const [StretchMode.fadeTitle, StretchMode.zoomBackground],
        background: Image.network(
            "https://images.ctfassets.net/hrltx12pl8hq/3MbF54EhWUhsXunc5Keueb/60774fbbff86e6bf6776f1e17a8016b4/04-nature_721703848.jpg?fit=fill&w=480&h=270",
            fit: BoxFit.fill),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    var animalsList = Provider.of<Data>(context);

    // list = getImageList(animalsList.allAnimals);

    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          height: sh,
          width: sw,
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber),
                ),
                onPressed: () {
                  setState(() {
                    list = getImageList(animalsList.allAnimals);
                  });
                },
                child: const Text("Animals"),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    setState(() {
                      list = getImageList(animalsList.allAmphs);
                    });
                  },
                  child: const Text("Amphs")),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () {
                    setState(() {
                      list = getImageList(animalsList.allBirds);
                    });
                  },
                  child: const Text("Birds")),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                  ),
                  onPressed: () {
                    setState(() {
                      list = getImageList(animalsList.allPlants);
                    });
                  },
                  child: const Text("Plants")),
            ]),
            Expanded(
              child: CustomScrollView(slivers: [
                ...list,
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (index == 0) {
                              gridColor = null;
                            } else {}
                            gridColor = colors.elementAt(
                                index % 20)[max(100 * (index % 9), 400)];
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: colors.elementAt(
                              index % 20)[max(100 * (index % 9), 400)],
                          //  Colors.teal[100 * (index % 9)]
                          child: Text('grid item $index'),
                        ),
                      );
                    },
                    childCount: 30,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 2.0,
                  ),
                ),
              ]),
            ),
          ])),
    );
  }

  Widget getWidget(
    Animal elementAt,
  ) {
    return SliverAppBar(
      leading: const Text(""),
      foregroundColor: Colors.red,
      centerTitle: true,
      automaticallyImplyLeading: false,
      // pinned: true,
      floating: false,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          elementAt.name,
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        collapseMode: CollapseMode.pin,
        stretchModes: const [
          StretchMode.fadeTitle,
        ],
        background: Opacity(
            opacity: 0.7,
            child: Image.network(
              elementAt.imgurl,
              fit: BoxFit.fill,
              color: gridColor,
              colorBlendMode: BlendMode.lighten,
            )),
      ),
    );
  }

  List<Widget> getImageList(List<Animal> allAnimals) {
    List<Widget> ans = [];
    for (int i = 0; i < allAnimals.length; i++) {
      ans.add(
        getWidget(allAnimals.elementAt(i)),
      );
    }
    return ans;
  }
}
