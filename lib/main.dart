import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      routes: {
        '/': (context) => Home(),
        '/idea': (context) => IdeaScreen(),
      },
      // initialRoute: '/',  Это для чего надо? В примере этого не было
    );
  }
}

class Idea {
  String valueIdea;
  int indexIdea;

  Function editIdea;
  Function deleteIdea;

  Idea({
    required this.valueIdea,
    required this.indexIdea,
    required this.editIdea,
    required this.deleteIdea,
  });
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var greatIdeas = <String>[
    'Суперская идея №1',
    'Еще лучше идея №2',
    'А эта идея такая потрясающая, что остановите Землю, я сойду №3',
  ];

  void editIdea(String newIdea, int indexIdea) {
    setState(() {
      greatIdeas[indexIdea] = newIdea;
    });
  }

  void deleteIdea(int indexIdea) {
    setState(() {
      greatIdeas.remove(greatIdeas.elementAt(indexIdea));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Гениальные идеи"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                width: 320,
                margin: const EdgeInsets.all(20),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Напиши, о чем думаешь',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(width: 3, color: Colors.yellow),
                    ),
                  ),
                  onSubmitted: (String newIdea) {
                    setState(() {
                      greatIdeas.add(newIdea);
                    });
                  },
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: greatIdeas.length,
                itemBuilder: (_, i) => Card(
                  color: Colors.yellow[100],
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(greatIdeas.elementAt(i)),
                    // greatIdeas[index]
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/idea',
                        arguments: Idea(
                          valueIdea: greatIdeas.elementAt(i),
                          indexIdea: i,
                          editIdea: editIdea,
                          deleteIdea: deleteIdea,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IdeaScreen extends StatefulWidget {
  const IdeaScreen({super.key});

  @override
  State<IdeaScreen> createState() => _IdeaScreenState();
}

class _IdeaScreenState extends State<IdeaScreen> {
  @override
  Widget build(BuildContext context) {
    var argument = ModalRoute.of(context)?.settings.arguments as Idea;
    return Scaffold(
      appBar: AppBar(
        title: Text(argument.valueIdea),
        actions: [
          IconButton(
            onPressed: () {
              argument.deleteIdea(argument.indexIdea);
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.delete),
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 320,
          margin: EdgeInsets.all(20),
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Редактирование идеи',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(width: 3, color: Colors.yellow),
              ),
            ),
            onSubmitted: ((value) {
              argument.editIdea(value, argument.indexIdea);
              Navigator.of(context).pop();
            }),
          ),
        ),
      ),
    );
  }
}
