<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/14
  Time: 12:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>已修课程</title>
    <link rel="stylesheet" href="/css/base.css" type="text/css">
    <link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/css/myTable.css" type="text/css">
    <script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script>
        function getCounts(){
            $("#allCount", window.parent.document).text("${requestScope.countAll}");
            $("#selCount", window.parent.document).text("${requestScope.countSel}");
            $("#getCount", window.parent.document).text("${requestScope.countGet}");
        }
    </script>
</head>
<body onload="getCounts()">
<table class="table table-striped table-bordered table-hover table-condensed cztable-table">
    <tr>
        <td colspan="9" style="border: 0px" bgcolor="#eef7fc">
            <label style="font-size: 30px">已修课程</label>
        </td>
    </tr>
    <tr align="center" style="color:#185697;">
        <td>课程号</td><td>课程名称</td><td>授课老师</td><td>上课时间</td><td>上课地点</td>
        <td>周数</td><td>课程类型</td><td>学分</td><td>分数</td>
    </tr>
    <c:if test="${not empty requestScope.courseList}">
        <c:forEach var="courseList" items="${requestScope.courseList}">
            <tr align="center" style="vertical-align: middle">
                <td>${courseList.course.id}</td>
                <td>${courseList.course.courseName}</td>
                <td>${courseList.course.teacher.name}</td>
                <td>${courseList.course.courseTime}</td>
                <td>${courseList.course.classRoom}</td>
                <td>${courseList.course.classWeek}</td>
                <td>${courseList.course.courseType}</td>
                <td>${courseList.course.score}</td>
                <td style="color: red">${courseList.mark}</td>
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
            <li><a href="SelectMyGet.do?currentPage=1&studentId=${requestScope.courseList[0].studentId}">首页</a></li>
            <li><a href="SelectMyGet.do?currentPage=${requestScope.pageIndex-1}&studentId=${requestScope.courseList[0].studentId}">上一页</a></li>
            <li> 第${requestScope.pageIndex}页 / 共${requestScope.totalPage}页 </li>
            <li><a href="SelectMyGet.do?currentPage=${requestScope.pageIndex+1}&studentId=${requestScope.courseList[0].studentId}">下一页</a></li>
            <li><a href="SelectMyGet.do?currentPage=${requestScope.totalPage}&studentId=${requestScope.courseList[0].studentId}">末页</a></li>
        </ul>
    </div>
</c:if>
</body>
</html>
