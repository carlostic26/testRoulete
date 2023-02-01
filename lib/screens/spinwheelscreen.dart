import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:ruleparejas_project/screens/options.dart';
import 'package:rxdart/rxdart.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'checkBox.dart';

class SpinWheel extends StatefulWidget {
  final String requiredPlan;

  const SpinWheel({required this.requiredPlan, Key? key}) : super(key: key);

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

SharedPreferences? _prefs;

class _SpinWheelState extends State<SpinWheel> {
  final selected = BehaviorSubject<int>();
  String plan = '100';

  //deportes: Golf, Volleyball, Basketboll, Mini Fútboll

  List<String> itemsPlan = [];
  List<String> itemsRoulette = [];
  List<bool> isRemoved = [];

  @override
  void initState() {
    isRemoved = List.filled(itemsPlan.length, false);
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });

    // TODO: implement initState
    super.initState();

    if (widget.requiredPlan.contains('Comidas')) {
      itemsPlan = [
        'Hot Dogs',
        'Spaguetti',
        'Sandwich',
        'Ensaladas',
        'Arepas',
        'Pollo frito',
        'Empanadas',
        'Hamburguesa',
        'Pollo asado',
        'Helado',
        'Churros',
        'Pizza'
      ];
    }

    if (widget.requiredPlan.contains('Hobbies')) {
      //debe ser un numero par para evitar formar doble franja del mismo color en la ruleta
      itemsPlan = [
        'Karaoke',
        'Caminata',
        'Cine',
        'Grabar un TikTok',
        'Picnic',
        'Paseo en bicicleta',
        'Natación',
        //'Pesca',
        'Camping',
        'Escalada',
        'Senderismo',
        'Kayak',
        'Pintar',
      ];
    }

    if (widget.requiredPlan.contains('Juegos Outdoor')) {
      itemsPlan = [
        'Bolos',
        'Carritos chocones',
        'Montaña Rusa',
        'Paintball',
        'Volar cometa',
        'Pin pon',
        'Beach soccer',
        'frisbee o boomerang'
      ];
    }

    if (widget.requiredPlan.contains('Juegos de Mesa')) {
      itemsPlan = [
        'Dominó',
        'Damas',
        'Ajedrez',
        'Parqués',
        'Monopoly',
        'Uno',
        'Rummy',
        'Póker',
        'Bingo',
        'Baraja española',
        'Trivial pursuit',
        'Risk',
        'Scrabble',
        'Jenga'
      ];
    }

    if (widget.requiredPlan.contains('Postres')) {
      itemsPlan = [
        'Natilla',
        'Arroz con leche',
        'Tres leches',
        'Bocadillo',
        'Chocolate con queso',
        'Buñuelos',
        'Postre de leche',
        'Torta de Chocolate',
        'Helado de vainilla',
        'Pastel de zanahoria',
        'Crepes',
        'Fondue de Chocolate',
        'Pay de manzana',
        'Brownie',
        'Mousse de Chocolate',
        'Flan',
        'Quesillo',
        'Cupcakes'
      ];
    }

    if (widget.requiredPlan.contains('Bebidas')) {
      itemsPlan = [
        'Vino',
        'Frappé',
        'Granizado',
        'Juguito',
        'Agua',
        'Gaseosa Refresco',
        'Cerveza',
        'Cocktail',
        'Sangría',
        'Whiskey',
        'Tequila',
        'Ron',
        'Licor de café',
        //'Smoothie',
        'Leche'
      ];
    }
  }

  List<int> selectedIndices = [];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double drawer_width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 19, 64),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            //flecha atras
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 1, 5, 1),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      size: 30, color: Colors.amber),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const optionsPlanesScreen()),
                    );
                  },
                ),
              ),
            ),

            const Text(
              "RulePlan",
              style: TextStyle(
                  fontSize: 70, fontFamily: 'LobsterTwo', color: Colors.white),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.requiredPlan,
                style: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'LobsterTwo',
                  color: Colors.amber,
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(),
                  SizedBox(
                    height: 300,
                    child: Container(
                      decoration: BoxDecoration(
                        //establece el color del borde de la ruleta
                        border: Border.all(color: Colors.black, width: 4),
                        shape: BoxShape.circle,
                      ),
                      child: FortuneWheel(
                        styleStrategy: const UniformStyleStrategy(
                          borderColor: Colors.yellow,
                          color: Colors.yellow,
                          borderWidth: 4,
                        ),
                        selected: selected.stream,
                        animateFirst: false,
                        items: [
                          for (int i = 0;
                              i < itemsPlan.length;
                              i++) ...<FortuneItem>{
                            FortuneItem(
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: i % 2 == 0
                                          ? Colors.orange
                                          : Colors.yellow,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      itemsPlan[i],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          },
                        ],
                        onAnimationEnd: () {
                          setState(() {
                            plan = itemsPlan[selected.value];
                          });
                          showItemDialog(plan);
                          print(plan);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("El plan de hoy será $plan ¡Adelante!"),
                            ),

                            //dialog
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Elije tus intereses',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'LobsterTwo',
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: drawer_width * 0.4),
                          GestureDetector(
                            onTap: () {
                              // aquí agrega el código que quieres ejecutar al tocar el botón
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.amber,
                              radius: 12,
                              child: Icon(
                                Icons.refresh,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 7,
                      children: [
                        for (int i = 0; i < itemsPlan.length; i++)
                          if (!isRemoved[i])
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (i >= 0 && i < itemsPlan.length) {
                                    selectedIndices.add(i);
                                    _prefs?.setString("boton_$i", itemsPlan[i]);
                                  } else {
                                    if (itemsPlan.length <= 2) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Debes tener al menos 2 items en este plan"),
                                        ),
                                      );
                                    } else {
                                      selectedIndices.remove(i);
                                      isRemoved[i] = true;
                                      _prefs?.remove("boton_$i");
                                    }
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedIndices.contains(i)
                                      ? Colors.grey
                                      : Colors.amber,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    isRemoved[i] ? "" : itemsPlan[i],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected.add(Fortune.randomInt(0, itemsPlan.length));
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 40,
                      width: 120,
                      child: const Center(
                        child: Text(
                          "Girar",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'LobsterTwo',
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showItemDialog(String plan) {
    String imageUrl = '';
    if (itemsPlan.contains(plan)) {}

    if (plan.contains("Hot Dogs")) {
      imageUrl =
          'https://www.gifcen.com/wp-content/uploads/2022/04/hot-dog-gif-6.gif';
    } else if (plan.contains("Pizza")) {
      imageUrl = 'https://media.tenor.com/VWAZosGBC6AAAAAC/hellmo-pizza.gif';
    } else if (plan.contains("Arepita")) {
      imageUrl =
          'https://arepaslaaguelita.com/wp-content/uploads/2020/08/GIF-FINAL-AREPAS..-1.gif';
    } else if (plan.contains("Spaguetti")) {
      imageUrl =
          'https://media.tenor.com/Rzqtdzfs0zEAAAAd/spaghetti-cheese.gif';
    } else if (plan.contains("Sandwich")) {
      imageUrl = 'https://media3.giphy.com/media/26BRtdgnU1y90zNeg/giphy.gif';
    } else if (plan.contains("Pollo frito")) {
      imageUrl = 'https://i.makeagif.com/media/7-25-2015/Pz8ENk.gif';
    } else if (plan.contains("Empanadas")) {
      imageUrl =
          'https://media.tenor.com/svMojj-YwtYAAAAC/empanada-empanadas.gif';
    } else if (plan.contains("Hamburguesa")) {
      imageUrl =
          'https://i.gifer.com/origin/f9/f9a850a4bafb8702f34dd1c3d8f247a3.gif';
    } else if (plan.contains("Helado")) {
      imageUrl =
          'https://verdeazul.es/wp-content/uploads/2019/07/FixedFalseHeterodontosaurus-small.gif';
    } else if (plan.contains("Churros")) {
      imageUrl = 'https://media0.giphy.com/media/FENqTQVsCV7va/giphy.gif';
    } else if (plan.contains("Pollo asado")) {
      imageUrl =
          'https://espanol.kingsford.com/wp-content/uploads/2015/06/chicken3_560x340.gif';
    } else {
      imageUrl =
          'https://i.pinimg.com/originals/49/2f/2e/492f2eb541ae4e5d1644248a1d5cff1d.gif';
    }

    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: NetworkGiffDialog(
              image: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
              title: Text(
                '¡$plan!',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              description: const Text(
                'Abre el mapa para ver los sitios mas cercanos e interesantes para este plan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              buttonCancelText: const Text(
                'Ya no',
                style: TextStyle(color: Colors.white),
              ),
              buttonOkText: const Text(
                'Ver Mapa',
                style: TextStyle(color: Colors.white),
              ),
              buttonOkColor: const Color.fromARGB(255, 188, 19, 64),
              onOkButtonPressed: () async {
                // Acciones al presionar el boton OK

                Navigator.pop(context);
                final url =
                    'https://www.google.com/maps/search/?api=1&query=$plan';
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  launch(url);
                  throw 'Could not launch $url';
                }
              },
              onCancelButtonPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) => Container(),
    );
  }
}
