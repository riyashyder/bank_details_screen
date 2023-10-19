import 'package:bank_details_screen/bank_details_list_screen.dart';
import 'package:bank_details_screen/database_helper.dart';
import 'package:bank_details_screen/main.dart';
import 'package:flutter/material.dart';

class BankDetailsFormScreen extends StatefulWidget {
  const BankDetailsFormScreen({super.key});

  @override
  State<BankDetailsFormScreen> createState() => _BankDetailsFormScreenState();
}

class _BankDetailsFormScreenState extends State<BankDetailsFormScreen> {
  var bankNameController = TextEditingController();
  var branchNameController = TextEditingController();
  var accountTypeController = TextEditingController();
  var accountNoController = TextEditingController();
  var ifscCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Bank Form Details'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: bankNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Bank Name',
                      hintText: 'Enter your Bank Name'),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: branchNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Branch Name',
                      hintText: 'Enter your Branch Name'),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: accountTypeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Account type',
                      hintText: 'Enter Account Type'),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: accountNoController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Account No',
                      hintText: 'Enter Your Account Number'),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: ifscCodeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      labelText: 'IFSC code',
                      hintText: 'Enter IFSC Code'),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    print('---------->Save Button Worked');
                    _save();
                  },
                  child: Text('Save'))
            ],
          ),
        ),
      ),
    );
  }


  void _save() async {
    print('------->Save');
    print('------->Bank Name:${bankNameController.text}');
    print('------->Branch Name:${branchNameController.text}');
    print('------->Account Type:${accountTypeController.text}');
    print('------->Account Number:${accountNoController.text}');
    print('------->IFSC code:${ifscCodeController.text}');

    Map<String, dynamic> row = {
      DatabaseHelper.columnBankName: bankNameController.text,
      DatabaseHelper.columnBranchName: branchNameController.text,
      DatabaseHelper.columnAccountType: accountTypeController.text,
      DatabaseHelper.columnAccountNumber: accountNoController.text,
      DatabaseHelper.columnIFSCCode: ifscCodeController.text,
    };

    final result =
    await dbHelper.insertBankDetails(row, DatabaseHelper.bankDetailsTable);

    debugPrint('----------> Inserted Row ID: $result');

    if (result > 0) {
      Navigator.pop(context);
      _showSuccessSnackBar(context, 'Saved');
    }
    setState(() {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => BankDetailsListScreen()));
    });
  }


    void _showSuccessSnackBar(BuildContext context, String message) {
      ScaffoldMessenger.of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }
  }


