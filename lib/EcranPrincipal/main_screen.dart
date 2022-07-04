import 'package:flutter/material.dart';
import 'package:uber_clone/Pages/accueil.dart';
import 'package:uber_clone/Pages/profile.dart';
import 'package:uber_clone/Pages/note.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  onSItemclick(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [HomePage(), NotePage(), ProfilePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Paiement',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Note',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
        ),
        showSelectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onSItemclick,
      ),
    );
  }
/*
  ElevatedButton sortirApp() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (c) => SignUp()));
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.lightGreenAccent,
      ),
      child: const Text(
        "sortir",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white54,
        ),
      ),
    );
  }
  */

}
