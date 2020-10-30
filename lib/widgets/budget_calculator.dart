import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class BudgetCalculator extends StatefulWidget {
  final double budget;
  final DateTime date;
  final double itemsCount;

  BudgetCalculator({
    @required this.budget,
    @required this.date,
    this.itemsCount,
  });

  @override
  _BudgetCalculatorState createState() => _BudgetCalculatorState();
}

class _BudgetCalculatorState extends State<BudgetCalculator> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(); // Create instance.
  String timer;
  bool isTimerRunning = false;
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) {
      print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}');
      setState(() {
        timer = StopWatchTimer.getDisplayTime(value);
      });
    });

    // _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    // _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    // _stopWatchTimer.records.listen((value) => print('records $value'));

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
      width: double.infinity,
      height: 200,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Total Budget : ₦ ${oCcy.format(widget.budget)}',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.w3schools.com/howto/img_avatar.png'),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Date : ${DateFormat.yMMMd().format(widget.date)}',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Number Of Items : ${widget.itemsCount.toInt()}',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Timer : ${timer} ',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.indigo,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0))),
                    child: isTimerRunning == true
                        ? GestureDetector(
                            onTap: () {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.stop);
                              setState(() {
                                isTimerRunning = false;
                              });
                            },
                            child: Text(
                              'Stop',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.start);
                              setState(() {
                                isTimerRunning = true;
                              });
                            },
                            child: Text(
                              'Start',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
