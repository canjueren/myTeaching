<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/10
  Time: 17:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/css/base.css" type="text/css">
    <link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/css/myTable.css" type="text/css">
    <script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
</head>
<body>
<table class="table table-striped table-bordered table-hover cztable-table">
    <tr>
        <td colspan="9" align="center" bgcolor="#eef7fc">
            <label style="font-size: 30px">我教授的课程</label>
        </td>
    </tr>
    <tr align="center" style="color:#185697;">
        <td>课程号</td><td>课程名称</td><td>授课老师编号</td><td>上课时间</td><td>上课地点</td>
        <td>周数</td><td>课程类型</td><td>学分</td><td>操作</td>
    </tr>
    <c:if test="${not empty requestScope.courseList}">
        <c:forEach var="courseList" items="${requestScope.courseList}">
            <tr align="center" style="vertical-align: middle">
                <td>${courseList.id}</td>
                <td>${courseList.courseName}</td>
                <td>${courseList.teacher.name}</td>
                <td>${courseList.courseTime}</td>
                <td>${courseList.classRoom}</td>
                <td>${courseList.classWeek}</td>
                <td>${courseList.courseType}</td>
                <td>${courseList.score}</td>
                <td>
                    <a href="stuOfCour.do?courseId=${courseList.id}" target="teacher">
                        <button type="button" class="btn btn-primary btn-sm">
                            成绩
                        </button>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </c:if>
    <c:if test="${empty requestScope.courseList}">
        <tr><td colspan="9">没有相关数据</td></tr>
    </c:if>
</table>
<c:if test="${not empty requestScope.courseList}">
    <div align="center" class="pager">
        <ul>
            <li><a href="getTeacherCourses.do?currentPage=1">首页</a></li>
            <li><a href="getTeacherCourses.do?currentPage=${requestScope.pageIndex-1}">上一页</a></li>
            <li> 第${requestScope.pageIndex}页 / 共${requestScope.totalPage}页 </li>
            <li><a href="getTeacherCourses.do?currentPage=${requestScope.pageIndex+1}">下一页</a></li>
            <li><a href="getTeacherCourses.do?currentPage=${requestScope.totalPage}">末页</a></li>
        </ul>
    </div>
</c:if>
</body>
</html>
