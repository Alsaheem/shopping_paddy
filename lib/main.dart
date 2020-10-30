import 'package:flutter/material.dart';
import 'package:shopping_paddy/widgets/add_item.dart';
import 'package:shopping_paddy/widgets/set_budget.dart';
import './widgets/budget_calculator.dart';
import './widgets/items_list.dart';
import './models/item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Paddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "Grandstander"),
      home: MyHomePage(title: 'Shopping Paddy'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Item> _marketItems = [];

  double marketBudget = 0.0;
  DateTime marketDate = DateTime.now();

  void _deleteItem(String id) {
    setState(() {
      _marketItems.removeWhere((itx) {
        return itx.id == id;
      });
    });
  }

  void _reset() {
    setState(() {
      _marketItems.clear();
      marketBudget = 0.0;
    });
  }

  void _addNewTransaction(
      String itemTitle, double itemAmount, bool itemImportance) {
    final newItem = Item(
      id: DateTime.now().toString(),
      name: itemTitle,
      amount: itemAmount,
      ifImportant: itemImportance,
    );
    setState(() {
      _marketItems.add(newItem);
    });
  }

  void _addNewBudget(newBudget) {
    setState(() {
      marketBudget = newBudget;
    });
  }

  void _startAddNewTransactionSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child: AddItem(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _startSetBudget(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child: SetBudget(_addNewBudget),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mr Market',
                    style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.indigo,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.white,
                      child: Text(
                        'M',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1550989460-0adf9ea622e2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
              trailing: Icon(
                Icons.home,
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
              trailing: Icon(
                Icons.ac_unit_sharp,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(title: Text(widget.title), actions: [
        IconButton(
          icon: Icon(Icons.reset_tv),
          onPressed: () {
            _reset();
          },
        ),
      ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BudgetCalculator(
            date: marketDate,
            budget: marketBudget,
            itemsCount: _marketItems.length.toDouble(),
          ),
          SingleChildScrollView(child: ItemList(_marketItems, _deleteItem))
        ],
      ),
      floatingActionButton: marketBudget == 0
          ? FloatingActionButton(
              onPressed: () {
                _startSetBudget(context);
              },
              tooltip: 'Set Budget',
              child: Icon(Icons.add),
            )
          : FloatingActionButton(
              onPressed: () {
                _startAddNewTransactionSheet(context);
              },
              tooltip: 'Add Market Items',
              child: Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
