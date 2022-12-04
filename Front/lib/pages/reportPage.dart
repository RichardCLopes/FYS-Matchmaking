import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fys/http.dart';

class reportPage extends StatefulWidget {
  reportPage(this.reportedID, this.reportedNome);
  final String reportedID;
  final String reportedNome;

  @override
  State<reportPage> createState() => _reportPageState(reportedID, reportedNome);
}

class _reportPageState extends State<reportPage> {
  _reportPageState(this.reportedID, this.reportedNome);
  final String reportedID;
  final String reportedNome;

  TextEditingController reason = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Denunciar Usuário",
            style: TextStyle(
              fontFamily: 'alagard',
              color: Colors.white,
              fontSize: 20,
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Denunciar " + reportedNome,
                  style: TextStyle(
                    fontFamily: 'alagard',
                    color: Colors.yellow,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Motivo:",
                  style: TextStyle(
                    fontFamily: 'alagard',
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              TextFormField(
                controller: reason,
                keyboardType: TextInputType.multiline,
                maxLength: 100,
                maxLines: 4,
                minLines: 3,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 34, 34, 34),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 51, 225, 255), width: 1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  counterStyle: TextStyle(color: Colors.white),
                  hintText: 'Descreva o motivo da denuncia',
                  hintStyle: TextStyle(
                    fontSize: 21,
                    color: Color.fromARGB(255, 189, 189, 189),
                  ),
                  contentPadding: EdgeInsets.all(12.0),
                ),
                style: TextStyle(
                  fontSize: 21,
                  color: Color.fromARGB(255, 189, 189, 189),
                ),
              ),
              Container(
                height: 100,
                width: 200,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Cofirmar denuncia'),
                        content: Text(
                            'Tem certeza que deseja denunciar o usuário ' +
                                reportedNome),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              ReportUser(reportedID, reason.text).then((value) {
                                if (value == 201) Navigator.pop(context, 'OK');
                                Navigator.pop(context, 'OK');
                              });
                            },
                            child: const Text('Sim'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('Não'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    "ENVIAR",
                    style: TextStyle(
                        color: Color.fromARGB(255, 40, 6, 49),
                        fontSize: 27,
                        fontFamily: 'alagard'),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 51, 225, 255),
                    side: BorderSide(
                        color: Color.fromARGB(255, 40, 6, 49), width: 2),
                    // ignore: unnecessary_new
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
