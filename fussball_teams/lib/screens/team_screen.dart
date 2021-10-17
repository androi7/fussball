import 'package:flutter/material.dart';
import 'package:fussball_teams/utilities/team_helpers.dart';

class TeamScreen extends StatelessWidget {
  static const id = '/team-seite';

  const TeamScreen({
    Key? key,
    required this.team,
    required this.country,
    required this.image,
    required this.value,
  }) : super(key: key);
  final String team;
  final String country;
  final String image;
  final int? value;

  String get _erhalteMarktwert =>
      TeamHelpers.erhalteMarktwert(value: value, withCurrency: true);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(team),
      ),
    );
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final top = mediaQuery.padding.top;
    final remainingPageHeight = size.height - top - appBar.preferredSize.height;
    final imageContainerHeight = remainingPageHeight * 1 / 3;
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Column(children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(
              width: double.infinity,
              height: remainingPageHeight * 1 / 3,
            ),
            color: const Color.fromRGBO(51, 51, 51, 1.0),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Image(
                    image: NetworkImage(image),
                    height: imageContainerHeight * 2 / 3,
                  ),
                ),
                Positioned(
                  child: Text(
                    country,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.white),
                  ),
                  bottom: 10,
                  left: 10,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText1!,
                  children: <InlineSpan>[
                    const TextSpan(text: 'Der Club '),
                    TextSpan(
                      text: team,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ' aus $country hat einen Wert von $_erhalteMarktwert.',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
