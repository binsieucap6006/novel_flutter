import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/constants.dart';
import 'package:novel_flutter/routes/routes.dart';
import 'package:novel_flutter/states/current_user.dart';

enum SampleItem {
  logout,
  setting,
  upload_novel,
  bookmarked,
  upload_chapter,
  uploaded,
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Sign out"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
        Navigator.of(context).pushNamed(Routes.LOGIN);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("AlertDialog"),
      content: const Text("Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              //padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              //child: const Icon(CupertinoIcons.bars),
              // child: IconButton(
              //   icon: const Icon(CupertinoIcons.bars),
              //   onPressed: () {
              // CurrentUser().signOutUser();
              // Navigator.of(context).pushNamed(Routes.WELCOME);
              //   },
              // ),
              child: PopupMenuButton<SampleItem>(
                onSelected: (Enum selectedItem) {
                  if (selectedItem == SampleItem.logout) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          'Are you sure',
                          style: TextStyle(color: Colors.grey),
                        ),
                        content: const Text('You want to log out?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              CurrentUser().signOutUser();
                              Navigator.of(context).pushNamed(Routes.WELCOME);
                            },
                            child: Text(
                              'Log out',
                              style:
                                  TextStyle(color: Colors.red.withOpacity(0.8)),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (selectedItem == SampleItem.setting) {
                    Navigator.of(context).pushNamed('/');
                  } else if (selectedItem == SampleItem.upload_novel) {
                    Navigator.of(context).pushNamed(Routes.ADD_NOVEL);
                  } else if (selectedItem == SampleItem.bookmarked) {
                    Navigator.of(context).pushNamed(Routes.BOOKMARKED);
                  } else if (selectedItem == SampleItem.upload_chapter) {
                    Navigator.of(context).pushNamed(Routes.ADD_CHAPTER);
                  } else if (selectedItem == SampleItem.uploaded) {
                    Navigator.of(context).pushNamed(Routes.UPLOADED);
                  }
                },
                icon: const Icon(CupertinoIcons.bars),
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<SampleItem>>[
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.logout,
                    child: const Text('Log out'),
                  ),
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.setting,
                    child: const Text('Setting'),
                  ),
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.upload_novel,
                    child: const Text('Upload Novel'),
                  ),
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.bookmarked,
                    child: const Text('Bookmark'),
                  ),
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.upload_chapter,
                    child: const Text('Upload Chapter'),
                  ),
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.uploaded,
                    child: const Text('Uploaded novels'),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Text(
              "Novel Hovel",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.RQ_MANAGE);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: const Icon(Icons.notifications),
            ),
          ),
        ],
      ),
    );
  }
}
