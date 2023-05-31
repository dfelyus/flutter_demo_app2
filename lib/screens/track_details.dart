import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_app2/constants/icons.dart';

class TrackDetails extends StatefulWidget{
  const TrackDetails({
    Key?key,}):super(key:key);

  @override
  _TrackDetails createState(){
    return _TrackDetails();
  }



}

class _TrackDetails extends State<TrackDetails> {

  int _selectedTag = 0;

  final textCtrl = TextEditingController();

  void changeTab(int index) {
    setState(() {
      _selectedTag = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Stack(
                    children: [
                      Align(
                        child: Text("Tracking position",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Positioned(
                        child: CustomIconButton(
                          color: Colors.orange,
                          child: const Icon(
                            Icons.arrow_back,
                          ),
                          height: 40,
                          width:40,
                          onTap: ()=>Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text("Tracking",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "Created by Elyus77",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 3,),
                Row(
                  children: [
                    Image.asset(
                      icFeaturedOutlined,
                      height: 15,
                    ),
                    const Text(
                      "(3) Position              ",
                      style:TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.monetization_on_sharp,
                      color: Colors.grey,
                    ),
                    Column(
                      children: const [
                        Text(
                          "1500-4000 fcfa",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          "Available on 72H",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                CustomTabView(
                  changeTab: changeTab,
                  index: _selectedTag,
                ),

                _selectedTag == 0 ? const SimilarVideos(): const Description(),
                Row(
                  children: [
                    Container(
                      child: TextField(
                        controller: textCtrl,
                        obscureText: false,
                        decoration: InputDecoration(
                            fillColor: Colors.black12,
                            filled: true,
                            hintText: "Tape Your message",
                            hintStyle: TextStyle(color: Colors.deepPurple)),
                      ),
                      width: 190,
                    ),
                    SizedBox(width: 2,),
                    MaterialButton(
                      onPressed: (){},
                      color: Colors.deepPurple,
                      child: Text("Send",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SimilarVideos extends StatelessWidget{
  const SimilarVideos({Key?key}):super(key:key);

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Image.asset("assets/icons/google-maps.jpg",
            height: 300,
          ),
        ],
      ),
    );
  }
}

class Description extends StatelessWidget{

  const Description({Key ? key}):super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
        height: 250,
      child: Text("Tracking indications: Just arrived this City Show all steps from where going. Till the destination over"),
    );
  }
}


class CustomTabView extends StatefulWidget {
  final Function(int) changeTab;
  final int index;
  const CustomTabView({Key? key, required this.changeTab, required this.index})
      : super(key: key);

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  final List<String> _tags = ["Position", "Description"];

  Widget _buildTags(int index) {
    return GestureDetector(
      onTap: () {
        widget.changeTab(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .06, vertical: 6),
        decoration: BoxDecoration(
          color: widget.index == index ? Colors.deepPurple : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          _tags[index],
          style: TextStyle(
            color: widget.index != index ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: _tags
            .asMap()
            .entries
            .map((MapEntry map) => _buildTags(map.key))
            .toList(),
      ),
    );
  }
}


class CustomIconButton extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final Color? color;
  final VoidCallback onTap;

  const CustomIconButton({
    Key? key,
    required this.child,
    required this.height,
    required this.width,
    this.color = Colors.white,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        child: Center(child: child),
        onTap: onTap,
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 2.0,
            spreadRadius: .05,
          ), //BoxShadow
        ],
      ),
    );
  }
}
