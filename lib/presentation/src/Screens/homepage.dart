import 'package:chat/components/shared_database.dart';
import 'package:chat/hive/boxes.dart';
import 'package:chat/hive/user/user_info.dart';
import 'package:chat/presentation/provider/user_provider.dart';
import 'package:chat/presentation/src/widgets/chatListView.dart';
import 'package:chat/presentation/src/widgets/groupListView.dart';
import 'package:chat/presentation/src/widgets/profileHeader.dart';
import 'package:chat/presentation/src/widgets/searchBar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

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
          body: Consumer<UserProvider>(builder: (context, userProvider, child) {
        return NestedScrollView(
          physics: const BouncingScrollPhysics(),
            controller: _scrollViewController,
            headerSliverBuilder: (context, bool) => [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        profileHeader(
                          context: context,
                          name: userProvider.userInfo.name,
                          imageUrl: userProvider.userInfo.image,
                        ),
                        const SearchBar()
                      ],
                    ),
                  ),
                ],
            body: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Chats', icon: Icon(Icons.chat)),
                    Tab(text: 'Groups', icon: Icon(Icons.group)),
                    Tab(text: 'Calls', icon: Icon(Icons.call)),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ChatView(),
                      GroupView(),
                      Container(),
                    ],
                  ),
                ),
              ],
            ));
      })),
    );
  }
}
