import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_online/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';

class SingUpScreen extends StatefulWidget {

  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _enderecoController = TextEditingController();

  final _FormKey = GlobalKey<FormState>();
  final _ScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _ScaffoldKey,
        appBar: AppBar(
          title: Text('Criar Conta',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),),
          centerTitle: true,
          backgroundColor:  Colors.pinkAccent,
        ),
        body: ScopedModelDescendant<UserModel>(
            builder: (context,child,model){
              if(model.isLoading)
                return Center(child: CircularProgressIndicator());
              return Form(
                key: _FormKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          hintText: 'Nome Completo'
                      ),

                      validator: (texto){
                        if(texto.isEmpty) return "Nome inválido";
                      },
                    ),
                    SizedBox(height: 16.0,),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: 'Email'
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (texto){
                        if(texto.isEmpty || !texto.contains('@')) return "Email inválido";
                      },
                    ),
                    SizedBox(height: 16.0,),
                    TextFormField(
                      controller: _senhaController,
                      decoration: InputDecoration(
                        hintText: 'Senha',
                      ),
                      obscureText: true,
                      validator: (texto){
                        if(texto.isEmpty || texto.length < 6) return 'Senha Inválida';
                      },
                    ),
                    SizedBox(height: 16.0,),
                    TextFormField(
                      controller: _enderecoController,
                      decoration: InputDecoration(
                          hintText: 'Endereço'
                      ),
                      validator: (texto){
                        if(texto.isEmpty ) return "Endereço inválido";
                      },
                    ),
                    SizedBox(height: 16.0,),
                    SizedBox(
                      height: 44.0,
                      child: RaisedButton(
                        onPressed: (){
                          if(_FormKey.currentState.validate()){

                            Map<String, dynamic> userData = {
                              // não armazenar a senha junto com as informações do usuario.
                              'name' : _nameController.text,
                              'email': _emailController.text,
                              'senha' : _senhaController.text,
                              'endereco': _enderecoController.text

                            };

                            model.singUp(
                                userData: userData,
                                pass: _senhaController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail
                            );
                          }
                        },
                        child: Text('Criar Conta',
                          style: TextStyle(
                              fontSize: 18.0
                          ),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }
        )
    );
  }
  void _onSuccess(){
    _ScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text('Usuario criado com sucesso!'),
        backgroundColor: Theme.of(context).primaryColor ,
      duration: Duration(seconds: 2),
      )
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }
  void _onFail(){

    _ScaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('Falha ao criar o usuario!'),
          backgroundColor: Colors.redAccent ,
          duration: Duration(seconds: 2),
        )
    );

  }
}



