import 'package:bank_details_screen/bank_details_list_screen.dart';
import 'package:bank_details_screen/bank_details_model.dart';
import 'package:bank_details_screen/database_helper.dart';
import 'package:bank_details_screen/main.dart';
import 'package:flutter/material.dart';

class OptimizedBankDetailsScreen extends StatefulWidget {
  const OptimizedBankDetailsScreen({super.key});

  @override
  State<OptimizedBankDetailsScreen> createState() => _OptimizedBankDetailsScreenState();
}

class _OptimizedBankDetailsScreenState extends State<OptimizedBankDetailsScreen> {
  var bankNameController = TextEditingController();
  var branchNameController = TextEditingController();
  var accountTypeController = TextEditingController();
  var accountNoController = TextEditingController();
  var ifscCodeController = TextEditingController();

  bool firstTimeFlag = false;
  int _selectedId = 0;

  String buttonText = 'Save';

  @override

  void initState(){
    super.initState();
  }

  _deleteFormDailog(BuildContext context){
    return showDialog(context: context,barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: <Widget>[
          ElevatedButton(onPressed: (){}, child: Text('Cancel'),),
          ElevatedButton(onPressed: ()async{
            final result = await dbHelper.deleteBankDetails(
              _selectedId,DatabaseHelper.bankDetailsTable
            );
            debugPrint('------------->deleted Row Id: $result');
            if(result>0){
              _showSuccessSnackBar(context, 'Deleted');
              Navigator.pop(context);

              setState(() {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BankDetailsListScreen()));
              });
            }

          }, child: Text('Delete'))
        ],
        title: Text('Are you Sure you Want to Delete This?'),
      );

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(firstTimeFlag==false){
      print('----->once execute');

      firstTimeFlag = true;

      final bankDetails = ModalRoute.of(context)!.settings.arguments;

      if(bankDetails==null){
        print('------------>FAB : Insert/Delete');
      }else {
        print('----------->ListView: Received Data : Edit/Delete');

        bankDetails as BankDetailsModel;

        print(bankDetails.id);
        print(bankDetails.bankName);
        print(bankDetails.branchName);
        print(bankDetails.accountType);
        print(bankDetails.accountNo);
        print(bankDetails.iFSCCode);

        _selectedId = bankDetails.id!;
        buttonText = 'Update';

        bankNameController.text = bankDetails.bankName;
        branchNameController.text = bankDetails.branchName;
        accountTypeController.text = bankDetails.accountType;
        accountNoController.text = bankDetails.accountNo;
        ifscCodeController.text = bankDetails.iFSCCode;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Details  Form Screen'),
        actions: [
          PopupMenuButton(itemBuilder: (context)=>[
            PopupMenuItem(value: 1,child: Text('Delete')),
          ],
          elevation: 2,
          onSelected: (value){
            if(value==1){
              _deleteFormDailog(context);
            }
          },)
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  controller: bankNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Bank Name',
                      hintText: 'Enter Bank Name'
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: branchNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Branch Name',
                      hintText: 'Enter Branch Name'
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: accountTypeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Account Type',
                      hintText: 'Enter Account Type'
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: accountNoController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Account No',
                      hintText: 'Enter Account No'
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: ifscCodeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'IFSCCode',
                      hintText: 'Enter IFSCCode'
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(onPressed: (){
                  print('------------>update Button Clicked');
                  _update();
                },
                  child: Text('Update'),)
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _update() async{

    print('------------>_update');
    print('---------------> Selected ID: $_selectedId');
    print('-------------> Bank Name:${bankNameController.text}');
    print('-------------> Branch Name:${branchNameController.text}');
    print('-------------> Account Type:${accountTypeController.text}');
    print('-------------> Account No:${accountNoController.text}');
    print('-------------> IFSC COde:${ifscCodeController.text}');

    Map<String, dynamic> row = {
      DatabaseHelper.columnId: _selectedId,
      DatabaseHelper.columnBankName: bankNameController.text,
      DatabaseHelper.columnBranchName: branchNameController.text,
      DatabaseHelper.columnAccountType: accountTypeController.text,
      DatabaseHelper.columnAccountNumber: accountNoController.text,
      DatabaseHelper.columnIFSCCode: ifscCodeController.text,
    };

    final result = await dbHelper.updateBankDetails(
        row, DatabaseHelper.bankDetailsTable);

    debugPrint('--------> updated Row Id: $result');

    if (result > 0) {
      Navigator.pop(context);
      _showSuccessSnackBar(context, 'updated');
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

