import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

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
            child: TextFormField(
              showCursor: false,
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
            child: TextButton(
              child: Text("Search", style: Theme.of(context).textTheme.bodyText1),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
