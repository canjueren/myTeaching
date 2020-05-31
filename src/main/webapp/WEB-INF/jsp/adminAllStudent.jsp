<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/16
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>学生管理</title>
    <link rel="stylesheet" href="/css/base.css" type="text/css">
    <link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/css/myTable.css" type="text/css">
    <script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/adminStudent.js"></script>
    <link href="bootstrap_datetime/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <script src="bootstrap_datetime/moment-with-locales.js"></script>
    <script src="bootstrap_datetime/bootstrap-datetimepicker.min.js"></script>
    <script src="bootstrap_datetime/bootstrap-datetimepicker.zh-CN.js"></script>
    <script>
        function getCountStudent(){
            $("#stuCount", window.parent.document).text("${requestScope.countStudent}");
        }
    </script>
</head>
<body onload="getCountStudent()">
<table class="table table-striped table-bordered table-hover table-condensed cztable-table">
    <tr>
        <td colspan="4" style="border: 0px" bgcolor="#eef7fc">
            <label style="font-size: 30px">学生名单管理</label>
        </td>
        <td colspan="2" style="vertical-align: middle;border: 0px" bgcolor="#eef7fc">
            <div style="height: 33px;">
                <div class="form-group" style="vertical-align: middle">
                    <a class="input-group">
                        <input type='text' id="searchStudent" class="form-control" placeholder="请输入姓名"
                               style="width: 230px; height: 35px;" value="${requestScope.searchName}">
                        <span class="input-group-addon btn" onclick="searchBySearchName()"
                              style="width: 30px; height: 35px;">
                            <span class="glyphicon glyphicon-search"></span>
                        </span>
                    </a>
                </div>
            </div>
        </td>
        <td colspan="1" align="right" style="vertical-align: middle;border: 0px" bgcolor="#eef7fc">
            <button type="button" class="btn btn-success btn-sm" style="height: 30px" onclick="addTheStudent()">
                <span class="glyphicon glyphicon-plus">  新增</span>
            </button>
        </td>
        <td colspan="1" align="center" style="vertical-align: middle;border: 0px" bgcolor="#eef7fc">
            <button type="button" class="btn btn-danger btn-sm" style="height: 30px" onclick="delTheStudent()">
                <span class="glyphicon glyphicon-trash">  删除</span>
            </button>
        </td>
    </tr>
    <tr align="center" style="color:#185697;">
        <td><input type="checkbox" id="checkAll" onclick="selectAll()"></td>
        <td>学号</td><td>姓名</td><td>性别</td><td>出生日期</td><td>入学时间</td>
        <td>所属学院</td><td>操作</td>
    </tr>
    <c:if test="${not empty requestScope.studentList}">
        <c:forEach var="studentList" items="${requestScope.studentList}">
            <tr align="center" style="vertical-align: middle">
                <td><input type="checkbox" name="studentList" value="${studentList.id}" onclick="ch_select()" ></td>
                <td>${studentList.id}</td>
                <td>${studentList.name}</td>
                <c:if test="${studentList.sex==0}">
                    <td>女</td>
                </c:if>
                <c:if test="${studentList.sex==1}">
                    <td>男</td>
                </c:if>
                <td>${studentList.birthday}</td>
                <td>${studentList.grade}</td>
                <td>${studentList.college.collegeName}</td>
                <td>
                    <a target="teacher" onclick="changeTheStudent(${studentList.id})">
                        <button type="button" class="btn btn-primary btn-sm"style="width: 100%">
                            修&nbsp;&nbsp;&nbsp;改
                        </button>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </c:if>
    <c:if test="${empty requestScope.studentList}">
        <tr><td colspan="9">没有相关数据</td></tr>
    </c:if>
</table>
<c:if test="${not empty requestScope.studentList}">
    <div align="center" class="pager">
        <ul>
            <li><a href="getAllStudent.do?currentPage=1&searchName=${requestScope.searchName}">首页</a></li>
            <li><a href="getAllStudent.do?currentPage=${requestScope.pageIndex-1}&searchName=${requestScope.searchName}">上一页</a></li>
            <li> 第${requestScope.pageIndex}页 / 共${requestScope.totalPage}页 </li>
            <li><a href="getAllStudent.do?currentPage=${requestScope.pageIndex+1}&searchName=${requestScope.searchName}">下一页</a></li>
            <li><a href="getAllStudent.do?currentPage=${requestScope.totalPage}&searchName=${requestScope.searchName}">末页</a></li>
        </ul>
    </div>
</c:if>
<div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <label class="modal-title" style="font-size: 25px" id="theTitle"></label>
                <label style="font-size: 15px" class="pull-right">
                    所有标记<span style="color: red;font-size: 20px;vertical-align: middle">*</span>均为必填
                </label>
            </div>
            <form action="" id="theStudentInf" method="post">
                <div class="modal-body" style="background: #EEF7FC">

                    <ul>
                        <li class="list-group-item clearfix" style="border: 0px;background: #EEF7FC">
                            <input type="text" id="studentId" name="id" hidden>
                            <div class="row" >
                                <div class="form-group">
                                    <label class="col-sm-3">
                                        <span style="color: red;font-size: 20px;vertical-align: middle">*</span>
                                        学生姓名</label>
                                    <div class="col-sm-5">
                                        <input type="text" id="name" name="name" class="form-control" onblur="verStudentName()">
                                    </div>
                                    <span style="display: none" id="nStudentName">姓名不能为空!</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-3">
                                        <span style="color: red;font-size: 20px;vertical-align: middle">*</span>
                                        性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</label>
                                    <div class="col-sm-5">
                                        <input type="radio" name="sex" value="1" id="man">男
                                        <input type="radio" name="sex" value="0" id="woman">女
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-3">
                                        <span style="color: red;font-size: 20px;vertical-align: middle">*</span>
                                        出生日期</label>
                                    <div class="col-sm-5">
                                        <a class='input-group date' id='datetimepicker1' style="float: left; left: 0px;width: 100%">
                                            <input type='text' class="form-control txt" id='bDate1' name="birthday"
                                                   readonly=readonly onchange="verStuBirthday()">
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar" id="changeDate1"></span>
                                            </span>
                                        </a>
                                    </div>
                                    <span>点击选择出生日期</span>
                                    <span style="display: none" id="nStuBirthday">出生日期不能为空!</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-3">
                                        <span style="color: red;font-size: 20px;vertical-align: middle">*</span>
                                        入学时间</label>
                                    <div class="col-sm-5">
                                        <a class='input-group date' id='datetimepicker2' style="float: left; left: 0px;width: 100%">
                                            <input type='text' class="form-control txt" id='bDate2' name="grade"
                                                   readonly=readonly onchange="verStuGrade()">
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar" id="changeDate2"></span>
                                            </span>
                                        </a>
                                    </div>
                                    <span>点击选择入学时间</span>
                                    <span style="display: none" id="nStuGrade">入学时间不能为空!</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-3">
                                        <span style="color: red;font-size: 20px;vertical-align: middle">*</span>
                                        所属学院</label>
                                    <div class="col-sm-5">
                                        <select id="collegeId" name="collegeId" onblur="verStuCollege()" style="width: 100%;height: 100%">
                                        </select>
                                    </div>
                                    <span style="display: none" id="nCollegeId">学院不能为空!</span>
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
