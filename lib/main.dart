import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: const Home(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      hintColor: Colors.blue,
      primaryColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        hintStyle: TextStyle(color: Colors.lightBlueAccent)
      )
    ),
  ));
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final codClientController = TextEditingController();
  final valorCompraController = TextEditingController();

  int codigo = 0;
  double desconto = 0;
  double valorFinal = 0;

  String mensagem = "";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _aplicaDesconto(){
    setState(() {
      codigo = int.parse(codClientController.text);
      double valorCompra = double.parse(valorCompraController.text);
      if(codigo == 1){
        desconto = 1;
      }
      if(codigo == 2){
        desconto = 0.9;
      }
      if (codigo == 3){
        desconto = 0.95;
      }
      desconto != 0 ? valorFinal = valorCompra * desconto : valorCompra;
      mensagem = "O valor final da compra é de R\$${valorFinal}";
      codClientController.clear();
      valorCompraController.clear();
    });
  }

  _limpaCampos(){
    codClientController.clear();
    valorCompraController.clear();
    setState(() {
      mensagem = "Informe o valor da compra e o codigo de comprador";
      _formKey = GlobalKey<FormState>();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Calculo de valor de compra"),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed: _limpaCampos, icon: const Icon(Icons.refresh))
        ]
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.shopping_cart,
                size: 150,
                color: Colors.blueAccent,
              ),
              const Center(
                child: Text(
                  "Para realizar o calculo é necessário informar o código de consumidor:\n1 - Cliente comum\n2 - Funcionario\n3 - VIP",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20
                  ),
                ),
              ),
              const Divider(),
              construirTextField("Codigo", "Codigo: ", codClientController, "Erro"),
              const Divider(),
              construirTextField("Valor", "Valor: ", valorCompraController, "Erro"),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      _aplicaDesconto();
                    }
                  },
                  child: const Text(
                    "Calcular valor final",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                )
              ),
              Center(
                child: Text(
                  mensagem,
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 30
                  ),
                ),
              )
            ], 
            ),
        )
      ),
    );
  }
}

Widget construirTextField(String texto, String prefixo, TextEditingController c, String mensagemErro){
  return TextFormField(
    validator: (value){
      if(value!.isEmpty){
        return mensagemErro;
      } else {
        return null;
      }
    },
    controller: c,
    decoration: InputDecoration(
      labelText: texto,
      labelStyle: const TextStyle(color: Colors.blue),
      border: const OutlineInputBorder(),
      prefixText: prefixo
    ),
    style: const TextStyle(
      color: Colors.black
    ),
  );
}