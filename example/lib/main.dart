import 'package:flutter/material.dart';
import 'package:flutter_credit_card_detector/flutter_credit_card_detector.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ControllerBase()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
          backgroundColor: Colors.orange[300],
        ),
        body: CreditCardWidget(
                        labelTextNum: 'Número do cartão',
                        // Texto exibido no textField
                        labelTextName: 'Nome no cartão',
                        // Texto exibido no textField
                        labelTextExpData: 'MM/AA',
                        // Texto exibido no textField
                        labelTextCVV: 'CVC',
                        // Texto exibido no textField
                        labelTextCPF: 'CPF do Titular',
                        // Texto exibido no textField
                        //labelTextButton: 'Efetuar pagamento', // Texto do button
                        titleCreditCard: 'Cartão de Crédito',
                        // Título do cartão
                        labelTextValidate: 'Valido Até',
                        // Texto de validade do cartão
                        textRequired: 'Campo é obrigatorio',
                        // Mensagem de erro no textField - campos vazios
                        textSelectBand: 'Selecione a bandeira',
                        // Mensagem de erro no textField - quando a bandeira não é identificada
                        textNameMin: 'O nome de conter pelo menos 6 caracteres',
                        // Mensagem de erro no textField - campo nome
                        textIntroNameValid: 'Insira um nome válido',
                        // Mensagem de erro no textField - campo nome
                        textCardExpired: 'Cartão vencido',
                        // Mensagem de erro no textField - campo validade do cartão
                        textInvalidateMonth: 'Mês incorreto.',
                        // Mensagem de erro no textField - campo validade do cartão
                        colorButton: const Color(0xFFfec177),
                        // Cor do button
                        colorTextButton: Colors.white,
                        // Cor do texto no button
                        colorTextField: Colors.grey,
                        // Cor do texto no textField
                        colorCardSelect: const Color(0xFFfec177),
                        // Cor do card selecionado
                        colorCreditWhite: const Color(0xff535252),
                        // Cor do cartão
                        colorCreditBlack: const Color(0xff211e1e),
                        // Cor do cartão
                        textSizeNumber: 0.06,
                        // Tamanho do número apresentado no cartão
                        textSizeName: 0.04,
                        // Tamanho do nome apresentado no cartão
                        textSizeMonth: 0.03,
                        // Tamanho do texto apresentado no cartão
                        textSizeCVC: 0.03,
                        // Tamanho do texto apresentado no cartão
                        viewLayout: false,
                        // Vertical = false, Horizontal = true
                        cpfVisibility: false,
                        // Campo do CPF visível = true e false para ocultar o campo
                        listBand: listBand,
                        onTap: _onTap),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  // Bandeiras disponíveis
  List<String> listBand = [
    'visa',
    'mastercard',
    'amex',
    'elo',
    'dinersclub',
    'discover',
    'jcb',
    'aura',
    'hiper',
    'hipercard',
    'rupay'
  ];

  _onTap() async {
    print('Numero do cartão: $creditCardNumber'); // Numero do cartão digitado
    print('Nome no cartão: $creditCardName'); // Nome no cartão digitado
    print('Valido até: $creditCardExpData'); // Validade do cartão
    print('CVV: $creditCardCVV'); // Código de segurança
    print('Bandeira: $creditCardBand'); // Bandeira do cartão
    print('CPF: $creditCardCPF'); // CPF do Titular
    print('Grava dados do cartão: $creditCardGravarDadosCartao');
    print('Aceita Contrato: $creditCardAceitaContrato');
  }
}
