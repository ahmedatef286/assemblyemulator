import 'package:assemblyemulator/business_logic/services/assembly_services.dart';
import 'package:flutter/material.dart';

class InstructionProvider extends ChangeNotifier {
  List<String> instructions =
      []; //will contain all separate instructions after being parsed

  Map<String, int> instructionsAndNumberOfOperands = {
    'add': 3,
    'sub': 3,
    'div': 3,
    'mul': 3,
    ////////
    'addi': 3,
    'subi': 3,
    ///////
    'lw': 2,
    'sw': 2,
    'la': 2,
    'li': 2,
    /////
    'move': 2,
    ///////
    'beq': 3,
    'bne': 3,
    'bgt': 3,
    'blt': 3,
    'bge': 3,
    'ble': 3,
    //
    'slt': 3,
    'slti': 3,
    ////
    'j': 1,
    'jal': 1,
    //
    'syscall': 0,
  };
  Map<String, Function> instructionFunctions = {
    'add': add,
    'sub': subtract,
    'div': divide,
    'mul': multiply,
    ////////
    'addi': addi,
    'subi': subi,
    ///////
    'lw': loadWord,
    'sw': savedWord,
    'la': loadAscii,
    'li': loadImmediate,
    /////
    'move': move,
    ///////
    'beq': beq,
    'bne': bne,
    'bgt': bgt,
    'blt': blt,
    'bge': bge,
    'ble': ble,
    //
    'slt': slt,
    'slti': slti,
    ////
    'j': jump,
    'jal': jumpAndLink,
    //
    'syscall': syscall,
  };

  int loadInstructions(String instructions) {
    instructions = instructions
        .toLowerCase(); //set all to lowercase since mips is not case sensetive

    List<String> tempInstructionsList =
        instructions.split('\n'); //split line by line
    if (tempInstructionsList[0].trim() == '.data') {
      //contains .data and .text section

    } else {}

    return -1;
  }
}
