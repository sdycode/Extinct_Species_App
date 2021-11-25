import 'package:extinct_animals/animations/fade_animation.dart';
import 'package:extinct_animals/animations/rotaion_transition.dart';
import 'package:extinct_animals/animations/scale_animation.dart';
import 'package:extinct_animals/animations/slider_animation.dart';
import 'package:extinct_animals/screens/extict_animals_birds_screen.dart';
import 'package:extinct_animals/screens/grid_screen.dart';
import 'package:extinct_animals/screens/random_words_screen.dart';
import 'package:extinct_animals/screens/sample_form_screen.dart';
import 'package:extinct_animals/screens/sliver_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../constants/route_path_names.dart' as routes;

class PageTransitionScreen extends StatefulWidget {
  const PageTransitionScreen({Key? key}) : super(key: key);

  @override
  _PageTransitionScreenState createState() => _PageTransitionScreenState();
}

class _PageTransitionScreenState extends State<PageTransitionScreen> {
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page Trasnitions"),
      ),
      body: Container(
        width: sw,
        height: sh,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, "extinct");
                  //   var args;
                  // Navigator.of(context).pushNamed('/extinct', arguments: args);
                  Navigator.of(context).push(CustomPageRouteScale(child: ExtinctAnimals()));
                },
                child: const Text("Extinct Species"),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/gridscreen');
                   Navigator.of(context).push(CustomPageRouteSlider(child: GridScreen(), direction: AxisDirection.up));
                },
                child: const Text("Grid Screen"),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                 Navigator.of(context).push(CustomPageRouteFade(child: RandomWordsScreen(),));
                },
                child: const Text("Random Words "),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  var args;
                  Navigator.of(context).push(CustomPageRouteRotate(child: SampleFormScreen(j: 1,), ));
                  
                },
                child: const Text("Form Screen"),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(CustomPageRouteSlider(child: SliverScreen(), direction: AxisDirection.left));
                },
                child: const Text("Sliver Screen"),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
