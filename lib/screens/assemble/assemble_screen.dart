import 'package:assemblyemulator/business_logic/view_models/register_provider.dart';
import 'package:assemblyemulator/custom_style.dart';
import 'package:assemblyemulator/screens/home/edit_body.dart';
import 'package:assemblyemulator/screens/home/register_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssembleScreen extends StatefulWidget {
  const AssembleScreen({super.key});

  @override
  State<AssembleScreen> createState() => _AssembleScreenState();
}

class _AssembleScreenState extends State<AssembleScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomStyle.colorPalette.cyan,
          child: const Icon(
            Icons.play_arrow_rounded,
          ),
          onPressed: () {},
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
        ),
        backgroundColor: CustomStyle.colorPalette.darkestGrey,
        body: Container());
  }
}
