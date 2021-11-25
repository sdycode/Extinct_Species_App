import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// class MyWidget extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return  IconButton(
//       // Use the MdiIcons class for the IconData
//       icon:  const Icon(MdiIcons.sword),
//       onPressed: () { print('Using the sword'); }
//      );
//   }
// }
enum whichAnimation { rotate, fade, scale, slide }

class SampleCard extends StatefulWidget {
  String name;
  String img;
  String area;
  String wikiurl;
  SampleCard({
    Key? key,
    required this.name,
    required this.img,
    required this.area,
    required this.wikiurl,
  }) : super(key: key);

  @override
  _SampleCardState createState() => _SampleCardState();
}

class _SampleCardState extends State<SampleCard> with TickerProviderStateMixin {
  bool isVisible = false;
  bool isBlurred = true;
  bool isCircular = false;
  bool isExpanded = false;
  bool isColorBlendSelected = false;
  bool isVerticalDragBlur = false;
  var imagecolor = Colors.transparent;
  double _scaleFactor = 1;
  double _baseScaleFactor = 1;
  double dragstart = 0.000004;
  double dragend = 1.000004;
  double opacityratio = 0.9;

  whichAnimation whichanim = whichAnimation.fade;
  int anim = 1;

  List colorBlendModes = [
    BlendMode.clear,
    BlendMode.color,
    BlendMode.colorBurn,
    BlendMode.colorDodge,
    BlendMode.darken,
    BlendMode.difference,
    BlendMode.dstATop,
  ];
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

  int colorslidervalue = 0;
  int blendslidervalue = 0;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  late final AnimationController fadeController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
      reverseDuration: Duration(seconds: 2));
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  late final rotateController = AnimationController(
    duration: const Duration(seconds: 4),
    reverseDuration: Duration(microseconds: 1000),
    vsync: this,
  );

  late final rotateAnimation = CurvedAnimation(
    parent: rotateController,
    curve: Curves.elasticOut,
  );

  late final fadeAnimation =
      Tween(begin: 0.0, end: 1.0).animate(fadeController);

  late final AnimationController slideController = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> slideAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: slideController,
    curve: Curves.elasticIn,
  ));

  late final AnimationController scaleController = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> scaleAnimation = CurvedAnimation(
    parent: scaleController,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    // _controller.dispose();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.name +
                  "-" +
                  colorslidervalue.toString() +
                  "-" +
                  blendslidervalue.toString(),
              overflow: TextOverflow.fade,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            isBlurred
                ? GestureDetector(
                    onVerticalDragStart: (drag) {
                      setState(() {
                        dragstart = drag.localPosition.dy;
                      });
                    },
                    onVerticalDragUpdate: (drag) {
                      setState(() {
                        dragend = drag.localPosition.dy;
                        if (dragend > dragstart) {
                          dragend -= dragstart;
                        } else {
                          dragend = dragstart - dragend;
                        }
                        if ((dragend / 200) > 1.0) {
                          opacityratio = 1.0;
                        } else {
                          opacityratio = dragend / 200;
                        }
                      });
                    },
                    onDoubleTap: () {
                      setState(() {
                        print("is cirlcuar " + isCircular.toString());
                        isCircular = !isCircular;
                      });
                    },
                    onScaleStart: (details) {
                      _baseScaleFactor = _scaleFactor;
                    },
                    onScaleUpdate: (details) {
                      setState(() {
                        _scaleFactor = _baseScaleFactor * details.scale;
                      });
                    },
                    onScaleEnd: (details) {
                      // return to initial scale
                      // _scaleFactor = _baseScaleFactor;
                    },
                    child: anim == 1
                        ? rotateImage()
                        : (anim == 3
                            ? scaledImage()
                            : (anim == 2
                                ? fadeImage()
                                : (anim == 4
                                    ? slideImae()
                                    : noAnimationImage()))),
                  )
                : Container(
                    height: 165,
                    child: getImageFromNetwork(widget.img),
                    //   SizeTransition(
                    //   sizeFactor: _animation,
                    //   axis: Axis.horizontal,
                    //   axisAlignment: -1,
                    //   child: Icon(Icons.ice_skating,size:150)

                    // ),
                  ),
            // Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: 170,
            //     child: Image.network(widget.img, fit: BoxFit.fill)),
            Container(
              width: MediaQuery.of(context).size.width,
              child: isExpanded
                  ? (isColorBlendSelected
                      ? sliderBox(true, colors.length, context)
                      : sliderBox(false, colorBlendModes.length, context))
                  : Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // isExpanded = !isExpanded;
                            });
                            showSliderinBottomSheet();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              width: 50,
                              child: Text(
                                widget.area
                                    .substring(0, min(widget.area.length, 6)),
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    splashColor: Colors.red,
                                    alignment: Alignment.centerRight,
                                    onPressed: () {
                                      setState(() {
                                        isBlurred = !isBlurred;
                                      });
                                    },
                                    icon:
                                        const Icon(Icons.wifi_protected_setup)),
                                IconButton(
                                    onPressed: () {
                                      searchOnGoogle(widget.name, context);
                                    },
                                    icon: const Icon(MdiIcons.googleChrome)),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVerticalDragBlur =
                                            !isVerticalDragBlur;
                                      });
                                    },
                                    icon: Icon(isVerticalDragBlur
                                        ? MdiIcons.blur
                                        : MdiIcons.blurOff))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    splashColor: Colors.purple,
                                    splashRadius: 20,
                                    alignment: Alignment.centerRight,
                                    onPressed: () {
                                      showAnimatedOptionsinBottomSheet();
                                    },
                                    icon: const Icon(
                                      MdiIcons.balloon,
                                      color: Colors.deepPurple,
                                    )),
                                IconButton(
                                    splashColor: Colors.redAccent,
                                    alignment: Alignment.centerRight,
                                    onPressed: () {
                                      openYoutube(widget.name, context);
                                    },
                                    icon: const Icon(
                                      MdiIcons.youtube,
                                      color: Colors.red,
                                    )),
                                IconButton(
                                    splashColor: Colors.yellow,
                                    alignment: Alignment.centerRight,
                                    onPressed: () {
                                      openWiki(widget.wikiurl);
                                    },
                                    icon: const Icon(MdiIcons.wikipedia))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void openWiki(String wikiurl) async {
    // await canLaunch(wikiurl)
    //     ? await launch(wikiurl)
    //     : throw 'Could not launch $wikiurl';
    showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            elevation: 20,
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
                height: 500,
                child: Column(
                  children: [
                    Container(
                      height: 450,
                      child: WebView(
                        initialUrl: wikiurl,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("close"))
                  ],
                )),
          );
        });
  }

  void searchOnGoogle(String name, BuildContext context) async {
    String _url = "https://www.google.com/search?q=$name";
    // await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
    showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            elevation: 20,
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
                height: 500,
                child: Column(
                  children: [
                    Container(
                      height: 450,
                      child: WebView(
                        initialUrl: _url,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("close"))
                  ],
                )),
          );
        });
  }

  void openYoutube(String name, BuildContext context) {
    String _url = "https://www.youtube.com/results?search_query=$name";
    String u = "https://www.youtube.com/watch?v=RA-vLF_vnng";
    // await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
    showDialog(
        context: context,
        builder: (ctx) {
          return SafeArea(
            child: Dialog(
              elevation: 20,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: SafeArea(
                child: Container(
                    child: Column(
                  children: [
                    SafeArea(
                      maintainBottomViewPadding: true,
                      bottom: true,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 200,
                          maxHeight: 510,
                        ),
                        child: Flexible(
                          child: WebView(
                            zoomEnabled: true,
                            initialUrl: _url,
                            javascriptMode: JavascriptMode.unrestricted,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("close"))
                  ],
                )),
              ),
            ),
          );
        });
  }

  Widget getImageFromNetwork(String img) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.network(
          img,
          fit: BoxFit.fill,
          semanticLabel: "jjjj",
          loadingBuilder: (context, child, progress) {
            return progress == null
                ? child
                : const LinearProgressIndicator(
                    value: 50,
                    backgroundColor: Colors.yellow,
                  );
          },
        ),
        Center(
          child: ClipRect(
            // <-- clips to the 200x200 [Container] below
            child: BackdropFilter(
              filter: ImageFilter.blur(
                tileMode: TileMode.mirror,
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                child: const Text(''),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget sliderBox(
    bool isColorBlend,
    int divisions,
    BuildContext context,
  ) {
    int selectedvalue = 0;
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
              mouseCursor: MouseCursor.defer,
              onChanged: (double v) {
                setState(() {
                  selectedvalue = v.round();
                  if (isColorBlend) {
                    colorslidervalue = selectedvalue;
                  } else {
                    blendslidervalue = selectedvalue;
                  }
                });
              },
              value: selectedvalue.toDouble(),
              min: 0.0,
              max: divisions.toDouble() - 1.0,
              divisions: divisions,
              label: isColorBlend
                  ? "Color - " + colorslidervalue.toString()
                  : "Blend - " + blendslidervalue.toString()),
        ),
        Text(isColorBlend
            ? colorslidervalue.toString()
            : blendslidervalue.toString()),
        IconButton(
            onPressed: () {
              setState(() {
                if (isColorBlend) {
                  colorslidervalue = 0;
                } else {
                  blendslidervalue = 0;
                }
                isExpanded = false;
              });
            },
            icon: const Icon(Icons.close)),
        SafeArea(child: Text(isColorBlend ? "Color" : "Blend")),
      ],
    ));
  }

  void showSliderinBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // decoration: BoxDecoration(
          //   shape: BoxShape.rectangle,
          //   borderRadius: BorderRadius.circular(10),
          //   color: Colors.red,
          //   border: Border.all(color: Colors.black, width: 3),
          // ),
          height: 130,
          color: Colors.white24,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                sliderBox(true, colors.length, context),
                sliderBox(false, colorBlendModes.length, context),
              ],
            ),
          ),
        );
      },
    );
  }

  void showAnimatedOptionsinBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // decoration: BoxDecoration(
          //   shape: BoxShape.rectangle,
          //   borderRadius: BorderRadius.circular(10),
          //   color: Colors.red,
          //   border: Border.all(color: Colors.black, width: 3),
          // ),
          height: 100,
          color: Colors.white24,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Animation",
                  textAlign: TextAlign.center,
                  style: textStyle(30),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          anim = 1;
                          Navigator.pop(context);
                          rotateController.resync(this);
                          rotateController.reverse();
                          rotateController.forward();
                        });
                      },
                      child: Text(
                        "Rotate",
                        style: textStyle(20),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          anim = 2;
                            Navigator.pop(context);
                          fadeController
                              .forward()
                              .then((value) => fadeController.repeat());
                          // fadeController.reverse();
                        });
                      },
                      child: Text(
                        "Fade",
                        style: textStyle(20),
                      ),
                    )
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // _scaleFactor = 1.6;
                          anim = 3;
                          scaleController.forward();
                            Navigator.pop(context);
                            
                          
                        });
                      },
                      child: Text(
                        "Scale",
                        style: textStyle(20),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                           Navigator.pop(context);
                          anim = 4;
                          slideController.forward();
                        });
                      },
                      child: Text(
                        "Slide",
                        style: textStyle(20),
                      ),
                    )
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  
  }

  TextStyle textStyle(double s) {
    return TextStyle(fontSize: s);
  }

  Widget rotateImage() {
    return RotationTransition(
      turns: rotateAnimation,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 165,
          child: InkWell(
            splashColor: Colors.red,
            hoverColor: Colors.yellow,
            child: Card(
                clipBehavior: Clip.antiAlias,
                shape: isCircular ? CircleBorder() : RoundedRectangleBorder(),
                child: Opacity(
                  opacity: isVerticalDragBlur ? opacityratio : 1.0,
                  child: Image.network(widget.img,
                      fit: BoxFit.fitHeight,
                      color: colorslidervalue == 0
                          ? null
                          : colors.elementAt(colorslidervalue),
                      colorBlendMode: blendslidervalue == 0
                          ? BlendMode.clear
                          : colorBlendModes.elementAt(blendslidervalue)),
                )),
          )),
    );
  }


  // Widget showRotateinCurves(){

  // }

  Widget noAnimationImage() {
    return Transform.scale(
      scale: _scaleFactor,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 165,
          child: InkWell(
            splashColor: Colors.red,
            hoverColor: Colors.yellow,
            child: Card(
                clipBehavior: Clip.antiAlias,
                shape: isCircular ? CircleBorder() : RoundedRectangleBorder(),
                child: Opacity(
                  opacity: isVerticalDragBlur ? opacityratio : 1.0,
                  child: Image.network(widget.img,
                      fit: BoxFit.fitHeight,
                      color: colorslidervalue == 0
                          ? null
                          : colors.elementAt(colorslidervalue),
                      colorBlendMode: blendslidervalue == 0
                          ? BlendMode.clear
                          : colorBlendModes.elementAt(blendslidervalue)),
                )),
          )),
    );
  }

  Widget slideImae() {
    return SlideTransition(
      position: slideAnimation,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 165,
          child: InkWell(
            splashColor: Colors.red,
            hoverColor: Colors.yellow,
            child: Card(
                clipBehavior: Clip.antiAlias,
                shape: isCircular ? CircleBorder() : RoundedRectangleBorder(),
                child: Opacity(
                  opacity: isVerticalDragBlur ? opacityratio : 1.0,
                  child: Image.network(widget.img,
                      fit: BoxFit.fitHeight,
                      color: colorslidervalue == 0
                          ? null
                          : colors.elementAt(colorslidervalue),
                      colorBlendMode: blendslidervalue == 0
                          ? BlendMode.clear
                          : colorBlendModes.elementAt(blendslidervalue)),
                )),
          )),
    );
  }

  Widget fadeImage() {
    return FadeTransition(
      opacity: fadeAnimation,
      child: Transform.scale(
        scale: _scaleFactor,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 165,
            child: InkWell(
              splashColor: Colors.red,
              hoverColor: Colors.yellow,
              child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: isCircular ? CircleBorder() : RoundedRectangleBorder(),
                  child: Opacity(
                    opacity: 1.0,
                    child: Image.network(
                      widget.img,
                      fit: BoxFit.fitHeight,
                    ),
                  )),
            )),
      ),
    );
  }

  Widget scaledImage() {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 165,
          child: InkWell(
            splashColor: Colors.red,
            hoverColor: Colors.yellow,
            child: Card(
                clipBehavior: Clip.antiAlias,
                shape: isCircular ? CircleBorder() : RoundedRectangleBorder(),
                child: Opacity(
                  opacity: isVerticalDragBlur ? opacityratio : 1.0,
                  child: Image.network(widget.img,
                      fit: BoxFit.fitHeight,
                      color: colorslidervalue == 0
                          ? null
                          : colors.elementAt(colorslidervalue),
                      colorBlendMode: blendslidervalue == 0
                          ? BlendMode.clear
                          : colorBlendModes.elementAt(blendslidervalue)),
                )),
          )),
    );
  }
}
