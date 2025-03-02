import 'package:blog_rest_api_provider/data/model/get_all_post_responose.dart';
import 'package:blog_rest_api_provider/data/model/get_one_post_response.dart';

abstract class GetAllPostState{

}
class GetAllPostLoading extends GetAllPostState{}
class GetAllPostSucccess extends GetAllPostState{
  final List<GetAllPostResponse> getAllPostList;

  GetAllPostSucccess(this.getAllPostList);
}
class GetAllPostFail extends GetAllPostState{
  final String errorMessage;

  GetAllPostFail(this.errorMessage);
}

