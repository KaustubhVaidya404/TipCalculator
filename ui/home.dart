//import 'dart:math';

import 'package:flutter/material.dart';

class BillSplit extends StatefulWidget {
  const BillSplit({super.key});

  @override
  State<BillSplit> createState() => _BillSplitState();
}

class _BillSplitState extends State<BillSplit> {
  int _tipPercentage = 0;
  int _payingPerson = 1;
  double _billAmount = 00.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(215, 187, 245, 50),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Total Per Person",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color.fromRGBO(160, 118, 249, 1),
                        fontSize: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.00),
                      child: Text(
                        "Rs. ${calTotalBill(_tipPercentage, _billAmount, _payingPerson)}",
                        style: const TextStyle(
                          fontSize: 30,
                          color: Color.fromRGBO(160, 118, 249, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.00),
              padding: const EdgeInsets.all(12.00),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: const Color.fromRGBO(215, 187, 245, 50),
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(
                      color: Color.fromRGBO(215, 187, 245, 50),
                    ),
                    decoration: const InputDecoration(
                        labelText: "Bill Amount",
                        prefixIcon: Icon(Icons.currency_rupee)),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Split",
                        style: TextStyle(fontSize: 18, color: Colors.black45),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_payingPerson > 1) {
                                  _payingPerson -= 1;
                                } else {}
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.all(10.00),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.00),
                                color: const Color.fromRGBO(215, 187, 245, 50),
                              ),
                              child: const Center(
                                  child: Text(
                                "-",
                                style: TextStyle(
                                    color: Color.fromRGBO(160, 118, 249, 1),
                                    fontSize: 35),
                              )),
                            ),
                          ),
                          Text(
                            "$_payingPerson",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(160, 118, 249, 1),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _payingPerson += 1;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.all(10.00),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.00),
                                color: const Color.fromRGBO(215, 187, 245, 50),
                              ),
                              child: const Center(
                                  child: Text(
                                "+",
                                style: TextStyle(
                                    color: Color.fromRGBO(160, 118, 249, 1),
                                    fontSize: 30),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tip",
                        style: TextStyle(fontSize: 18, color: Colors.black45),
                      ),
                      Text(
                        "Rs. ${calTotalTip(_billAmount, _tipPercentage)}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(160, 118, 249, 1),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$_tipPercentage%",
                        style: const TextStyle(
                            fontSize: 15.00,
                            color: Color.fromRGBO(160, 118, 249, 1),
                            fontWeight: FontWeight.bold),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: const Color.fromRGBO(160, 118, 249, 1),
                          inactiveColor: Colors.black12,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double value) {
                            setState(
                              () {
                                _tipPercentage = value.round();
                              },
                            );
                          })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  calTotalBill(int totalTipPercentage, double billAmount, int splitBy){
    var billPerPerson = (calTotalTip(billAmount, totalTipPercentage) + billAmount) / splitBy;
    return billPerPerson;
  }
  calTotalTip(double billAmount, int tipPercentage){
    double totalTip = 0.00;
    if(billAmount<0 || billAmount.toString().isEmpty){
      //Leave as it is
    }
    else{
      totalTip= (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }
}
