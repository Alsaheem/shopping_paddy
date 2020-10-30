import 'package:flutter/material.dart';

class SetBudget extends StatefulWidget {
  final Function setBudget;
  SetBudget(this.setBudget);

  @override
  _SetBudgetState createState() => _SetBudgetState();
}

class _SetBudgetState extends State<SetBudget> {
  final budgetAmountController = TextEditingController();

  void _submitData() {
    final enteredBudgetAmount = double.parse(budgetAmountController.text);
    // doings
    widget.setBudget(
      enteredBudgetAmount,
    );
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
                decoration: InputDecoration(labelText: 'Set Budget'),
                controller: budgetAmountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              RaisedButton(
                child: Text(
                  'Set Budget',
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
