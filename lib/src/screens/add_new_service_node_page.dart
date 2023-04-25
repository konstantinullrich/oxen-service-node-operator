import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/oxen/service_node.dart';
import 'package:oxen_service_node/src/stores/node_sync_store.dart';
import 'package:oxen_service_node/src/utils/router/oxen_routes.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';
import 'package:oxen_service_node/src/utils/validators.dart';
import 'package:oxen_service_node/src/widgets/base_page.dart';
import 'package:oxen_service_node/src/widgets/oxen/oxen_text_field.dart';
import 'package:oxen_service_node/src/widgets/primary_button.dart';
import 'package:oxen_service_node/src/widgets/scrollable_with_bottom_section.dart';
import 'package:provider/provider.dart';

class AddNewServiceNodePage extends BasePage {
  @override
  String get title => S.current.title_add_service_node;

  @override
  Widget body(BuildContext context) => AddNewServiceNodePageBody();
}

class AddNewServiceNodePageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddNewServiceNodePageBodyState();
}

class AddNewServiceNodePageBodyState extends State<AddNewServiceNodePageBody> {
  final _nameController = TextEditingController();
  final _publicKeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isDuplicatePublicKey(
          String publicKey, Box<ServiceNode> serviceNodeSource) =>
      serviceNodeSource.values.any((element) => element.publicKey == publicKey);

  bool _isDuplicateName(String? name, Box<ServiceNode> serviceNodeSource) =>
      serviceNodeSource.values.any((element) => element.name == name);

  @override
  void dispose() {
    _nameController.dispose();
    _publicKeyController.dispose();
    super.dispose();
  }

  Future _saveServiceNode(Box<ServiceNode> serviceNodeSource) async {
    final serviceNode =
        ServiceNode(_nameController.text, _publicKeyController.text);
    await serviceNodeSource.add(serviceNode);
  }

  @override
  Widget build(BuildContext context) {
    final serviceNodeSource = context.read<Box<ServiceNode>>();
    final nodeSyncStatus = context.read<NodeSyncStore>();

    return ScrollableWithBottomSection(
      contentPadding: EdgeInsets.all(0),
      content: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: OxenTextField(
                controller: _nameController,
                hintText: S.of(context).name,
                validator: (value) {
                  final isDuplicate =
                      _isDuplicateName(value, serviceNodeSource);
                  if (isDuplicate) return S.of(context).error_name_taken;
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: OxenTextField(
                controller: _publicKeyController,
                hintText: S.of(context).public_key,
                suffixIcon: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    color: OxenPalette.teal,
                    icon: Icon(Icons.content_paste_sharp),
                    onPressed: () async {
                      final clipboard = await Clipboard.getData('text/plain');
                      if (clipboard?.text != null)
                        _publicKeyController.text = clipboard!.text!;
                    }),
                validator: (value) {
                  if (value == null) return null;
                  final validPublicKey = isValidPublicKey(value);
                  final isDuplicate =
                      _isDuplicatePublicKey(value, serviceNodeSource);
                  if (value.isEmpty || validPublicKey == KeyValidity.TOO_SHORT)
                    return S.of(context).error_public_key_too_short;
                  else if (validPublicKey == KeyValidity.TOO_LONG)
                    return S.of(context).error_public_key_too_long;
                  else if (isDuplicate)
                    return S.of(context).error_you_are_already_monitoring;
                  return null;
                },
              ),
            ),
          ]),
        ),
      ),
      bottomSection: PrimaryButton(
          onPressed: () async {
            if (!(_formKey.currentState?.validate() == true)) return;
            await _saveServiceNode(serviceNodeSource);
            await nodeSyncStatus.sync();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(S.of(context).success_saved_node),
                behavior: SnackBarBehavior.floating,
                backgroundColor: OxenPalette.green));
            Navigator.pushNamed(context, OxenRoutes.dashboard);
          },
          text: S.of(context).add_service_node,
          color: Theme.of(context).primaryTextTheme.labelLarge?.backgroundColor,
          borderColor:
              Theme.of(context).primaryTextTheme.labelLarge?.decorationColor),
    );
  }
}
