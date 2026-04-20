import 'package:app/views/layout/base_layout.dart';
import 'package:app/views/widgets/upload_invoice_box_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class Uploadmusicview extends StatelessWidget {

  const Uploadmusicview();

  @override
  Widget build(BuildContext context) {
    return BaseLayout(title: FlutterI18n.translate(context, "title_project"), child: UploadInvoiceBoxWidget(onFileSelected:(){} ));
  }
}