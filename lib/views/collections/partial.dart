import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinda/models/partial_index.dart';
import 'package:sinda/views/collections/bloc/collections_bloc.dart';
import 'package:sinda/widgets/collections/partial_tile.dart';

class PartialRequest extends StatefulWidget {
  const PartialRequest({super.key});

  @override
  State<StatefulWidget> createState() => _PartialRequestState();
}

class _PartialRequestState extends State<PartialRequest> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  onClickNew() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text('New Task'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'))
            ],
            content: Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 3,
              padding: EdgeInsets.all(12),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                children: [
                  InkWell(
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.folder_zip,
                            size: 80,
                          ),
                          Text('Create new collection')
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.file_present,
                            size: 80,
                          ),
                          Text('Create new request')
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.file_upload,
                            size: 80,
                          ),
                          Text('Import collection from local drive')
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.only(right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: PopupMenuButton(
                    offset: Offset(2, 48),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          height: 24,
                          onTap: () {
                            context
                                .read<CollectionsBloc>()
                                .add(OnNewCollection());
                          },
                          child: ListTile(
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            contentPadding: EdgeInsets.all(0),
                            leading: Icon(Icons.folder),
                            title: Text('New Collection'),
                          ),
                        )
                      ];
                    },
                    icon: Icon(
                      Icons.add,
                    )),
              ),
              Expanded(
                  child: TextField(
                style: TextStyle(fontSize: 10),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    isDense: true,
                    border: OutlineInputBorder()),
              ))
            ],
          ),
        ),
        Divider(),
        Expanded(
          child: SizedBox(
            child: BlocBuilder<CollectionsBloc, CollectionsState>(
              bloc: context.read<CollectionsBloc>(),
              builder: (context, state) {
                if (state is CollectionsReady) {
                  return Scrollbar(
                      controller: _scrollController,
                      child: ListView.builder(
                          controller: _scrollController,
                          physics: PageScrollPhysics(),
                          itemCount: state.collections.length,
                          padding: EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            PartialIndex partialTileData =
                                state.collections[index];
                            return PartialTile(
                              partialTileData,
                            );
                          }));
                }
                return Container();
              },
            ),
          ),
        ),
        Expanded(
          child: SizedBox(),
        )
      ],
    );
  }
}
