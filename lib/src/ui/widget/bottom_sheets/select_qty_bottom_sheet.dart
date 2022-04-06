import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/ui/widget/tiles/item_tiles/item_qty_grid_tile.dart';

class SelectQtyBottomSheet extends StatefulWidget {
  final int? selectedQty;
  final Function? doneBtnClickedWithNewQty;

  const SelectQtyBottomSheet(
      {Key? key,
      @required this.selectedQty,
      @required this.doneBtnClickedWithNewQty})
      : super(key: key);

  @override
  _SelectQtyBottomSheetState createState() => _SelectQtyBottomSheetState();
}

class _SelectQtyBottomSheetState extends State<SelectQtyBottomSheet> {
  final qtyArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  int? _newSelectedQty;

  void newQtySelected(int newSize) {
    setState(() {
      _newSelectedQty = newSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text(
                    'Select Quantity',
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 55,
                child: ListView.builder(
                  itemBuilder: (ctx, index) => ItemQtyGridTile(
                    itemQty: qtyArray[index],
                    isSelected: _newSelectedQty != null
                        ? qtyArray[index] == _newSelectedQty
                        : qtyArray[index] == widget.selectedQty,
                    isSelectable: true,
                    newQtySelected: newQtySelected,
                  ),
                  itemCount: qtyArray.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.white,
                child: TextButton(
                  onPressed: () {
                    widget.doneBtnClickedWithNewQty!(
                        _newSelectedQty ?? widget.selectedQty);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'DONE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
