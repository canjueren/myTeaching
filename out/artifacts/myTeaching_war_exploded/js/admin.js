/**
 * Created by Administrator on 2018/10/23.
 */
function AllCourse(){
    $("#courseCount").attr("class","active");
    $("#studentCount").attr("class","");
    $("#teacherCount").attr("class","");
    $("#reSetPwd").attr("class","");
    $("#changePwd").attr("class","");
    $("#takeOut").attr("class","");
}
function AllStudent(){
    $("#courseCount").attr("class","");
    $("#studentCount").attr("class","active");
    $("#teacherCount").attr("class","");
    $("#reSetPwd").attr("class","");
    $("#changePwd").attr("class","");
    $("#takeOut").attr("class","");
}
function AllTeacher(){
    $("#courseCount").attr("class","");
    $("#studentCount").attr("class","");
    $("#teacherCount").attr("class","active");
    $("#reSetPwd").attr("class","");
    $("#changePwd").attr("class","");
    $("#takeOut").attr("class","");
}
function reSetPwd(){
    $("#courseCount").attr("class","");
    $("#studentCount").attr("class","");
    $("#teacherCount").attr("class","");
    $("#reSetPwd").attr("class","active");
    $("#changePwd").attr("class","");
    $("#takeOut").attr("class","");
}
function changeThePwd(){
    $("#courseCount").attr("class","");
    $("#studentCount").attr("class","");
    $("#teacherCount").attr("class","");
    $("#reSetPwd").attr("class","");
    $("#changePwd").attr("class","active");
    $("#takeOut").attr("class","");
}
function outadminLogin(){
    $("#courseCount").attr("class","");
    $("#studentCount").attr("class","");
    $("#teacherCount").attr("class","");
    $("#reSetPwd").attr("class","");
    $("#changePwd").attr("class","");
    $("#takeOut").attr("class","active");
    if(confirm("确认退出？")){
        location.href="outLogin.do";
    }
}
