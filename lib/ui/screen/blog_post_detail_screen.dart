import 'package:blog_rest_api_provider/data/model/get_one_post_response.dart';
import 'package:blog_rest_api_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_provider/provider/get_complete_post/get_complete_post_notifier.dart';
import 'package:blog_rest_api_provider/provider/get_complete_post/get_complete_post_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogPostDetailScreen extends StatefulWidget {
  const BlogPostDetailScreen({super.key, required this.id});
  final int id;

  @override
  State<BlogPostDetailScreen> createState() => _BlogPostDetailScreenState();
}

class _BlogPostDetailScreenState extends State<BlogPostDetailScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getBlogDetail(widget.id);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<GetCompletePostNotifier>(
        builder: (_, getCompletePostNotifier, __) {
          final getCompletePostState = getCompletePostNotifier.getCompletePostState;

          if (getCompletePostState is GetCompletePostLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (getCompletePostState is GetCompletePostSuccess) {
            final getOnePostResponse = getCompletePostState.getOnePostResponse;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(getOnePostResponse.body ?? 'No body'),
                    Divider(),
                    if (getOnePostResponse.photo != null)
                      Image.network('${BlogApiService.baseUrl}/${getOnePostResponse.photo}'),
                  ],
                ),
              ),
            );
          } else if (getCompletePostState is GetCompletePostFail) {
            return Column(
              children: [
                Text(getCompletePostState.errorMessage),
                Divider(),
                ElevatedButton(
                  onPressed: () {
                    _getBlogDetail(widget.id); // Retry fetching data
                  },
                  child: Text("Try again"),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _getBlogDetail(int id){
    Provider.of<GetCompletePostNotifier>(context,listen:false).getCompletePost(id:widget.id);

  }

}
