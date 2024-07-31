import 'package:flutter/material.dart';

Widget table(
    Iterable<String> headers, Iterable<List<String>> values, Color color) {
  return Table(
    defaultColumnWidth: const FixedColumnWidth(60.0),
    border: TableBorder(
      horizontalInside: BorderSide(
        color: Colors.grey.shade300,
        style: BorderStyle.solid,
        width: 1,
      ),
    ),
    children: [
      TableRow(
        children: headers
            .map((header) => Container(
                  alignment: Alignment.bottomCenter,
                  color: Colors.grey.shade100,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      header,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Color.fromARGB(212, 36, 34, 185)),
                    ),
                  ),
                ))
            .toList(),
      ),
      for (var row in values)
        TableRow(
          children: row.asMap().entries.map((entry) {
            int index = entry.key;
            String value = entry.value;
            bool isOIChg = headers.elementAt(index) == 'OI Chg%';
            bool isOIChgNegative = headers.elementAt(index) == 'OI Chg%' &&
                double.tryParse(value) != null &&
                double.parse(value) < 0;

            return Container(
              alignment: Alignment.center,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  isOIChg ? "$value%" : value,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: isOIChg ? FontWeight.bold : FontWeight.normal,
                    color: isOIChgNegative
                        ? Colors.red
                        : isOIChg
                            ? Colors.green
                            : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
    ],
  );
}
