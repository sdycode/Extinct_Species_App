import 'package:extinct_animals/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RandomWordsScreen extends StatefulWidget {
  const RandomWordsScreen({Key? key}) : super(key: key);

  @override
  _RandomWordsScreenState createState() => _RandomWordsScreenState();
}

class _RandomWordsScreenState extends State<RandomWordsScreen> {
  final wordPair = WordPair.random();
  int curindex = 0;
  var color = Colors.grey;
  List<WordPair> words = [];
  List<WordPair> favs = [];
  @override
  Widget build(BuildContext context) {
    final tabs = [
      Container(
        child: ListView.builder(
          itemBuilder: (ctx, i) {
            words.addAll(generateWordPairs().take(20));
            return tile(i);
          },
        ),
      ),
      Container(
        child: ListView.builder(
          itemBuilder: (ctx, i) {
            return favTile(i);
          },
          itemCount: favs.length,
        ),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Words"),
      ),
      drawer: const AppDrawer(),
      body: tabs[curindex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: curindex,
          backgroundColor: color,
          selectedLabelStyle: const TextStyle(color: Colors.black),
          onTap: (index) {
            setState(() {
              curindex = index;
              color = Colors.amber;
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
                MdiIcons.starThreePoints,
                color: Colors.black38,
                size: 22,
              ),
              label: "Favorites",
              activeIcon: Icon(
                MdiIcons.starThreePoints,
                color: Colors.black,
                size: 30,
              ),
            ),
          ]),
    );
  }

  Widget tile(int i) {
    bool fav = false;
    words.add((WordPair.random()));
    return ListTile(
      title: Text(words.elementAt(i).toString()),
      trailing: IconButton(
          onPressed: () {
            setState(() {
              favs.add(words.elementAt(i));
              fav = !fav;
            });
          },
          icon: favs.contains(words.elementAt(i))
              ? const Icon(MdiIcons.starBox, color: Colors.red)
              : const Icon(MdiIcons.starBox)),
    );
  }

  Widget favTile(int i) {
    return ListTile(
      title: Text(favs.elementAt(i).toString()),
      trailing: IconButton(
          onPressed: () {
            setState(() {
              favs.remove(favs.elementAt(i));
            });
          },
          icon: true
              ? Icon(MdiIcons.deleteAlert, color: Colors.red)
              : Icon(MdiIcons.starBox)),
    );
  }
}
