import 'package:assemblyemulator/business_logic/services/assembly_services.dart';
import 'package:assemblyemulator/business_logic/view_models/register_memory_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstructionProvider extends ChangeNotifier {
  int instructionPointer = 0;
  String outputMessages = '';
  String input = '';
  bool enableInput = false;
  bool showBottomSheet = false;
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
    'and': and,
    'andi': andi,
    'or': or,
    'ori': ori,
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
    clearInstructions();
    Provider.of<RegisterMAndMemoryProvider>(context, listen: false).clear();
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
        line = line.replaceRange(line.indexOf('#'), null, '').trim();
      }
      //check if this is a label not an instruction

      if (line.contains(':')) {
        if (line.split(':').length - 1 == 1) {
          List<String> parts = line.trim().replaceAll(':', ' :').split(' ');
          //acount for whitespace in the middle
          parts.removeWhere((element) => element == ' ' || element == '');
          if (parts.length == 2 && parts.first.contains(RegExp(r'[a-z]'))) {
            labelIndecies[parts.first] = instructionsContainer.length;
            instructionsContainer.add(FunctionWithParameters(doNothing, []));
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
          instructionsContainer.add(
              FunctionWithParameters(instructionFunctions[line.trim()]!, []));
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
                case 'and':
                case 'or':
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
                case 'andi':
                case 'ori':
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
                            (registeraliases.containsKey(splitLine[1]) ||
                                registeraliases.containsValue(splitLine[1]))) &
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
                case 'li':
                  {
                    //check if all register names are validd

                    if (!(registeraliases.containsKey(splitLine[0]) ||
                        registeraliases.containsValue(splitLine[0]))) {
                      return counter;
                    }
                    if (int.tryParse(splitLine.elementAt(1)) == null) {
                      return counter;
                    }

                    instructionsContainer.add(FunctionWithParameters(
                        instructionFunctions[operation]!, splitLine));
                  }
                  break;
                case 'j':
                  {
                    instructionsContainer.add(FunctionWithParameters(
                        instructionFunctions[operation]!, splitLine));
                    labelsToCheck[counter] = splitLine[0];
                  }
                  break;
                /*  case 'jal':
                  {
                    splitLine.add('$counter');
                    instructionsContainer.add(FunctionWithParameters(
                        instructionFunctions[operation]!, splitLine));
                    labelsToCheck[counter] = splitLine[0];
                  }
                  break; */
                case 'sw':
                  {
                    if ((int.tryParse(splitLine[1].trim().split('(').first) ==
                        null)) return counter;
                    int offset =
                        int.parse((splitLine[1].trim().split('(').first));
                    splitLine[1] = splitLine[1].replaceFirst('(', '');
                    splitLine[1] = splitLine[1].replaceFirst(')', '');
                    splitLine[1] =
                        splitLine[1].replaceFirst('$offset', '').trim();
                    //check if all register names are validd
                    for (final reg in splitLine) {
                      if (!(registeraliases.containsKey(reg) ||
                          registeraliases.containsValue(reg))) return counter;
                    }
                    List<String> params = [];
                    params.addAll(splitLine);
                    params.add('$offset');
                    instructionsContainer.add(FunctionWithParameters(
                        instructionFunctions[operation]!, params));
                  }
                  break;
                case 'lw':
                  {
                    if ((int.tryParse(splitLine[1].trim().split('(').first) ==
                        null)) return counter;
                    int offset =
                        int.parse((splitLine[1].trim().split('(').first));
                    splitLine[1] = splitLine[1].replaceFirst('(', '');
                    splitLine[1] = splitLine[1].replaceFirst(')', '');
                    splitLine[1] =
                        splitLine[1].replaceFirst('$offset', '').trim();
                    //check if all register names are validd
                    for (final reg in splitLine) {
                      if (!(registeraliases.containsKey(reg) ||
                          registeraliases.containsValue(reg))) return counter;
                    }
                    List<String> params = [];
                    params.addAll(splitLine);
                    params.add('$offset');
                    instructionsContainer.add(FunctionWithParameters(
                        instructionFunctions[operation]!, params));
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

  void executeAllInstructions(BuildContext context) {
    while (instructionPointer < instructionsContainer.length) {
      if (instructionsContainer[instructionPointer].function == terminate) {
        return;
      }
      if (instructionsContainer[instructionPointer].function == doNothing) {
        instructionPointer++;
        continue;
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
    notifyListeners();
  }

  void executeSinleInstruction(BuildContext context) {
    if (instructionPointer < instructionsContainer.length) {
      if (instructionsContainer[instructionPointer].function == terminate) {
        return;
      }
      if (instructionsContainer[instructionPointer].function == doNothing) {
        instructionPointer++;
        notifyListeners();
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
    notifyListeners();
  }

  void clearInstructions() {
    instructionPointer = 0;
    instructionsContainer = [];
    textInstructions = [];

    labelIndecies = {};
    labelsToCheck = {};
  }

  void restartInstructions() {
    instructionPointer = 0;
    notifyListeners();
  }

  void toggleInput() {
    enableInput = !enableInput;
    notifyListeners();
  }

  void jumpToInstruction(String label) {
    instructionPointer = labelIndecies[label]! - 1;
    notifyListeners();
  }
}

class FunctionWithParameters {
  final Function function;

  final List<dynamic> parameters;

  FunctionWithParameters(this.function, this.parameters);
}
