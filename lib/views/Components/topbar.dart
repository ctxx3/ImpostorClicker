import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:impostor_clicker/classes/character_class.dart';

Widget uiButton(IconData icon, void Function() onclick) {
  return SizedBox.fromSize(
    size: const Size(50, 50),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            splashColor: Colors.green,
            onTap: onclick,
            child: Icon(
              icon,
              size: 30,
              color: const Color(0xffb9970b),
            )),
      ),
    ),
  );
}

Widget topBar(int lvl, num xp, num max, Color col) {
  return Container(
    margin: const EdgeInsets.only(top: 10, bottom: 10),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        children: [uiButton(FontAwesomeIcons.dumpsterFire, () {})],
      ),
      Column(
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 25,
                  color: Color(0xffffffff),
                  fontFamily: 'SansPro',
                  fontWeight: FontWeight.w300),
              children: <TextSpan>[
                const TextSpan(text: 'LVL '),
                TextSpan(
                  text: '$lvl',
                  style: TextStyle(color: col, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 6),
              width: 100,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: LinearProgressIndicator(
                    color: col.withAlpha(200),
                    backgroundColor: const Color.fromARGB(127, 0, 0, 0),
                    value: (xp / max),
                    minHeight: 10,
                  ))),
        ],
      ),
      Column(
        children: [uiButton(FontAwesomeIcons.sliders, () {})],
      )
    ]),
  );
}

Widget star(Color col) {
  return Container(
      margin: const EdgeInsets.only(right: 5),
      child: Icon(
        FontAwesomeIcons.solidStar,
        color: col,
        size: 22,
        //shadows: [Shadow(color: Color(0xaf000000), offset: Offset(-3, 3))],
      ));
}

Widget title(
    String name, String tier, int stars, Color starCol, Color tierCol) {
  return Container(
    margin: const EdgeInsets.only(top: 5, bottom: 5),
    child: Column(children: [
      SizedBox(
          height: 22,
          child: Row(
            children: List<Widget>.generate(stars, (index) => star(starCol)),
          )),
      Row(children: [
        Container(
            margin: const EdgeInsets.only(top: 10, bottom: 0),
            child: Text(
              name,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xffffffff),
                fontSize: 34,
                fontFamily: 'SansPro',
                fontWeight: FontWeight.w600,
              ),
            ))
      ]),
      Row(children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 26.0,
                  fontFamily: 'SansPro',
                  fontWeight: FontWeight.w300,
                  color: Color(0x5fffffff),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '$tier ',
                    style:
                        TextStyle(color: tierCol, fontWeight: FontWeight.w600),
                  ),
                  const TextSpan(text: 'Impostor')
                ],
              ),
            ))
      ]),
    ]),
  );
}

Widget ibutton(IconData icon, String text) {
  return SizedBox.fromSize(
    size: const Size(56, 66),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Material(
        color: const Color(0x00b9970b),
        child: InkWell(
          splashColor: Colors.green,
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                icon,
                color: const Color(0xffffffff),
              ),
              Text(text,
                  style: const TextStyle(
                      color: Color(0x4fffffff),
                      fontFamily: 'SansPro',
                      fontSize: 18,
                      fontWeight: FontWeight.w300)),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget impostorTile(
    int id, String asset, String title, String lvl, void Function(int id) onTap,
    {bool dark = false}) {
  return SizedBox(
      height: 50,
      child: Card(
        color: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            side:
                BorderSide(width: 1, color: Color.fromARGB(235, 211, 62, 86))),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Material(
            color: Colors.transparent,
            //color: (!dark) ? const Color(0xff1d2029) : Colors.transparent,
            child: InkWell(
                splashColor: Colors.green,
                onTap: () {
                  onTap(id - 1);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Text(id.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'SansPro',
                                      color: Color(0xff6f7485),
                                      fontSize: 18))),
                          Image.asset(asset),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            width: 140,
                            child: Text(
                              title,
                              style: const TextStyle(
                                color: Color(0xff6f7485),
                                fontFamily: 'SansPro',
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      Text("LVL $lvl",
                          style: const TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 16,
                              fontFamily: 'SansPro',
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                )),
          ),
        ),
      ));
}

List<Column> list = [];
Widget impostorList(List<Character> impostors, void Function(int id) onTap) {
  ScrollController sc = ScrollController();

  if (list.isEmpty) {
    List<Widget> tempList = [];
    for (var i = 0; i < impostors.length; i++) {
      tempList.add(impostorTile(i + 1, impostors[i].sprite, impostors[i].name,
          '${impostors[i].level}', onTap));
      if (i % 2 == 0 && i != 0) {
        list.add(Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.from(tempList)));
        tempList = [];
      }
    }
    if (tempList.length == 2) {
      tempList.add(const SizedBox(width: 300, height: 50));
    } else if (tempList.length == 1) {
      tempList.add(const SizedBox(width: 300, height: 50));
      tempList.add(const SizedBox(width: 300, height: 50));
    }
    if (tempList.isNotEmpty) {
      list.add(Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: tempList));
      tempList = [];
    }
  }

  return Column(
    children: [
      Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        alignment: Alignment.centerLeft,
        child: RichText(
          text: const TextSpan(
            style: TextStyle(
                fontSize: 20,
                color: Color(0xffffffff),
                fontFamily: 'SansPro',
                fontWeight: FontWeight.w300),
            children: <TextSpan>[
              TextSpan(
                text: 'Impostors  ',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: 'your collection',
                style: TextStyle(color: Color(0x4fffffff)),
              )
            ],
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 160,
        child: Scrollbar(
          controller: sc,
          child: ListView(
            controller: sc,
            physics: const BouncingScrollPhysics(),
            children: list,
          ),
        ),
      )
    ],
  );
}
