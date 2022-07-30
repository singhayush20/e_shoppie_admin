import 'package:e_shoppie_admin/screens/ManageScreen.dart';
import 'package:e_shoppie_admin/screens/StatesScreen.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin App for E Shoppie'),
        bottom: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.dashboard),
              text: 'Dashboard',
            ),
            Tab(
              icon: Icon(Icons.edit),
              text: 'Manage',
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          StatsScreen(),
          ManageScreen(),
        ],
      ),
    );
  }
}
