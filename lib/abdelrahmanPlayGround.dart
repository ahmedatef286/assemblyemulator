



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

void main() {
  var mipsinstruction = "slt \$s2 \$s0 \$s1";
  
  List<String> tokens = mipsinstruction.replaceAll(' ', ',').split(',');

  slt(tokens);
  //slti(tokens); 

  
}



void add(List<String> tokens) {
  int destination = registerValues[tokens[1].replaceAll(",", "")] ?? 0;
  int Svalue1 = registerValues[tokens[2].replaceAll(",", "")] ?? 0;
  int Svalue2 = registerValues[tokens[3].replaceAll(",", "")] ?? 0;

  destination = Svalue1 + Svalue2;
  registerValues[tokens[1].replaceAll(",", "")] = destination;
  
  print("Sum of register values: $destination");
}

void subtract(List<String> tokens) {
  int destination = registerValues[tokens[1].replaceAll(",", "")] ?? 0;
  int Svalue1 = registerValues[tokens[2].replaceAll(",", "")] ?? 0;
  int Svalue2 = registerValues[tokens[3].replaceAll(",", "")] ?? 0;

  destination = Svalue1 - Svalue2;
  registerValues[tokens[1].replaceAll(",", "")] = destination;
  print(registerValues);

  print("Difference of register values: $destination");
}

void multiply(List<String> tokens) {
  int destination = registerValues[tokens[1].replaceAll(",", "")] ?? 0;
  int Svalue1 = registerValues[tokens[2].replaceAll(",", "")] ?? 0;
  int Svalue2 = registerValues[tokens[3].replaceAll(",", "")] ?? 0;

  destination = Svalue1 * Svalue2;
  registerValues[tokens[1].replaceAll(",", "")] = destination;

  print("Product of register values: $destination");
}

void divide(List<String> tokens) {
  int destination = registerValues[tokens[1].replaceAll(",", "")] ?? 0;
  int Svalue1 = registerValues[tokens[2].replaceAll(",", "")] ?? 0;
  int Svalue2 = registerValues[tokens[3].replaceAll(",", "")] ?? 0;

  if (Svalue2 != 0) {
    destination = Svalue1 ~/ Svalue2;
    registerValues[tokens[1].replaceAll(",", "")] = destination;
    print("Division of register values: $destination");
  } else {
    print("Error: Division by zero");
  }

}

void addi(tokens){
  int destination = registerValues[tokens[1].replaceAll(",", "")] ?? 0;
  int Svalue1 = registerValues[tokens[2].replaceAll(",", "")] ?? 0;
  int immeadiat = int.parse(tokens[3].replaceAll(",", ""));

  destination=Svalue1+immeadiat;
  registerValues[tokens[1].replaceAll(",", "")] = destination;

  print(destination);
  print(registerValues);

  }



  void subi(tokens){
  int destination = registerValues[tokens[1].replaceAll(",", "")] ?? 0;
  int Svalue1 = registerValues[tokens[2].replaceAll(",", "")] ?? 0;
  int immeadiat = int.parse(tokens[3].replaceAll(",", ""));

  destination=Svalue1-immeadiat;
  registerValues[tokens[1].replaceAll(",", "")] = destination;

  print(destination);
  print(registerValues);


  }



bool beq(dynamic tokens){
  
  int Svalue1 = registerValues[tokens[1].replaceAll(",", "")] ?? 0;
  int Svalue2 = registerValues[tokens[2].replaceAll(",", "")] ?? 0;
  String label=tokens[3].replaceAll(",", "");



  if (Svalue1==Svalue2){

  return true;

  
}


  return false;

}


bool bne(dynamic tokens){
  
  int Svalue1 = registerValues[tokens[1].replaceAll(",", "")] ?? 0;
  int Svalue2 = registerValues[tokens[2].replaceAll(",", "")] ?? 0;
  String label=tokens[3].replaceAll(",", "");



  if (Svalue1!=Svalue2){

  return true;

  
}


  return false;

}

bool bgt(dynamic tokens){
  
  int Svalue1 = registerValues[tokens[1].replaceAll(",", "")] ?? 0;
  int Svalue2 = registerValues[tokens[2].replaceAll(",", "")] ?? 0;
  String label=tokens[3].replaceAll(",", "");



  if (Svalue1>Svalue2){

  return true;

  
}


  return false;

}


bool blt(dynamic tokens){
  
  int Svalue1 = registerValues[tokens[1].replaceAll(",", "")] ?? 0;
  int Svalue2 = registerValues[tokens[2].replaceAll(",", "")] ?? 0;
  String label=tokens[3].replaceAll(",", "");



  if (Svalue1<Svalue2){

  return true;

  
}


  return false;

}


bool bge(dynamic tokens){
  
  int Svalue1 = registerValues[tokens[1].replaceAll(",", "")] ?? 0;
  int Svalue2 = registerValues[tokens[2].replaceAll(",", "")] ?? 0;
  String label=tokens[3].replaceAll(",", "");



  if (Svalue1>=Svalue2){

  return true;

  
}


  return false;

}



bool ble(dynamic tokens){
  
  int Svalue1 = registerValues[tokens[1].replaceAll(",", "")] ?? 0;
  int Svalue2 = registerValues[tokens[2].replaceAll(",", "")] ?? 0;
  String label=tokens[3].replaceAll(",", "");



  if (Svalue1<=Svalue2){

  return true;

  
}


  return false;

}



void slti(tokens){
  int destination = registerValues[tokens[1].replaceAll(",", "")] ?? 0;
  int Svalue1 = registerValues[tokens[2].replaceAll(",", "")] ?? 0;
  int immeadiat =(tokens[3].replaceAll(",", ""));

  if (Svalue1<immeadiat)
    destination=1;

  registerValues[tokens[1].replaceAll(",", "")] = destination;


}

void slt(tokens){
  int destination = registerValues[tokens[1].replaceAll(",", "")] ?? 0;
  int Svalue1 = registerValues[tokens[2].replaceAll(",", "")] ?? 0;
   int Svalue2 = registerValues[tokens[3].replaceAll(",", "")] ?? 0;

  if (Svalue1<Svalue2){
    destination=1;
    registerValues[tokens[1].replaceAll(",", "")] = destination;

  }
    

  else{
    destination=0;
    registerValues[tokens[1].replaceAll(",", "")] = destination;
  }
   

  print(destination);
  print(registerValues);

  }



