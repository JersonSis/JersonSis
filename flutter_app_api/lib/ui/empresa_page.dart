import 'package:flutter/material.dart';
import 'package:flutter_app_api/model/empresa_model.dart';
import 'package:flutter_app_api/ui/home_page.dart';

class EmpresaPage extends StatefulWidget {
  final Empresa emp;
  EmpresaPage({this.emp});

  @override
  _EmpresaPageState createState() => _EmpresaPageState();
}

class _EmpresaPageState extends State<EmpresaPage> {
  final _codEmpresa = TextEditingController();
  final _nomeEmpresa = TextEditingController();
  final _cnpjEmpresa = TextEditingController();

  Empresa _editedEmp;

  @override
  void initState() {
    super.initState();

    if (widget.emp == null) {
      _editedEmp = Empresa();
    } else {
      _editedEmp = widget.emp;
    }
    _codEmpresa.text = _editedEmp.codEmpresa;
    _nomeEmpresa.text = _editedEmp.nomeEmpresa;
    _cnpjEmpresa.text = _editedEmp.cnpjEmpresa;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text('Cadastro de Administrador')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _codEmpresa,
              decoration: InputDecoration(labelText: "Codigo"),
              enabled: false,
              onChanged: (text) {
                _editedEmp.codEmpresa = text ?? "";
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _nomeEmpresa,
              decoration: InputDecoration(labelText: "Usuario"),
              onChanged: (text) {
                setState(() {
                  _editedEmp.nomeEmpresa = text;
                });
              },
            ),
            TextField(
              obscureText: true,
              controller: _cnpjEmpresa,
              decoration: InputDecoration(labelText: "Senha"),
              onChanged: (text) {
                _editedEmp.cnpjEmpresa = text;
              },
              keyboardType: TextInputType.phone,
            ),
            Divider(),
            InkWell(
              onTap: () {
                if (_editedEmp.codEmpresa == null) {
                  if (api.inserirEmpresa(_editedEmp) != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  } else {
                    Dialog(child: Text('Erro ao Inserir Usuario.'));
                  }
                } else {
                  if (api.alterarEmpresa(_editedEmp) != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  } else {
                    Dialog(child: Text('Erro ao Alterar Usuario.'));
                  }
                }
              },
              child: Container(
                width: 200,
                height: 60,
                color: Colors.blueGrey,
                child: Center(child: Text('Salvar')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
