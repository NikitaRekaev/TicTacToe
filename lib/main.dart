import 'package:flutter/material.dart';
import 'my_styles.dart';

void main() {
  runApp(const TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Flutter Demo',
      home: const TicTacToePage(title: 'Tic Tac Toe'),
    );
  }
}

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key, required this.title});

  final String title;

  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  bool isTurn = true;
  int oScore = 0;
  int xScore = 0;
  int count = 0;

  List<String> changeXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Игрок Х',
                          style: txtStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          xScore.toString(),
                          style: txtStyle,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Игрок О',
                          style: txtStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          oScore.toString(),
                          style: txtStyle,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
            Expanded(
                flex: 3,
                child: GridView.builder(
                    itemCount: changeXO.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (BuildContext ctx, int index) {
                      return GestureDetector(
                        onTap: () => _setXorO(index),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey)),
                          child: Center(
                              child: Text(
                            changeXO[index],
                            style: xoStyle,
                          )),
                        ),
                      );
                    })),
          ],
        ));
  }

  void _setXorO(int i) {
    if (isTurn && changeXO[i] == '') {
      setState(() {
        changeXO[i] = 'o';
        isTurn = !isTurn;
      });
    } else if (!isTurn && changeXO[i] == '') {
      setState(() {
        changeXO[i] = 'x';
        isTurn = !isTurn;
      });
    }

    count++;
    _checkWinner();
  }

  void _checkWinner() {
    if (changeXO[0] == changeXO[1] &&
        changeXO[0] == changeXO[2] &&
        changeXO[0] != '') {
      _showDialog(winner: changeXO[0]);
    }
    if (changeXO[3] == changeXO[4] &&
        changeXO[3] == changeXO[5] &&
        changeXO[3] != '') {
      _showDialog(winner: changeXO[3]);
    }
    if (changeXO[6] == changeXO[7] &&
        changeXO[6] == changeXO[8] &&
        changeXO[6] != '') {
      _showDialog(winner: changeXO[6]);
    }
    if (changeXO[0] == changeXO[3] &&
        changeXO[0] == changeXO[6] &&
        changeXO[0] != '') {
      _showDialog(winner: changeXO[0]);
    }
    if (changeXO[1] == changeXO[4] &&
        changeXO[1] == changeXO[7] &&
        changeXO[1] != '') {
      _showDialog(winner: changeXO[1]);
    }
    if (changeXO[2] == changeXO[5] &&
        changeXO[2] == changeXO[8] &&
        changeXO[2] != '') {
      _showDialog(winner: changeXO[2]);
    }
    if (changeXO[0] == changeXO[4] &&
        changeXO[0] == changeXO[8] &&
        changeXO[0] != '') {
      _showDialog(winner: changeXO[0]);
    }
    if (changeXO[2] == changeXO[4] &&
        changeXO[2] == changeXO[6] &&
        changeXO[2] != '') {
      _showDialog(winner: changeXO[2]);
    }

    if (count == 9) {
      _showDialog(winnerExist: false);
      _clearBoard();
    }
  }

  void _showDialog({String winner = '', bool winnerExist = true}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(winnerExist ? 'Победитель: $winner' : 'Нет победителя'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Играть ещё раз!'))
            ],
          );
        });
    count = 0;
    _clearBoard();

    if (winner == 'o') {
      setState(() {
        oScore++;
      });
    } else if (winner == 'x') {
      setState(() {
        xScore++;
      });
    }
  }

  void _clearBoard() {
    for (int i = 0; i < 9; i++) {
      changeXO[i] = '';
    }
  }
}