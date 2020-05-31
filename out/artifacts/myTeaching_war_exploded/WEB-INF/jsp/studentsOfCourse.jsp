<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/11
  Time: 13:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>课程学生列表</title>
    <link rel="stylesheet" href="/css/base.css" type="text/css">
    <link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/css/myTable.css" type="text/css">
    <script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script>
        var courseId;
        function takeScore(studentid){
            //使用ajax发送请求
            $.ajax({
                url:'getNameById.do',//请求的url
                type:'post',//提交方式
                asyns:true,//是否异步
                data:{
                    id:studentid //以key-value的形式传递参数到后台，可同时传递多个参数，中间以逗号隔开
                },
                dataType:'json',//返回的格式：json/xml/html/text
                //回调函数
                //请求成功后调用
                success:function(data){
                    $("#theStudentId").val(studentid);
                    $("#theStudentName").val(data[0].name);
                    $("#score").val("");
                    $('#myModal').modal('show');
                },
                //请求失败后调用
                error:function(xhr,textStatus){
                    console.log('错误')
                }
            });
            courseId=${requestScope.myStuList[0].courseId};

        }
        function upScore(){
            var studentId = $("#theStudentId").val();
            var mark = $("#score").val();
            if(mark==''||mark==null){
                alert("成绩不能为空！");
                return false;
            }else if(!mark.match(/^100$|^(\d|[1-9]\d)$/)){
                alert("成绩只能是0-100的数字！");
                return false;
            }else {
                location.href="upScore.do?courseId="+courseId+"&studentId="+studentId+"&mark="
                        +mark+"&pageIndex=${requestScope.pageIndex}";
            }
        }
    </script>
</head>
<body>
<table class="table table-striped table-bordered table-hover cztable-table">
    <tr>
        <td colspan="4" bgcolor="#eef7fc">
            <label style="font-size: 30px">已选该课的学生 ( 共 ${requestScope.total} 人 )</label>
        </td>
    </tr>
    <tr align="center" style="color:#185697;">
        <td>学号</td><td>姓名</td><td>分数</td><td>操作</td>
    </tr>
    <c:if test="${not empty requestScope.myStuList}">

        <c:forEach var="myStuList" items="${requestScope.myStuList}">

            <tr align="center" style="vertical-align: middle">
                <td>${myStuList.studentId}</td>
                <td>${myStuList.student.name}</td>
                <c:if test="${myStuList.mark=='-1'}">
                    <td>未打分</td>
                    <td>
                        <a onclick="takeScore(${myStuList.studentId})">
                            <button class="btn btn-primary btn-sm">
                                打分
                            </button>
                        </a>
                    </td>
                </c:if>
                <c:if test="${myStuList.mark!='-1'}">
                    <td>${myStuList.mark}</td>
                    <td>已打分</td>
                </c:if>
            </tr>
        </c:forEach>
    </c:if>
    <c:if test="${empty requestScope.myStuList}">
        <tr><td colspan="9">没有相关数据</td></tr>
    </c:if>
</table>
<c:if test="${not empty requestScope.myStuList}">
    <div align="center" class="pager">
        <ul>
            <li><a href="stuOfCour.do?currentPage=1&courseId=${requestScope.myStuList[0].courseId}">首页</a></li>
            <li><a href="stuOfCour.do?currentPage=${requestScope.pageIndex-1}&courseId=${requestScope.myStuList[0].courseId}">上一页</a></li>
            <li> 第${requestScope.pageIndex}页 / 共${requestScope.totalPage}页 </li>
            <li><a href="stuOfCour.do?currentPage=${requestScope.pageIndex+1}&courseId=${requestScope.myStuList[0].courseId}">下一页</a></li>
            <li><a href="stuOfCour.do?currentPage=${requestScope.totalPage}&courseId=${requestScope.myStuList[0].courseId}">末页</a></li>
        </ul>
    </div>
</c:if>
<div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 550px">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    成绩打分
                </h4>
            </div>
            <form>
                <div class="modal-body">
                    <ul>
                        <li class="list-group-item" style="border: 0px">
                            <div class="row">
                                <div class="form-group">
                                    <div><label class="col-sm-2" style="font-size:17px">学号</label></div>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="theStudentId"
                                               readonly="readonly">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-2" style="font-size:17px">姓名</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="theStudentName"
                                               readonly="readonly">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <div><label class="col-sm-2" style="font-size:17px">成绩</label></div>
                                    <div class="col-sm-8">
                                        <input type="text" placeholder="请输入学生成绩" id="score" name="userId" class="form-control">
                                    </div>
                                </div>
                            </div>
                            <div class="row" align="center">
                                <div class="form-group">
                                    <%--<button type="reset" class="btn btn-default" data-dismiss="modal">重置</button>--%>
                                    <button type="button" id="submit" class="btn btn-primary" onclick="upScore()">提交</button>
                                    <button class="btn btn-default" data-dismiss="modal">取消</button>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>