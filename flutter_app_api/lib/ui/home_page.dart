import 'package:flutter/material.dart';
import 'package:flutter_app_api/classes/api_controller.dart';
import 'package:flutter_app_api/model/empresa_model.dart';
import 'package:flutter_app_api/ui/empresa_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

ApiController api = ApiController();

class _HomePageState extends State<HomePage> {
  List<Empresa> empresas = <Empresa>[];

  @override
  void initState() {
    super.initState();
    _getAllEmpresas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          title: Text('Lista de Administradores'),
        ),
        bottomSheet: Container(
          color: Colors.blueGrey,
          height: 60,
          child: InkWell(
            onTap: () {
              _getAllEmpresas();
            },
            child: Center(
              child: Text('Recarregar'),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showEmpresa();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: empresas.length,
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    Empresa emp = empresas[index];
                    return InkWell(
                      onTap: () {
                        //Navigator.pop(context);
                        _showEmpresa(empresa: emp);
                      },
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("codigo: ${emp.codEmpresa}"),
                              Text("email: ${emp.nomeEmpresa}"),
                              Text("senha: ${emp.cnpjEmpresa}"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      api.excluirEmpresa(emp) != null
                                          ? _getAllEmpresas()
                                          : AlertDialog(
                                              title: Text('ERRO'),
                                              content: Text(
                                                  'Ocorreu um problema ao excluir!'),
                                            );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(8),
                                      color: Colors.blueGrey,
                                      height: 40,
                                      width: 120,
                                      child: Card(
                                        child: Center(child: Text("Excluir")),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void _showEmpresa({Empresa empresa}) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EmpresaPage(emp: empresa)));
  }

  void _getAllEmpresas() {
    api.getEmpresas().then((list) {
      setState(() {
        empresas = list;
      });
    });
  }
}
