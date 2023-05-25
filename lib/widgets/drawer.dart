import 'package:flutter/material.dart';

class ShowDrawer extends StatelessWidget {
  const ShowDrawer({super.key});

  get context => null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Joel Miller"),
            accountEmail: Text("joelmiller@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://pm1.narvii.com/6952/cbcbea1bfd42f47929a29703490c151a387ecd43r1-800-837v2_hq.jpg"),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://wallpapercave.com/wp/wp6446023.jpg",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.of(context).pushNamed('/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text("User List"),
            onTap: () {
              Navigator.of(context).pushNamed('/profileList');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Profile"),
            onTap: () {
              Navigator.of(context).pushNamed('/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Signout"),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Alert"),
                    content: const Text("Are you sure you want to sign out?"),
                    actions: [
                      TextButton(
                        child: const Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/login');
                        },
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
