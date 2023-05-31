import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class Help extends StatefulWidget{
  const Help({
    Key?key,}):super(key:key);

  @override
  _Help createState(){
    return _Help();
  }



}

class _Help extends State<Help> {

  int _selectedTag = 0;
  final textCtrl = TextEditingController();

  void changeTab(int index) {
    setState(() {
      _selectedTag = index;
    });
  }

  late VideoPlayerController _controller;
  int currentIndex = 0;

  void _playVideo({int index = 0, bool init = false}){
    //_controller = VideoPlayerController.network(tabVideo[_currentIndex].url);
    _controller = VideoPlayerController.asset("assets/flutter.mp4")
      ..addListener(()=>setState(()=>{}))//for update the new videos
      ..setLooping(true)
      ..initialize().then((value)=>_controller.play());
  }

  String _videoDuration(Duration duration){
    String twoDigits(int n)=>n.toString().padLeft(2,'0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if(duration.inHours > 0 ) hours,
      minutes,
      seconds,
    ].join(':');
  }


  @override
  void initState(){
    super.initState();
    _playVideo(init: true);
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
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
                      /*
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
                      */
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                //CustomVideoPlayer(vidUrl: "${widget.videoLink.toString()}",),
                Container(
                  color: Colors.black12,
                  child: _controller.value.isInitialized ?
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height:150,
                        child: VideoPlayer(_controller),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ValueListenableBuilder(
                              valueListenable: _controller,
                              builder:
                                  (context,VideoPlayerValue value,child){
                                return Text(
                                  _videoDuration(value.position),
                                  style: const TextStyle(

                                      color: Colors.black,
                                      fontSize: 10
                                  ),
                                );
                              },
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 10,
                                child: VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 0,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 5,),
                            Text(
                              _videoDuration(_controller.value.duration),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ),
                            ),
                            IconButton(
                              onPressed: ()=>_controller.value.isPlaying
                                  ? _controller.pause() :_controller.play(),
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.deepPurple,
                                size: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context)=>LandscapePlayerPage(controller:_controller),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.fullscreen_sharp,
                                color: Colors.deepPurple,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ):const Center(
                    child: CircularProgressIndicator(color: Colors.deepPurple,),
                  ),
                ),
                const SizedBox(height: 10,),
                Text("Truck / Farmer logistic",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
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
                const SizedBox(height: 5,),
                CustomTabView(
                  changeTab: changeTab,
                  index: _selectedTag,
                ),
                _selectedTag == 0 ? const SimilarVideos(): const Description(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LandscapePlayerPage extends StatefulWidget{
  final VideoPlayerController controller;
  const LandscapePlayerPage({Key?key,required this.controller}):super(key:key);

  @override
  State<LandscapePlayerPage> createState()=>_LandscapePlayerPage();



}

class _LandscapePlayerPage extends State<LandscapePlayerPage>{

  Future _landscapeMode() async{
    await SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]
    );
  }

  Future _setAllOrientation() async{
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void initState(){
    super.initState();
    _landscapeMode();
  }

  @override
  void dispose(){
    _setAllOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)=>VideoPlayer(widget.controller);
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
            height: 155,
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
    return const Padding(padding: EdgeInsets.only(top: 10.0),
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
