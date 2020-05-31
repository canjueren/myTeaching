<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/14
  Time: 9:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>学生登录</title>
    <link rel="stylesheet" href="/css/base.css" type="text/css">
    <link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/css/myTable.css" type="text/css">
    <script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/student.js"></script>
</head>
<body onload="getAllCou()">
<table style="border-Radius: 1px;width:90%;height: 100%;"
       class="table table-striped table-bordered table-hover table-condensed czbtable-table" align="center">
    <tr style="height: 60px">
        <td colspan="2">
            <div align="center">
                <label class="col-lg-10" style="font-size: 25px">金桥教务管理系统(学生端)</label>
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
                <li id="allCourses">
                    <a href="getAllCourse.do" target="teacher" onclick="getAllCou()">
                        <span class="badge pull-right" id="allCount">${requestScope.countAll}</span>
                        所有课程
                    </a>
                </li>
                <li id="myChoose">
                    <a href="SelectMySel.do?studentId=${requestScope.user.userId}" target="teacher" onclick="getSelectCou()">
                        <span class="badge pull-right" id="selCount">${requestScope.countSel}</span>
                        已选课程
                    </a>
                </li>
                <li id="myGet">
                    <a href="SelectMyGet.do?studentId=${requestScope.user.userId}" target="teacher" onclick="getGetCou()">
                        <span class="badge pull-right" id="getCount">${requestScope.countGet}</span>
                        已修课程
                    </a>
                </li>
                <li id="changePwd"><a href="toChange.do?userId=${requestScope.user.userId}&password=${requestScope.user.password}"
                                      target="teacher" onclick="changestuPwd()">
                    <span class="pull-right glyphicon glyphicon-pencil"></span>修改密码
                </a></li>
                <li id="takeOut"><a onclick="outstuLogin()">
                    <span class="pull-right glyphicon glyphicon-log-out"></span>退出系统
                </a></li>
            </ul>
        </td>
        <td>
            <div style="height: 100%">
                <iframe name="teacher" frameborder="no" scrolling="auto" src="getAllCourse.do"
                        width="100%" height="100%"></iframe>
            </div>
        </td>
    </tr>
</table>
</body>
</html>
