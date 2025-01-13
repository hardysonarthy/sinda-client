import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinda/models/collection.dart';
import 'package:sinda/models/partial_index.dart';
import 'package:sinda/views/collections/bloc/collections_bloc.dart';

class PartialRequest extends StatefulWidget {
  const PartialRequest({super.key});

  @override
  State<StatefulWidget> createState() => _PartialRequestState();
}

class _PartialRequestState extends State<PartialRequest> {
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
                child: IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.all(0),
                    onPressed: onClickNew,
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
                      child: ListView.builder(
                          itemCount: state.collections.length,
                          padding: EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            PartialIndex collection = state.collections[index];
                            if (collection is HttpRequest) {
                              return ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8),
                                selectedColor: Theme.of(context).focusColor,
                                onTap: () {},
                                minLeadingWidth: 12,
                                leading: SizedBox(
                                    width: 36,
                                    child: Text(
                                      collection.method.getShortForm(),
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: collection.method.color),
                                    )),
                                title: Text(collection.url),
                                trailing: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.more_vert_outlined,
                                      size: 14,
                                    )),
                              );
                            }
                            if (collection is Collection) {
                              return ExpansionTile(
                                title: Text(collection.name),
                                children: collection.requests.map((req) {
                                  return ListTile(
                                    dense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    selectedColor: Theme.of(context).focusColor,
                                    onTap: () {},
                                    minLeadingWidth: 12,
                                    leading: SizedBox(
                                        width: 36,
                                        child: Text(
                                          req.method.getShortForm(),
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: req.method.color),
                                        )),
                                    title: Text(req.url),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.more_vert_outlined,
                                          size: 14,
                                        )),
                                  );
                                }).toList(),
                              );
                            }
                            return Container();
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
