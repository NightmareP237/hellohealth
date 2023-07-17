import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hellohealth/screens/profile/profile_page.dart';
import 'package:hellohealth/widget/profile/button_widget.dart';
import 'package:hellohealth/widget/profile/profile_form_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:hellohealth/models/user.dart' as model;
import 'package:provider/provider.dart';
import '../../models/auth_provider.dart';
import '../../widget/profile/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  final model.User authUser;

  const EditProfilePage({Key? key, required this.authUser}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController.text = widget.authUser.name ?? '';
    _emailController.text =
        widget.authUser.phone.isEmpty ? '651734079@gmail.com' : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authStateProvider =
        Provider.of<AuthProvider>(context, listen: false);

    final nameField = TextFormField(
        controller: _nameController,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ));

    final emailField = TextFormField(
        controller: _emailController,
        validator: (value) {
          if (value!.isEmpty ||
              (!value.contains('@') && !value.contains('.'))) {
            return 'Enter a valid email address !';
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ));

    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final model.User user = model.User(
                createdAt: authStateProvider.authUser!.createdAt,
                role: authStateProvider.authUser!.role,
                id: authStateProvider.authUser!.id.isEmpty
                    ? 'kksjjdjjdjd'
                    : authStateProvider.authUser!.id,
                phone: _emailController.text,
                name: _nameController.text,
                password: authStateProvider.authUser?.password ?? 'hjhjhjhjhh');
            await authStateProvider.updateUser(user);
            if (!mounted) return;
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const ProfilePage()));
          }
        },
        child: Text(
          "Save",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Builder(
        builder: (context) => Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.moon_stars),
                  ),
                ],
              ),
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 32),
                physics: BouncingScrollPhysics(),
                children: [
                  ProfileFormWidget(
                    imagePath: authStateProvider.authUser!.imagePath ??
                        'assets/images/d7.jpeg',
                    isEdit: true,
                    onClicked: () async {
                      // final image = await ImagePicker()
                      //     // ignore: deprecated_member_use
                      //     .getImage(source: ImageSource.gallery);

                      // if (image == null) return;
                      // final directory =
                      //     await getApplicationDocumentsDirectory();
                      // final name = basename(image.path);
                      // final imageFile = File('${directory.path}/$name');
                      // final newImage =
                      //     await File(image.path).copy(imageFile.path);

                      /* setState(() => authStateProvider.authUser =
                          authStateProvider.authUser!.copy(imagePath: newImage.path));*/
                    },
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          nameField,
                          const SizedBox(height: 25.0),
                          emailField,
                          const SizedBox(height: 25.0),
                          SaveButon,
                          const SizedBox(height: 15.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
