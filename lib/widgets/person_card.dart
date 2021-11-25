import 'package:extinct_animals/models/person_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:extinct_animals/providers/provider_data.dart';
import 'package:extinct_animals/screens/sample_form_screen.dart';
import 'package:extinct_animals/utils/database_helper.dart';

class PersonCard extends StatefulWidget {
  int i;
  int id;
  int vers;
  String firstName;
  String lastName;
  String phoneNo;
  String mailId;
  bool colorPicked;
  bool isFav;
  get getColorPicked => this.colorPicked;

  set setColorPicked(bool colorPicked) => this.colorPicked = colorPicked;
  PersonCard({
    Key? key,
    required this.i,
    required this.id,
    required this.vers,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.mailId,
    required this.isFav,
    this.colorPicked = false,
  }) : super(key: key);

  @override
  _PersonCardState createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> with ChangeNotifier {
  var color = Colors.grey;
  bool redPicked = false;


  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var providerList = Provider.of<Data>(context);
    return Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text((widget.i + 1).toString()),
            Container(
              width: 210,
              child: Card(
                elevation: 5,
                color: widget.colorPicked ? Colors.red : null,
                margin: const EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.firstName,
                          style: const TextStyle(fontSize: 10),
                        ),
                        Text(
                          widget.lastName,
                          style: const TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.phoneNo,
                          style: const TextStyle(fontSize: 10),
                        ),
                        Text(
                          widget.mailId,
                          style: const TextStyle(fontSize: 10),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(()  {
                    widget.isFav = !widget.isFav;
                  });
                  Person p =
                      Person(widget.firstName, widget.lastName, widget.phoneNo, widget.mailId, widget.isFav ?"1":"0" , widget.id);
                  NotesDatabase.instance.update(p, 1);
                  providerList.getUpdatedPersons(widget.vers);
                  notifyListeners();
                },
                icon: widget.isFav
                    ? const Icon(
                        Icons.star_rate_rounded,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.star_outline,
                        color: Colors.grey,
                      )),
            IconButton(
                onPressed: () {
                  NotesDatabase.instance.delete(widget.id, widget.vers);

                  providerList.getUpdatedPersons(widget.vers);
                  notifyListeners();
                },
                icon: const Icon(Icons.delete_forever))
          ],
        ));
  }

  void setColor() {
    setState(() {
      widget.colorPicked = !widget.colorPicked;
      if (widget.colorPicked) {
        color = Colors.red;
        print("red picked");
      } else {
        color = Colors.grey;
      }
    });
  }
}
