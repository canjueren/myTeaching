<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/12
  Time: 11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改密码</title>
    <link rel="stylesheet" href="/css/base.css" type="text/css">
    <link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
    <script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script>
        function getOldPwd(){
            var password = $("#password").val();
            if(!password.match(/^[0-9a-zA-Z]{6,15}$/)){
                $("#npassword").attr("style","color:red");
                return false;
            }else {
                if($("#password").val()!=${requestScope.password}){
                    alert("密码错误！")
                }else {
                    $("#npassword").removeAttr("style");
                    return true;
                }
            }
        }
        function getNewPwd(){
            var password = $("#Pwd").val();
            if(!password.match(/^[a-zA-Z0-9]{6,15}$/)){
                $("#nPwd").attr("style","color:red");
                return false;
            }else {
                $("#nPwd").removeAttr("style");
                return true;
            }
        }
        function getrNewPwd(){
            var password = $("#Pwd").val();
            var password1 = $("#rPwd").val();
            if(!(password1.match(/^[a-zA-Z0-9]{6,15}$/)&&password==password1)){
                $("#nrPwd").attr("style","color:red;display:block");
                return false;
            }else {
                $("#nrPwd").attr("style","display:none");
                return true;
            }
        }
        function changeTo(){
            if(getOldPwd()&&getNewPwd()&&getrNewPwd()){
                var newPwd= $("#Pwd").val();
                location.href="changeTo.do?userId=${requestScope.userId}&password="+newPwd;
            }else {
                alert("请按要求填写！")
            }
        }
    </script>
</head>
<body style="background: #a9a1a1">
<c:if test="${requestScope.change=='修改成功！'}">
    <script>
        alert("修改成功,请重新登录！");
        window.parent.location="outLogin.do";
    </script>
</c:if>
<c:if test="${requestScope.change=='修改失败！'}">
    <script>
        alert("修改失败！")
    </script>
</c:if>
<div class="modal-dialog" style="width: 550px;">
    <div class="modal-content">
        <div class="modal-header" align="center" >
            <h2 class="modal-title" id="theTitle">修改密码</h2>
        </div>
        <form>
            <div class="modal-body" align="center" style="background: #EEF7FC">
                <ul>
                    <li class="list-group-item" style="border: 0px;background: #EEF7FC">
                        <div class="row">
                            <div class="form-group">
                                <div><label class="col-sm-3" style="font-size:17px">现用密码</label></div>
                                <div class="col-sm-5">
                                    <input type="text" id="password" name="password" class="form-control"
                                           onblur="getOldPwd()">
                                </div>
                                <div class="col-sm-4">
                                    <label id="npassword">请输入6-15位密码</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <label class="col-sm-3" style="font-size:17px">新密码</label>
                                <div class="col-sm-5">
                                    <input type="text" id="Pwd" name="Pwd" class="form-control"
                                           onblur="getNewPwd()">
                                </div>
                                <div class="col-sm-4">
                                    <label id="nPwd">请输入6-15位密码</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <div><label class="col-sm-3" style="font-size:17px">重复新密码</label></div>
                                <div class="col-sm-5">
                                    <input type="text" id="rPwd" name="rPwd" class="form-control"
                                           onblur="getrNewPwd()">
                                </div>
                                <div class="col-sm-4">
                                    <label id="nrPwd" style="display:none;">两次输入不一致</label>
                                </div>
                            </div>
                        </div>
                        <div class="row" align="center">
                            <div class="form-group">
                                <button type="reset" class="btn btn-default" data-dismiss="modal">重置</button>
                                <button type="button" id="submit" class="btn btn-primary" onclick="changeTo()">确认</button>
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
