import 'package:chat/components/shared_database.dart';
import 'package:chat/firebase/authentication.dart';
import 'package:chat/hive/boxes.dart';
import 'package:chat/hive/user/user_info.dart';
import 'package:chat/presentation/src/Screens/chatScreen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  List<UserInf> usersList = [];
  getUserObjectList() async {
    List<UserInf> list = [];
    var x = await FirebaseService.getUserList();
    for (var i in x) {
      list.add(UserInf.fromJson(i));
    }
    setState(() {
      usersList = list;
    });
    return list;
  }

  String _displayStringForOption(UserInf option) => option.email;

  @override
  void initState() {
    getUserObjectList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Autocomplete<UserInf>(
              fieldViewBuilder: (BuildContext context,
                  _controller,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  controller: _controller,
                  focusNode: fieldFocusNode,
                  keyboardType: TextInputType.text,
                  keyboardAppearance: Brightness.light,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                );
              },
              displayStringForOption: _displayStringForOption,
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<UserInf>.empty();
                }
                return usersList.where(
                  (UserInf option) {
                    return option.email
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  },
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<UserInf> onSelected,
                  Iterable<UserInf> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: 300,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          if (options.elementAt(index).email ==
                              Boxes.getCurrentUserInfo()!.email) {
                            return Container();
                          } else {
                            return ListTile(
                              
                              leading: ClipOval(
                                child: Image.network(
                                  options.elementAt(index).image,
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              title: Text(
                                options.elementAt(index).name,
                                style: const TextStyle(fontSize: 14),
                              ),
                              subtitle: Text(
                                options.elementAt(index).email,
                                style: const TextStyle(fontSize: 12),
                              ),
                              trailing: TextButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  _controller.clear();
                                  onSelected(options.elementAt(index));
                                },
                                child: const Text('Add'),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                );
              },
              onSelected: (UserInf selection) {
                if(Boxes.getUserInfoBox().get(selection.uid)==null){
                  Boxes.getUserInfoBox().put(selection.uid, selection);
                }
                // Navigator.of(context).push(
                //   CupertinoPageRoute(
                //     builder: (context) => ChatScreen(user: selection),
                //   ),
                // );
              },
            ),
          ),
          Container(
            // duration: const Duration(milliseconds: 300),
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Theme.of(context).primaryColor,
            ),
            width: 60,
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
