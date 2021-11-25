import 'package:extinct_animals/screens/extict_animals_birds_screen.dart';
import 'package:extinct_animals/screens/sample_form_screen.dart';
import 'package:extinct_animals/widgets/app_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants/route_path_names.dart' as routes;

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/extinct':
      print("case extincts");
      return MaterialPageRoute(
          builder: (_) => ExtinctAnimals(), settings: settings);
    case '/form':
      print("case form");
      return MaterialPageRoute(
          builder: (_) => SampleFormScreen(j: 1), settings: settings);
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          drawer: AppDrawer(),
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
