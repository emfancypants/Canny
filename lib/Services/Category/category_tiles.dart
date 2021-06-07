import 'package:Canny/Database/all_database.dart';
import 'package:Canny/Models/expense.dart';
import 'package:Canny/Services/Category/category_database.dart';
import 'package:Canny/Services/Category/default_categories.dart';
import 'package:Canny/Services/Receipt/receipt_database.dart';
import 'package:Canny/Shared/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryTile extends StatefulWidget {
  final String categoryName;
  final int categoryColorValue;
  final int categoryIconCodePoint;
  final String categoryFontFamily;
  final String categoryFontPackage;
  final String categoryId;
  final double categoryAmount;
  final bool isIncome;
  final bool tappable;

  CategoryTile({
    this.categoryName,
    this.categoryColorValue,
    this.categoryIconCodePoint,
    this.categoryFontFamily,
    this.categoryFontPackage,
    this.categoryId,
    this.categoryAmount,
    this.isIncome,
    this.tappable,
  });

  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {

  final _formKey = GlobalKey<FormState>();
  final CategoryDatabaseService _authCategory = CategoryDatabaseService();
  final CollectionReference expenseCollection = Database().expensesDatabase();
  final ReceiptDatabaseService _authReceipt = ReceiptDatabaseService();
  final int categoriesSize = defaultCategories.length;

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    void _editCatPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                    children: <Widget>[
                      Text(
                        'Update your category color',
                        style: TextStyle(
                            fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 260,
                        height: 260,
                        child: BlockPicker(
                          pickerColor: currentColor,
                          onColorChanged: changeColor,
                        ),
                      ),
                      SizedBox(
                          height: 10
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() => currentColor = pickerColor);
                          _authCategory.updateCategoryColor(
                              widget.categoryId,
                              currentColor);
                          Navigator.of(context).pop();
                        },
                        child: Text("Update",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: kDeepOrangeLight
                        ),
                      ),
                    ]
                )
            )
        );
      });
    }
    return Card(
      color: Colors.white.withOpacity(0.9),
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      child: ListTile(
        contentPadding: EdgeInsets.all(10.0),
        title: Text(
          widget.categoryName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[900],
          ),
        ),
        onTap: widget.tappable
            ? () => Navigator.pop(context,
            {'categoryId': int.parse(widget.categoryId) < 10
                ? '0' + widget.categoryId
                : widget.categoryId,
              'categoryName': widget.categoryName,
              'isIncome': widget.isIncome,
              'categoryColorValue': widget.categoryColorValue,
              'categoryIconCodePoint': widget.categoryIconCodePoint,
              'categoryFontFamily': widget.categoryFontFamily,
              'categoryFontPackage': widget.categoryFontPackage,
            })
            : null,
        leading: CircleAvatar(
          backgroundColor: Color(widget.categoryColorValue).withOpacity(0.1),
          radius: 30,
          child: IconTheme(
              data: IconThemeData(color: Color(widget.categoryColorValue).withOpacity(1), size: 25),
              child: Icon(IconData(widget.categoryIconCodePoint,
                  fontFamily: widget.categoryFontFamily,
                  fontPackage: widget.categoryFontPackage)
              )
          ),
        ),
        trailing: Visibility(
          visible: !widget.tappable,
          child: Container(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget> [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editCatPanel();
                  },
                ),
                Visibility(
                  visible: int.parse(widget.categoryId) >= categoriesSize,
                  child: StreamBuilder(
                    stream: expenseCollection.snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return IconButton(
                            icon: Icon(FontAwesomeIcons.trashAlt),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder:
                                    (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Are you sure you want to delete " + widget.categoryName + "?"),
                                    content: Text("Once it is deleted, you will not be able "
                                        "to retrieve it back. Your expenses for " + widget.categoryName +
                                        " will be moved to Others."),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      TextButton(
                                        child: Text("Yes"),
                                        onPressed: () async {
                                          await _authCategory.removeCategory(widget.categoryId, widget.categoryAmount);
                                          for (int i = 0; i < snapshot.data.docs.length; i++) {
                                            if (snapshot.data.docs[i]['categoryId'] == widget.categoryId) {
                                              await _authReceipt.changeCategoryToOthers(snapshot.data.docs[i].id);
                                            }
                                          }
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                        );
                      }
                      return Icon(FontAwesomeIcons.trashAlt);
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
