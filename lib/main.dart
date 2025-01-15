import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinda/views/bloc/view_bloc.dart';
import 'package:sinda/views/collections/bloc/collections_bloc.dart';
import 'package:sinda/views/collections/main.dart';
import 'package:sinda/views/collections/partial.dart';
import 'package:sinda/widgets/sidebar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController mainTabController;
  @override
  void initState() {
    super.initState();
    mainTabController = TabController(length: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
      providers: [
        BlocProvider<CollectionsBloc>(create: (_) => CollectionsBloc()),
        BlocProvider<ViewBloc>(
          create: (_) => ViewBloc(),
        )
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 48,
            child: Sidebar(),
          ),
          SizedBox(
            width: 256,
            child: PartialRequest(),
          ),
          VerticalDivider(
            width: 2,
            thickness: 1,
          ),
          Expanded(
              flex: 9,
              child: Column(children: [
                SizedBox(
                    height: 50,
                    child: BlocConsumer<ViewBloc, ViewState>(
                        listener: (context, state) {
                          setState(() {
                            mainTabController = TabController(
                                length: state.activeViews.length, vsync: this);
                          });
                        },
                        builder: (context, state) => TabBar(
                            controller: mainTabController,
                            tabAlignment: TabAlignment.start,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Theme.of(context).focusColor,
                            unselectedLabelColor:
                                Theme.of(context).disabledColor,
                            isScrollable: true,
                            tabs: state.activeViews
                                .map((viewData) => Tab(
                                      child: SizedBox(
                                        width: 80,
                                        child: Text(
                                          'this',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ))
                                .toList()))),
                Expanded(
                    child: TabBarView(
                        controller: mainTabController,
                        children: [ComposeRequestView()])),
              ]))
        ],
      ),
    ));
  }
}
