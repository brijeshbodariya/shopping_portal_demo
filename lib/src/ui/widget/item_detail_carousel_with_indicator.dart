import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ItemDetailCarouselWithIndicator extends StatefulWidget {
  final List<String>? itemsArray;

  const ItemDetailCarouselWithIndicator({Key? key, @required this.itemsArray})
      : super(key: key);

  @override
  State<ItemDetailCarouselWithIndicator> createState() =>
      ItemDetailCarouselWithIndicatorState();
}

class ItemDetailCarouselWithIndicatorState
    extends State<ItemDetailCarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: widget.itemsArray!.length,
            itemBuilder: (BuildContext ctx, int itemIndex, int realIdx) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Image.network(
                      widget.itemsArray![itemIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 0.2,
                    color: Colors.grey,
                  ),
                ],
              );
            },
            options: CarouselOptions(
              height: height / 2,
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.itemsArray!.map(
              (item) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == widget.itemsArray!.indexOf(item)
                        ? const Color.fromRGBO(0, 0, 0, 0.9)
                        : const Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
