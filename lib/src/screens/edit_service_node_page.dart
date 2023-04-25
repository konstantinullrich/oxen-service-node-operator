import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/oxen/service_node.dart';
import 'package:oxen_service_node/src/stores/node_sync_store.dart';
import 'package:oxen_service_node/src/utils/router/oxen_routes.dart';
import 'package:oxen_service_node/src/utils/short_address.dart';
import 'package:oxen_service_node/src/utils/theme/palette.dart';
import 'package:oxen_service_node/src/widgets/base_page.dart';
import 'package:oxen_service_node/src/widgets/nav/nav_list_multiheader.dart';
import 'package:oxen_service_node/src/widgets/oxen/oxen_text_field.dart';
import 'package:oxen_service_node/src/widgets/primary_button.dart';
import 'package:oxen_service_node/src/widgets/scrollable_with_bottom_section.dart';
import 'package:provider/provider.dart';

class EditServiceNodePage extends BasePage {
  EditServiceNodePage(this.publicKey);

  final String publicKey;

  @override
  void onClose(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  String get title => S.current.title_add_service_node;

  @override
  Widget body(BuildContext context) => EditServiceNodePageBody(this.publicKey);
}

class EditServiceNodePageBody extends StatefulWidget {
  EditServiceNodePageBody(this.publicKey);

  final String publicKey;

  @override
  State<StatefulWidget> createState() =>
      EditServiceNodePageBodyState(this.publicKey);
}

class EditServiceNodePageBodyState extends State<EditServiceNodePageBody> {
  EditServiceNodePageBodyState(this.publicKey);

  final String publicKey;
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late Box<ServiceNode> serviceNodeSource;
  late ServiceNode node;

  bool _isDuplicateName(String? name) =>
      serviceNodeSource.values.any((element) => element.name == name);

  @override
  void initState() {
    super.initState();
    serviceNodeSource = context.read<Box<ServiceNode>>();
    node = serviceNodeSource.values
        .firstWhere((e) => e.publicKey == this.publicKey);

    _nameController.text = node.name;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future _saveServiceNode() async {
    node.name = _nameController.text;
    await node.save();
  }

  Future _deleteServiceNode() async {
    await node.delete();

    if (serviceNodeSource.isEmpty)
      Navigator.pushNamedAndRemoveUntil(context, OxenRoutes.welcome,
          ModalRoute.withName(OxenRoutes.dashboard));
    else
      Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final nodeSyncStore = context.watch<NodeSyncStore>();

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
                  final isDuplicate = _isDuplicateName(value);
                  if (isDuplicate) return S.of(context).error_name_taken;
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: NavListMultiHeader(
                  S.of(context).public_key, publicKey.toShortAddress(20)),
            ),
            PrimaryButton(
              onPressed: _deleteServiceNode,
              text: S.of(context).delete_service_node,
              color: Colors.transparent,
              borderColor: Colors.transparent,
              textColor: Colors.red,
            ),
          ]),
        ),
      ),
      bottomSection: PrimaryButton(
          onPressed: () async {
            if (!(_formKey.currentState?.validate() == true)) return;
            await _saveServiceNode();
            await nodeSyncStore.sync();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(S.of(context).success_saved_node),
                behavior: SnackBarBehavior.floating,
                backgroundColor: OxenPalette.green));
          },
          text: S.of(context).save_service_node,
          color: Theme.of(context).primaryTextTheme.labelLarge?.backgroundColor,
          borderColor:
              Theme.of(context).primaryTextTheme.labelLarge?.decorationColor),
    );
  }
}
