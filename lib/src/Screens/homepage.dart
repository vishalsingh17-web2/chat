import 'package:chat/components/shared_database.dart';
import 'package:chat/hive/boxes.dart';
import 'package:chat/hive/user_info.dart';
import 'package:chat/src/widgets/chatListView.dart';
import 'package:chat/src/widgets/groupListView.dart';
import 'package:chat/src/widgets/searchBar.dart';
import 'package:chat/src/widgets/profileHeader.dart';
import 'package:chat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var _scrollViewController;
  var _tabController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (context, bool) => [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              pinned: true,
              floating: true,
              toolbarHeight: 100,
              expandedHeight: 250,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    profileHeader(
                      context: context,
                      name: Boxes.getCurrentUserInfo()!.name,
                      imageUrl: Boxes.getCurrentUserInfo()!.image,
                    ),
                    const SearchBar()
                  ],
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(
                    text: 'Direct messages',
                    icon: Icon(Icons.chat),
                  ),
                  Tab(
                    text: 'Groups',
                    icon: Icon(Icons.group),
                  ),
                  Tab(
                    text: 'Calls',
                    icon: Icon(Icons.call),
                  ),
                ],
              ),
            ),
          ],
          body: TabBarView(
            controller: _tabController,
            children: [
              ChatView(),
              GroupView(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
