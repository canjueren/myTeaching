<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/14
  Time: 12:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>所有课程</title>
    <link rel="stylesheet" href="/css/base.css" type="text/css">
    <link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/css/myTable.css" type="text/css">
    <script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script>
        function chooseTheCourse(courseId){
            var studentId= ${sessionScope.userId};
            if(confirm("确认选择？")){
//                            location.href="ChooseTheCourse.do?courseId="+courseId+"&studentId="+studentId;
                //使用ajax发送请求
                $.ajax({
                    url:'ChooseTheCourse.do',//请求的url
                    type:'post',//提交方式
                    asyns:true,//是否异步
                    data:{
                        courseId:courseId, //以key-value的形式传递参数到后台，可同时传递多个参数，中间以逗号隔开
                        studentId:studentId
                    },
                    dataType:'json',//返回的格式：json/xml/html/text
                    //回调函数
                    //请求成功后调用
                    success:function(data){
                        if(data=='1'||data==1){
                            alert("选课成功！");
                            window.parent.getSelectCou();
                            location.href="SelectMySel.do"
                        }
                    },
                    //请求失败后调用
                    error:function(xhr,textStatus){
                        console.log('错误')
                    }
                });
            }
        }
        function searchByName(){
            var searchName = $("#searchCourse").val();
            location.href="getAllCourse.do?name="+searchName;
        }
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
        <td colspan="3" style="border: 0px" bgcolor="#eef7fc">
            <label style="font-size: 30px">课程列表</label>
        </td>
        <td colspan="6" style="border: 0px" bgcolor="#eef7fc">
            <div style="height: 33px;">
                <div class="form-group" style="vertical-align: middle">
                    <a class="input-group">
                        <input type='text' id="searchCourse" class="form-control" placeholder="请输入课程名"
                               style="width: 250px; height: 35px;" value="${requestScope.name}">
                        <span class="input-group-addon btn" onclick="searchByName()" style="width: 30px; height: 35px;">
                            <span class="glyphicon glyphicon-search"></span>
                        </span>
                    </a>
                </div>
            </div>
        </td>
    </tr>
    <tr align="center" style="color:#185697;">
        <td>课程号</td><td>课程名称</td><td>授课老师</td><td>上课时间</td><td>上课地点</td>
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
                <td id="theFlag">
                    <c:if test="${not empty courseList.selectedCourse}">
                        <c:forEach var="selectedCourse" items="${courseList.selectedCourse}">
                            <c:if test="${selectedCourse.studentId==sessionScope.userId}">
                                <c:if test="${selectedCourse.mark==-1}">
                                    已选
                                </c:if>
                                <c:if test="${selectedCourse.mark!=-1}">
                                    已修
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty courseList.selectedCourse}">
                        <a target="teacher" onclick="chooseTheCourse(${courseList.id})">
                            <button type="button" class="btn btn-primary btn-sm">
                                选课
                            </button>
                        </a>
                    </c:if>
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
            <li><a href="getAllCourse.do?currentPage=1&name=${requestScope.name}">首页</a></li>
            <li><a href="getAllCourse.do?currentPage=${requestScope.pageIndex-1}&name=${requestScope.name}">上一页</a></li>
            <li> 第${requestScope.pageIndex}页 / 共${requestScope.totalPage}页 </li>
            <li><a href="getAllCourse.do?currentPage=${requestScope.pageIndex+1}&name=${requestScope.name}">下一页</a></li>
            <li><a href="getAllCourse.do?currentPage=${requestScope.totalPage}&name=${requestScope.name}">末页</a></li>
        </ul>
    </div>
</c:if>
</body>
</html>
