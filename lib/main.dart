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
      'OI Chg%': ['-1%', '2%', '3%', '-1%', '2%', '3%'],
      'OI': ['-1%', '2%', '3%', '-1%', '2%', '3%'],
      'Chg Chg%': ['-1%', '2%', '3%', '-1%', '2%', '3%'],
      'LTP': ['-1%', '2%', '3%', '-1%', '2%', '3%'],
    };

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all()),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: ListView.builder(
              controller: _leftScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(data.keys.elementAt(index)),
                    for (var column in data.values.elementAt(index))
                      Text(column),
                  ],
                );
              },
            ),
          ),
          Container(
            height: double.infinity,
            decoration: BoxDecoration(border: Border.all()),
            child: const Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Strike",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "VI",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              controller: _rightScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(data.keys.elementAt(data.length - 1 - index)),
                    for (var column
                        in data.values.elementAt(data.length - 1 - index))
                      Text(column)
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
