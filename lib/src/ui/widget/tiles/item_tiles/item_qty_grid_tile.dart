import 'package:flutter/material.dart';

class ItemQtyGridTile extends StatelessWidget {
  final int? itemQty;
  final bool isSelected;
  final bool isSelectable;
  final Function? newQtySelected;

  final double tileWidth = 55;

  const ItemQtyGridTile({
    Key? key,
    @required this.itemQty,
    this.isSelected = false,
    this.isSelectable = false,
    this.newQtySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: tileWidth,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: isSelectable ? () => newQtySelected!(itemQty) : null,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular((tileWidth - 10) / 2),
                ),
                border: Border.all(
                  color: isSelected ? Colors.red : Colors.black,
                  width: 0.8,
                ),
              ),
              alignment: Alignment.center,
              width: tileWidth - 10,
              height: tileWidth - 10,
              child: Text(
                '$itemQty',
                style: TextStyle(
                  color: isSelected ? Colors.red : Colors.black,
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
