

import 'package:blog_rest_api_provider/data/model/get_all_post_responose.dart';
import 'package:blog_rest_api_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_provider/provider/gell_all_post_state.dart';
import 'package:flutter/cupertino.dart';

class GetAllProvider extends ChangeNotifier{
  GetAllPostState getAllPostState=GetAllPostLoading();
  BlogApiService _apiService=BlogApiService();
    Future<void> getAllPost()async{
      getAllPostState=GetAllPostLoading();
      notifyListeners();
      try{

        List<GetAllPostResponse> getAllPostList=await _apiService.getAllPosts();
        getAllPostState=GetAllPostSucccess(getAllPostList);
        notifyListeners();
      }
      catch(e){
        getAllPostState=GetAllPostFail(e.toString());
      }
    }
}

