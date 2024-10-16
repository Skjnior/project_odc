import 'dart:ui';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:animate_do/animate_do.dart';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:project_odc/entity/user_entity.dart';
import '../database.dart';
import '../models/user.dart';
import 'message.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.database});

  AppDatabase database;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List message = [];

  dynamic _formKey = GlobalKey<FormBuilderState>();
  final _formUpdaeKey = new GlobalKey<FormBuilderState>();

  List<User> users = [];
  int pageCourante = 1;

  PagingController<int, User> pagingController =
      PagingController(firstPageKey: 1);

  //double fontSize = 16;

  @override
  void initState() {
    // TODO: implement initState

    /* message =
    [
        {
          "user": users[3],
          "message": "Cv??",
          "heure": "12:30",
          "status": 1,
        },
        {
          "user": users[0],
          "message": "Longue vie à toi fils",
          "heure": "21:05",
          "status": 2,
        },
        {
        "user": users[1],
        "message": "C'est naruto???",
        "heure": "15:10",
        "status": 2,
      },
        {
        "user": users[7],
        "message": "Quand tu seras disponible fait moi singe",
        "heure": "12:30",
        "status": 3,
      },
      {
        "user": users[4],
        "message": "Tu as vu?",
        "heure": "12:30",
        "status": 1,
      },
      {
        "user": users[0],
        "message": "Longue vie à toi fils",
        "heure": "21:05",
        "status": 2,
      },
      {
      "user": users[3],
      "message": "Cv??",
      "heure": "12:30",
      "status": 1,
    },
      {
        "user": users[4],
        "message": "Faire quoi ?",
        "heure": "21:05",
        "status": 2,
      },
      {
        "user": users[0],
        "message": "Longue vie à toi fils",
        "heure": "21:05",
        "status": 2,
      },
      {
        "user": users[3],
        "message": "Cv??",
        "heure": "12:30",
        "status": 1,
      },
      {
        "user": users[4],
        "message": "Faire quoi ?",
        "heure": "21:05",
        "status": 2,
      },

    ];*/

    pagingController.addPageRequestListener((pageKey) {
      getUserList(page: pageKey);
    });
  }

  /* List users = [
    {
      "nom": "Ma mere",
      "image": "assets/images/15.jpeg",
      "status": true,
    },
    {
      "nom": "Malick",
      "image": "assets/images/28.jpeg",
      "status": false,
    },
    {
      "nom": "Homo",
      "image": "assets/images/hom.jpg",
      "status": true,
    },
    {
      "nom": "Doussou",
      "image": "assets/images/doussou.jpeg",
      "status": false,
    },
    {
      "nom": "Eddy",
      "image": "assets/images/3.jpeg",
      "status": true,
    },
    {
      "nom": "Fatmae",
      "image": "assets/images/14.jpeg",
      "status": false,
    },
    {
      "nom": "Rene",
      "image": "assets/images/17.jpeg",
      "status": true,
    },
    {
      "nom": "Mr Ousmane",
      "image": "assets/images/12.jpeg",
      "status": true,
    },

  ];*/

/*
void getUsersList({int page = 1}){
  getUsers().then((value) {
    setState(() {
      users = value;
    });
  });
}
*/

  void getUserList({int page = 1}) {
    getUsers(page: page, pagingController: pagingController);
  }

  void updateUser({required Utilisateur user}) {
    Get.bottomSheet(ListView(
      children: [
        Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/google.png"),
                    ),
                    title: Text("Mise a jour d'un utilisateur"),
                    subtitle: Text("Formulaire de mise a jour"),
                  ),
                  FormBuilder(
                    key: _formUpdaeKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: FormBuilderTextField(
                            name: "nom",
                            initialValue: user.nom,
                            decoration: InputDecoration(
                                labelText: "Nom de famille",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: FormBuilderTextField(
                            name: "prenom",
                            initialValue: user.prenom,
                            decoration: InputDecoration(
                                labelText: "Prenom",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GFButton(
                            text: "Modifier",
                            color: Colors.orange,
                            size: GFSize.LARGE,
                            fullWidthButton: true,
                            shape: GFButtonShape.pills,
                            onPressed: () async {
                              if (_formUpdaeKey.currentState!
                                  .saveAndValidate()) {
                                int id = await widget.database.utilisateurDao
                                    .updateUtilisateur(Utilisateur(
                                        id: user.id,
                                        nom: _formUpdaeKey
                                            .currentState!.value['nom'],
                                        prenom: _formUpdaeKey
                                            .currentState!.value['prenom'],
                                        telephone: "666666666"));

                                _formUpdaeKey.currentState!.reset();
                                Get.back();
                                setState(() {});

                                Get.snackbar(
                                  "Success",
                                  "L'utilisateur a été modifié avec succès",
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blueAccent,
                                    size: 25,
                                  ),
                                  backgroundColor: Colors.white,
                                  colorText: Colors.green,
                                  isDismissible: true,
                                  messageText: const  Text(
                                    "L'utilisateur a été modifié avec succès",
                                    style: TextStyle(
                                      color: Colors.blueAccent, // Couleur du texte
                                    ),
                                  ),
                                );

                              }
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ],
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white30,
          onPressed: () {
            Get.bottomSheet(
                ListView(
              children: [
                Container(
                    decoration: const BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                    ),
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.height / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/google.png"),
                              backgroundColor: Colors.white,
                            ),
                            title: Text(
                              "Ajout d'un utilisateur",
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "Formulaire d'enregistrement",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          FormBuilder(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0, top: 30.0),
                                  child: FormBuilderTextField(
                                    style: const TextStyle(color: Colors.white),
                                    autofocus: true,
                                    cursorColor: Colors.white,
                                    name: 'nom',
                                    decoration: const InputDecoration(
                                      hintStyle: TextStyle(color: Colors.white),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        size: 24,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Nom de famille',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black87, width: 1),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0, top: 30.0),
                                  child: FormBuilderTextField(
                                    style: const TextStyle(color: Colors.white),
                                    autofocus: true,
                                    cursorColor: Colors.white,
                                    name: 'prenom',
                                    decoration: const InputDecoration(
                                      hintStyle: TextStyle(color: Colors.white),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        size: 24,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Prénom',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black87, width: 1),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: SizedBox(
                                    width: 250,
                                    height: 45,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)),
                                      onPressed: () {
                                        if (_formKey.currentState!
                                            .saveAndValidate()) {
                                          widget.database.utilisateurDao
                                              .insertUtilisateur(Utilisateur(
                                                  nom: _formKey.currentState!
                                                      .value['nom'],
                                                  prenom: _formKey.currentState!
                                                      .value['prenom'],
                                                  telephone: "66363"));

                                          _formKey.currentState!.reset();
                                          Get.back();
                                          setState(() {});

                                          Get.snackbar(
                                            "Success",
                                            "L'utilisateur a été ajouter avec succès",
                                            icon: const Icon(
                                              Icons.check,
                                              color: Colors.green,
                                              size: 25,
                                            ),
                                            colorText: Colors.green,
                                            backgroundColor: Colors.white,
                                            isDismissible: true,
                                            messageText: Text(
                                                "L'utilisateur à été jouter avec succès",
                                              style: TextStyle(
                                                color: Colors.green
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: const SizedBox(
                                        child: Text(
                                          'Sauvergarder',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ));
          },
          child: const Icon(
            Icons.add,
            size: 25,
            color: Colors.white,
          ),
        ),
        appBar: MyCustomAppBar(),
        
        backgroundColor: HexColor("#000000"),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 130,
                  child: PagedListView(
                      scrollDirection: Axis.horizontal,
                      pagingController: pagingController,
                      builderDelegate: PagedChildBuilderDelegate<User>(
                          firstPageProgressIndicatorBuilder: (context) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 15,
                              ),

                            ],
                          ),
                        );
                      }, firstPageErrorIndicatorBuilder: (context) {
                        return const Text("Erreur de chargement des données");
                      }, itemBuilder: (context, item, index) {
                        return createAvart(user: item);
                      })),
                ),
                /* Container(
                height: 150,
                child:  FutureBuilder(
                    future: widget.database.utilisateurDao.findAllUser(),
                    builder: (context, data) {

                      if(data.connectionState == ConnectionState.waiting){
                        return const Center(
                          child:  CircularProgressIndicator(
                            backgroundColor: Colors.cyanAccent,
                          ),
                        );
                      }

                      if(!data.hasError && data.hasData){

                        List<Utilisateur> users =  data.data as List<Utilisateur>;

                        print(users);
                        return  ListView(

                                scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                      users.length, (index) {
                                    return createAvart(user: );
                                  }),
                        );



                        */
                /*ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: users.map((user) {
                            return createAvartUi(user: user);
                          }).toList(),
                        );*/
                /*

                        return const Center(
                          child: Text(
                            "Erreur",
                            style: TextStyle(
                              color: Colors.cyanAccent,
                            ),
                          ),
                        );
                      }

                      return SizedBox();
                    }
                ),

                */
                /*ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(users.length, (index) {
                    return createAvart(user: users[index]);
                  }),
                ),*/
                /*
              ),*/

                const Padding(
                  padding: EdgeInsets.only(top: 5, left: 10,),
                  child: Text(
                    "New",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),

                /// Zone de message
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: FutureBuilder(
                        future: widget.database.utilisateurDao.findAllUser(),
                        builder: (context, data) {
                          if (data.connectionState == ConnectionState.active) {
                            return const CircularProgressIndicator();
                          }

                          if (!data.hasError && data.hasData) {
                            List<Utilisateur> users =
                                data.data as List<Utilisateur>;
                            return ListView(
                              /// Mon coup de coeur Lol
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: users.map((user) {
                                return GestureDetector(
                                  onTap: (){
                                    Get.to(() => MessagesPage(messages: user.prenom, nom: user.nom,));
                                  },
                                  child: Slidable(
                                      // Specify a key if the Slidable is dismissible.
                                      key: Key(user.id.toString()),

                                      // The start action pane is the one at the left or the top side.
                                      startActionPane: ActionPane(
                                        // A motion is a widget used to control how the pane animates.
                                        motion: const ScrollMotion(),

                                        // A pane can dismiss the Slidable.
                                        dismissible:
                                            DismissiblePane(
                                                onDismissed: () {

                                                }
                                            ),

                                        // All actions are defined in the children parameter.
                                        children:  [
                                          // A SlidableAction can have an icon and/or a label.
                                          SlidableAction(
                                            padding: EdgeInsets.only(top: 18.0),
                                            onPressed: (BuildContext context) async {
                                              // Action à effectuer lorsque la première action est tapée
                                              await showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text("Confirmation"),
                                                    content: const Text("Êtes-vous sur le point de rendre ce message nouveau, voulez-vous continuer ?"),
                                                    actions: <Widget>[
                                                      // Bouton pour annuler la suppression
                                                      TextButton(
                                                        onPressed: () {
                                                          // Action à effectuer lorsque l'utilisateur annule la suppression
                                                          // Fermer la boîte de dialogue avec la valeur false
                                                          Navigator.of(context).pop(false);
                                                        },
                                                        child: const Text("Annuler"),
                                                      ),
                                                      // Bouton pour confirmer la suppression
                                                      TextButton(
                                                        onPressed: () async {
                                                          // Confirmer la suppression

                                                          // Fermer la boîte de dialogue avec la valeur true
                                                          Navigator.of(context).pop(true);
                                                        },
                                                        child: const Text("Supprimer"),
                                                      ),
                                                    ],
                                                  );

                                                },
                                              );
                                            },
                                            backgroundColor: Color(0xFF0a84ff),
                                            foregroundColor: Colors.white,
                                            icon: CupertinoIcons.chat_bubble_fill,
                                            label: '',
                                          ),
                                        ],
                                      ),
                                    endActionPane: ActionPane(
                                      // A motion is a widget used to control how the pane animates.
                                      motion: const ScrollMotion(),

                                      // A pane can dismiss the Slidable.
                                      dismissible: DismissiblePane(
                                        onDismissed: () {
                                          // Action à effectuer lorsque l'élément est glissé
                                        },
                                      ),

                                      // All actions are defined in the children parameter.
                                      children: [
                                        // Première action
                                        SlidableAction(
                                          padding: EdgeInsets.only(top: 18.0),
                                          onPressed: (BuildContext context) async {
                                            // Action à effectuer lorsque la première action est tapée
                                            await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text("Confirmation"),
                                                  content: const Text("Êtes-vous sûr de vouloir déactiver la notification ?"),
                                                  actions: <Widget>[
                                                    // Bouton pour annuler la suppression
                                                    TextButton(
                                                      onPressed: () {
                                                        // Action à effectuer lorsque l'utilisateur annule la suppression
                                                        // Fermer la boîte de dialogue avec la valeur false
                                                        Navigator.of(context).pop(false);
                                                      },
                                                      child: const Text("Annuler"),
                                                    ),
                                                    // Bouton pour confirmer la suppression
                                                    TextButton(
                                                      onPressed: () async {
                                                        // Confirmer la suppression

                                                        // Fermer la boîte de dialogue avec la valeur true
                                                        Navigator.of(context).pop(true);
                                                      },
                                                      child: const Text("Supprimer"),
                                                    ),
                                                  ],
                                                );

                                              },
                                            );

                                          },
                                          backgroundColor: Color(0xFF5e5be6),
                                          foregroundColor: Colors.white,
                                          icon: Icons.notifications_off,
                                          label: '',
                                        ),

                                        // Deuxième action
                                        SlidableAction(
                                          padding: EdgeInsets.only(top: 18.0),
                                          onPressed: (BuildContext context) async {
                                            // Action à effectuer lorsque la deuxième action est tapée
                                            await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text("Confirmation"),
                                                  content: const Text("Êtes-vous sûr de vouloir supprimer cet élément ?"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () => Navigator.of(context).pop(false), // Annuler la suppression
                                                      child: const Text("Annuler"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        // Confirmer la suppression
                                                        users.remove(user);
                                                        await widget.database.utilisateurDao.deleteUtilisateur(user);
                                                        setState(() { });
                                                        Get.snackbar(
                                                          "Success",
                                                          "L'utilisateur a été supprimer avec succès",
                                                          icon: const Icon(
                                                            CupertinoIcons.delete,
                                                            color: Colors.red,
                                                            size: 25,
                                                          ),
                                                          colorText: Colors.green,
                                                          backgroundColor: Colors.white,
                                                          isDismissible: true,
                                                          messageText: const Text(
                                                            "L'utilisateur à été supprimer avec succès",
                                                            style: TextStyle(
                                                                color: Colors.red
                                                            ),
                                                          ),
                                                        );
                                                        Navigator.of(context).pop(true);
                                                },
                                                      child: const Text("Supprimer"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          backgroundColor: Color(0xFFff4439),
                                          foregroundColor: Colors.white,
                                          icon: CupertinoIcons.delete,
                                          label: '',
                                        ),
                                      ],
                                    ),
                                    child: createMessage(user: user),
                                  ),
                                );



                                // Pour chatGPT
                                /* Dismissible(
                                  key: Key(user.id.toString()),
                                  background: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                        ),
                                        height: double.infinity,
                                        width: MediaQuery.of(context).size.height / 5,
                                        child: Container(
                                          color: Colors.blue,
                                          height: double.infinity,
                                          width: MediaQuery.of(context).size.height / 8,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              CupertinoIcons.chat_bubble_fill,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context).size.height / 2,
                                            width: MediaQuery.of(context).size.width / 6,
                                            color: Colors.blueAccent,
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.notifications_off,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: MediaQuery.of(context).size.height / 2,
                                            width: MediaQuery.of(context).size.width / 6,
                                            color: Colors.red,
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  confirmDismiss: (direction) async {
                                    // Afficher une boîte de dialogue de confirmation et renvoyer true si l'utilisateur confirme.
                                    return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirmation"),
                                          content: const Text("Êtes-vous sûr de vouloir supprimer cet élément ?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.of(context).pop(false), // Annuler la suppression
                                              child: const Text("Annuler"),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.of(context).pop(true), // Confirmer la suppression
                                              child: const Text("Supprimer"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  onDismissed: (direction) async {
                                    // Supprimer l'utilisateur si la suppression est confirmée
                                    users.remove(user);
                                    await widget.database.utilisateurDao.deleteUtilisateur(user);
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: Colors.white, // Couleur de la bordure supérieure
                                          width: 0.05,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.white, // Couleur de la bordure supérieure
                                          width: 0.05,
                                        ),
                                      ),
                                    ),
                                    child: createMessage(user: user),
                                  ),
                                );*/

                                // Mon Dismissible
                                /*Dismissible(
                                  key: Key(user.id.toString()),
                                  background: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.only(
                                              topLeft:  Radius.circular(20),
                                              topRight:  Radius.circular(20),
                                              bottomRight:  Radius.circular(20),
                                              bottomLeft:  Radius.circular(20),
                                            )
                                        ),
                                        height: double.infinity,
                                        width: MediaQuery.of(context).size.height/5,
                                        child: Container(
                                            color: Colors.blue,
                                            height: double.infinity,
                                            width: MediaQuery.of(context).size.height/8,
                                            child: IconButton(
                                              onPressed: (){

                                              },
                                              icon: const Icon(
                                                CupertinoIcons.chat_bubble_fill,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            )
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context).size.height/2,
                                                width: MediaQuery.of(context).size.width/6,
                                                color: Colors.blueAccent,
                                                child: IconButton(
                                                  onPressed: (){

                                                  },
                                                  icon: const Icon(
                                                    Icons.notifications_off,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: MediaQuery.of(context).size.height/2,
                                                width: MediaQuery.of(context).size.width/6,
                                                color: Colors.red,
                                                child: IconButton(
                                                  onPressed: (){

                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),

                                  onDismissed: (direction) async {

                                    users.remove(user);
                                    await widget.database.utilisateurDao.deleteUtilisateur(user);

                                    setState(() { });

                                  },
                                  child: Container(
                                      decoration:   const BoxDecoration(
                                        border:  Border(
                                          top: BorderSide(
                                            color: Colors.white, // Couleur de la bordure supérieure
                                            width: 0.05,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.white, // Couleur de la bordure supérieure
                                            width: 0.05,
                                          ),
                                        ),
                                      ),
                                      child: createMessage(user: user)
                                  ),
                                  // confirmDismiss: (direction) {
                                  //   return true;
                                  // },
                                );*/

                                /* FadeInLeft(
                                child: Text(
                                    "messs",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              );*/
                              }).toList(),
                            );
                          }
                          return SizedBox();
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }

  Widget createMessage({required Utilisateur user}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 0, right: 2),
      child: ListTile(
          textColor: Colors.white,
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("assets/images/7.jpeg"),
          ),
          title: Text(
            user.prenom,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Salut",
          ),
          trailing: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Text(
                      "00:45",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: IconButton(
                        onPressed: () {
                          updateUser(user: user);
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )

          /*Column(
          children: [
            Text(
              "00:45",
            ),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
              color: HexColor("#301c70"),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),

              child: Center(
                  child: IconButton(
                    onPressed: (){
                      updateUser(user: user);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  )
              ),
            ),
          ],
        ),*/
          ),
    );
  }


  Widget createMessagePlacHosder({required Utilisateur user}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 0, right: 2),
      child: ListTile(
          textColor: Colors.white,
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("assets/images/7.jpeg"),
          ),
          title: Text(
            user.prenom,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Salut",
          ),
          trailing: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Expanded(
                  child: Stack(
                    children: [
                      Text(
                        "00:45",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: IconButton(
                          onPressed: () {
                            updateUser(user: user);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )

        /*Column(
          children: [
            Text(
              "00:45",
            ),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
              color: HexColor("#301c70"),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),

              child: Center(
                  child: IconButton(
                    onPressed: (){
                      updateUser(user: user);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  )
              ),
            ),
          ],
        ),*/
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(180.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
      ),
      child: Stack(
        children: <Widget>[
          AppBar(
            elevation: 0,
            backgroundColor: HexColor("#181818"),
            title: const Text(
              "Chats",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            centerTitle: true,
            leading: const Padding(
              padding: const EdgeInsets.all(7.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/9.jpeg",
                ),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white30,
                      width: 2.0,
                    ),
                  ),
                  child: const Center(
                    child: IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.add,
                        size: 25,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 120.0, // Positionnement de la barre de recherche
            left: 0.0,
            right: 0.0,
            child: Container(
              width: 150,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: HexColor("#000000"),
                borderRadius: BorderRadius.circular(80.0),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 32,
                    ),
                    hintText: "Search...",
                    hintStyle: TextStyle(
                      color: Colors.white60,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget createAvart({required User user}) {
  return Padding(
    padding: EdgeInsets.all(15),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(user.image),
              ),
              true
                  ? Positioned(
                      top: 45,
                      left: 40,
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.black,
                        ),
                      ),
                    )
                  : const SizedBox(),
              true
                  ? Positioned(
                      top: 45,
                      left: 40,
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.green,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        Text(
          user.firstName,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white60),
        ),
      ],
    ),
  );
}

Widget createAvartUi({required Utilisateur user}) {
  return Padding(
    padding: EdgeInsets.all(15),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/7.jpeg"),
              ),
              true
                  ? Positioned(
                      top: 45,
                      left: 40,
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.black,
                        ),
                      ),
                    )
                  : const SizedBox(),
              true
                  ? Positioned(
                      top: 45,
                      left: 40,
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.green,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        Text(
          user.prenom,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white60),
        ),
      ],
    ),
  );
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
