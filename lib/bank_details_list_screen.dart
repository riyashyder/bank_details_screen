import 'package:bank_details_screen/bank_details_form_screen.dart';
import 'package:bank_details_screen/edit_bank_details_form_screen.dart';
import 'package:bank_details_screen/main.dart';
import 'package:flutter/material.dart';
import 'bank_details_model.dart';
import 'database_helper.dart';

class BankDetailsListScreen extends StatefulWidget {
  const BankDetailsListScreen({super.key});

  @override
  State<BankDetailsListScreen> createState() => _BankDetailsListScreenState();
}

class _BankDetailsListScreenState extends State<BankDetailsListScreen> {
  late List<BankDetailsModel> _bankDetailsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllBankDetails();
  }

  getAllBankDetails() async {
    _bankDetailsList = <BankDetailsModel>[];

    var bankDetailRecords =
        await dbHelper.queryAllRows(DatabaseHelper.bankDetailsTable);

    bankDetailRecords.forEach((bankDetail) {
      setState(() {
        print(bankDetail['_id']);
        print(bankDetail['_bankName']);
        print(bankDetail['_branchName']);
        print(bankDetail['_accountType']);
        print(bankDetail['_accountNumber']);
        print(bankDetail['_IFSCCode']);

        var bankDetailsModel = BankDetailsModel(
          bankDetail['_id'],
          bankDetail['_bankName'],
          bankDetail['_branchName'],
          bankDetail['_accountType'],
          bankDetail['_accountNumber'],
          bankDetail['_IFSCCode'],
        );

        _bankDetailsList.add(bankDetailsModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Bank Details'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            new Expanded(
              child: new ListView.builder(
                itemCount: _bankDetailsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new InkWell(
                    onTap: () {
                      print('--------->Edit or Delete Invoked:send data');
                      print(_bankDetailsList[index].id);
                      print(_bankDetailsList[index].bankName);
                      print(_bankDetailsList[index].branchName);
                      print(_bankDetailsList[index].accountType);
                      print(_bankDetailsList[index].accountNo);
                      print(_bankDetailsList[index].iFSCCode);

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditBankDetailsFormScreen(),
                        settings: RouteSettings(
                          arguments: _bankDetailsList[index],
                        ),
                      ));
                    },
                    child: ListTile(
                      title: Text(_bankDetailsList[index].bankName +
                          '\n' +
                          _bankDetailsList[index].branchName +
                          '\n' +
                          _bankDetailsList[index].accountType +
                          '\n' +
                          _bankDetailsList[index].accountNo +
                          '\n' +
                          _bankDetailsList[index].iFSCCode),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('----->Launch Bank details  Form screen');
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => BankDetailsFormScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
