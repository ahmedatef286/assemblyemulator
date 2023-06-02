import 'package:assemblyemulator/business_logic/services/assembly_services.dart';
import 'package:assemblyemulator/business_logic/view_models/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstructionProvider extends ChangeNotifier {
  int instructionPointer = 0;
  List<FunctionWithParameters> instructionsContainer =
      []; //will contain all separate instructions after being parsed
  List<String> textInstructions = [];
  List<String> dataInstructions =
      []; //will contain all separate .data code after being parsed

  Map<String, int> labelIndecies = {};
  Map<int, String> labelsToCheck = {};

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
    //
    'syscall': syscall,
  };

  int loadInstructions(String instructions, BuildContext context) {
    instructions = instructions
        .toLowerCase(); //set all to lowercase since mips is not case sensetive

    List<String> tempInstructionsList =
        instructions.split('\n'); //split line by line
    int counter = 0;
    for (String instructionLine in tempInstructionsList) {
      String line = instructionLine.trim();
      if (line.isEmpty) continue;
      //remove comments from parsing
      if (line.contains('#')) {
        line.replaceRange(line.indexOf('#'), null, '');
      }
      //check if this is a label not an instruction

      if (line.contains(':')) {
        if (line.split(':').length - 1 == 1) {
          List<String> parts = line.trim().replaceAll(':', ' :').split(' ');
          //acount for whitespace in the middle
          parts.removeWhere((element) => element == ' ' || element == '');
          if (parts.length == 2 && parts.first.contains(RegExp(r'[a-z]'))) {
            labelIndecies[parts.first] = instructionsContainer.length;
          } else {
            return counter;
          }
        } else {
          //if it is wrong returns the index of the wrong line

          return counter;
        }
      }
      //check if systemcall
      else {
        if (line.trim() == 'syscall') {
        } else {
          List<String> splitLine = line.split(' ');
          //account for extra white space
          splitLine.removeWhere((element) => element == ' ');
          //checking operation type
          String operation = splitLine.first;
          splitLine = line
              .replaceFirst(operation, '')
              .split(',')
              .map((e) => e.trim())
              .toList();

          if (instructionsAndNumberOfOperands.containsKey(operation)) {
            if (splitLine.length ==
                instructionsAndNumberOfOperands[operation]!) {
              final registeraliases = Provider.of<RegisterMAndMemoryProvider>(
                      context,
                      listen: false)
                  .registerAliases;
              switch (operation) {
                case 'add':
                case 'sub':
                case 'mul':
                case 'div':
                  {
                    //check if all register names are validd
                    for (final reg in splitLine) {
                      if (!(registeraliases.containsKey(reg) ||
                          registeraliases.containsValue(reg))) return counter;
                    }

                    instructionsContainer.add(FunctionWithParameters(
                        instructionFunctions[operation]!, splitLine));
                  }
                  break;
                case 'addi':
                case 'subi':
                  {
                    //check if all register names are validd
                    for (final reg in splitLine.take(2)) {
                      if (!(registeraliases.containsKey(reg) ||
                          registeraliases.containsValue(reg))) return counter;
                    }
                    //third element must be a number
                    if (int.tryParse(splitLine.elementAt(2)) == null) {
                      return counter;
                    }
                    instructionsContainer.add(FunctionWithParameters(
                        instructionFunctions[operation]!, splitLine));
                  }
                  break;
                case 'beq':
                case 'bne':
                case 'bge':
                case 'ble':
                case 'bgt':
                case 'blt':
                  {
                    //check if  register name is validd

                    if (!(registeraliases.containsKey(splitLine[0]) ||
                        registeraliases.containsValue(0))) return counter;
                    if (!(registeraliases.containsKey(splitLine[0]) ||
                        registeraliases.containsValue(0))) return counter;

                    //second element must be a number or register and third must be a label
                    if ((int.tryParse(splitLine.elementAt(1)) != null ||
                            (registeraliases.containsKey(splitLine[0]) ||
                                registeraliases.containsValue(0))) &
                        splitLine[2].contains(RegExp(r'[a-z]'))) {
                      instructionsContainer.add(FunctionWithParameters(
                          instructionFunctions[operation]!, splitLine));
                      labelsToCheck[counter] = splitLine[2];
                    } else {
                      return counter;
                    }
                  }
                  break;
                case 'slt':
                  {
                    //check if all register names are validd
                    for (final reg in splitLine) {
                      if (!(registeraliases.containsKey(reg) ||
                          registeraliases.containsValue(reg))) return counter;
                    }
                    instructionsContainer.add(FunctionWithParameters(
                        instructionFunctions[operation]!, splitLine));
                  }
                  break;
                case 'slti':
                  {
                    //check if all register names are validd
                    for (final reg in splitLine.take(2)) {
                      if (!(registeraliases.containsKey(reg) ||
                          registeraliases.containsValue(reg))) return counter;
                    }
                    //third element must be a number
                    if (int.tryParse(splitLine.elementAt(2)) == null) {
                      return counter;
                    }
                    instructionsContainer.add(FunctionWithParameters(
                        instructionFunctions[operation]!, splitLine));
                  }
                  break;

                case 'move':
                  {
                    //check if all register names are validd
                    for (final reg in splitLine) {
                      if (!(registeraliases.containsKey(reg) ||
                          registeraliases.containsValue(reg))) return counter;
                    }
                    instructionsContainer.add(FunctionWithParameters(
                        instructionFunctions[operation]!, splitLine));
                  }
                  break;
                case 'j':
                  {
                    //check if all register names are validd
                    for (final reg in splitLine) {
                      if (!(registeraliases.containsKey(reg) ||
                          registeraliases.containsValue(reg))) return counter;
                    }
                    instructionsContainer.add(FunctionWithParameters(
                        instructionFunctions[operation]!, splitLine));
                    labelsToCheck[counter] = splitLine[0];
                  }
                  break;
                default:
                  return counter;
              }
            }
          } else {
            return counter;
          }
        }
      }
      textInstructions.add(instructionLine);
      counter++;
    }
    for (final map in labelsToCheck.entries) {
      if (!labelIndecies.containsKey(map.value)) {
        return map.key;
      }
    }
    instructionsContainer.add(FunctionWithParameters(terminate, []));

    return -1;
  }

  void executeInstruction(BuildContext context) {
    while (instructionPointer < instructionsContainer.length) {
      if (instructionsContainer[instructionPointer].function == terminate) {
        return;
      }
      List<dynamic> myList = [];
      myList.add(instructionsContainer[instructionPointer].parameters);
      myList.add(context);

      Function.apply(
        instructionsContainer[instructionPointer].function,
        myList,
      );
      instructionPointer++;
    }
    clearInstructions();
    Provider.of<RegisterMAndMemoryProvider>(context, listen: false).clear();
  }

  void clearInstructions() {
    instructionPointer = 0;
    instructionsContainer = [];
    labelIndecies = {};
    labelsToCheck = {};
  }

  void jumpToInstruction(String label) {
    instructionPointer = labelIndecies[label]!;
    notifyListeners();
  }
}

class FunctionWithParameters {
  final Function function;

  final List<dynamic> parameters;

  FunctionWithParameters(this.function, this.parameters);
}
