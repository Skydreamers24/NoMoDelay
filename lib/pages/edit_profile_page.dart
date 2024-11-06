import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:image_picker/image_picker.dart';

import 'package:skywalker/backend/database.dart';
import 'package:skywalker/backend/account.dart';
import 'package:skywalker/misc/name.dart';
import 'package:skywalker/misc/values.dart';
import 'package:skywalker/widgets/other/adaptive.dart';
import 'package:skywalker/widgets/other/profile_image.dart';
import 'package:skywalker/widgets/other/form_fields.dart';

class EditProfilePage extends StatefulWidget {
  final void Function() onSave;
  final AccountData account;
  final bool hasBackButton;
  const EditProfilePage(
      {super.key,
      required this.account,
      required this.onSave,
      this.hasBackButton = true});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  var accountStaging = AccountStaging();
  var didSubmit = false;

  @override
  void didUpdateWidget(covariant EditProfilePage oldWidget) {
    setAccountStaging(widget.account);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    setAccountStaging(widget.account);
    super.initState();
  }

  void setAccountStaging(AccountData account) async {
    accountStaging["givenName"] = account.name.given;
    accountStaging["familyName"] = account.name.family;
    accountStaging["dateOfBirth"] = account.dateOfBirth;
    accountStaging["email"] = account.email;
    accountStaging["phoneNo"] = account.phoneNo;
    accountStaging["gender"] = account.gender;
  }

  void setProfileImage(String profileImage) {
    setState(() {
      accountStaging["profileImage"] = profileImage;
    });
  }

  void setDidSubmit(bool didSubmit) {
    setState(() {
      this.didSubmit = didSubmit;
    });
  }

  List<Widget> widgets(BuildContext context) {
    return [
      I18n.locale.languageCode == "zh"
          ? TextFormFieldRow(
              labelText: "Family Name",
              accountStaging: accountStaging,
              valueToChange: "familyName",
            )
          : TextFormFieldRow(
              labelText: "Given Name",
              accountStaging: accountStaging,
              valueToChange: "givenName",
            ),
      I18n.locale.languageCode == "zh"
          ? TextFormFieldRow(
              labelText: "Given Name",
              accountStaging: accountStaging,
              valueToChange: "givenName",
            )
          : TextFormFieldRow(
              labelText: "Family Name",
              accountStaging: accountStaging,
              valueToChange: "familyName",
            ),
      EditGenderRow(
        accountStaging: accountStaging,
      ),
      EditDateOfBirthRow(accountStaging: accountStaging),
      PhoneNumberFieldRow(
        labelText: "Phone Number",
        validator: (value) =>
            value != null && value.isNotEmpty && int.tryParse(value) == null
                ? ""
                : null,
        accountStaging: accountStaging,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return widget.account.copyWith(
        child: Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          leading: widget.hasBackButton
              ? const Padding(
                  padding: comfortable,
                  child: BackButton(),
                )
              : null,
          title: Text(
            "Edit Profile",
            style: heading(context),
          ),
          actions: [
            Padding(
              padding: comfortableHorizontal,
              child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save;
                      toDatabaseSync(widget.account.copyWith(
                          name: Name(accountStaging["givenName"],
                              accountStaging["familyName"]),
                          email: accountStaging["email"],
                          phoneNo: accountStaging["phoneNo"],
                          gender: accountStaging["gender"],
                          age: accountStaging["age"],
                          dateOfBirth: accountStaging["dateOfBirth"]));
                      setDidSubmit(true);
                      widget.onSave();
                      if (widget.hasBackButton) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: didSubmit
                      ? const CircularProgressIndicator.adaptive()
                      : const Text(
                          "Save",
                        )),
            )
          ],
        ),
        body: Adaptive(
          horizontal: EditProfilePageHorizontal(
            updateAccountPage: widget.onSave,
            widgets: widgets,
          ),
          vertical: EditProfilePageVertical(
            updateAccountPage: widget.onSave,
            widgets: widgets,
          ),
        ),
      ),
    ));
  }
}

class EditProfilePageVertical extends StatefulWidget {
  final void Function() updateAccountPage;
  final List<Widget> Function(BuildContext) widgets;
  const EditProfilePageVertical(
      {super.key, required this.updateAccountPage, required this.widgets});

  @override
  State<EditProfilePageVertical> createState() =>
      _EditProfilePageVerticalState();
}

class _EditProfilePageVerticalState extends State<EditProfilePageVertical> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 8,
            ),
            Column(
              children: [
                for (var widget in widget.widgets(context))
                  Padding(
                    padding: comfortableListChildren,
                    child: widget,
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class EditProfilePageHorizontal extends StatefulWidget {
  final void Function() updateAccountPage;
  final List<Widget> Function(BuildContext) widgets;
  const EditProfilePageHorizontal(
      {super.key, required this.updateAccountPage, required this.widgets});

  @override
  State<EditProfilePageHorizontal> createState() =>
      _EditProfilePageHorizontalState();
}

class _EditProfilePageHorizontalState extends State<EditProfilePageHorizontal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 8,
            ),
            for (var widget in widget.widgets(context))
              Padding(
                padding: comfortableListChildren,
                child: widget,
              )
          ],
        ),
      ),
    );
  }
}

class ProfileImageEditBox extends StatefulWidget {
  const ProfileImageEditBox(
      {super.key,
      required this.profileImage,
      required this.unsetProfileImage,
      required this.onProfileImageChanged});

  final String profileImage;
  final void Function() unsetProfileImage;
  final void Function(String) onProfileImageChanged;

  @override
  State<ProfileImageEditBox> createState() => _ProfileImageEditBoxState();
}

class _ProfileImageEditBoxState extends State<ProfileImageEditBox> {
  @override
  Widget build(BuildContext context) {
    final account = Account.of(context);
    return SizedBox(
      width: 221,
      height: 260,
      child: Stack(
        children: [
          Padding(
            padding: comfortable,
            child: ProfileImage(
              heroTag: "profileImage",
              profileImage: widget.profileImage,
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  onPressed: widget.unsetProfileImage,
                  icon: const Icon(Icons.delete_forever),
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
                      foregroundColor: WidgetStatePropertyAll(Colors.white)),
                ),
              )),
          Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 40,
                height: 40,
                child: IconButton.filled(
                  onPressed: () async {
                    var result = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (kIsWeb) {
                      if (result != null) {
                        final storageRef = FirebaseStorage.instance.ref();
                        var profileImageRef =
                            storageRef.child("profileImages/${account.uid}");
                        await profileImageRef
                            .putData(await result.readAsBytes());
                        final downloadURL =
                            await profileImageRef.getDownloadURL();
                        widget.onProfileImageChanged(downloadURL);
                      }
                      return;
                    }
                    if (result != null) {
                      widget.onProfileImageChanged(result.path);
                    }
                  },
                  icon: const Icon(Icons.edit),
                ),
              )),
        ],
      ),
    );
  }
}
