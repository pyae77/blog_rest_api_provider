

 import "package:blog_rest_api_provider/data/model/get_all_post_responose.dart";
import "package:blog_rest_api_provider/data/model/get_one_post_response.dart";
import "package:dio/dio.dart";
    class BlogApiService{
     // static const String baseUrl='http://localhost:5000/';
      static const String baseUrl = 'http://10.0.2.2:5000/';



      late Dio dio;
      BlogApiService(){
        dio=Dio();
      }
      Future<List<GetAllPostResponse>> getAllPosts()async{
       final postListResponse=await dio.get("${baseUrl}posts");
      final postList=(postListResponse.data as List).map((e){
         return GetAllPostResponse.fromJson(e);
      }).toList();
       return postList;
      }
      Future<GetOnePostResponse> getOnePost(int id) async {
        final response = await dio.get('${baseUrl}post?id=$id');

        // Ensure that the response is a Map and not a List
        final postData = response.data as Map<String, dynamic>;

        return GetOnePostResponse.fromJson(postData);
      }




    }