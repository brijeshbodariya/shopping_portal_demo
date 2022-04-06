import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/models/product_model.dart';

class ProductSizeGridTile extends StatelessWidget {
  final ProdSizeModel? prodSize;
  final bool isSelected;
  final bool isSelectable;
  final Function? newSizeSelected;
  final double tileWidth = 55;

  const ProductSizeGridTile({
    Key? key,
    @required this.prodSize,
    this.isSelected = false,
    this.isSelectable = false,
    this.newSizeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: tileWidth,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: isSelectable ? () => newSizeSelected!(prodSize) : null,
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
                prodSize!.name!,
                style: TextStyle(
                  color: isSelected ? Colors.red : Colors.black,
                ),
              ),
            ),
          ),
          if (prodSize!.remainingQty! < 10)
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(1.5)),
                border: Border.all(color: Colors.pink, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: Text(
                '${prodSize!.remainingQty} left',
                style: const TextStyle(color: Colors.pink, fontSize: 8),
              ),
            ),
          const Spacer(),
        ],
      ),
    );
  }
}
