import 'package:flutter/material.dart';
void main(){
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      hintColor: Colors.blue,
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black,)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          hintStyle: TextStyle(color: Colors.lightBlueAccent),
      )
    )
  ));

}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final anoController = TextEditingController();
  final mesController = TextEditingController();
  final diaController = TextEditingController();


  String _mensagem = "";

  int ano = 0;
  int mes = 0;
  int dia = 0;
  GlobalKey<FormState>_formKey = GlobalKey<FormState>();

  _diaMesAnoParaDias(){
    setState(() {
      //entrada de dados
      ano = int.parse(anoController.text);
      mes = int.parse(mesController.text);
      dia = int.parse(diaController.text);

      //processamento
      int dias = ano * 360 + mes * 30 + dia;

      //saida
      _mensagem = "você tem ${dias.toString()} de vida";
      anoController.clear();
      mesController.clear();
      diaController.clear();
    });
  }

  void _limpaCampos(){
    anoController.clear();
    mesController.clear();
    diaController.clear();
    setState(() {
      _mensagem = 'Informe seus dados!';
      _formKey = GlobalKey<FormState>();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Ano/Mes/Dia para dias - Fatec Ferraz'),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: (){
              if (_formKey.currentState!.validate()){
                _diaMesAnoParaDias();
              }
            },
            icon: Icon(Icons.refresh),
          )
        ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10), //adiciona margem 10 em tudo
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.date_range,
                  size: 150,
                  color: Colors.blueAccent,
                ),
                construirTextField("Ano", "Qtde", anoController, "Favor Digitar o ano ou anos"),
                Divider(),
                construirTextField("Mês", "Qtde", mesController, "Favor Digitar o mes ou meses"),
                Divider(),
                construirTextField("Dia", "Qtde", diaController, "Favor Digitar o dia ou dias"),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: FlatButton(
                    child: Text(
                      "Ano/Mês/Dia para Dias",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                      _diaMesAnoParaDias();

                      }
                    },
                    ),
                ),
                Center(child: Text(
                  _mensagem,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                  ),
                ),)
              ],
            ),
          ),
        ),
    );
  }

  Widget construirTextField(String texto, String prefixo, TextEditingController c, String mensagemErro){
    
    return TextFormField(
      controller: c,
      validator: (value){
        if (value!.isEmpty){
          return mensagemErro;
        }
        else{
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: texto,
        labelStyle: TextStyle(
          color: Colors.blue,
        )
      ),
      style: TextStyle(color: Colors.black,
      fontSize: 25,
      ),
    );

  }
}