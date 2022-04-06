import 'package:flutter/material.dart';

class HomeScreenHotDealsListTile extends StatelessWidget {
  final String? imageName;
  final String? heading;
  final String? msg;
  final String? title;

  const HomeScreenHotDealsListTile(
      {Key? key,
      @required this.imageName,
      @required this.heading,
      @required this.msg,
      @required this.title})
      : super(key: key);

  final double totalWidth = 350;
  final double gapWidth = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: totalWidth,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2.5),
      child: Card(
        elevation: 2,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: (totalWidth - gapWidth) / 2,
              child: Image.asset(
                imageName!,
                fit: BoxFit.cover,
                height: double.infinity,
              ),
            ),
            SizedBox(
              width: gapWidth,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 1,
                          child: Container(
                            width: 30,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          heading!,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          msg!,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 1,
                          child: Container(
                            width: 30,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
