import 'package:flutter/material.dart';
import 'package:fussball_teams/models/sprache_provider.dart';
import 'package:fussball_teams/utilities/team_helpers.dart';
import 'package:provider/provider.dart';

import '../screens/team_screen.dart';

class TeamCard extends StatelessWidget {
  const TeamCard({
    Key? key,
    required this.image,
    required this.team,
    required this.country,
    required this.value,
  }) : super(key: key);
  final String image;
  final String team;
  final String country;
  final int? value;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      child: _buildListTile(context, size, textTheme),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TeamScreen(
              team: team,
              country: country,
              image: image,
              value: value,
            ),
          ),
        );
      },
    );
  }

  Padding _buildListTile(BuildContext context, Size size, TextTheme textTheme) {
    final sprache = Provider.of<SpracheProvider>(context).erhalteSprache;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: SizedBox(
        height: size.height * 0.1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.jpeg',
              image: image,
              imageErrorBuilder: (context, error, st) {
                return Container();
              },
              width: size.height * 0.1,
              fit: BoxFit.contain,
            ),
            // Image(
            //   image: NetworkImage(image),
            //   width: size.height * 0.1,
            //   height: size.height * 0.1,
            //   fit: BoxFit.cover,
            // ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(team, style: textTheme.headline3),
                  Text(country, style: textTheme.subtitle2),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      TeamHelpers.erhalteMarktwert(
                          sprache: sprache,
                          value: value), // _erhalteMarktwert(),
                      style: textTheme.subtitle1,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
