import 'package:brew_crew/models/my_user.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/database.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  String? _currentname = null;
  String? _currensugars = null;
  int? _currenstrength = null;

  final List<String> sugars = ['0','1','2','3','4'];

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);

    return StreamBuilder<MyUserData>(
      stream: DatabaseService(uid: user?.uid).userData,
      builder: (context, snapshot) {

        if (snapshot.hasData) {

          MyUserData? myUserData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Update your brew settings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                SizedBox(height: 25,),
                TextFormField(
                  initialValue: myUserData?.name,
                  decoration: textInputDecoration.copyWith(hintText: 'name'),
                  validator: (val) => val!.isEmpty ? 'please enter a name' : null,
                  onChanged: (val) => setState(() => _currentname = val),
                ),
                SizedBox(height: 15),
                DropdownButtonFormField(
                  value: _currensugars ?? myUserData?.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  validator: (val) => val!.isEmpty ? 'please enter sugar preference' : null,
                  onChanged: (val) => setState(() => _currensugars = val),
                  decoration: textInputDecoration.copyWith(hintText: 'sugars'),
                ),
                Slider(
                  value: (_currenstrength ?? myUserData?.strength)!.toDouble(),
                  onChanged: (val) => setState(() => _currenstrength = val.round()),
                  min: 100,
                  max: 900,
                  divisions: 8,
                  activeColor: Colors.brown[_currenstrength ?? 100],
                  inactiveColor: Colors.brown[_currenstrength ?? 100],
                ),
                SizedBox(height: 15),
                ElevatedButton(onPressed: () async {
                  if(_formKey.currentState!.validate()) {
                    await DatabaseService(uid: user?.uid).updateUserData(
                      _currensugars ?? myUserData!.sugars!,
                      _currentname ?? myUserData!.name!,
                      _currenstrength ?? myUserData!.strength!,
                    );
                    Navigator.pop(context);
                  }
                },
                  child: Text('Update', style: TextStyle(color: Colors.white),),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                      Colors.pink[300])),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      }
    );
  }
}
