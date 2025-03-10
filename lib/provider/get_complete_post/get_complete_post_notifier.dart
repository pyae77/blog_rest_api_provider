import 'package:blog_rest_api_provider/data/model/get_one_post_response.dart';
import 'package:blog_rest_api_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_provider/provider/get_complete_post/get_complete_post_state.dart';
import 'package:flutter/cupertino.dart';


class GetCompletePostNotifier extends ChangeNotifier{

  GetCompletePostState getCompletePostState=GetCompletePostLoading();
  final BlogApiService _blogApiService=BlogApiService();
  void getCompletePost({required int id}) async{
    getCompletePostState=GetCompletePostLoading();
    notifyListeners();
   try{
     GetOnePostResponse getOnePostResponse=await _blogApiService.getOnePost(id);
     getCompletePostState=GetCompletePostSuccess(getOnePostResponse);
     notifyListeners();
   }
   catch(_){
     getCompletePostState=GetCompletePostFail("Something Wrong");
   }
  }
}