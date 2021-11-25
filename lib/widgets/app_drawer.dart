import 'package:extinct_animals/screens/extict_animals_birds_screen.dart';
import 'package:extinct_animals/screens/page_transition_screen.dart';
import 'package:extinct_animals/screens/random_words_screen.dart';
import 'package:extinct_animals/screens/sample_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Extinct !!!"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.iso),
            title: const Text("Animals"),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (c) =>  ExtinctAnimals()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_online),
            title: const Text("Form "),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (c) =>  SampleFormScreen(j: 1, )));
            },
          ),
           ListTile(
            leading: const Icon(Icons.sort_by_alpha),
            title: const Text("Random "),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (c) =>  RandomWordsScreen( )));
            },
          ),
          ListTile(
            leading: const Icon(MdiIcons.pageNext),
            title: const Text("Page Transition "),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (c) =>  PageTransitionScreen( )));
            },
          ),
        
        
        ],
      ),
    );
  }
}
