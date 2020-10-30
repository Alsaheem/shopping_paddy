import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  final Function addItem;
  AddItem(this.addItem);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  bool _checkBoxValue = false;

  void _submitData() {
    final enteredName = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    // doings
    widget.addItem(enteredName, enteredAmount, _checkBoxValue);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                controller: titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (value) => titleInput = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Price'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Is Important',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Checkbox(
                      value: _checkBoxValue,
                      onChanged: (bool value) {
                        setState(() {
                          _checkBoxValue = value;
                        });
                      }),
                ],
              ),
              RaisedButton(
                child: Text(
                  'Add Item',
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () => _submitData(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
