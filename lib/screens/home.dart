import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  //---------------ADD DATA -----------------------------

  //***** INPUT FIELDS TO STORE DATA *****

  String product_name="";
  double product_price=0;
  int product_weight=0;

  final prod_nameCtrl = TextEditingController();
  final prod_priceCtrl = TextEditingController();
  final prod_weightCtrl = TextEditingController();


  void addProd(String name, double price, int weight){

    CollectionReference product = FirebaseFirestore.instance.collection('products');
    product
    //.doc('us5')
    //.set({'nom': nom, 'age': age})
        .add({
      'name': product_name,
      'price': product_price,
      'weight': product_weight,
      'date': new DateTime.now(),
    })
        .then((value) => print("Product Added"))
        .catchError((error) => print("Failed to add product: $error"));

  }

  Future<String?> openDialog()=>showDialog<String>(
    context: context,
    builder: (context)=>AlertDialog(


      content: Container(
        height: 150,
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontSize: 12),
              autofocus: true,
              decoration: InputDecoration(hintText: "Enter the product name"),
              controller: prod_nameCtrl,
            ),
            TextField(
              style: TextStyle(fontSize: 12),
              autofocus: true,
              decoration: InputDecoration(hintText: "Enter the product price"),
              controller: prod_priceCtrl,
              keyboardType: TextInputType.number,
            ),
            TextField(
              style: TextStyle(fontSize: 12),
              autofocus: true,
              decoration: InputDecoration(hintText: "Enter the product weight"),
              controller: prod_weightCtrl,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: cancel,
            child: Text("CANCEL")),
        TextButton(onPressed: submit,
            child: Text("SUBMIT"))
      ],
    ),
  );

  Future<String?> openDialog2()=>showDialog<String>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Rewind and remember'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('You will never be satisfied.'),
              Text('You\’re like me. I’m never satisfied.'),
              TextField(),
            ],
          ),
        ),
        actions: <Widget>[
          FloatingActionButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );

  void submit(){
    if(prod_weightCtrl.text == "" || prod_nameCtrl.text == "" || prod_priceCtrl.text == "")
    {
      toast(context,"Please add correct value for the product !");
      Navigator.of(context).pop();
      return;
    }
    setState(() {
      product_name = prod_nameCtrl.text;
      product_weight = int.parse(prod_weightCtrl.text);
      product_price = double.parse(prod_priceCtrl.text);
    });
    addProd(product_name, product_price, product_weight);
    Navigator.of(context).pop();
    toast(context,"Product added !");

  }

  void cancel(){
    Navigator.of(context).pop();
  }

  void toast(BuildContext context,String text){
    ScaffoldMessenger.of(context)
        .showSnackBar(
        SnackBar(
          content: Text(text,style: TextStyle(color: Colors.deepPurple),),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          backgroundColor: Colors.tealAccent,
        ));
  }

  @override
  void initState(){
    super.initState();

  }
  @override
  void dispose(){
    prod_nameCtrl.dispose();
    prod_weightCtrl.dispose();
    prod_priceCtrl.dispose();

    super.dispose();
  }

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('products').snapshots();

  //---------------RETRIEVE DATA -----------------------------


  TableRow buildRow(List<String> cells)=>TableRow(
      children: cells.map((cell)=>Padding(
          padding: const EdgeInsets.all(12),
          child: Text(cell))).toList()
  );

  TableRow buildRowHead(List<String> cells)=>TableRow(
      children: cells.map((cell)=>Container(
        color: Colors.deepOrangeAccent,
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(cell,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),)),
      )).toList()
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        backgroundColor: Colors.tealAccent,
        title: Text('Account',style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),),
        shape: Border.symmetric(horizontal: BorderSide.none),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return Column(
                  children: [
                    Table(
                      children: [
                        buildRowHead(["name","weight", "price"]),
                      ],
                    ),
                    Container(
                      height:150,
                      child: ListView(
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                          return Table(
                            children: [
                              buildRow([data['name'],data['weight'].toString(), data['price'].toString()]),
                            ],
                          );
                        }).toList(),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(

              children: [
                MaterialButton(onPressed: ()async{
                  final popup = await openDialog();
                },
                  color: Colors.deepPurple,
                  child: Text("Add new"),
                ),
                SizedBox(width: 70,),
                MaterialButton(onPressed: ()async{
                  final popup = await openDialog2();
                },
                  color: Colors.deepPurple,

                  child: Text("Sell"),
                ),
              ],
            ),
          )
        ],
      ),
    );


  }
}




