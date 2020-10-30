import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemList extends StatelessWidget {
  final List<Item> marketItems;
  final Function deleteItem;
  ItemList(this.marketItems, this.deleteItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Theme.of(context).primaryColorLight,
      padding: const EdgeInsets.all(8.0),
      child: marketItems.length <= 0
          ? Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                'No Items Added Yet !',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 45,fontWeight: FontWeight.w900),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 8,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: marketItems[index].ifImportant
                          ? Text(
                              'A',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          : Text(
                              'B',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                    ),
                    title: Text(marketItems[index].name),
                    subtitle: Text(
                      '₦${marketItems[index].amount}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: GestureDetector(
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: () {
                        deleteItem(marketItems[index].id.toString());
                      },
                    ),
                  ),
                );
              },
              itemCount: marketItems.length),
    );
  }
}
