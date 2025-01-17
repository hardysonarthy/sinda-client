import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:sinda/models/variable_map.dart';

class DynamicTableWidget extends StatefulWidget {
  const DynamicTableWidget({super.key});

  @override
  State<StatefulWidget> createState() => _DynamicTableWidgetState();
}

class _DynamicTableWidgetState extends State<DynamicTableWidget> {
  final List<VariableMap> rows = [];

  @override
  void initState() {
    super.initState();
    // for heading row
    rows.add(VariableMap());
    rows.add(VariableMap());
  }

  List<TableRow> renderRows() {
    return rows.mapIndexed((index, row) {
      if (index == 0) {
        return TableRow(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              color: Theme.of(context).focusColor),
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Checkbox(value: false, onChanged: (value) {}),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Key', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Text('Value', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Description',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox()
          ],
        );
      }

      return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Checkbox(value: false, onChanged: (value) {}),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: TextField(
              onChanged: (value) => {
                if (value.isNotEmpty)
                  {
                    if ((rows.length - 1) == index)
                      {
                        setState(() {
                          rows.add(VariableMap());
                        })
                      }
                  }
              },
              style: TextStyle(fontSize: 12),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: TextField(
              style: TextStyle(fontSize: 12),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: TextField(
              style: TextStyle(fontSize: 12),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            child: IconButton(
                onPressed: () {
                  setState(() {
                    rows.removeAt(index);
                  });
                },
                icon: Icon(
                  Icons.delete,
                  size: 16,
                )),
          )
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Table(
        border: TableBorder.all(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.circular(4)),
        columnWidths: const {
          0: FixedColumnWidth(48),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(3),
          3: FlexColumnWidth(3),
          4: FixedColumnWidth(48),
        },
        children: renderRows());
  }
}
