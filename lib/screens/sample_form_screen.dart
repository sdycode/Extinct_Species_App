import 'dart:math';

import 'package:extinct_animals/screens/v2_screen.dart';
import 'package:extinct_animals/screens/v3_screen.dart';
import 'package:extinct_animals/widgets/scaled_person_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:extinct_animals/models/person_model.dart';
import 'package:extinct_animals/providers/provider_data.dart';
import 'package:extinct_animals/utils/database_helper.dart';
import 'package:extinct_animals/widgets/app_drawer.dart';
import 'package:extinct_animals/widgets/person_card.dart';

class SampleFormScreen extends StatefulWidget {
  //  static final _formKey = GlobalKey<FormState>();
  int j;
  SampleFormScreen({
    Key? key,
    required this.j,
  }) : super(key: key);
  // SampleFormScreen(int j, {Key? key}) : super(key: key);

  @override
  _SampleFormScreenState createState() => _SampleFormScreenState();
}

class _SampleFormScreenState extends State<SampleFormScreen> {
  bool isLongPressed = false;
  bool closeForm = false;
  int whichVersionSelected = 1;
  bool leftClicked = false;
  bool rightClicked = false;
  int v = 0;

  @override
  void initState() {
    setState(() {
      whichVersionSelected = widget.j;
      NotesDatabase.instance.database(whichVersionSelected);
      // v = await NotesDatabase.instance.getVersionNo(whichVersionSelected);
    });

    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  final Person _person =
      Person("firstName", "lastName", "phoneNo", "mailId", "0", 0);
  List<PersonCard> persons = [];

  String first = "";
  String last = "";
  String ph = "";
  String mail = "";
  TextEditingController f = TextEditingController();
  TextEditingController l = TextEditingController();
  TextEditingController p = TextEditingController();
  TextEditingController m = TextEditingController();
  int updatingId = 0;
  @override
  Widget build(BuildContext context) {
    var providerList = Provider.of<Data>(context);

    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    FocusNode firstName = FocusNode();
    FocusNode lastName = FocusNode();
    FocusNode phone = FocusNode();
    FocusNode email = FocusNode();

    return Scaffold(
        appBar: AppBar(
          title: Text("Form " + whichVersionSelected.toString()),
        ),
        drawer: const AppDrawer(),
        body: Container(
          width: sw,
          height: sh,
          child: SafeArea(
            child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  closeForm
                      ? SizedBox(
                          height: 5,
                          child: Form(key: formKey, child: const Text("")),
                        )
                      : Container(
                          clipBehavior: Clip.none,
                          height: 4 * 70,
                          child: Form(
                            key: formKey,
                            autovalidateMode: AutovalidateMode.always,
                            child: Column(
                              children: [
                                Container(
                                  width: sw,
                                  child: TextFormField(
                                    controller: f,
                                    keyboardAppearance: Brightness.dark,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.person),
                                      hintText: 'Enter your first name',
                                      labelText: ' First Name ',
                                    ),
                                    focusNode: firstName,
                                    // autofocus: true,
                                    onSaved: (String? value) {
                                      setState(() {
                                        _person.firstName = value!;
                                      });
                                      // firstName.requestFocus(lastName);
                                      // FocusScope.of(context).requestFocus(lastName);
                                    },
                                    onFieldSubmitted: (ctx) {},
                                    validator: (String? value) {
                                      if (value != null &&
                                          value.contains(RegExp(r'\w'))) {
                                        return (value != null &&
                                                value.contains(
                                                    RegExp(r'[a-zA-Z]')) &&
                                                !value
                                                    .contains(RegExp(r'[0-9]')))
                                            ? null
                                            : "Enter characters only";
                                      }
                                      // if (value != null &&
                                      //     value.length != 10 &&
                                      //     value.contains(RegExp(r'\d'))) {
                                      //   return "Enter 10 digit no";
                                      // }
                                    },
                                  ),
                                ),
                                Container(
                                  width: sw,
                                  child: TextFormField(
                                    keyboardAppearance: Brightness.dark,
                                    keyboardType: TextInputType.name,
                                    controller: l,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.person),
                                      hintText: 'Enter your last name',
                                      labelText: 'Last Name',
                                    ),
                                    focusNode: lastName,
                                    // autofocus: true,
                                    onSaved: (String? value) {
                                      setState(() {
                                        _person.lastName = value!;
                                      });
                                      // lastName.requestFocus(phone);
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.
                                    },
                                    onFieldSubmitted: (ctx) {},
                                    validator: (String? value) {
                                      if (value != null &&
                                          value.contains(RegExp(r'\w'))) {
                                        return (value != null &&
                                                value.contains(
                                                    RegExp(r'[a-zA-Z]')) &&
                                                !value
                                                    .contains(RegExp(r'[0-9]')))
                                            ? null
                                            : "Enter characters only";
                                      }
                                    },
                                  ),
                               
                                ),
                                Container(
                                  width: sw,
                                  child: TextFormField(
                                    controller: p,
                                    keyboardAppearance: Brightness.dark,
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.person),
                                      hintText: 'Enter phone no ',
                                      labelText: 'Phone no',
                                    ),
                                    focusNode: phone,
                                    // autofocus: true,
                                    onSaved: (String? value) {
                                      setState(() {
                                        _person.phoneNo = value!;
                                      });
                                      // phone.requestFocus(email);
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.
                                    },
                                    onFieldSubmitted: (ctx) {},
                                    validator: (String? value) {
                                      if (value != null &&
                                          value.contains(RegExp(r'\D'))) {
                                        return (value != null &&
                                                value.contains(RegExp(r'\D')))
                                            ? 'Enter no only.'
                                            : null;
                                      }
                                      if (value != null &&
                                          value.length != 10 &&
                                          value.contains(RegExp(r'\d'))) {
                                        return "Enter 10 digit no";
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  width: sw,
                                  child: TextFormField(
                                    controller: m,
                                    keyboardAppearance: Brightness.dark,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.person),
                                      hintText: 'Enter your email id',
                                      labelText: 'Email id',
                                    ),
                                    focusNode: email,
                                    // autofocus: true,
                                    onSaved: (String? value) {
                                      setState(() {
                                        _person.mailId = value!;
                                      });
                                    },
                                    onFieldSubmitted: (ctx) {
                                      // focus1.requestFocus();
                                    },
                                    validator: (String? value) {
                                      if (value != null && value.isEmpty) {
                                        return null;
                                      } else {
                                        return (value != null &&
                                                !value.contains(RegExp(
                                                    r"[a-zA-Z0-9_\-\.]+[@][a-z]+[\.][a-z]{2,3}")))
                                            ? 'Enter in email format only.'
                                            : null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  Container(
                    width: sw,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              submitForm(sh, providerList);
                            },
                            child: const Text("Submit",
                                style: TextStyle(fontSize: 10))),
                        ElevatedButton(
                            onPressed: () {
                              getAll(providerList);
                            },
                            child: const Text("All",
                                style: TextStyle(fontSize: 10))),
                        isLongPressed
                            ? ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    updatePerson(providerList);
                                  });
                                },
                                child: const Text("Update",
                                    style: TextStyle(fontSize: 10)))
                            : SizedBox.shrink(),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                persons.clear();
                                providerList.clearAll();
                              });
                            },
                            child: Text(
                                "Reset " +
                                    providerList.pscards.length.toString(),
                                style: TextStyle(fontSize: 10))),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                closeForm = !closeForm;
                              });
                            },
                            child: closeForm
                                ? const Text(
                                    "Open Form",
                                    style: TextStyle(fontSize: 10),
                                  )
                                : const Text("Close Form",
                                    style: TextStyle(fontSize: 10))),
                      ],
                    ),
                  ),
                  closeForm
                      ?  personList(sh * 0.55, providerList)
                      
                      : personList(sh * 0.3, providerList),
                  Container(
                    height: 60,
                    width: sw,
                    child: true
                        ? Center()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: leftClicked
                                        ? MaterialStateProperty.all<Color>(
                                            Colors.red)
                                        : MaterialStateProperty.all<Color>(
                                            Colors.blue.shade300),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      leftClicked = true;
                                      rightClicked = false;
                                      if (whichVersionSelected == 1) {
                                        // whichVersionSelected == 2;
                                        NotesDatabase.instance.close(1);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (c) =>
                                                    SampleFormScreen(
                                                      j: 2,
                                                    )));
                                      } else if (whichVersionSelected == 2) {
                                        // whichVersionSelected = 1;
                                        NotesDatabase.instance.close(2);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (c) =>
                                                    SampleFormScreen(
                                                      j: 1,
                                                    )));
                                      }
                                    });
                                  },
                                  child: whichVersionSelected == 1
                                      ? const Text("Ver 2 ")
                                      : const Text("Ver 1 ")),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: rightClicked
                                        ? MaterialStateProperty.all<Color>(
                                            Colors.red)
                                        : MaterialStateProperty.all<Color>(
                                            Colors.blue.shade300),
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        leftClicked = false;
                                        rightClicked = true;
                                        if (whichVersionSelected == 2) {
                                          // whichVersionSelected == 3;
                                          NotesDatabase.instance.close(2);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      SampleFormScreen(
                                                        j: 3,
                                                      )));
                                        } else if (whichVersionSelected == 3) {
                                          // whichVersionSelected = 2;
                                          NotesDatabase.instance.close(3);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      SampleFormScreen(
                                                        j: 2,
                                                      )));
                                        }
                                      },
                                    );
                                  },
                                  child: whichVersionSelected == 2
                                      ? const Text("Ver 3 ")
                                      : const Text("Ver 2 "))
                            ],
                          ),
                  )
                ]),
          ),
        ));
  }

  Widget personList(double sh, Data providerList) {
    List<PersonCard> ps = providerList.pscards;
    return Container(
      height: sh,
      width: 340,
      child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 320,
              height: 50,
              child: GestureDetector(
                child: ps.elementAt(index),
                onLongPress: () {
                  print("long pressed");
                  setState(() {
                    isLongPressed = true;
                    if (ps.elementAt(index).colorPicked == true) {
                      ps.elementAt(index).colorPicked = false;
                      print(" true " +
                          ps.elementAt(index).colorPicked.toString());
                      ps.elementAt(index).setColorPicked = false;

                      print(" true " +
                          ps.elementAt(index).colorPicked.toString());
                    } else {
                      print(" false " +
                          ps.elementAt(index).colorPicked.toString());
                      ps.elementAt(index).colorPicked = false;

                      print(" false " +
                          ps.elementAt(index).colorPicked.toString());
                    }

                    FormState? form = formKey.currentState;
                    // form!.didChangeDependencies();
                    form!.setState(() {
                      f.text = ps.elementAt(index).firstName;
                      l.text = ps.elementAt(index).lastName;
                      p.text = ps.elementAt(index).phoneNo;
                      m.text = ps.elementAt(index).mailId;
                      updatingId = ps.elementAt(index).id;
                      _person.id = updatingId;
                    });
                    form.save();
                  });
                },
              ),
            );
          },
          itemCount: ps.length),

      // children: [...providerList.pscards],
    );
  }

  void submitForm(double sh, Data providerList) {
    FormState? form = formKey.currentState;
    if (form!.validate() == true) {
      form.save();
      persons.add(PersonCard(
        i: 0,
        firstName: _person.firstName,
        lastName: _person.lastName,
        phoneNo: _person.phoneNo,
        mailId: _person.mailId,
        id: DateTime.now().second.toInt() +
            DateTime.now().day.toInt() +
            DateTime.now().hour.toInt(),
        vers: whichVersionSelected,
        isFav: _person.fav == "0" ? false : true,
      ));
      _person.setId = DateTime.now().second.toInt() +
          DateTime.now().day.toInt() +
          DateTime.now().hour.toInt();
      // _person.setFirstName = DateTime.now().second.toString() +
      //     DateTime.now().day.toString() +
      //     DateTime.now().hour.toString();
      NotesDatabase.instance.database(whichVersionSelected);
      NotesDatabase.instance.createPerson(_person, whichVersionSelected);
    }
    providerList.getUpdatedPersons(whichVersionSelected);

    personList(sh, providerList);
  }

  void getAll(Data providerList) async {
    var ps = [];
    persons.clear();
    ps = await NotesDatabase.instance.getAllPersons(whichVersionSelected)
        as List<Person>;
    providerList.getUpdatedPersons(whichVersionSelected);
    for (int i = 0; i < ps.length; i++) {
      print("i = " +
          i.toString() +
          " - " +
          ps.length.toString() +
          " = " +
          ps.elementAt(i).lastName +
          " ps " +
          persons.length.toString());
      PersonCard p = PersonCard(
        i: i + 1,
        firstName: ps.elementAt(i).firstName,
        lastName: ps.elementAt(i).lastName,
        phoneNo: ps.elementAt(i).phoneNo,
        mailId: ps.elementAt(i).mailId,
        id: ps.elementAt(i).id,
        vers: whichVersionSelected,
        isFav: ps.elementAt(i).fav == "0" ? false : true,
      );
      persons.add(p);
      print("persons " + persons.length.toString());
    }
    FormState? form = formKey.currentState;
    form!.save();
  }

  void update() {
    FormState? form = formKey.currentState;
    form!.save();
  }

  void updatePerson(Data providerList) async {
    FormState? form = formKey.currentState;
    form!.save();
    await NotesDatabase.instance.update(_person, whichVersionSelected);

    providerList.getUpdatedPersons(whichVersionSelected);
    isLongPressed = false;
  }
}
