import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SyncedListView(),
        ),
      ),
    );
  }
}

class SyncedListView extends StatefulWidget {
  const SyncedListView({super.key});

  @override
  _SyncedListViewState createState() => _SyncedListViewState();
}

class _SyncedListViewState extends State<SyncedListView> {
  final ScrollController _leftScrollController = ScrollController();
  final ScrollController _rightScrollController = ScrollController();
  bool _isLeftScrolling = false;
  bool _isRightScrolling = false;

  @override
  void initState() {
    super.initState();
    _leftScrollController.addListener(_leftScrollListener);
    _rightScrollController.addListener(_rightScrollListener);
  }

  void _leftScrollListener() {
    if (!_isRightScrolling) {
      _isLeftScrolling = true;
      final offset = _leftScrollController.offset;
      _rightScrollController
          .jumpTo(_rightScrollController.position.maxScrollExtent - offset);
      _isLeftScrolling = false;
    }
  }

  void _rightScrollListener() {
    if (!_isLeftScrolling) {
      _isRightScrolling = true;
      final offset = _rightScrollController.offset;
      _leftScrollController
          .jumpTo(_leftScrollController.position.maxScrollExtent - offset);
      _isRightScrolling = false;
    }
  }

  @override
  void dispose() {
    _leftScrollController.dispose();
    _rightScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> data = {
      'Volume': [
        '1.8L',
        '73k',
        '1.8L',
        '73k',
        '1.8L',
        '73k',
      ],
      'OI Chg%': ['-1', '2', '3', '-1', '2', '3'],
      'OI': [
        '1.8L',
        '73k',
        '1.8L',
        '73k',
        '1.8L',
        '73k',
      ],
      'Chg Chg%': [
        '1.8L',
        '73k',
        '1.8L',
        '73k',
        '1.8L',
        '73k',
      ],
      'LTP': [
        '1.8L',
        '73k',
        '1.8L',
        '73k',
        '1.8L',
        '73k',
      ],
    };

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column
              Expanded(
                flex: 2,
                child: ListView.builder(
                  controller: _leftScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      constraints: const BoxConstraints(minWidth: 60),
                      decoration: BoxDecoration(
                        border: Border(
                          right:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.shade300, width: 1),
                              ),
                            ),
                            alignment: Alignment.bottomCenter,
                            height: 40,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              data.keys.elementAt(index),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (var i = 0;
                                    i < data.values.elementAt(index).length;
                                    i++) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Container(
                                      child: Text(
                                        data.keys.elementAt(index) == 'OI Chg%'
                                            ? "${data.values.elementAt(index)[i]}%"
                                            : data.values.elementAt(index)[i],
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: data.keys.elementAt(index) ==
                                                        'OI Chg%' &&
                                                    int.parse(data.values
                                                            .elementAt(
                                                                index)[i]) <
                                                        0
                                                ? Colors.red
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                  if (i <
                                      data.values.elementAt(index).length - 1)
                                    const Divider(
                                      height: 10,
                                    ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Middle Section
              Container(
                width: 100,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        border: Border(),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Strike",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "26000",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                "26000",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                "26000",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                "26000",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                "26000",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                "26000",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "VI",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "12.3",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                "12.3",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                "12.3",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                "12.3",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                "12.3",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                "12.3",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Right Column
              Expanded(
                flex: 2,
                child: ListView.builder(
                  controller: _rightScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      constraints: const BoxConstraints(minWidth: 60),
                      decoration: BoxDecoration(
                        border: Border(
                          right:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.shade300, width: 1),
                              ),
                            ),
                            alignment: Alignment.bottomCenter,
                            height: 40,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              data.keys.elementAt(data.length - 1 - index),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (var i = 0;
                                    i <
                                        data.values
                                            .elementAt(data.length - 1 - index)
                                            .length;
                                    i++) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Container(
                                      child: Text(
                                        data.keys.elementAt(index) == 'OI Chg%'
                                            ? "${data.values.elementAt(index)[i]}%"
                                            : data.values.elementAt(index)[i],
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: data.keys.elementAt(index) ==
                                                        'OI Chg%' &&
                                                    int.parse(data.values
                                                            .elementAt(
                                                                index)[i]) <
                                                        0
                                                ? Colors.red
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                  if (i <
                                      data.values.elementAt(index).length - 1)
                                    const Divider(
                                      height: 10,
                                    ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
