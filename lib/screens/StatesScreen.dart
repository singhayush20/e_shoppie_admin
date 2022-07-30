import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    // final double itemWidth = MediaQuery.of(context).size.width / 2;
    // final double itemHeight =
    //     (MediaQuery.of(context).size.height - appBarHeight) / 2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02,
              vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  ' Total Revenue',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  ' \$12,000',
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02,
                vertical: 20),
            child: GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: <Widget>[
                Card(
                  child: ListTile(
                      title: TextButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.people_outline),
                        label: Text("Users",
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                      subtitle: Text(
                        '7',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )),
                ),
                Card(
                  child: ListTile(
                    title: TextButton.icon(
                      onPressed: null,
                      icon: Icon(Icons.category_outlined),
                      label: Text(
                        "Categories",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    subtitle: Text(
                      '23',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                      title: TextButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.track_changes),
                          label: Text(
                            "Producs",
                            style: Theme.of(context).textTheme.titleSmall,
                          )),
                      subtitle: Text(
                        '120',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )),
                ),
                Card(
                  child: ListTile(
                      title: TextButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.tag_faces),
                          label: Text(
                            "Sold",
                            style: Theme.of(context).textTheme.titleSmall,
                          )),
                      subtitle: Text(
                        '13',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )),
                ),
                Card(
                  child: ListTile(
                      title: TextButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.shopping_cart_outlined),
                          label: Text(
                            "Orders",
                            style: Theme.of(context).textTheme.titleSmall,
                          )),
                      subtitle: Text(
                        '5',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )),
                ),
                Card(
                  child: ListTile(
                      title: TextButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.close),
                          label: Text(
                            "Return",
                            style: Theme.of(context).textTheme.titleSmall,
                          )),
                      subtitle: Text(
                        '0',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
