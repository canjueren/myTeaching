/**
 * Created by Administrator on 2018/10/23.
 */
function selectAll(){
    var ch_all = document.getElementById("checkAll");
    var arr=document.getElementsByName("teacherList");
    if(ch_all.checked == true){
        for(var i = 0;i < arr.length;i ++){
            arr[i].checked = true;
        }
    }else{
        for(var i = 0;i < arr.length;i ++){
            arr[i].checked = false;
        }
    }
}
function ch_select(){
    var ch_all = document.getElementById("checkAll");
    var arr = document.getElementsByName("teacherList");
    var count = 0;
    for(var i = 0;i < arr.length;i ++){
        if(arr[i].checked == true){
            count ++;
        }
    }
    if(count == arr.length){
        ch_all.checked = true;
    }else{
        ch_all.checked = false;
    }
}
$(function(){
    //$("#changeDate1").click(function(){
        $('#datetimepicker1').datetimepicker({
            language: 'zh-CN',//显示中文
            format: 'yyyy-mm-dd',//显示格式
            minView: "month",//设置只显示到月份
            initialDate: new Date(),
            autoclose: true,//选中自动关闭
            todayBtn: true,//显示今日按钮
            locale: moment.locale('zh-cn')
        });
    //});
    //$("#changeDate2").click(function(){
        $('#datetimepicker2').datetimepicker({
            language: 'zh-CN',//显示中文
            format: 'yyyy-mm-dd',//显示格式
            minView: "month",//设置只显示到月份
            initialDate: new Date(),
            autoclose: true,//选中自动关闭
            todayBtn: true,//显示今日按钮
            locale: moment.locale('zh-cn')
        });
    //});
});
function changeTheTeacher(teacherId){
    initTeacherModal();
    //使用ajax发送请求
    $.ajax({
        url:'getTheTeacher.do',//请求的url
        type:'post',//提交方式
        asyns:true,//是否异步
        data:{
            teacherId:teacherId //以key-value的形式传递参数到后台，可同时传递多个参数，中间以逗号隔开
        },
        dataType:'json',//返回的格式：json/xml/html/text
        //回调函数
        //请求成功后调用
        success:function(data){
            $("#theTitle").text("修改教师信息");
            $("#teacherId").val(data[0].id);
            $("#name").val(data[0].name);
            if(data[0].sex.toString()==0){
                $("#woman").attr("checked","checked");
            }else {
                $("#man").attr("checked","checked");
            }
            $("#bDate1").val(data[0].birthday);
            $("#degree1").val(data[0].degree);
            $("#title1").val(data[0].title);
            $("#bDate2").val(data[0].grade);
            $("#collegeId").html("");
            $("#collegeId").append('<option style="display: none">'+data[0].college.collegeName+'</option>');
            //使用ajax发送请求
            $.ajax({
                url:'findAllCollegeId.do',//请求的url
                type:'post',//提交方式
                asyns:true,//是否异步
                data:{
                },
                dataType:'json',//返回的格式：json/xml/html/text
                //回调函数
                //请求成功后调用
                success:function(data1){
                    for(i in data1){
                        $("#collegeId").append('<option>'+data1[i].collegeName+'</option>');
                    }
                },
                //请求失败后调用
                error:function(xhr,textStatus){
                    console.log('错误')
                }
            });
            $('#myModal').modal('show');
            $("#subChange").click(function(){
                if(verTeacherName()&&verTeaBirthday()&&verDegree()&&verTitle()&&verTeaGrade()){
                    //使用ajax发送请求
                    $.ajax({
                        url:'changeTheTeacher.do',//请求的url
                        type:'post',//提交方式
                        asyns:true,//是否异步
                        contentType:'application/x-www-form-urlencoded',
                        data:
                            $("#theTeacherInf").serialize(),
                        dataType:'text',//返回的格式：json/xml/html/text
                        //回调函数
                        //请求成功后调用
                        success:function(data){
                            if(data==1||data==2){
                                alert("修改成功！");
                                window.location.reload();
                            }else {
                                alert("修改失败！")
                            }
                        },
                        //请求失败后调用
                        error:function(xhr,textStatus){
                            console.log('错误')
                        }
                    });
                }else {
                    alert("填写不符合要求！")
                    return false;
                }
            })
        },
        //请求失败后调用
        error:function(xhr,textStatus){
            console.log('错误')
        }
    });
}
function addTheTeacher(){
    initTeacherModal();
    $("#theTitle").text("添加教师");
    $("#teacherId").val("");
    $("#name").val("");
//            $("#woman").removeAttr("checked");
    $("#man").attr("checked","checked");
    $("#bDate1").val("");
    $("#degree1").val("");
    $("#title1").val("");
    $("#bDate2").val("");
    $("#collegeId").html("");
    $("#collegeId").append('<option style="display: none">'+""+'</option>');
    //使用ajax发送请求
    $.ajax({
        url:'findAllCollegeId.do',//请求的url
        type:'post',//提交方式
        asyns:true,//是否异步
        data:{
        },
        dataType:'json',//返回的格式：json/xml/html/text
        //回调函数
        //请求成功后调用
        success:function(data1){
            for(i in data1){
                $("#collegeId").append('<option>'+data1[i].collegeName+'</option>');
            }
        },
        //请求失败后调用
        error:function(xhr,textStatus){
            console.log('错误')
        }
    });
    $('#myModal').modal('show');
    $("#subChange").click(function(){
        var a=0;
        $.each($("input[name='sex']"),function(){
            if(this.checked){
                a++;
            }
        });
        if(verTeacherName()&&verTeaBirthday()&&verDegree()&&verTitle()&&verTeaGrade()&&verTeaCollege()&&(a==1)){
            //使用ajax发送请求
            $.ajax({
                url:'addTheTeacher.do',//请求的url
                type:'post',//提交方式
                asyns:true,//是否异步
                contentType:'application/x-www-form-urlencoded',
                data:
                    $("#theTeacherInf").serialize(),
                dataType:'text',//返回的格式：json/xml/html/text
                //回调函数
                //请求成功后调用
                success:function(data){
                    if(data=='2'||data==2){
                        alert("添加成功！");
                        window.location.reload();
                    }else {
                        alert("添加失败！")
                    }
                },
                //请求失败后调用
                error:function(xhr,textStatus){
                    console.log('错误')
                }
            });
        }else {
            alert("填写不符合要求！")
            return false;
        }
    })
}
function delTheTeacher(){
    var ids = new Array();
    var a=0;
    $.each($("input[name='teacherList']"),function(){
        if(this.checked){
            ids.push($(this).val());
            a+=2;
        }
    });
    if(ids==null||ids==''){
        alert("请选择要删除的数据！");
        return false;
    }
    $.ajax({
        url:'findCouOfTeacher.do',//请求的url
        type:'post',//提交方式
        asyns:true,//是否异步
        data:{
            ids:ids.toString()
        },
        dataType:'json',//返回的格式：json/xml/html/text
        //回调函数
        //请求成功后调用
        success:function(data){
            if(data[0]==null){
                //删除提示
                if(confirm("确定删除吗？")){
                    //使用ajax发送请求
                    $.ajax({
                        url:'delTheTeacher.do',//请求的url
                        type:'post',//提交方式
                        asyns:true,//是否异步
                        data:{
                            ids:ids.toString()
                        },
                        dataType:'text',//返回的格式：json/xml/html/text
                        //回调函数
                        //请求成功后调用
                        success:function(data){
                            if(data==a){
                                alert("删除成功！");
                                window.location.reload();
                            }else {
                                alert("删除失败！")
                            }
                        },
                        //请求失败后调用
                        error:function(xhr,textStatus){
                            console.log('错误')
                        }
                    });
                }
            }else {
                alert("包含尚有课程，无法删除！")
            }
        },
        //请求失败后调用
        error:function(xhr,textStatus){
            console.log('错误')
        }
    });
}
function verTeacherName(){
    var teacherName=$("#name").val();
    if(teacherName==''||teacherName==null){
        $("#nTeacherName").attr("style","display:block;color:red");
        return false;
    }else {
        $("#nTeacherName").attr("style","display:none");
        return true;
    }
}
function verTeaBirthday(){
    var birthday=$("#bDate1").val();
    var grade=$("#bDate2").val();
    if(birthday==''||birthday==null){
        $("#nTeaBirthday").attr("style","display:block;color:red");
        return false;
    }else {
        if(birthday >= grade && grade != ''){
            alert("入职不能在出生之前！");
            return false;
        }else {
            $("#nTeaBirthday").attr("style","display:none");
            return true;
        }

    }
}
function verDegree(){
    var degree=$("#degree1").val();
    if(degree==''||degree==null){
        $("#nDegree").attr("style","display:block;color:red");
        return false;
    }else {
        $("#nDegree").attr("style","display:none");
        return true;
    }
}
function verTitle(){
    var title=$("#title1").val();
    if(title==''||title==null){
        $("#nTitle").attr("style","display:block;color:red");
        return false;
    }else {
        $("#nTitle").attr("style","display:none");
        return true;
    }
}
function verTeaCollege(){
    var collegeId=$("#collegeId").val();
    if(collegeId==''||collegeId==null){
        $("#nCollegeId").attr("style","display:block;color:red");
        return false;
    }else {
        $("#nCollegeId").attr("style","display:none");
        return true;
    }
}
function verTeaGrade(){debugger
    var birthday=$("#bDate1").val();
    var grade=$("#bDate2").val();
    if(grade==''||grade==null){
        $("#nTeaGrade").attr("style","display:block;color:red");
        return false;
    }else {
        if(birthday >= grade){
            alert("入职不能在出生之前！");
            return false;
        }else {
            $("#nTeaGrade").attr("style","display:none");
            return true;
        }

    }
}
function searchBySearchName(){
    var searchName = $("#searchTeacher").val();
    location.href="getAllTeacher.do?searchName="+searchName;
}

function initTeacherModal(){
    $("#nTeacherName").attr("style","display:none");
    $("#nTeaBirthday").attr("style","display:none");
    $("#nDegree").attr("style","display:none");
    $("#nTitle").attr("style","display:none");
    $("#nCollegeId").attr("style","display:none");
    $("#nTeaGrade").attr("style","display:none");
}
