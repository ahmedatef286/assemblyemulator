import 'package:flutter/foundation.dart';

class RegisterMAndMemoryProvider extends ChangeNotifier {
  List<dynamic> memory = List.filled(1024,
      null); // in mips registers only hold int data, so when a variable of type string is created and stored in $a0 for example ,this list will hold the value and the register will store the index of the value of that variable an

  Map<String, int> variableMemoryAddress = {};

  int firstEmptyMemoryAddress = 0;

  Map<String, dynamic> registers = {
    "\$0": 0,
    "\$1": 0,
    "\$2": 0,
    "\$3": 0,
    "\$4": 0,
    "\$5": 0,
    "\$6": 0,
    "\$7": 0,
    "\$8": 0,
    "\$9": 0,
    "\$10": 0,
    "\$11": 0,
    "\$12": 0,
    "\$13": 0,
    "\$14": 0,
    "\$15": 0,
    "\$16": 0,
    "\$17": 0,
    "\$18": 0,
    "\$19": 0,
    "\$20": 0,
    "\$21": 0,
    "\$22": 0,
    "\$23": 0,
    "\$24": 0,
    "\$25": 0,
    "\$26": 0,
    "\$27": 0,
    "\$28": 0,
    "\$29": 0,
    "\$30": 0,
    "\$31": 0
  };
  Map<String, String> registerAliases = {
    "\$zero": "\$0",
    "\$at": "\$1",
    "\$v0": "\$2",
    "\$v1": "\$3",
    "\$a0": "\$4",
    "\$a1": "\$5",
    "\$a2": "\$6",
    "\$a3": "\$7",
    "\$t0": "\$8",
    "\$t1": "\$9",
    "\$t2": "\$10",
    "\$t3": "\$11",
    "\$t4": "\$12",
    "\$t5": "\$13",
    "\$t6": "\$14",
    "\$t7": "\$15",
    "\$s0": "\$16",
    "\$s1": "\$17",
    "\$s2": "\$18",
    "\$s3": "\$19",
    "\$s4": "\$20",
    "\$s5": "\$21",
    "\$s6": "\$22",
    "\$s7": "\$23",
    "\$t8": "\$24",
    "\$t9": "\$25",
    "\$k0": "\$26",
    "\$k1": "\$27",
    "\$gp": "\$28",
    "\$sp": "\$29",
    "\$fp": "\$30",
    "\$ra": "\$31"
  };

  //memory
  int putVariableInMemory(String variableName, dynamic value) {
    //puts variable in memory , returns address
    if (variableMemoryAddress.containsKey(variableName)) {
      memory[variableMemoryAddress[variableName]!] = value;
      return variableMemoryAddress[variableName]!;
    } else {
      memory[firstEmptyMemoryAddress] = value;
      variableMemoryAddress[variableName] = firstEmptyMemoryAddress;
      firstEmptyMemoryAddress += 1;
      return firstEmptyMemoryAddress - 1;
    }
  }

  dynamic getMemoryValueAtAdress(int address) {
    if (address < memory.length && address >= 9) {
      return memory[address];
    } else {
      return null;
    }
  }

  dynamic getMemoryValueVariableName(String name) {
    if (variableMemoryAddress.containsKey(name)) {
      return memory[variableMemoryAddress[name]!];
    }
    return null;
  }

  int? getVariableAddress(String name) {
    if (variableMemoryAddress.containsKey(name)) {
      return variableMemoryAddress[name]!;
    }
    return null;
  }

  //registers
  int? getRegsiterValue(String regName) {
    if (registerAliases.containsKey(regName)) {
      regName = registerAliases[regName]!;
    }
    if (registers.containsKey(regName)) {
      return registers[regName];
    } else {
      return null;
    }
  }

  bool updateRegsiterValue(String regName, int value) {
    if (registerAliases.containsKey(regName)) {
      regName = registerAliases[regName]!;
    }
    if (registers.containsKey(regName)) {
      registers[regName] = value;
      return true;
    } else {
      return false;
    }
  }

  void emptyTempRegisters() {
    for (int i = 8; i <= 15; i++) {
      registers['\$t$i'] = 0;
    }
    registers['\$t${24}'] = 0;
    registers['\$t${25}'] = 0;
  }
}
