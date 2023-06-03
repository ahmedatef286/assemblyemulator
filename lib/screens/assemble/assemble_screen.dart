import 'package:assemblyemulator/business_logic/view_models/instruction_provider.dart';
import 'package:assemblyemulator/business_logic/view_models/register_memory_provider.dart';
import 'package:assemblyemulator/custom_style.dart';
import 'package:assemblyemulator/screens/home/register_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssembleScreen extends StatefulWidget {
  const AssembleScreen({super.key});

  @override
  State<AssembleScreen> createState() => _AssembleScreenState();
}

class _AssembleScreenState extends State<AssembleScreen>
    with TickerProviderStateMixin {
  TextEditingController inputController = TextEditingController();
  late final TabController _tabController;

  final List<Tab> myTabs = [
    Tab(
      text: 'Execute',
      icon: Icon(Icons.arrow_downward_rounded),
    ),
    Tab(
      text: 'Registers',
      icon: Icon(Icons.select_all_rounded),
    ),
  ];
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
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer<InstructionProvider>(
              builder: (context, myType, child) {
                return FloatingActionButton(
                  heroTag: 'play all',
                  backgroundColor: myType.instructionPointer == 0
                      ? CustomStyle.colorPalette.cyan
                      : Colors.green.shade900,
                  child: const Icon(
                    Icons.play_arrow_rounded,
                  ),
                  onPressed: () {
                    if (!myType.enableInput)
                      Provider.of<InstructionProvider>(context, listen: false)
                          .executeAllInstructions(context);
                  },
                );
              },
            ),
            SizedBox(
              height: 6,
            ),
            Consumer<InstructionProvider>(
              builder: (context, myType, child) {
                return FloatingActionButton(
                  heroTag: 'play one',
                  backgroundColor: myType.instructionPointer == 0
                      ? CustomStyle.colorPalette.cyan
                      : Colors.green.shade900,
                  child: const Icon(
                    Icons.next_plan_outlined,
                  ),
                  onPressed: () {
                    if (!myType.enableInput)
                      Provider.of<InstructionProvider>(context, listen: false)
                          .executeSinleInstruction(context);
                  },
                );
              },
            ),
            SizedBox(
              height: 6,
            ),
            Consumer<InstructionProvider>(
              builder: (context, myType, child) {
                return FloatingActionButton(
                  heroTag: 'stop',
                  backgroundColor: myType.instructionPointer == 0
                      ? CustomStyle.colorPalette.cyan
                      : Colors.redAccent.shade700,
                  child: const Icon(
                    Icons.stop_rounded,
                  ),
                  onPressed: () {
                    Provider.of<RegisterMAndMemoryProvider>(context,
                            listen: false)
                        .clear();
                    myType.restartInstructions();
                  },
                );
              },
            ),
          ],
        ),
        appBar: AppBar(
          surfaceTintColor: CustomStyle.colorPalette.darkGrey,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Assemble',
            style: TextStyle(
                color: CustomStyle.colorPalette.lightGrey,
                fontSize: CustomStyle.fontSizes.mediumFont),
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.075,
          backgroundColor: CustomStyle.colorPalette.darkGrey,
          bottom: TabBar(
              indicatorWeight: 3,
              indicatorColor: CustomStyle.colorPalette.cyan,
              controller: _tabController,
              labelColor: CustomStyle.colorPalette.cyan,
              unselectedLabelColor: CustomStyle.colorPalette.lightGrey,
              tabs: myTabs),
        ),
        backgroundColor: CustomStyle.colorPalette.darkestGrey,
        body: TabBarView(controller: _tabController, children: [
          AssembleBody(inputController: inputController),
          RegisterBody()
        ]));
  }
}

class AssembleBody extends StatelessWidget {
  const AssembleBody({
    Key? key,
    required this.inputController,
  }) : super(key: key);

  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return Consumer<InstructionProvider>(
      builder: (context, myType, child) {
        final List<String> textInstructiions = myType.textInstructions;
        if (myType.showBottomSheet) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0))),
                  isScrollControlled: true,
                  backgroundColor: CustomStyle.colorPalette.darkGrey,
                  context: context,
                  builder: ((context) {
                    inputController.text += myType.outputMessages;
                    final tempText = inputController.text;
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: customTextField(
                          onEditingComplete: myType.enableInput
                              ? () {
                                  Provider.of<InstructionProvider>(context,
                                              listen: false)
                                          .input =
                                      inputController.text
                                          .replaceFirst(tempText, '');
                                  Provider.of<InstructionProvider>(context,
                                          listen: false)
                                      .toggleInput();
                                }
                              : null,
                          enabled: myType.enableInput,
                          keyboardType: TextInputType.text,
                          textEditingController: inputController,
                          hintText: '',
                          width: MediaQuery.of(context).size.width),
                    );
                  })));
        }
        return ListView.separated(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.02),
            separatorBuilder: (context, index) => Divider(
                  color: CustomStyle.colorPalette.white,
                ),
            itemCount: textInstructiions.length,
            itemBuilder: ((context, index) {
              return IntrinsicHeight(
                  child: ListTile(
                tileColor: index == myType.instructionPointer
                    ? CustomStyle.colorPalette.cyan
                    : Colors.transparent,
                title: Text(
                  textInstructiions[index].trim(),
                  style: TextStyle(
                      color: CustomStyle.colorPalette.white,
                      fontSize: CustomStyle.fontSizes.smallFont,
                      fontWeight: FontWeight.bold),
                ),
              ));
            }));
      },
    );
  }
}
