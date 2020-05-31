<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/9
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>登录</title>
    <link rel="stylesheet" href="/css/base.css" type="text/css">
    <link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
    <script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/loginOn.js"></script>
    <style>
        body{
            background: url("/img/t1.jpg");
            background-size: 1360px;
            background-position:center;
            background-repeat:no-repeat;
        }
    </style>
</head>
<body>
<c:if test="${not empty requestScope.fail}">
    <script>
        alert("用户名或密码错误");
    </script>
</c:if>
<div align="center">
    <label style="font-size: 45px;color: #ec611F">金桥教务管理系统</label>
</div>
    <div class="modal-dialog" style="width: 550px;">
        <div class="modal-content" style="background: grey">
            <div class="modal-header">
                <h3 class="modal-title" align="center" style="color: white">
                    用户登录
                </h3>
            </div>
            <form action="login.do" method="post">
                <div class="modal-body" style="background: grey">
                    <ul>
                        <li class="list-group-item" style="background: grey;border: 0px">
                            <div class="row">
                                <div class="form-group">
                                    <div><label class="col-sm-2" style="color: white;font-size:17px">用户id</label></div>
                                    <div class="col-sm-5">
                                        <input type="text" id="userId" name="userId" class="form-control"
                                             placeholder="请输入用户id" value="${cookie.userId.value}" onblur="getuName()">
                                    </div>
                                    <div id="nuId" class="col-sm-3" style="background: white;display:none;">
                                        <label style="border: 0px;color: red;font-size:17px">id不能为空</label>
                                    </div>
                                    <div id="nuId1" class="col-sm-3" style="background: white;display:none;">
                                        <label style="border: 0px;color: red;font-size:17px">用户不存在</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-2" style="color: white;font-size:17px">密码</label>
                                    <div class="col-sm-5">
                                        <input type="password" id="password" name="password" class="form-control"
                                              placeholder="请输入密码" value="${cookie.pwd.value}" onblur="getuPwd()">
                                    </div>
                                    <div id="nPassword" class="col-sm-3;" style="background: white;display:none;">
                                        <label style="border: 0px;color: red;font-size:17px">密码不能为空</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-6"></label>
                                    <input type="checkbox" id="remember" name="remember" checked="checked"> 记住密码
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <div align="center">
                                        <button type="submit" id="submit" class="btn btn-warning" onclick="return to_login()"
                                                style="width: 150px;font-size: 18px;font-weight: lighter">登 录</button>
                                    </div>
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
