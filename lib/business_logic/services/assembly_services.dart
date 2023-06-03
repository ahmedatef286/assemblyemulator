import 'package:assemblyemulator/business_logic/view_models/instruction_provider.dart';
import 'package:assemblyemulator/business_logic/view_models/register_memory_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Map<String, int> registerValues = {
  "\$zero": 0,
  "\$at": 0,
  "\$v0": 0,
  "\$v1": 0,
  "\$a0": 0,
  "\$a1": 0,
  "\$a2": 0,
  "\$a3": 0,
  "\$t0": 0,
  "\$t1": 0,
  "\$t2": 0,
  "\$t3": 0,
  "\$t4": 0,
  "\$t5": 0,
  "\$t6": 0,
  "\$t7": 0,
  "\$s0": 5,
  "\$s1": 10,
  "\$s2": 0,
  "\$s3": 0,
  "\$s4": 0,
  "\$s5": 0,
  "\$s6": 0,
  "\$s7": 0,
  "\$t8": 0,
  "\$t9": 0,
  "\$k0": 0,
  "\$k1": 0,
  "\$gp": 0,
  "\$sp": 0,
  "\$fp": 0,
  "\$ra": 0,
};

/* void main() {
  var mipsinstruction = "subi \$t2, \$s0, 10";
  List<String> tokens = mipsinstruction.split(' ');

  executeInstruction(tokens);
} */

void add(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[1])!;
  int value2 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[2])!;

  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], value1 + value2);
}

void and(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[1])!;
  int value2 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[2])!;

  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], value1 & value2);
}

void or(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[1])!;
  int value2 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[2])!;

  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], value1 | value2);
}

void subtract(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[1])!;
  int value2 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[2])!;

  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], value1 - value2);
}

void multiply(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[1])!;
  int value2 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[2])!;

  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], value1 * value2);
}

void divide(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[1])!;
  int value2 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[2])!;
  if (value2 == 0) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('divide by zero')));
    return;
  }

  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], (value1 ~/ value2));
}

///////////////
void addi(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[1])!;
  int value2 = int.parse(tokens[2]);

  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], value1 + value2);
}

void andi(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[1])!;
  int value2 = int.parse(tokens[2]);

  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], value1 & value2);
}

void subi(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[1])!;
  int value2 = int.parse(tokens[2]);

  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], value1 - value2);
}

void ori(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[1])!;
  int value2 = int.parse(tokens[2]);

  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], value1 | value2);
}

///////
void move(List<String> tokens, BuildContext context) {
  int value = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[1])!;
  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], value);
}

////////////
void beq(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[0])!;
  int value2 = (int.tryParse(tokens.elementAt(1))) ??
      Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
          .getRegsiterValue(tokens[1])!;

  if (value1 == value2) {
    Provider.of<InstructionProvider>(context, listen: false)
        .jumpToInstruction(tokens[2]);
  }
}

void bne(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[0])!;
  int value2 = (int.tryParse(tokens.elementAt(1))) ??
      Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
          .getRegsiterValue(tokens[1])!;

  if (value1 != value2) {
    Provider.of<InstructionProvider>(context, listen: false)
        .jumpToInstruction(tokens[2]);
  }
}

void blt(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[0])!;

  int value2 = (int.tryParse(tokens.elementAt(1))) ??
      Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
          .getRegsiterValue(tokens[1])!;

  if (value1 < value2) {
    Provider.of<InstructionProvider>(context, listen: false)
        .jumpToInstruction(tokens[2]);
  }
}

void ble(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[0])!;
  int value2 = (int.tryParse(tokens.elementAt(1))) ??
      Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
          .getRegsiterValue(tokens[1])!;

  if (value1 <= value2) {
    Provider.of<InstructionProvider>(context, listen: false)
        .jumpToInstruction(tokens[2]);
  }
}

void bgt(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[0])!;
  int value2 = (int.tryParse(tokens.elementAt(1))) ??
      Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
          .getRegsiterValue(tokens[1])!;

  if (value1 > value2) {
    Provider.of<InstructionProvider>(context, listen: false)
        .jumpToInstruction(tokens[2]);
  }
}

void bge(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[0])!;
  int value2 = (int.tryParse(tokens.elementAt(1))) ??
      Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
          .getRegsiterValue(tokens[1])!;

  if (value1 >= value2) {
    Provider.of<InstructionProvider>(context, listen: false)
        .jumpToInstruction(tokens[2]);
  }
}

///
void slt(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[1])!;
  int value2 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[2])!;

  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], (value1 < value2) ? 1 : 0);
}

void slti(List<String> tokens, BuildContext context) {
  int value1 = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[1])!;
  int value2 = int.parse(tokens[2]);

  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], (value1 < value2) ? 1 : 0);
}

void jump(List<String> tokens, BuildContext context) {
  Provider.of<InstructionProvider>(context, listen: false)
      .jumpToInstruction(tokens[0]);
}

void jumpAndLink(List<String> tokens, BuildContext context) {
  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue('\$ra', int.parse(tokens[1]));

  Provider.of<InstructionProvider>(context, listen: false)
      .jumpToInstruction(tokens[0]);
}

void terminate() {}
void doNothing() {}
////
void loadWord(List<String> tokens, BuildContext context) {
  int offset = int.parse(tokens[2]);
  int sourceAddress =
      Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
              .getRegsiterValue(tokens[1])! +
          offset;
  dynamic value =
      Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
          .getMemoryValueAtAdress(sourceAddress);
  if (value == null) {
    Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
        .updateRegsiterValue(tokens[0], 0);
    return;
  }
  if (value.runtimeType == String) {
    value = sourceAddress;
  }
  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], value);
}

void savedWord(List<String> tokens, BuildContext context) {
  int offset = int.parse(tokens[2]);
  int destinationAddress =
      Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
          .getRegsiterValue(tokens[1])!;
  int value = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .getRegsiterValue(tokens[0])!;
  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .putValueInMemory(offset + destinationAddress, value);
}

void loadAscii(List<String> tokens, BuildContext context) {
  dynamic value =
      Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
          .getMemoryValueVariableName(tokens[1]);
  if (value == null) {
    value = 0;
  } else if (value.runtimeType == String) {
    value = Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
        .getVariableAddress(tokens[1]);
  }
  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], value);
}

void loadImmediate(List<String> tokens, BuildContext context) {
  int value1 = int.parse(tokens[1]);
  Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
      .updateRegsiterValue(tokens[0], value1);
}

void syscall(BuildContext context) {
  int operation =
      Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
          .getRegsiterValue('\$v0')!;
  switch (operation) {
    case 1:
      {
        int valueToPrint =
            Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
                .getRegsiterValue('\$a0')!;
      }

      break;

    case 5:
      break;

    case 4:
      int valueAddressToPrint =
          Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
              .getRegsiterValue('\$a0')!;
      String valueToPrint =
          Provider.of<RegisterMAndMemoryProvider>(context, listen: false)
              .getMemoryValueAtAdress(valueAddressToPrint);

      break;

    default:
  }
}
