import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatScreen extends StatefulWidget {
  static const String id='chat_screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var msg=TextEditingController();
  final _auth = FirebaseAuth.instance;
  var loggedInUser;

  @override
  void initState(){
    super.initState();
    getUserInfo();
    getMsg();
  }

//user ka info le rahe hai key hame age chat me kam aye ga ki kon sa user chat kr raha hai
  void getUserInfo() async{
    try{
      final user=await _auth.currentUser;
      if(user !=null){
        loggedInUser=user;
        print(loggedInUser.email);
      }
    }
    catch(e){
      print(e);
    }
  }



  void getMsg() async{
    final msgs = FirebaseFirestore.instance.collection("messages").snapshots();

    msgs.listen((snapshot) {
      for (var msg in snapshot.docs) {
        print(msg.data());
      }
    }, onError: (error) {
      print('Error: $error');
    });

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [
        IconButton(icon: const Icon(Icons.close),
          onPressed: (){
          FirebaseAuth.instance.signOut();
          Navigator.pushNamed(context, WelcomeScreen.id);
          }, )
      ],
        title:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120.0),
          child: Image.asset("assets/images/flassh.png",),
        ),centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,///2222222
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Expanded(
              child: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('messages').orderBy('timestamp', descending: true).snapshots(), builder: (context,ss){
               if(ss.connectionState==ConnectionState.active) {
                 if (ss.hasData) {
                   var messages = ss.data!.docs;
                  return ListView.builder(
                    reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context,index){
                    return ListTile(
                      // leading: CircleAvatar(
                      //   child: Text("${index+1}",),
                      // ),
                      title: Text("${ss.data!.docs[index]['sender']}",style: const TextStyle(color: Colors.white38),),
                      subtitle: Text("${ss.data?.docs[index]['text']}",style: const TextStyle(color: Colors.white),),

                    );
                  });
              
                 }else if(ss.hasError){
                   return Center(child: Text(ss.hasError.toString(),),);
                 }else{
                    return const Center(child: Text("There is no data is present!"),);
                 }
               }else{
                 return const Center(child: CircularProgressIndicator(),);
               }
              }),
            ),
            Container(
              child: Row(
                children: [
                   Expanded(
                    child: TextField(
                      controller: msg,
                      decoration: const InputDecoration(
                        hintText: "Type your message here...",
                        fillColor: Colors.white54,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                        ),
                      ),
                    ),
                  ),
               const SizedBox(width: 9,),
               ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
                  ),
                  onPressed: (){
                    FirebaseFirestore.instance.collection('messages').add({
                      'text': msg.text,
                      'sender': loggedInUser.email,
                      'timestamp': FieldValue.serverTimestamp(),
                    });
                    msg.clear();
                  },
                  child: const Text("Send",style: TextStyle(color: Colors.white,),))
                      ],
                    ),
            ),
          ],
        ) ,
    ),
    );
  }
}
