import 'dart:io';

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
  final nomeController = TextEditingController();

  String _mensagem = "";

  int ano = 0;
  int mes = 0;
  int dia = 0;
  String nome = '';
  DateTime now = new DateTime.now();
  GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  
  _calcIdade(){
    setState(() {
       //entrada de dados
      DateTime date = new DateTime(now.year, now.month, now.day);

      ano = int.parse(anoController.text);
      mes = int.parse(mesController.text);
      dia = int.parse(diaController.text);
      nome = nomeController.text;

      //calculando idade
      int idade = now.year - int.parse(anoController.text);

      //saida
      _mensagem = "${nome.toString()}: Você tem ${idade.toString()} anos";
    });
   
      
  }

  _diaMesAnoParaDias(){
    setState(() {
      //entrada de dados
      ano = int.parse(anoController.text);
      mes = int.parse(mesController.text);
      dia = int.parse(diaController.text);

      //processamento
      int idade = ano * 360 + mes * 30 + dia;

      //saida
      _mensagem = "você tem ${idade.toString()}";
      
    });
  }

 

  void _limpaCampos(){
    anoController.clear();
    mesController.clear();
    diaController.clear();
    nomeController.clear();  
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
        title: Text('Calcular Idade - Fatec Ferraz'),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: (){
              if (_formKey.currentState!.validate()){
                _calcIdade();
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
                  color: Colors.blue,
                ),
                Text('Insira sua Data de Nascimento',
                style: TextStyle(
                  fontSize: 30, 
                  color: Colors.blue,
                  ),
                
                ),
    
                construirTextField("Nome", "Qtde", nomeController, "Favor Digitar o Nome"),
                Divider(),
                construirTextField("Ano", "Qtde", anoController, "Favor Digitar o ano ou anos"),
                Divider(),
                construirTextField("Mês", "Qtde", mesController, "Favor Digitar o mes ou meses"),
                Divider(),
                construirTextField("Dia", "Qtde", diaController, "Favor Digitar o dia ou dias"),
                
                
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton.icon(
                     onPressed: () {
                      if(_formKey.currentState!.validate()){
                      _calcIdade();

                      }
                    },
                     style: ElevatedButton.styleFrom(fixedSize: Size(10,40)),
                     icon: Icon(Icons.calculate, size:30),
                     label: Text('Calcular Idade'),
                     
                     )
                    
                    
               
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