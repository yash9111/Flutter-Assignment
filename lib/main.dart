import 'package:flutter/material.dart';
import 'package:table_app/flutter_table.dart';

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
        backgroundColor: Colors.white,
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

  List<List<String>> transpose(List<List<String>> input) {
    final int rowCount = input.isNotEmpty ? input[0].length : 0;
    final int columnCount = input.length;
    List<List<String>> output =
        List.generate(rowCount, (_) => List.filled(columnCount, ''));

    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        output[i][j] = input[j][i];
      }
    }

    return output;
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
          height: 450,
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
                child: SingleChildScrollView(
                  controller: _leftScrollController,
                  scrollDirection: Axis.horizontal,
                  child: table(
                      data.keys.toList(),
                      transpose(data.values.toList()),
                      // const Color.fromARGB(255, 241, 231, 199),
                      Colors.transparent),
                ),
              ),
              // Middle Section
              Container(
                // margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                ),
                child: table(
                    ["Strike", "IV"],
                    transpose([
                      [
                        "2600",
                        "2600",
                        "2600",
                        "2600",
                        "2600",
                        "2600",
                      ],
                      [
                        '12.3',
                        '12.3',
                        '12.3',
                        '12.3',
                        '12.3',
                        '12.3',
                      ]
                    ]),
                    Colors.transparent),
              ),
              // Right Column
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  controller: _rightScrollController,
                  scrollDirection: Axis.horizontal,
                  child: table(
                      data.keys.toList().reversed,
                      transpose(data.values.toList().reversed.toList()),
                      Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
