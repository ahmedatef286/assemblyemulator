import 'package:assemblyemulator/business_logic/view_models/register_provider.dart';
import 'package:assemblyemulator/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterMAndMemoryProvider>(
      builder: (context, myType, child) {
        final List<String> regList = myType.registers.keys.toList();
        final List<String> regAlias = myType.registerAliases.keys.toList();
        return ListView.separated(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.02),
            separatorBuilder: (context, index) => Divider(
                  color: CustomStyle.colorPalette.white,
                ),
            itemCount: myType.registers.length + 1,
            itemBuilder: ((context, index) {
              if (index == 0) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        'Name',
                        style: TextStyle(
                            color: CustomStyle.colorPalette.white,
                            fontSize: CustomStyle.fontSizes.smallFont,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        'Number',
                        style: TextStyle(
                            color: CustomStyle.colorPalette.white,
                            fontSize: CustomStyle.fontSizes.smallFont,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      alignment: Alignment.center,
                      child: Text(
                        'Value',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: CustomStyle.fontSizes.smallFont,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              } else {
                return IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(
                          regAlias[index - 1],
                          style: TextStyle(
                              color: CustomStyle.colorPalette.white,
                              fontSize: CustomStyle.fontSizes.smallFont,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(
                          regList[index - 1],
                          style: TextStyle(
                              color: CustomStyle.colorPalette.white,
                              fontSize: CustomStyle.fontSizes.smallFont,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        alignment: Alignment.center,
                        child: Text(
                          '${myType.registers[regList[index - 1]]}',
                          style: TextStyle(
                              color: CustomStyle.colorPalette.amber,
                              fontSize: CustomStyle.fontSizes.smallFont,
                              fontWeight: FontWeight.w200),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }));
      },
    );
  }
}
