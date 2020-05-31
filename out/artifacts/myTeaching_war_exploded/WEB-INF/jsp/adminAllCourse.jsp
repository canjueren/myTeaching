<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/16
  Time: 9:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>课程管理</title>
    <link rel="stylesheet" href="/css/base.css" type="text/css">
    <link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/css/myTable.css" type="text/css">
    <script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/adminCourse.js"></script>
    <script>
        function getCountCourse(){
            $("#couCount", window.parent.document).text("${requestScope.countCourse}");
        }
    </script>
</head>
<body onload="getCountCourse()">
<table class="table table-striped table-bordered table-hover table-condensed cztable-table">
    <tr>
        <td colspan="4" style="border: 0px" bgcolor="#eef7fc">
            <label style="font-size: 30px">课程名单管理</label>
        </td>
        <td colspan="2" style="vertical-align: middle;border: 0px" bgcolor="#eef7fc">
            <div style="height: 33px;">
                <div class="form-group" style="vertical-align: middle">
                    <a class="input-group">
                        <input type='text' id="searchCourse" class="form-control" placeholder="请输入课程名"
                               style="width: 230px; height: 35px;" value="${requestScope.name}">
                        <span class="input-group-addon btn" onclick="searchByName()"
                              style="width: 30px; height: 35px;">
                            <span class="glyphicon glyphicon-search"></span>
                        </span>
                    </a>
                </div>
            </div>
        </td>
        <td colspan="2" align="right" style="vertical-align: middle;border: 0px" bgcolor="#eef7fc">
            <button type="button" class="btn btn-success btn-sm" style="height: 30px" onclick="addTheCourse()">
                <span class="glyphicon glyphicon-plus">  新增</span>
            </button>
        </td>
        <td colspan="2" align="center" style="vertical-align: middle;border: 0px" bgcolor="#eef7fc">
        <button type="button" class="btn btn-danger btn-sm" style="height: 30px" onclick="delTheCourse()">
            <span class="glyphicon glyphicon-trash">  删除</span>
        </button>
        </td>
    </tr>
    <tr align="center" style="color:#185697;">
        <td><input type="checkbox" id="checkAll" onclick="selectAll()"></td>
        <td>课程号</td><td>课程名称</td><td>授课老师</td><td>上课时间</td><td>上课地点</td>
        <td>周数</td><td>课程类型</td><td>学分</td><td>操作</td>
    </tr>
    <c:if test="${not empty requestScope.courseList}">
        <c:forEach var="courseList" items="${requestScope.courseList}">
            <tr align="center" style="vertical-align: middle">
                <td><input type="checkbox" name="courseList" value="${courseList.id}" onclick="ch_select()" ></td>
                <td>${courseList.id}</td>
                <td>${courseList.courseName}</td>
                <td>${courseList.teacher.name}</td>
                <td>${courseList.courseTime}</td>
                <td>${courseList.classRoom}</td>
                <td>${courseList.classWeek}</td>
                <td>${courseList.courseType}</td>
                <td>${courseList.score}</td>
                <td>
                    <a onclick="changeTheCourse(${courseList.id})">
                        <button type="button" class="btn btn-primary btn-sm" style="width: 100%">
                            修 改
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
            <li><a href="getAllCourses.do?currentPage=1&name=${requestScope.name}">首页</a></li>
            <li><a href="getAllCourses.do?currentPage=${requestScope.pageIndex-1}&name=${requestScope.name}">上一页</a></li>
            <li> 第${requestScope.pageIndex}页 / 共${requestScope.totalPage}页 </li>
            <li><a href="getAllCourses.do?currentPage=${requestScope.pageIndex+1}&name=${requestScope.name}">下一页</a></li>
            <li><a href="getAllCourses.do?currentPage=${requestScope.totalPage}&name=${requestScope.name}">末页</a></li>
        </ul>
    </div>
</c:if>
<div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
     >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <label class="modal-title" style="font-size: 25px" id="theTitle"></label>
                <label style="font-size: 15px" class="pull-right">
                    所有标记<span style="color: red;font-size: 20px;vertical-align: middle">*</span>均为必填
                </label>
            </div>
            <form action="" id="theCourseInf" method="post">
                <div class="modal-body" style="background: #EEF7FC">
                    <ul>
                        <li class="list-group-item clearfix" style="border: 0px;background: #EEF7FC">
                            <input type="text" id="courseId" name="id" hidden>
                            <div class="row" >
                                <div class="form-group">
                                    <label class="col-sm-3">
                                        <span style="color: red;font-size: 20px;vertical-align: middle">*</span>课程名称</label>
                                    <div class="col-sm-5">
                                        <input type="text" id="courseName" name="courseName" class="form-control" onblur="verCourseName()">
                                    </div>
                                    <span style="display: none" id="nCourseName">课程名称不能为空!</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-3">
                                        <span style="color: red;font-size: 20px;vertical-align: middle">*</span>授课老师</label>
                                    <div class="col-sm-5">
                                        <select id="teacherId" name="teacherId" onblur="verCouTeaId()" style="width: 100%;height: 100%">
                                        </select>
                                    </div>
                                    <span class="red" style="display: none" id="nTeacherId">授课老师不能为空</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-3">
                                        <span style="color: red;font-size: 20px;vertical-align: middle">*</span>上课时间</label>
                                    <div class="col-sm-5">
                                        <select name="courseTime" id="courseTime1" onblur="verCourseTime()" style="width: 100%;height: 100%">
                                            <option id="courseTime"  style="display: none"></option>
                                            <option>周一</option>
                                            <option>周二</option>
                                            <option>周三</option>
                                            <option>周四</option>
                                            <option>周五</option>
                                            <option>周六</option>
                                            <option>周日</option>
                                        </select>
                                    </div>
                                    <span class="red" style="display: none" id="nCourseTime">上课时间不能为空</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-3">
                                        <span style="color: red;font-size: 20px;vertical-align: middle">*</span>上课地点</label>
                                    <div class="col-sm-5">
                                        <input type="text" class="form-control" name="classRoom"
                                               id="classRoom" onblur="verClassRoom()">
                                    </div>
                                    <span class="red" style="display: none" id="nClassRoom">上课地点不能为空</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-3">
                                        <span style="color: red;font-size: 20px;vertical-align: middle">*</span>授课周数</label>
                                    <div class="col-sm-5">
                                        <input type="text" class="form-control" name="classWeek"
                                               id="classWeek" onblur="verClassWeek()">
                                    </div>
                                    <span class="red" style="display: none" id="nClassWeek">授课周数应为正整数</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-3">
                                        <span style="color: red;font-size: 20px;vertical-align: middle">*</span>课程类型</label>
                                    <div class="col-sm-5">
                                        <select name="courseType" id="courseType1" onblur="verCourseType()" style="width: 100%;height: 100%">
                                            <option id="courseType" style="display: none"></option>
                                            <option>选修课</option>
                                            <option>必修课</option>
                                        </select>
                                    </div><span class="red" style="display: none" id="nCourseType">课程类型不能为空</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-3">
                                        <span style="color: red;font-size: 20px;vertical-align: middle">*</span>
                                        学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;分</label>
                                    <div class="col-sm-5">
                                        <input type="text" id="score" name="score"
                                               class="form-control" onblur="verScore()">
                                    </div>
                                    <span style="display: none" class="red" id="nScore">学分应为1-9整数</span>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" id="subChange" class="btn btn-primary">确定</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
