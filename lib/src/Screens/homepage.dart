import 'package:chat/src/widgets/chatListView.dart';
import 'package:chat/src/widgets/searchBar.dart';
import 'package:chat/src/widgets/widgets.dart';
import 'package:chat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

ScrollController controller = ScrollController(keepScrollOffset: true);

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  var searchBarHeight = 100.00;
  scrollController() {
    if (controller.position.userScrollDirection == ScrollDirection.reverse) {
      if (searchBarHeight != 0) {
        setState(() {
          searchBarHeight = 0;
        });
      }
    }
    if (controller.position.userScrollDirection == ScrollDirection.forward) {
      if (searchBarHeight == 0) {
        setState(() {
          searchBarHeight = 100.00;
        });
      }
    }
  }

  @override
  void initState() {
    controller.addListener(scrollController);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(scrollController);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            children: [
              profileHeader(
                context: context,
                name: 'Vishal Singh',
                imageUrl: 'assets/images/profile.png',
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: searchBarHeight,
                curve: Curves.fastOutSlowIn,
                child: const SearchBar(),
              ),
              // ThemeX.switchTheme(widget.value),
              Expanded(
                flex: 2,
                child: Container(
                  child: TabBar(
                    labelColor: Theme.of(context).tabBarTheme.labelColor,
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
              ),
              Expanded(
                flex: 8,
                child: TabBarView(
                  children: [
                    ChatView(controller: controller),
                    Container(),
                    Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
