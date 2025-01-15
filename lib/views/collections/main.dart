import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinda/models/collection.dart';
import 'package:sinda/models/methods.dart';
import 'package:sinda/constants/http_methods.dart';
import 'package:sinda/views/collections/bloc/collections_bloc.dart';
import 'package:sinda/widgets/dynamic_table.dart';

class ComposeRequestView extends StatefulWidget {
  const ComposeRequestView({super.key});

  @override
  State<StatefulWidget> createState() => _ComposeRequestViewState();
}

class _ComposeRequestViewState extends State<ComposeRequestView>
    with TickerProviderStateMixin {
  Method _selectedMethod = httpMethods[0]; // Default method
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
      items: httpMethods
          .map((method) => PopupMenuItem<Method>(
                value: method,
                child: Text(
                  method.label,
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
    return BlocBuilder<CollectionsBloc, CollectionsState>(
        bloc: context.read<CollectionsBloc>(),
        builder: (context, state) => Column(
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
                      PopupMenuButton(
                          icon: Icon(Icons.workspaces_outlined),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(child: Text('stg')),
                              PopupMenuItem(child: Text('prd')),
                            ];
                          }),
                      ElevatedButton.icon(
                        onPressed: () {
                          HttpRequest req = HttpRequest(_selectedMethod, '',
                              sortIndex: state.collections.length);
                          context
                              .read<CollectionsBloc>()
                              .add(OnNewRequest(request: req));
                        },
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
                            child: InkWell(
                              onTap: () {
                                _showMenu();
                              },
                              child: ElevatedButton(
                                key: _key, // Key for button positioning
                                style: ButtonStyle(),
                                onPressed:
                                    null, // Disabled because we handle the tap gesture manually
                                child: Text(
                                  _selectedMethod.label,
                                  style:
                                      TextStyle(color: _selectedMethod.color),
                                ),
                              ),
                            )),
                        Expanded(
                            child: TextField(
                          style: TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                              fillColor: Colors.amber,
                              border: OutlineInputBorder()),
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
                                    DynamicTableWidget(),
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
            ));
  }
}
