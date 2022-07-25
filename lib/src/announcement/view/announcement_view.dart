import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:very_good_app/src/announcement/data/ann_data.dart';

class AnnouncementView extends StatefulWidget {
  AnnouncementView({Key? key}) : super(key: key);

  @override
  State<AnnouncementView> createState() => _AnnouncementViewState();
}

class _AnnouncementViewState extends State<AnnouncementView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTML <> Flutter Example'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_downward),
        onPressed: () {
          // final anchorContext = AnchorKey.forId(staticAnchorKey, "bottom")?.currentContext;
          // if (anchorContext != null) {
          //   Scrollable.ensureVisible(anchorContext);
          // }
        },
      ),
      body: SingleChildScrollView(
        child: Html(
          data: AnnData.htmlData,
        ),
      ),
    );
  }
}
