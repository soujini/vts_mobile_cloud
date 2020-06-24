import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vts_mobile_cloud/models/call.dart';
import 'package:vts_mobile_cloud/providers/storage_company_provider.dart';
import '../widgets/call_add.dart';
import '../providers/relationTowCustomer_provider.dart';
import '../providers/processTowedVehicle_provider.dart';
import '../providers/storage_company_provider.dart';

class AddCallScreen extends StatelessWidget {
  static const routeName = '/add-call';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => TowCustomersVM()),
      ChangeNotifierProvider(create: (_) => StorageCompaniesVM()),
    ], child: CallAdd());
  }
}
