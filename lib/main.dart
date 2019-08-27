import 'package:flutter/material.dart';

void main() => runApp(Chat());

const String _name = 'Your name';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat',
        theme: ThemeData(
          primaryColor: Colors.purple,
        ),
        home: ChatScreen());
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body:  new Column(
        children: <Widget>[
        new Flexible(
          child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          )
        ),
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
       ]
     ),
    );
  }

  Widget _buildTextComposer() {
   return new Container(
       margin: const EdgeInsets.symmetric(horizontal: 8.0),
       child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: new InputDecoration.collapsed(
                hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send, color: Colors.purpleAccent,), 
                onPressed: () => _handleSubmitted(_textController.text)),
           ),
         ]
       )
    );
  }

  void _handleSubmitted(String text) {
    if(text.length == 0) {
      return;
    }

    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
    );

    setState(() {
      print(message);
      _messages.insert(0, message);
    });
  }
}


class ChatMessage extends StatelessWidget {
  final String text;
  ChatMessage({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: CircleAvatar(child: Text(_name[0]),),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(_name, style: Theme.of(context).textTheme.subhead),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(text),
              )
            ],
          )
        ],
      ),
    );
  }
}