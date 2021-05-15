import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final List<String> items = ["Wifi", "Bluetoth", "AirplanMode", "Shound"];
  String query = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () async {
                final String selected = await showSearch(
                    context: context, delegate: MySearchName(items));
                if (selected != null && selected != query) {
                  setState(() {
                    query = selected;
                  });
                }
              },
              child: Container(
                alignment: Alignment.centerLeft,
                height: 45,
                width: 45,
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.wifi,
                color: Colors.blue,
              ),
              title: Text(items[0]),
              subtitle: Text('wifi and network settings'),
              onTap: () {},
              onLongPress: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.bluetooth,
                color: Colors.blue,
              ),
              title: Text(items[1]),
              subtitle: Text('Bluetooth Settings'),
              onTap: () {},
              onLongPress: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.airplanemode_active,
                color: Colors.blue,
              ),
              title: Text(items[2]),
              subtitle: Text('Airplan mode'),
              onTap: () {},
              onLongPress: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.volume_up,
                color: Colors.blue,
              ),
              title: Text(items[3]),
              subtitle: Text('Shound and vibration'),
              onTap: () {},
              onLongPress: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class MySearchName extends SearchDelegate<String> {
  final List<String> items;
  MySearchName(this.items);
  final List<String> _list = ["Wifi", "Bluetoth", "AirplanMode", "Shound"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          tooltip: 'clear',
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? _list
        : items.where((c) => c.toLowerCase().contains(query)).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(suggestions[index]),
            onTap: () {
              close(context, suggestions[index]);
            },
          );
        });
  }
}
