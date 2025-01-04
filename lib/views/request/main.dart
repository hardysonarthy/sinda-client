import 'package:flutter/material.dart';

class Method {
  final String method;
  final Color color;

  Method(this.method, this.color);
}

List<Method> restMethods = [
  Method("GET", Colors.green),
  Method("POST", Colors.amber),
  Method("PUT", Colors.blue),
  Method("PATCH", Colors.purple),
  Method("DELETE", Colors.red),
  Method("HEAD", Colors.green),
  Method("OPTIONS", Colors.pink),
];

class RequestView extends StatefulWidget {
  const RequestView({super.key});

  @override
  State<StatefulWidget> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView>
    with TickerProviderStateMixin {
  Method _selectedMethod = restMethods[0]; // Default method
  final GlobalKey _key = GlobalKey(); // Key for locating the button
  late TabController requestSettingsTabController;
  late TabController responseSettingsTabController;

  @override
  void initState() {
    super.initState();
    requestSettingsTabController = TabController(length: 6, vsync: this);
    responseSettingsTabController = TabController(length: 5, vsync: this);
  }

  void _showMenu() {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    final Offset buttonPosition =
        renderBox.localToGlobal(Offset.zero); // Position of the button

    // Show the popup menu below the button at a specific position
    showMenu<Method>(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonPosition.dx, // X position
        buttonPosition.dy +
            renderBox.size.height +
            5, // Y position below the button
        buttonPosition.dx +
            renderBox.size.width, // X position right of the button
        buttonPosition.dy +
            renderBox.size.height, // Y position below the button
      ),
      popUpAnimationStyle: AnimationStyle.noAnimation,
      items: restMethods
          .map((method) => PopupMenuItem<Method>(
                value: method,
                child: Text(
                  method.method,
                  style: TextStyle(color: method.color),
                ),
              ))
          .toList(),
      elevation: 8.0,
    ).then((Method? value) {
      if (value != null) {
        setState(() {
          _selectedMethod = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SizedBox(),
              ),
              DropdownButton(
                  icon: Icon(Icons.workspaces_outlined),
                  isDense: true,
                  items: [
                    DropdownMenuItem(value: 'stg', child: Text('stg')),
                    DropdownMenuItem(value: 'prd', child: Text('prd')),
                  ],
                  onChanged: (value) {}),
              ElevatedButton.icon(
                onPressed: () {},
                label: Text('Save'),
                icon: Icon(Icons.save),
              ),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 70,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                SizedBox(
                    width: 120,
                    child: GestureDetector(
                      onTap: () {
                        _showMenu();
                      },
                      child: ElevatedButton(
                        key: _key, // Key for button positioning
                        style: ButtonStyle(),
                        onPressed:
                            null, // Disabled because we handle the tap gesture manually
                        child: Text(
                          _selectedMethod.method,
                          style: TextStyle(color: _selectedMethod.color),
                        ),
                      ),
                    )),
                Expanded(
                    child: TextField(
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                      fillColor: Colors.amber, border: OutlineInputBorder()),
                )),
                SizedBox(
                    width: 120,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      label: Text('Send'),
                      icon: Icon(Icons.send),
                    ))
              ],
            )),
        SizedBox(
          height: 28,
          child: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: TextStyle(fontSize: 12),
              controller: requestSettingsTabController,
              tabs: [
                Tab(
                  text: 'Params',
                ),
                Tab(
                  text: 'Authorization',
                ),
                Tab(
                  text: 'Headers',
                ),
                Tab(
                  text: 'Body',
                ),
                Tab(
                  text: 'Scripts',
                ),
                Tab(
                  text: 'Settings',
                )
              ]),
        ),
        Expanded(
            child: Container(
                padding: EdgeInsets.all(5),
                child: TabBarView(
                    controller: requestSettingsTabController,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 28,
                                child: Text(
                                  'Query Params',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(),
                                )),
                            Table(
                                border: TableBorder.all(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    borderRadius: BorderRadius.circular(4)),
                                columnWidths: const {
                                  0: FixedColumnWidth(48),
                                  1: FlexColumnWidth(2),
                                  2: FlexColumnWidth(3),
                                  3: FlexColumnWidth(3),
                                },
                                children: List.generate(15, (index) {
                                  if (index == 0) {
                                    return TableRow(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              topRight: Radius.circular(4)),
                                          color: Theme.of(context).focusColor),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Checkbox(
                                              value: false,
                                              onChanged: (value) {}),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Key',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Value',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Description',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    );
                                  }
                                  return TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Checkbox(
                                            value: false,
                                            onChanged: (value) {}),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 6),
                                        child: TextField(
                                          style: TextStyle(fontSize: 12),
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.all(0),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 6),
                                        child: TextField(
                                          style: TextStyle(fontSize: 12),
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.all(0),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 6),
                                        child: TextField(
                                          style: TextStyle(fontSize: 12),
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.all(0),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ],
                                  );
                                })),
                            SizedBox(
                              height: 24,
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Text('Authorization'),
                      ),
                      Center(
                        child: Text('Headers'),
                      ),
                      Center(
                        child: Text('Body'),
                      ),
                      Center(
                        child: Text('Scripts'),
                      ),
                      Center(
                        child: Text('Settings'),
                      ),
                    ]))),
        SizedBox(
          height: 28,
          child: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: TextStyle(fontSize: 12),
              controller: responseSettingsTabController,
              tabs: [
                Tab(
                  text: 'Body',
                ),
                Tab(
                  text: 'Cookies',
                ),
                Tab(
                  text: 'Headers',
                ),
                Tab(
                  text: 'Test Results',
                ),
                Tab(
                  text: 'History',
                ),
              ]),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: Colors.green.shade500),
          ),
        )
      ],
    );
  }
}
