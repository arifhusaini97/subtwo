import 'package:flutter/material.dart';
import 'package:subtwo/screens/parts/profile_bottom_part/activity.dart';
import 'package:subtwo/screens/parts/profile_bottom_part/biodata_about.dart';
import 'package:subtwo/screens/parts/profile_top_part.dart';

class Profile extends StatefulWidget {
  final int id;
  final int house;
  final bool _isOwner;

  Profile(this._isOwner, this.house, this.id);

  @override
  _ProfileState createState() => _ProfileState(_isOwner, house, id);
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  ScrollController _scrollController;

  final int id;
  final int house;
  final bool _isOwner;

  _ProfileState(this._isOwner, this.house, this.id);

  String _containTabBar1;
  String _containTabBar2;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (house) {
      case 1:
        _containTabBar1 = 'Biodata';
        _containTabBar2 = 'Activity';
        break;
      default:
        return null;
    }

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {},
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
                return <Widget>[
                  // User information section
                  SliverToBoxAdapter(
                    child: ProfileTopPart(_isOwner, house, id),
                  ),
                ];
              },
              body: Column(
                children: <Widget>[
                  Divider(
                    height: 0.0,
                    color: Colors.black54,
                  ),
                  PreferredSize(
                    preferredSize: Size.fromHeight(10.0),
                    child: TabBar(
                      indicatorColor: Colors.purple,
                      labelColor: Colors.black,
                      isScrollable: true,
                      tabs: [
                        Tab(
                          text: _containTabBar1,
                        ),
                        Tab(
                          text: _containTabBar2,
                        ),
                      ], // list of tabs
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: BiodataAbout(house),
                          ),
                        ),
                        Container(
                          child: Activity(house),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () => Navigator.pushNamed(
              context,
              'form_profile',
              // arguments: {
              //   // "eventDate": eventDate != null ? eventDate : DateTime.now()
              // },
            ),
          ),
        ),
      ),
    );
  }
}
