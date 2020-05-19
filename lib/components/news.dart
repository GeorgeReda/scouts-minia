import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:scouts_minia/routes/news_page.dart';

class NewsSections extends StatelessWidget {
  final List<String> _text = [
    'أخبار مجموعاتنا',
    'أخبار الأمانة العامة',
    'أخبار محلية و دولية'
  ];
  final List<IconData> _icons = [
    FontAwesomeIcons.users,
    FontAwesomeIcons.freeCodeCamp,
    FontAwesomeIcons.globe
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _ButtonContent(
            text: _text[0],
            icon: _icons[0],
          ),
          SizedBox(height: 15),
          _ButtonContent(
            text: _text[1],
            icon: _icons[1],
          ),
          SizedBox(height: 15),
          _ButtonContent(
            text: _text[2],
            icon: _icons[2],
          ),
        ],
      ),
    );
  }
}

class _ButtonContent extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ButtonContent({Key key, @required this.icon, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FaIcon(
                  icon,
                  color: Colors.white,
                  size: 50,
                ),
                SizedBox(width: 15),
                Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 32),
                )
              ],
            ),
            onPressed: () => Get.to(NewsPage(pageName: text, pageIcon: icon))));
  }
}
