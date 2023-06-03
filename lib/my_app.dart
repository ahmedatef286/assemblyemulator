import 'package:assemblyemulator/business_logic/view_models/instruction_provider.dart';
import 'package:assemblyemulator/business_logic/view_models/register_memory_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home/home_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegisterMAndMemoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InstructionProvider(),
        )
      ],
      child: MaterialApp(title: 'Mips Simulator', home: HomeScreen()),
    );
  }
}
