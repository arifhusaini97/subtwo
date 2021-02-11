import 'package:flutter/material.dart';
import 'package:subtwo/models/activity_model.dart';
import 'package:subtwo/screens/pages/forms/form_confirmation.dart';

class Activity extends StatelessWidget {
  final int house;
  Activity(this.house);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          EntryItem(dummyDataActivity[index]),
      itemCount: dummyDataActivity.length,
    );
  }
}

class EntryItem extends StatelessWidget {
  final EntryModel entry;

  EntryItem(this.entry);

  int positionTemp = 0;
  int competitionTemp = 0;

  @override
  Widget build(BuildContext context) {
    void _showEditPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 60.0,
              ),
              child: FormConfirmation(),
            );
          });
    }

    Widget _buildTiles(EntryModel root) {
      if (root.children.isEmpty)
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Activity Details",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          root.title,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                            onTap: () => _showEditPanel(),
                            child: Container(
                                height: 50,
                                width: 50,
                                child: Icon(Icons.border_all)),
                          ),
                          InkWell(
                            onTap: () => _showEditPanel(),
                            child: Container(
                                height: 50,
                                width: 50,
                                child: Icon(Icons.print)),
                          ),
                          InkWell(
                            onTap: () => _showEditPanel(),
                            child: Container(
                                height: 50,
                                width: 50,
                                child: Icon(Icons.create)),
                          ),
                          InkWell(
                            onTap: () => _showEditPanel(),
                            child: Container(
                                height: 50,
                                width: 50,
                                child: Icon(Icons.delete)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      return Card(
        child: ExpansionTile(
          key: PageStorageKey<EntryModel>(root),
          title: Container(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  root.title,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          subtitle: Container(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  root.subtitle,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          children: root.children.map(_buildTiles).toList(),
        ),
      );
    }

    return _buildTiles(entry);
  }
}
