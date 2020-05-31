<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/15
  Time: 18:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>管理员登录</title>
    <link rel="stylesheet" href="/css/base.css" type="text/css">
    <link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/css/myTable.css" type="text/css">
    <script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/admin.js"></script>
</head>
<body onload="AllCourse()">
<table style="border-Radius: 10px;width:90%;height: 100%;"
       class="table table-striped table-bordered table-hover table-condensed czbtable-table" align="center">
    <tr style="height: 60px">
        <td colspan="2">
            <div align="center">
                <label class="col-lg-10" style="font-size: 25px"> 金桥教务管理系统(管理员端)</label>
                <label class="pull-right" id="userId">
                    欢迎使用：
                    <span class="glyphicon glyphicon-user"></span>
                    ${requestScope.user.userName}
                </label>
            </div>
        </td>
    </tr>
    <tr valign="top">
        <td width="233px">
            <ul class="nav nav-pills nav-stacked" style="max-width: 230px;">
                <li id="courseCount">
                    <a href="getAllCourses.do" target="teacher" onclick="AllCourse()">
                        <span class="badge pull-right" id="couCount">${requestScope.countCourse}</span>
                        课程管理
                    </a>
                </li>
                <li id="studentCount">
                    <a href="getAllStudent.do" target="teacher" onclick="AllStudent()">
                        <span class="badge pull-right" id="stuCount">${requestScope.countStudent}</span>
                        学生管理
                    </a>
                </li>
                <li id="teacherCount">
                    <a href="getAllTeacher.do" target="teacher" onclick="AllTeacher()">
                        <span class="badge pull-right" id="teaCount">${requestScope.countTeacher}</span>
                        教师管理
                    </a>
                </li>
                <li id="reSetPwd"><a href="goToReSet.do"
                                      target="teacher" onclick="reSetPwd()">
                    <span class="pull-right glyphicon glyphicon-repeat"></span>重置用户密码
                </a></li>
                <li id="changePwd"><a href="toChange.do?userId=${requestScope.user.userId}&password=${requestScope.user.password}"
                                      target="teacher" onclick="changeThePwd()">
                    <span class="pull-right glyphicon glyphicon-pencil"></span>修改密码
                </a></li>
                <li id="takeOut"><a onclick="outadminLogin()">
                    <span class="pull-right glyphicon glyphicon-log-out"></span>退出系统
                </a></li>
            </ul>
        </td>
        <td>
            <div style="height: 100%">
                <iframe name="teacher" frameborder="no" scrolling="auto" src="getAllCourses.do"
                        width="100%" height="600px" align="center">
                    <script>
                        location.href="getAllCourses.do"
                    </script>
                </iframe>
            </div>
        </td>
    </tr>
</table>
</body>
</html>
