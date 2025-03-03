import 'package:blog_rest_api_provider/data/model/get_all_post_responose.dart';
import 'package:blog_rest_api_provider/provider/get_all_posts/gell_all_post_state.dart';
import 'package:blog_rest_api_provider/provider/get_all_posts/get_all_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void didChangeDependencies(){
    super.didChangeDependencies();
    _getAllPost(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Api Lesson'),
        centerTitle: true,
      ),
      body: Consumer<GetAllPostNotifier>(
        builder:(_,getAllProvider,_){
          GetAllPostState getAllPostState=getAllProvider.getAllPostState;
          if(getAllPostState is GetAllPostSucccess){
            List<GetAllPostResponse> getAllPostResponseList=getAllPostState.getAllPostList;
            return ListView.builder(
              itemCount: getAllPostResponseList.length,
                itemBuilder: (context,position){
                GetAllPostResponse getAllPostResponse=getAllPostResponseList[position];
                     return Card(
                       child: ListTile(
                         title: Text('${getAllPostResponse.title}'),
                       ),
                     );
                });
          }
          else if(getAllPostState is GetAllPostFail){
           return Column(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
               Text('Oops Something Wrong!'),
               Divider(),
               ElevatedButton(onPressed:(){
                _getAllPost(context);
               }, child: Text("Try Again"))
           
           ]);
          }
          return const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
  void _getAllPost(BuildContext ctx){
    Provider.of<GetAllPostNotifier>(ctx,listen: false).getAllPost();
  }

}
