import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/utilities/app_styles.dart';
import 'package:todo/core/utilities/colors_manager.dart';
typedef OnChanged = void Function(String?);
class SettingsTap extends StatefulWidget {
  SettingsTap({super.key});

  @override
  State<SettingsTap> createState() => _SettingsTapState();
}

class _SettingsTapState extends State<SettingsTap> {
  String selectedLang='English';
  String selectedMode='Dark';

  List<String> langList=['English','Arabic'];
  List<String> modeList=['Light','Dark'];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Language',style: LightStyle.sittingsText),
          const SizedBox(height: 10,),
          buildSittingsItem(
              list: langList,
              selected: selectedLang,
              OnChanged: (item){
            selectedLang=item;
            setState(() {

            });
          }),
          const SizedBox(height: 30,),
          Text('Mode',style: LightStyle.sittingsText,),
          const SizedBox(height: 10,),
          buildSittingsItem(
              list: modeList,
              selected: selectedMode,
              OnChanged: (item){
                selectedMode=item;
                setState(() {

                });
              })
        ],
      ),
    );
  }
  Widget buildSittingsItem(
      { required List<String> list, required String selected, required OnChanged})=>Container(
      height: 48,
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          border: Border.all(width: 1,color: ColorsManager.blue)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(selected,style: LightStyle.selectedItem,),
          DropdownButton<String>(
            underline: Container(),
            items: list.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: OnChanged,
          ),
        ],
      ));

}
