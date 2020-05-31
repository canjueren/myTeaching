/**
 * Created by Administrator on 2018/10/23.
 */
function selectAll(){
    var ch_all = document.getElementById("checkAll");
    var arr=document.getElementsByName("courseList");
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
    var arr = document.getElementsByName("courseList");
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
function changeTheCourse(courseId){
    initCourseModal();
    //使用ajax发送请求
    $.ajax({
        url:'getTheCourse.do',//请求的url
        type:'post',//提交方式
        asyns:true,//是否异步
        data:{
            courseId:courseId //以key-value的形式传递参数到后台，可同时传递多个参数，中间以逗号隔开
        },
        dataType:'json',//返回的格式：json/xml/html/text
        //回调函数
        //请求成功后调用
        success:function(data){
            $("#theTitle").text("修改课程信息");
            $("#courseId").val(data[0].id);
            $("#courseName").val(data[0].courseName);
            $("#teacherId").html("");
            $("#teacherId").append('<option style="display: none">'+data[0].teacher.id+' '+data[0].teacher.name+'</option>');
            //使用ajax发送请求
            $.ajax({
                url:'findAllTeacherId.do',//请求的url
                type:'post',//提交方式
                asyns:true,//是否异步
                data:{
                },
                dataType:'json',//返回的格式：json/xml/html/text
                //回调函数
                //请求成功后调用
                success:function(data1){
                    for(i in data1){
                        $("#teacherId").append('<option>'+data1[i].id+data1[i].name+'</option>');
                    }
                },
                //请求失败后调用
                error:function(xhr,textStatus){
                    console.log('错误')
                }
            });
            $("#courseTime1").val(data[0].courseTime);
            $("#classRoom").val(data[0].classRoom);
            $("#classWeek").val(data[0].classWeek);
            $("#courseType1").val(data[0].courseType);
            $("#score").val(data[0].score);
            $('#myModal').modal('show');
            $("#subChange").click(function(){
                if(verCourseName()&&verClassRoom()&&verClassWeek()&&verScore()){
                    //使用ajax发送请求
                    $.ajax({
                        url:'changeTheCourse.do',//请求的url
                        type:'post',//提交方式
                        asyns:true,//是否异步
                        contentType:'application/x-www-form-urlencoded',
                        data:
                            $("#theCourseInf").serialize(),
                        dataType:'text',//返回的格式：json/xml/html/text
                        //回调函数
                        //请求成功后调用
                        success:function(data){
                            if(data=='1'||data==1){
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
            alert('shib')
        }
    });
}
function addTheCourse(){
    initCourseModal();
    $("#theTitle").text("添加课程");
    $("#courseId").val("");
    $("#courseName").val("");
    $("#teacherId").html("");
    $("#teacherId").append('<option style="display: none">'+""+'</option>');
    //使用ajax发送请求
    $.ajax({
        url:'findAllTeacherId.do',//请求的url
        type:'post',//提交方式
        asyns:true,//是否异步
        data:{
        },
        dataType:'json',//返回的格式：json/xml/html/text
        //回调函数
        //请求成功后调用
        success:function(data){
            for(i in data){
                $("#teacherId").append('<option>'+data[i].id+'&nbsp;'+data[i].name+'</option>');
            }
        },
        //请求失败后调用
        error:function(xhr,textStatus){
            console.log('错误')
        }
    });
    $("#courseTime1").val("");
//            $("#courseTime").text("");
    $("#classRoom").val("");
    $("#classWeek").val("");
    $("#courseType1").val("");
//            $("#courseType").text("");
    $("#score").val("");
    $('#myModal').modal('show');
    $("#subChange").click(function(){
        if(verCourseName()&&verClassRoom()&&verClassWeek()&&verScore()&&verCouTeaId()
            &&verCourseTime()&&verCourseType()){
            //使用ajax发送请求
            $.ajax({
                url:'addTheCourse.do',//请求的url
                type:'post',//提交方式
                asyns:true,//是否异步
                contentType:'application/x-www-form-urlencoded',
                data:
                    $("#theCourseInf").serialize(),
                dataType:'json',//返回的格式：json/xml/html/text
                //回调函数
                //请求成功后调用
                success:function(data){
                    if(data=='1'||data==1){
                        alert("添加成功！");
                        window.location.reload();
                    }else {
                        alert("添加失败！");
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
function delTheCourse(){
    var ids = new Array();
    var a = 0;
    $.each($("input[name='courseList']"),function(){
        if(this.checked){
            ids.push($(this).val());
            a++;
        }
    });
    if(ids==null||ids==''){
        alert("请选择要删除的数据!");
        return false;
    }
    $.ajax({
        url:'findStuOfCourse.do',//请求的url
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
                        url:'delTheCourse.do',//请求的url
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
                alert("包含已有学生选择的课程，无法删除！")
            }
        },
        //请求失败后调用
        error:function(xhr,textStatus){
            console.log('错误')
        }
    });
}
function verCourseName(){
    var courseName=$("#courseName").val();
    if(courseName==''||courseName==null){
        $("#nCourseName").attr("style","display:block;color:red");
        return false;
    }else {
        $("#nCourseName").attr("style","display:none");
        return true;
    }
}
function verClassRoom(){
    var classRoom=$("#classRoom").val();
    if(classRoom==''||classRoom==null){
        $("#nClassRoom").attr("style","display:block;color:red");
        return false;
    }else {
        $("#nClassRoom").attr("style","display:none");
        return true;
    }
}
function verClassWeek(){
    var classWeek=$("#classWeek").val();
    if(classWeek==''||classWeek==null||(!classWeek.match(/^[1-9]{1}|[1-2]{1}[0-9]{1}$/))){
        $("#nClassWeek").attr("style","display:block;color:red");
        return false;
    }else {
        $("#nClassWeek").attr("style","display:none");
        return true;
    }
}
function verScore(){
    var score=$("#score").val();
    if(score==''||score==null||(!score.match(/^[1-9]$/))){
        $("#nScore").attr("style","display:block;color:red");
        return false;
    }else {
        $("#nScore").attr("style","display:none");
        return true;
    }
}
function verCouTeaId(){
    var teacherIde=$("#teacherId").val();
    if(teacherIde==''||teacherIde==null){
        $("#nTeacherId").attr("style","display:block;color:red");
        return false;
    }else {
        $("#nTeacherId").attr("style","display:none");
        return true;
    }
}
function verCourseTime(){
    var courseTime=$("#courseTime1").val();
    if(courseTime==''||courseTime==null){
        $("#nCourseTime").attr("style","display:block;color:red");
        return false;
    }else {
        $("#nCourseTime").attr("style","display:none");
        return true;
    }
}
function verCourseType(){
    var courseType=$("#courseType1").val();
    if(courseType==''||courseType==null){
        $("#nCourseType").attr("style","display:block;color:red");
        return false;
    }else {
        $("#nCourseType").attr("style","display:none");
        return true;
    }
}
function searchByName(){
    var searchName = $("#searchCourse").val();
    location.href="getAllCourses.do?name="+searchName;
}

function initCourseModal(){
    $("#nCourseName").attr("style","display:none");
    $("#nClassRoom").attr("style","display:none");
    $("#nClassWeek").attr("style","display:none");
    $("#nScore").attr("style","display:none");
    $("#nTeacherId").attr("style","display:none");
    $("#nCourseTime").attr("style","display:none");
    $("#nCourseType").attr("style","display:none");
}
