import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card_detector/flutter_credit_card_detector.dart';

import '../utils/mask_text_input_formatter.dart';

class CreditCardWidget extends StatefulWidget {
  final String labelTextNum;
  final String labelTextName;
  final String labelTextExpData;
  final String labelTextCVV;
  final String labelTextCPF;
  final String labelTextButton;
  final String titleCreditCard; // body_widget
  final String labelTextValidate; // body_widget
  final String textRequired; // Controller
  final String textSelectBand; // Controller
  final String textNameMin; // Controller
  final String textIntroNameValid; // Controller
  final String textCardExpired; // Controller
  final String textInvalidateMonth; // Controller
  final Color colorButton;
  final Color colorTextButton;
  final Color colorTextField;
  final Color colorCardSelect; // body_widget
  final Color colorCreditWhite; // body_widget
  final Color colorCreditBlack; // body_widget
  final double textSizeNumber; // body_widget
  final double textSizeName; // body_widget
  final double textSizeMonth; // body_widget
  final double textSizeCVC; // body_widget
  final List<String> listBand;
  final bool viewLayout;
  final bool cpfVisibility;
  final bool gravarDadosCartao;
  final bool aceitaContrato;
  final Function() onTap;

  const CreditCardWidget(
      {Key? key,
      this.labelTextNum = 'Número do cartão',
      this.labelTextName = 'Nome no cartão',
      this.labelTextExpData = 'MM/YY',
      this.labelTextCVV = 'CVV/CVC',
      this.labelTextCPF = 'CPF do Titular',
      this.labelTextButton = 'Feito!',
      this.titleCreditCard = 'Cartão de Crédito',
      this.labelTextValidate = 'Valido Até',
      this.textRequired = 'Campo é obrigatorio',
      this.textSelectBand = 'Selecione a bandeira',
      this.textNameMin = 'O nome de conter pelo menos 6 caracteres',
      this.textIntroNameValid = 'Insira um nome válido',
      this.textCardExpired = 'Cartão vencido',
      this.textInvalidateMonth = 'Mês incorreto.',
      this.colorButton = const Color(0xFFfec177),
      this.colorTextButton = Colors.white,
      this.colorTextField = Colors.grey,
      this.colorCardSelect = const Color(0xFFfec177),
      this.colorCreditWhite = const Color(0xff535252),
      this.colorCreditBlack = const Color(0xff211e1e),
      this.textSizeNumber = 0.06,
      this.textSizeName = 0.045,
      this.textSizeMonth = 0.03,
      this.textSizeCVC = 0.03,
      this.listBand = const [
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
      ],
      this.viewLayout = false,
      this.cpfVisibility = true,
      this.gravarDadosCartao = false,
      this.aceitaContrato = false,
      required this.onTap})
      : super(key: key);

  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  FocusNode _numFocus = FocusNode();
  FocusNode _nameFocus = FocusNode();
  FocusNode _expDateFocus = FocusNode();
  FocusNode _cvvFocus = FocusNode();
  FocusNode _cpfFocus = FocusNode();

  final _ccNum = MaskedTextController(mask: "0000 0000 0000 0000");
  final _nome = TextEditingController();
  final _expData = MaskedTextController(mask: "00/00");
  final _cvv = TextEditingController();
  final _cpf = TextEditingController();

  final textFieldNum = GlobalKey();
  final textFieldNam = GlobalKey();
  final textFieldExpD = GlobalKey();
  final textFieldCvv = GlobalKey();
  final textFieldCpf = GlobalKey();
  

  @override
  void initState() {
    super.initState();
    creditCardNumber = '';
    creditCardName = '';
    creditCardExpData = '';
    creditCardCVV = '';
    creditCardBand = '';
    creditCardCPF = '';
    gravarDadosCartao = false;
    aceitaContrato = false;
    validateCpfVisibility = widget.cpfVisibility;

    textRequired = widget.textRequired;
    textSelectBand = widget.textSelectBand;
    textNameMin = widget.textNameMin;
    textIntroNameValid = widget.textIntroNameValid;
    textCardExpired = widget.textCardExpired;
    textInvalidateMonth = widget.textInvalidateMonth;

    listBand = widget.listBand;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ControllerBase>(context);

    controller.number = _ccNum.text == '' ? '' : _ccNum.text;
    controller.name = _nome.text == '' ? '' : _nome.text;
    controller.expData = _expData.text == '' ? '' : _expData.text;
    controller.cvv = _cvv.text == '' ? '' : _cvv.text;
    controller.cpf = _cpf.text == '' ? '' : _cpf.text;
    controller.gravarDadosCartao = gravarDadosCartao;
    controller.aceitaContrato = aceitaContrato;

    _textFormField(
        {width,
        keyText,
        controllerTextField,
        keyboardType,
        textInputAction,
        maxLength,
        focusNode,
        onChanged,
        textCapitalization,
        nextFocusNode,
        labelText,
        nextTexFieldView,
        inputFormatters,
        decoration,
        String? Function()? errorText}) {
      return Container(
        width: width,
        child: TextFormField(
          key: keyText,
          controller: controllerTextField,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLength: maxLength,
          focusNode: focusNode,
          onChanged: onChanged,
          textCapitalization: textCapitalization,
          inputFormatters: inputFormatters != null
              ? [FilteringTextInputFormatter.digitsOnly]
              : [],
          //autoValidate: true,
          onFieldSubmitted: (v) {
            if (controller.isValid) {
              creditCardNumber = controller.number.replaceAll(' ', '');
              creditCardName = controller.name;
              creditCardExpData = controller.expData;
              creditCardCVV = controller.cvv;
              creditCardCPF = controller.cpf;
              creditCardBand = controller.typeBand;
              gravarDadosCartao = controller.gravarDadosCartao;
              aceitaContrato = controller.aceitaContrato;
              widget.onTap();
            } else {
              return null;
            }
          },
          onEditingComplete: () {
            if (nextTexFieldView == false) {
              FocusScope.of(context).unfocus();
            } else {
              FocusScope.of(context).requestFocus(nextFocusNode);
              nextTexFieldView.currentContext
                  .findRenderObject()
                  .showOnScreen(duration: Duration(seconds: 0));
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: widget.colorButton),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.colorButton),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            labelText: labelText,
            labelStyle: TextStyle(color: widget.colorTextField),
            errorText: errorText == null ? null : errorText(),
          ),
        ),
      );
    }

    Widget _inputSectionRow() {
      var ccType = detectCCType(controller.number);

      return Form(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //Numero do cartão
              _textFormField(
                keyText: textFieldNum,
                width: mediaQuery(context, 0.7),
                controllerTextField: _ccNum,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: true,
                maxLength: 19,
                focusNode: _numFocus,
                onChanged: controller.changeNumber,
                textCapitalization: TextCapitalization.none,
                nextFocusNode: _nameFocus,
                labelText: widget.labelTextNum,
                nextTexFieldView: textFieldNam,
                errorText: controller.validateNumber,
              ),
              SizedBox(width: 10),
              //Nome no cartão
              _textFormField(
                keyText: textFieldNam,
                width: mediaQuery(context, 0.8),
                controllerTextField: _nome,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLength: 25,
                focusNode: _nameFocus,
                onChanged: controller.changeName,
                textCapitalization: TextCapitalization.characters,
                nextFocusNode: _expDateFocus,
                labelText: widget.labelTextName,
                nextTexFieldView: textFieldExpD,
                errorText: controller.validateName,
              ),
              SizedBox(width: 10),
              //MM/YY
              _textFormField(
                keyText: textFieldExpD,
                width: mediaQuery(context, 0.35),
                controllerTextField: _expData,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                maxLength: 5,
                focusNode: _expDateFocus,
                onChanged: controller.changeExpData,
                textCapitalization: TextCapitalization.none,
                nextFocusNode: _cvvFocus,
                labelText: widget.labelTextExpData,
                nextTexFieldView: textFieldCvv,
                errorText: controller.validateExpData,
              ),
              SizedBox(width: 10),
              //CVV/CVC
              _textFormField(
                keyText: textFieldCvv,
                width: mediaQuery(context, 0.35),
                controllerTextField: _cvv,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                maxLength: ccType == CreditCardType.amex ||
                        ccType == CreditCardType.discover
                    ? 4
                    : 3,
                focusNode: _cvvFocus,
                onChanged: controller.changeCVV,
                textCapitalization: TextCapitalization.none,
                nextFocusNode: _cpfFocus,
                labelText: widget.labelTextCVV,
                nextTexFieldView: textFieldCpf,
                errorText: controller.validateCVV,
              ),
              widget.cpfVisibility == false ? Container() : SizedBox(width: 10),
              //CPF
              widget.cpfVisibility == false
                  ? Container()
                  : _textFormField(
                      keyText: textFieldCpf,
                      width: mediaQuery(context, 0.7),
                      controllerTextField: _cpf,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      maxLength: 11,
                      focusNode: _cpfFocus,
                      nextTexFieldView: false,
                      onChanged: controller.changeCpf,
                      textCapitalization: TextCapitalization.characters,
                      labelText: widget.labelTextCPF,
                      errorText: controller.validateCPF,
                    ),
            ],
          ),
        ),
      );
    }

    Widget _inputSectionColumn() {
      var ccType = detectCCType(controller.number);

      return Column(
        children: <Widget>[
          //Numero do cartão
          _textFormField(
            controllerTextField: _ccNum,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            maxLength: 19,
            focusNode: _numFocus,
            onChanged: controller.changeNumber,
            inputFormatters: true,
            textCapitalization: TextCapitalization.none,
            nextFocusNode: _nameFocus,
            labelText: widget.labelTextNum,
            errorText: controller.validateNumber,
            decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.credit_card),
                        hintText: 'Número do cartão',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
          ),
          SizedBox(height: 8),
          //Nome no cartão
          _textFormField(
            controllerTextField: _nome,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            maxLength: 25,
            focusNode: _nameFocus,
            onChanged: controller.changeName,
            textCapitalization: TextCapitalization.characters,
            nextFocusNode: _expDateFocus,
            labelText: widget.labelTextName,
            errorText: controller.validateName,
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //MM/YY
              _textFormField(
                width: mediaQuery(context, 0.35),
                controllerTextField: _expData,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                maxLength: 5,
                focusNode: _expDateFocus,
                onChanged: controller.changeExpData,
                textCapitalization: TextCapitalization.none,
                nextFocusNode: _cvvFocus,
                labelText: widget.labelTextExpData,
                errorText: controller.validateExpData,
              ),
              //CVV/CVC
              _textFormField(
                width: mediaQuery(context, 0.35),
                controllerTextField: _cvv,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                maxLength: ccType == CreditCardType.amex ||
                        ccType == CreditCardType.discover
                    ? 4
                    : 3,
                focusNode: _cvvFocus,
                onChanged: controller.changeCVV,
                textCapitalization: TextCapitalization.none,
                nextFocusNode: _cpfFocus,
                labelText: widget.labelTextCVV,
                nextTexFieldView: textFieldCpf,
                errorText: controller.validateCVV,
              ),
            ],
          ),
          widget.cpfVisibility == false ? Container() : SizedBox(height: 8),
          //CPF
          widget.cpfVisibility == false
              ? Container()
              : _textFormField(
                  controllerTextField: _cpf,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: true,
                  maxLength: 11,
                  focusNode: _cpfFocus,
                  onChanged: controller.changeCpf,
                  textCapitalization: TextCapitalization.characters,
                  nextTexFieldView: false,
                  labelText: widget.labelTextCPF,
                  errorText: controller.validateCPF,
                ),
        SizedBox(
                      height: 8,
                    ),
                    CheckboxListTile(
                      title: const Text(
                        "Gostaria de gravar os dados do cartão para as próximas compras no PayOk?",
                        style: TextStyle(color: Colors.orange),
                      ),
                      value: gravarDadosCartao,
                      onChanged: (newValue) {
                        print('Clicou em gravar dados cartão novoValor $newValue valorAntigo $gravarDadosCartao');
                        setState(() {
                          gravarDadosCartao = newValue!;
                          controller.changeGravarDadosContrato(newValue);
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CheckboxListTile(
                      title: const Text(
                        "Aceito as condições estabelecidas no contrato.",
                        style: TextStyle(color: Colors.orange),
                      ),
                      value: aceitaContrato,
                      onChanged: (newValue) {
                        setState(() {
                          aceitaContrato = newValue!;
                          controller.changeAceitaContrato(newValue);
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    InkWell(
                        child:
                            const Text('Clique aqui para acessar o contrato',
                        style: TextStyle(color: Colors.blue)),
                        onTap: () => print(
                            'https://docs.flutter.io/flutter/services/UrlLauncher-class.html')),
                    SizedBox(
                      height: 8,
                    ),
        
        
        
        ],
      );
    }

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: mediaQuery(context, 0.025)),
        child: Column(
          children: <Widget>[
            BodyWidget(
              titleCreditCard: widget.titleCreditCard,
              labelTextValidate: widget.labelTextValidate,
              colorCardSelect: widget.colorCardSelect,
              colorCreditWhite: widget.colorCreditWhite,
              colorCreditBlack: widget.colorCreditBlack,
              textSizeNumber: widget.textSizeNumber,
              textSizeName: widget.textSizeName,
              textSizeMonth: widget.textSizeMonth,
              textSizeCVC: widget.textSizeCVC,
              listBand: widget.listBand,
              gravaDadosCartao: widget.gravarDadosCartao,
              aceitaContrato: widget.aceitaContrato,
            ),
            SizedBox(height: 10),
            widget.viewLayout == true
                ? _inputSectionRow()
                : _inputSectionColumn(),
            SizedBox(
              width: double.infinity,
              height: 55
              ),
            //RaisedButton efetuar pagamento
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.colorButton,
                minimumSize: Size(88, 36),
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              onPressed: controller.isValid
                  ? () {
                      creditCardNumber = controller.number.replaceAll(' ', '');
                      creditCardName = controller.name;
                      creditCardExpData = controller.expData;
                      creditCardCVV = controller.cvv;
                      creditCardCPF = controller.cpf;
                      creditCardBand = controller.typeBand;
                      gravarDadosCartao = controller.gravarDadosCartao;
                      aceitaContrato = controller.aceitaContrato;
                      widget.onTap();
                    }
                  : null,
              child: Text(
                widget.labelTextButton,
                style: TextStyle(color: widget.colorTextButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
