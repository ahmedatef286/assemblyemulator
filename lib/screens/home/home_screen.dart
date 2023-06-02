import 'package:assemblyemulator/business_logic/view_models/instruction_provider.dart';
import 'package:assemblyemulator/business_logic/view_models/register_provider.dart';
import 'package:assemblyemulator/custom_style.dart';
import 'package:assemblyemulator/screens/assemble/assemble_screen.dart';
import 'package:assemblyemulator/screens/home/edit_body.dart';
import 'package:assemblyemulator/screens/home/register_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int errorIndex = -1;
  late final TabController _tabController;
  TextEditingController textController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  final List<Tab> myTabs = [
    Tab(
      text: 'Edit',
      icon: Icon(Icons.edit),
    ),
    Tab(
      text: 'Registers',
      icon: Icon(Icons.storage_rounded),
    ),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      // Retrieve the selected tab value
      String? selectedTab = myTabs[_tabController.index].text;
      print(selectedTab);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomStyle.colorPalette.cyan,
        child: const Icon(
          Icons.construction_rounded,
        ),
        onPressed: () {
          int test = Provider.of<InstructionProvider>(context, listen: false)
              .loadInstructions(textController.text, context);
          if (test == -1) {
            setState(() {
              errorIndex = -1;
            });
            Provider.of<InstructionProvider>(context, listen: false)
                .executeInstruction(context);

            /*  Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AssembleScreen(),
            )); */
          } else {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              'Error at line ${test + 1}',
              style: TextStyle(
                  color: CustomStyle.colorPalette.white,
                  fontSize: CustomStyle.fontSizes.mediumFont),
            )));
            Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
                .clear();
            Provider.of<InstructionProvider>(context, listen: false)
                .clearInstructions();

            setState(() {
              errorIndex = test;
            });
          }
        },
      ),
      appBar: AppBar(
        surfaceTintColor: CustomStyle.colorPalette.darkGrey,
        centerTitle: true,
        title: Text(
          'Assembly Emulator',
          style: TextStyle(
              color: CustomStyle.colorPalette.lightGrey,
              fontSize: CustomStyle.fontSizes.mediumFont),
        ),
        bottom: TabBar(
            indicatorWeight: 3,
            indicatorColor: CustomStyle.colorPalette.cyan,
            controller: _tabController,
            labelColor: CustomStyle.colorPalette.cyan,
            unselectedLabelColor: CustomStyle.colorPalette.lightGrey,
            tabs: myTabs),
        toolbarHeight: MediaQuery.of(context).size.height * 0.075,
        backgroundColor: CustomStyle.colorPalette.darkGrey,
      ),
      backgroundColor: CustomStyle.colorPalette.darkestGrey,
      body: TabBarView(controller: _tabController, children: [
        EditBody(
          errorIndex: errorIndex,
          dataController: dataController,
          textController: textController,
        ),
        RegisterBody()
      ]),
    );
  }
}
