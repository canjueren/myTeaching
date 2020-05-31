/**
 * Created by Administrator on 2018/10/23.
 */
function getTeachCou(){
    $("#teachCou").attr("class","active");
    $("#changePwd").attr("class","");
    $("#takeOut").attr("class","");
}
function changePwd(){
    $("#teachCou").attr("class","");
    $("#changePwd").attr("class","active");
    $("#takeOut").attr("class","");
}
function outteaLogin(){
    $("#teachCou").attr("class","");
    $("#changePwd").attr("class","");
    $("#takeOut").attr("class","active");
    if(confirm("确认退出？")){
        location.href="outLogin.do";
    }
}