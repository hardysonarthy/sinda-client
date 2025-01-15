import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinda/models/collection.dart';
import 'package:sinda/models/partial_index.dart';
import 'package:sinda/models/view.dart';
import 'package:sinda/views/bloc/view_bloc.dart';

class PartialTile extends StatelessWidget {
  final PartialIndex tileData;
  const PartialTile(this.tileData, {super.key});

  triggerViewBloc(
      BuildContext context, ViewTypes viewType, Map<String, dynamic> data) {
    context.read<ViewBloc>().add(OpenView(viewType, data));
  }

  renderTile(BuildContext context) {
    PartialIndex collection = tileData;
    if (collection is HttpRequest) {
      return ListTile(
        dense: true,
        visualDensity: VisualDensity(vertical: -4),
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
        selectedColor: Theme.of(context).focusColor,
        onTap: () {
          triggerViewBloc(context, ViewTypes.request, {});
        },
        minLeadingWidth: 12,
        leading: SizedBox(
            width: 36,
            child: Text(
              collection.method.shortForm,
              style: TextStyle(fontSize: 10, color: collection.method.color),
            )),
        title: Text(collection.name ?? collection.url),
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
        visualDensity: VisualDensity(vertical: -4, horizontal: -4),
        dense: true,
        onExpansionChanged: (value) {
          triggerViewBloc(context, ViewTypes.request, {});
        },
        tilePadding: EdgeInsets.symmetric(horizontal: 6),
        childrenPadding: EdgeInsets.only(left: 12),
        initiallyExpanded: collection.isExpanded,
        controlAffinity: ListTileControlAffinity.leading,
        children: collection.requests.map((req) {
          return PartialTile(req);
        }).toList(),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewBloc, ViewState>(
        bloc: context.read<ViewBloc>(),
        builder: (context, state) {
          return renderTile(context);
        });
  }
}
