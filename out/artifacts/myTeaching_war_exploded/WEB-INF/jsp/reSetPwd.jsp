<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/19
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>重置用户密码</title>
    <link rel="stylesheet" href="/css/base.css" type="text/css">
    <link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
    <script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script>
        function getUserId(){
            var uId = $("#userId").val();
            if(uId==null||uId==''){
                $("#nuId").attr("style","color:red;display:block");
                return false;
            }else {
                $("#nuId").attr("style","display:none");
                return true;
            }
        }
        function getUserName(){
            var uName = $("#userName").val();
            if(uName==null||uName==''){
                $("#nuName").attr("style","color:red;display:block");
                return false;
            }else {
                $("#nuName").attr("style","display:none");
                return true;
            }
        }
        function reSetThePwd(){
            if(getUserName()&&getUserId()){
                if(confirm("确认重置此用户密码？")){
                    var uId = $("#userId").val();
                    var uName = $("#userName").val();
                    var identify = $("#identity").val();
                    var role;
                    if(identify=='教师'){
                        role='1';
                    }else {
                        role='2';
                    }
                    //使用ajax发送请求
                    $.ajax({
                        url:'reSetThePwd.do',//请求的url
                        type:'post',//提交方式
                        asyns:true,//是否异步
                        data:{
                            userId:uId,
                            userName:uName,
                            role:role
                        },
                        dataType:'text',//返回的格式：json/xml/html/text
                        //回调函数
                        //请求成功后调用
                        success:function(data){
                            if(data=='1'||data==1){
                                alert("重置成功！");
                                window.location.reload();
                            }else {
                                alert("没有符合条件的用户！");
                                return false;
                            }
                        },
                        //请求失败后调用
                        error:function(xhr,textStatus){
                            console.log('错误')
                        }
                    });
                }
            }else {
                alert("填写不符合要求!")
            }
        }
    </script>
</head>
<body style="background: #a9a1a1">
<div class="modal-dialog" style="width: 550px">
    <div class="modal-content">
        <div class="modal-header" align="center">
            <h2 class="modal-title" id="theTitle">重置用户密码</h2>
        </div>
        <form>
            <div class="modal-body" align="center" style="background: #EEF7FC">
                <ul>
                    <li class="list-group-item" style="border: 0px;background: #EEF7FC">
                        <div class="row">
                            <div class="form-group">
                                <div><label class="col-sm-4" style="font-size:17px">用户身份</label></div>
                                <div class="col-sm-5">
                                    <select id="identity" style="width: 100%;height: 100%">
                                        <option>学生</option>
                                        <option>教师</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <label class="col-sm-4" style="font-size:17px">学号(教职工号)</label>
                                <div class="col-sm-5">
                                    <input type="text" id="userId" class="form-control"
                                           onblur="getUserId()">
                                </div>
                                <div class="col-sm-3">
                                    <label id="nuId" style="display:none;">编号不能为空</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <div><label class="col-sm-4" style="font-size:17px">用户姓名</label></div>
                                <div class="col-sm-5">
                                    <input type="text" id="userName" class="form-control"
                                           onblur="getUserName()">
                                </div>
                                <div class="col-sm-3">
                                    <label id="nuName" style="display:none;">姓名不能为空</label>
                                </div>
                            </div>
                        </div>
                        <div class="row" align="center">
                            <div class="form-group">
                                <button type="reset" class="btn btn-default" data-dismiss="modal">重填</button>
                                <button type="button" id="submit" class="btn btn-primary" onclick="reSetThePwd()">确认</button>
                                <%--<button type="button" class="btn btn-default" data-dismiss="modal" onclick="goBack()">取消</button>--%>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </form>
    </div>
</div>
</body>
</html>
