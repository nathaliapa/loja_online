import 'package:flutter/material.dart';
import 'package:loja_online/models/user_models.dart';
import 'package:loja_online/screaans/singup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  final _FormKey = GlobalKey<FormState>();
  final _ScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _ScaffoldKey,
      appBar: AppBar(
        title: Text('Entrar',
          style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),),
        centerTitle: true,
        backgroundColor:  Colors.pinkAccent,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child,model){
          if(model.isLoading)
            return Center(child: CircularProgressIndicator(),);
          return Form(
            key: _FormKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
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
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: (){},
                    child: Text('Esqueci minha senha',
                      textAlign: TextAlign.right,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(height: 16.0,),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: (){
                      if(_FormKey.currentState.validate()){

                      }
                      model.sinIng(
                        email:_emailController.text,
                        pass: _senhaController.text,
                        onSuccess:_onSuccess,
                        onFail:_onFail,
                      );
                    },
                    child: Text('Entrar',
                      style: TextStyle(
                          fontSize: 18.0
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 16.0,),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context)=> SingUpScreen())
                      );
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
        },
      )
    );
  }

  void _onSuccess(){

    Navigator.of(context).pop();

  }
  void _onFail(){

    _ScaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('Falha ao entrar!'),
          backgroundColor: Colors.redAccent ,
          duration: Duration(seconds: 2),
        )
    );

  }
}

