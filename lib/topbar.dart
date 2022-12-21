import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

Widget topBar = Container(
  margin: const EdgeInsets.only(top: 10, bottom: 10),
  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Column(
      children: [uiButton(FontAwesomeIcons.dumpsterFire, () {})],
    ),
    Column(
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(
                fontSize: 25,
                color: Color(0xffffffff),
                fontFamily: 'SansPro',
                fontWeight: FontWeight.w300),
            children: <TextSpan>[
              TextSpan(text: 'LVL '),
              TextSpan(
                text: '278',
                style:
                    TextStyle(color: Colors.cyan, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 6),
            width: 100,
            child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: LinearProgressIndicator(
                  color: Color.fromARGB(200, 0, 188, 212),
                  backgroundColor: Color.fromARGB(127, 0, 0, 0),
                  value: .4,
                  minHeight: 10,
                ))),
      ],
    ),
    Column(
      children: [uiButton(FontAwesomeIcons.sliders, () {})],
    )
  ]),
);

Widget star = Container(
    margin: const EdgeInsets.only(right: 5),
    child: const Icon(
      FontAwesomeIcons.solidStar,
      color: Color(0xffaa4261),
      //shadows: [Shadow(color: Color(0xaf000000), offset: Offset(-3, 3))],
    ));

Widget title(String name, String tier, int stars) {
  return Container(
    margin: const EdgeInsets.only(top: 10, bottom: 5),
    child: Column(children: [
      Row(
        children: List<Widget>.generate(stars, (index) => star),
      ),
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
                    style: const TextStyle(
                        color: Color.fromARGB(235, 211, 62, 86),
                        fontWeight: FontWeight.w600),
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

Widget impostorTile(int id, String asset, String title, String lvl,
    {bool dark = false}) {
  return SizedBox.fromSize(
      size: const Size(300, 47),
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
                onTap: () {},
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
                          Image.asset(
                            'assets/amogus.png',
                          ),
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

Widget impostorList() {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
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
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      impostorTile(1, "", "The Real Sus", "278"),
                      impostorTile(2, "", "Suprime Sus", "244", dark: true),
                      impostorTile(3, "", "Mikosłaf", "208"),
                    ])),
            Container(
                margin: const EdgeInsets.only(right: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      impostorTile(4, "", "Huggy Waggy", "175", dark: true),
                      impostorTile(5, "", "Venter", "173"),
                      impostorTile(6, "", "Obama", "112", dark: true),
                    ])),
            Container(
                margin: const EdgeInsets.only(right: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      impostorTile(7, "", "Basic sus", "32"),
                      impostorTile(8, "", "First Impostor", "5", dark: true),
                      const SizedBox(height: 47)
                    ])),
          ],
        ),
      )
    ],
  );
}
