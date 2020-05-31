/**
 * Created by Administrator on 2018/10/10.
 */
$(function(){
    if (window.history && window.history.pushState) {
        $(window).on('popstate', function () {
            window.history.pushState('forward', null, '#');
            window.history.forward(1);
        });
    }
    window.history.pushState('forward', null, '#'); //在IE、火狐中必须得有这两行
    window.history.forward(1);
})
function getuName() {
    var id = $("#userId").val();
    if (id == null || id == "") {
        $("#nuId").attr("style", "color: red;display:block");
        $("#nuId1").attr("style", "display:none");
        return false;
    } else {
        //使用ajax发送请求
        $.ajax({
            url:'checkTheUser.do',//请求的url
            type:'post',//提交方式
            asyns:true,//是否异步
            data:{
                userId:id
            },
            dataType:'json',//返回的格式：json/xml/html/text
            //回调函数
            //请求成功后调用
            success:function(data){
                if(data[0]==null){
                    $("#nuId1").attr("style", "color: red;display:block");
                    $("#nuId").attr("style", "display:none");
                    return false;
                }else {
                    $("#nuId").attr("style", "display:none");
                    $("#nuId1").attr("style", "display:none");
                    return true;
                }
            },
            //请求失败后调用
            error:function(xhr,textStatus){
                console.log('错误');
            }
        });
    }
}
function getuPwd(){
    var uPwd = $("#password").val();
    if (uPwd == null || uPwd== "") {
        $("#nPassword").attr("style", "color: red;display:block");
        return false;
    } else {
        $("#nPassword").attr("style", "display:none");
        return true;
    }
}
function to_login(){
    var uid = $("#userId").val();
    var upwd = $("#password").val();
    var rem =null;
    if($("#remember").is(':checked')) {
        rem = "记住";
    }
    var a =0;
    var b=0;
    if (uid == null || uid == "") {
        $("#nuId").attr("style", "color: red;display:block");
        a=0;
        return false;
    } else {
        $("#nuId").attr("style", "display:none");
        a=1;
    }
    if (upwd == null || upwd== "") {
        $("#nPassword").attr("style", "color: red;display:block");
        b=0;
        return false;
    } else {
        $("#nPassword").attr("style", "display:none");
        b=1;
    }
    if(a==1&&b==1){
        //使用ajax发送请求
        $.ajax({
            url:'checkTheUser.do',//请求的url
            type:'post',//提交方式
            asyns:true,//是否异步
            data:{
                userId:uid
            },
            dataType:'json',//返回的格式：json/xml/html/text
            //回调函数
            //请求成功后调用
            success:function(data){
                if(data[0]==null){
                    alert("该账户不存在！");
                    return false;
                }else {
                    return true;
                    //location.href="login.do?userId="+uid+"&password="+upwd
                    //    +"&remember="+rem;
                }
            },
            //请求失败后调用
            error:function(xhr,textStatus){
                console.log('错误')
            }
        });
    }
}
