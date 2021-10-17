import 'package:flutter/material.dart';

class TeamListTile extends StatelessWidget {
  const TeamListTile({
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
    return ListTile(
      minVerticalPadding: 0.0,
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        height: 100,
        width: 100,
        child: Expanded(
          child: Container(
            alignment: Alignment.center,
            color: Colors.green,
          ),
        ),
      ),
      // leading: CircleAvatar(
      //   backgroundImage: NetworkImage(image),
      //   radius: 40.0,
      // ),
      title: Text(team),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(country),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
                value != null ? value.toString() + ' Millionen' : 'unbekannt'),
          )
        ],
      ),
    );
  }
}
