/**
 * Created by Administrator on 2018/10/23.
 */
function getAllCou(){
    $("#allCourses").attr("class","active");
    $("#myChoose").attr("class","");
    $("#myGet").attr("class","");
    $("#changePwd").attr("class","");
    $("#takeOut").attr("class","");
}
function getSelectCou(){
    $("#allCourses").attr("class","");
    $("#myChoose").attr("class","active");
    $("#myGet").attr("class","");
    $("#changePwd").attr("class","");
    $("#takeOut").attr("class","");
}
function getGetCou(){
    $("#allCourses").attr("class","");
    $("#myChoose").attr("class","");
    $("#myGet").attr("class","active");
    $("#changePwd").attr("class","");
    $("#takeOut").attr("class","");
}
function changestuPwd(){
    $("#allCourses").attr("class","");
    $("#myChoose").attr("class","");
    $("#myGet").attr("class","");
    $("#changePwd").attr("class","active");
    $("#takeOut").attr("class","");
}
function outstuLogin(){
    $("#allCourses").attr("class","");
    $("#myChoose").attr("class","");
    $("#myGet").attr("class","");
    $("#changePwd").attr("class","");
    $("#takeOut").attr("class","active");
    if(confirm("确认退出？")){
        location.href="outLogin.do";
    }
}