class LoginModel{

  String message;
  bool status;
  UserData data;

  LoginModel.fromJSON(Map<String ,dynamic> json){
    message=json['message'];
    status=json['status'];
    data =json['data']!=null? UserData.fromJSON(json['data']):null;

  }
}

class UserData{
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  //UserData({this.email,this.image,this.id,this.name,this.phone,this.credit,this.points,this.token});

  UserData.fromJSON(Map<String ,dynamic> json){
        id=json['id'];
        name=json['name'];
        email=json['email'];
        phone=json['phone'];
        image=json['image'];
        points=json['points'];
        credit=json['credit'];
        token=json['token'];
}

}