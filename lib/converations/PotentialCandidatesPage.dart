import 'package:flutter/material.dart';
import 'package:jobby/converations/EmployerEmployee.dart';

class CheapLaborPage extends StatelessWidget {
  const CheapLaborPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => EmployerEmployeePage()));
          }
        ),
      ),
    );
  }
}
