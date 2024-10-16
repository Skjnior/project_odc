
class Message{


  String user;
  String text;
  String heure;
  String status;

  Message({required this.user, required this.text, required this.heure, required this.status});

   List<Message>getMessages() {
    List<Message> Listmessage = [];

    /*Listmessage = [
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

    return Listmessage;
  }

}