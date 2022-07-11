import 'package:flutter/material.dart';
import 'package:very_good_app/src/config/environment.dart';

class UsersView extends StatefulWidget {
  UsersView({Key? key}) : super(key: key);

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GetX Infinite Scroll")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() {}),
        child: ListView.separated(
          itemCount: 4,
          separatorBuilder: (BuildContext context, int index) {
            return ListTile(
              // leading: CircleAvatar(
              //   backgroundImage: AppUtil.imageProvider(""),
              // ),
              title: Text(Environment.instance.name.toString()),
              subtitle: Text("item.username"),
              trailing: Text("item.id"),
              onTap: () {},
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return Divider(height: 0);
          },
        ),
      ),
    );
  }
}
