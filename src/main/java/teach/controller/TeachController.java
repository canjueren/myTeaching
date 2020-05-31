package teach.controller;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import teach.pojo.*;
import teach.service.*;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Author:mzh
 * @Description:TODO
 * @Date:2018/10/10$
 **/
@Controller
@SessionAttributes("userId")
public class TeachController {
    @Resource
    CollegeService collegeService;
    @Resource
    CourseService courseService;
    @Resource
    SelectedCourseService selectedCourseService;
    @Resource
    StudentService studentService;
    @Resource
    TeacherService teacherService;
    @Resource
    UserLoginService userLoginService;

    /**
     * @Description:验证用户是否存在
     * @param:[userId, response]
     * @return:void
     **/
    @RequestMapping("/checkTheUser.do")
    @ResponseBody
    public JSONArray checkTheUser(String userId) {
        List<UserLogin> userLogin = userLoginService.checkTheUser(userId);
        JSONArray jsonArray = new JSONArray();
        jsonArray = jsonArray.fromObject(userLogin);
        return jsonArray;
    }
    /**
     * @Description:登录
     * @param:[userLogin, request, model, response]
     * @return:java.lang.String
     **/
    @RequestMapping("/login.do")
    public String loginOn(UserLogin userLogin, HttpServletRequest request,Model model,
                          HttpServletResponse response){
        if(null != userLogin.getUserId()){
            UserLogin user = userLoginService.loginOn(userLogin);
            Cookie[] cookies = request.getCookies();
            for (Cookie cookie: cookies) {
                if ("userId".equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
                if ("pwd".equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
            if(user==null) {
                request.setAttribute("fail","fail");
                return "login";
            }else {
                String rem = request.getParameter("remember");

                if(!("".equals(rem)||rem==null)){
                    Cookie cookie1 = new Cookie("userId", user.getUserId());
                    Cookie cookie2 = new Cookie("pwd", user.getPassword());
                    cookie1.setMaxAge(60*60*24);
                    cookie2.setMaxAge(60*60*24);
                    response.addCookie(cookie1);
                    response.addCookie(cookie2);
                }
                String myId = user.getUserId();
                model.addAttribute("userId",myId);
                request.setAttribute("user",user);

                String role = user.getRole();

                if("0".equals(role)){
                    int countCourse = courseService.getAllCountcourse();
                    int countStudent = studentService.getAllCountStudent();
                    int countTeacher = teacherService.getAllCountTeacher();
                    request.setAttribute("countCourse",countCourse);
                    request.setAttribute("countStudent",countStudent);
                    request.setAttribute("countTeacher",countTeacher);
                    return "AdminMain";
                }else if ("1".equals(role)){
                    int count = courseService.getTeachCourseCount(myId);
                    request.setAttribute("count",count);
                    return "teacherMain";
                }else {
                    int countAll = courseService.getAllCountcourse();
                    int countSel = selectedCourseService.SelectMySelTotal(myId);
                    int countGet = selectedCourseService.SelectMyGetTotal(myId);
                    request.setAttribute("countAll",countAll);
                    request.setAttribute("countSel",countSel);
                    request.setAttribute("countGet",countGet);
                    return "studentMain";
                }
            }
        }else {
            request.setAttribute("fail","fail");
            return "login";
        }
    }
    /**
     * @Description:用于分页的工具方法
     * @param:[request, total, pageSize]
     * @return:java.util.Map<java.lang.String,java.lang.String>
     **/
    public static Map<String,String> paging(int total,int pageSize,String currentPage){
        //计算总页数
        int totalPage = (total%pageSize==0)?(total/pageSize):(total/pageSize+1);
        //获取当前页
        if(null==currentPage||"".equals(currentPage)){
            currentPage="1";
        }
        int pageIndex = Integer.parseInt(currentPage);
        //对首页末页进行控制
        if(pageIndex < 1){
            pageIndex = 1;
        }else if (pageIndex>totalPage){
            pageIndex = totalPage;
        }
        //计算当前页的索引值
        int start = pageSize*(pageIndex-1)+1;
        int end = pageSize*pageIndex;
        String startIndex = start + "";
        String endIndex = end + "";

        Map<String,String> myMap = new HashMap<String, String>();
        myMap.put("pageIndex",pageIndex+"");
        myMap.put("totalPage",totalPage+"");
        myMap.put("startIndex",startIndex);
        myMap.put("endIndex",endIndex);

        return myMap;
    }
    /**
     * @Description:教师查看自己的课程
     * @param:[request, modelMap]
     * @return:java.lang.String
     **/
    @RequestMapping("/getTeacherCourses.do")
    public String getTeacherCourses(HttpServletRequest request, ModelMap modelMap,String currentPage){
        String teacherId = modelMap.get("userId").toString();
        //分页查询
        //1.计算总条数
        int total = courseService.getTeachCourseCount(teacherId);
        //2.设置每页条数
        int pageSize = 3;

        Map<String,String> myMap = paging(total,pageSize,currentPage);
        myMap.put("teacherId",teacherId);

        List<Course> courseList = courseService.getTeacherCourses(myMap);
        request.setAttribute("courseList",courseList);
        request.setAttribute("pageIndex",myMap.get("pageIndex"));
        request.setAttribute("totalPage",myMap.get("totalPage"));
        return "teacherCourse";
    }
    /**
     * @Description:查询选某门课的学生
     * @param:[request]
     * @return:java.lang.String
     **/
    @RequestMapping("/stuOfCour.do")
    public String stuOfMyCourse(HttpServletRequest request,String currentPage){
        String courseId = request.getParameter("courseId");
        //分页查询
        //1.计算总条数
        int total = selectedCourseService.getTotalStuOfCourse(courseId);
        //2.设置每页条数
        int pageSize = 3;

        Map<String,String> myMap = paging(total,pageSize,currentPage);
        myMap.put("courseId",courseId);

        List<SelectedCourse> selectedCourses = selectedCourseService.stuOfMyCourse(myMap);
        request.setAttribute("total",total);
        request.setAttribute("myStuList",selectedCourses);
        request.setAttribute("pageIndex",myMap.get("pageIndex"));
        request.setAttribute("totalPage",myMap.get("totalPage"));
        return "studentsOfCourse";
    }
    /**
     * @Description:通过id查询学生姓名
     * @param:[id, response]
     * @return:void
     **/
    @RequestMapping("/getNameById.do")
    @ResponseBody
    public JSONArray GetNameById(String id,HttpServletResponse response){
        response.setCharacterEncoding("utf-8");
        Student student = studentService.getStudentById(id);
        JSONArray jsonArray = new JSONArray();
        jsonArray = jsonArray.fromObject(student);
        return jsonArray;
    }
    /**
     * @Description:打分
     * @param:[selectedCourse, pageIndex]
     * @return:java.lang.String
     **/
    @RequestMapping("/upScore.do")
    public String upScore(SelectedCourse selectedCourse,String pageIndex){
        selectedCourseService.upScore(selectedCourse);
        return "forward:stuOfCour.do?courseId="+selectedCourse.getCourseId()+"&pageIndex="+pageIndex;
    }
    /**
     * @Description:前往修改密码页
     * @param:[userId, password, request]
     * @return:java.lang.String
     **/
    @RequestMapping("/toChange.do")
    public String toChange(String userId,String password,HttpServletRequest request){
        request.setAttribute("userId",userId);
        request.setAttribute("password",password);
        return "changePwd";
    }
    /**
     * @Description:修改密码
     * @param:[userLogin, request]
     * @return:java.lang.String
     **/
    @RequestMapping("/changeTo.do")
    public String changeTo(UserLogin userLogin,HttpServletRequest request){
        userLoginService.changePwd(userLogin);
        UserLogin user = userLoginService.loginOn(userLogin);
        if(user!=null){
            request.setAttribute("change","修改成功！");
        }else {
            request.setAttribute("change","修改失败！");
        }
        return  "changePwd";
    }
    /**
     * @Description:得到所有课程
     * @param:[name, request, modelMap]
     * @return:java.lang.String
     **/
    @RequestMapping("/getAllCourse.do")
    public String getAllCourse(String name,HttpServletRequest request,ModelMap modelMap,String currentPage){
        String myId = modelMap.get("userId").toString();
        //分页查询
        //1.计算总条数
        int total;
        if("".equals(name)||name==null){
            total = courseService.getAllCountcourse();
        }else {
            total = courseService.CourseCountOfName(name);
        }
        //2.设置每页条数
        int pageSize = 3;

        Map<String,String> myMap = paging(total,pageSize,currentPage);

        List<Course> courseList;
        if("".equals(name)||name==null){
            courseList = courseService.getAllCourse(myMap);
        }else {
            myMap.put("name",name);
            courseList = courseService.getCourseOfName(myMap);
            request.setAttribute("name",name);
        }
        for(int i=0;i<courseList.size();i++) {
            List<SelectedCourse> se = courseList.get(i).getSelectedCourse();
            int count = 0;
            if(se.size()!=0){
                for(int j=0;j<se.size();j++){
                    SelectedCourse selectedCourse = se.get(j);
                    if(selectedCourse.getStudentId().equals(myId)){
                        count++;
                    }
                }
                if(count==0){
                    courseList.get(i).setSelectedCourse(null);
                }
            }

        }
        int countAll = courseService.getAllCountcourse();
        int countSel = selectedCourseService.SelectMySelTotal(myId);
        int countGet = selectedCourseService.SelectMyGetTotal(myId);
        request.setAttribute("countAll",countAll);
        request.setAttribute("countSel",countSel);
        request.setAttribute("countGet",countGet);
        request.setAttribute("courseList",courseList);
        request.setAttribute("pageIndex",myMap.get("pageIndex"));
        request.setAttribute("totalPage",myMap.get("totalPage"));
        return "AllSelCourse";
    }
    /**
     * @Description:学生已选的课程
     * @param:[request, modelMap]
     * @return:java.lang.String
     **/
    @RequestMapping("/SelectMySel.do")
    public String SelectMySel(HttpServletRequest request,ModelMap modelMap,String currentPage){
        String myId = modelMap.get("userId").toString();
        //分页查询
        //1.计算总条数
        int total = selectedCourseService.SelectMySelTotal(myId);
        //2.设置每页条数
        int pageSize = 2;

        Map<String,String> myMap = paging(total,pageSize,currentPage);
        myMap.put("studentId",myId);

        List<SelectedCourse> courseList = selectedCourseService.SelectMySel(myMap);
        int countAll = courseService.getAllCountcourse();
        int countSel = selectedCourseService.SelectMySelTotal(myId);
        int countGet = selectedCourseService.SelectMyGetTotal(myId);
        request.setAttribute("countAll",countAll);
        request.setAttribute("countSel",countSel);
        request.setAttribute("countGet",countGet);
        request.setAttribute("courseList",courseList);
        request.setAttribute("pageIndex",myMap.get("pageIndex"));
        request.setAttribute("totalPage",myMap.get("totalPage"));
        return "mySelCourse";
    }
    /**
     * @Description:学生已修完的课程
     * @param:[studentId, request, modelMap]
     * @return:java.lang.String
     **/
    @RequestMapping("/SelectMyGet.do")
    public String SelectMyGet(String studentId,HttpServletRequest request,ModelMap modelMap,String currentPage){
        String myId = modelMap.get("userId").toString();
        //分页查询
        //1.计算总条数
        int total = selectedCourseService.SelectMyGetTotal(studentId);
        //2.设置每页条数
        int pageSize = 2;

        Map<String,String> myMap = paging(total,pageSize,currentPage);
        myMap.put("studentId",studentId);

        List<SelectedCourse> courseList = selectedCourseService.SelectMyGet(myMap);
        int countAll = courseService.getAllCountcourse();
        int countSel = selectedCourseService.SelectMySelTotal(myId);
        int countGet = selectedCourseService.SelectMyGetTotal(myId);
        request.setAttribute("countAll",countAll);
        request.setAttribute("countSel",countSel);
        request.setAttribute("countGet",countGet);
        request.setAttribute("courseList",courseList);
        request.setAttribute("pageIndex",myMap.get("pageIndex"));
        request.setAttribute("totalPage",myMap.get("totalPage"));
        return "myGetCourse";
    }
    /**
     * @Description:退课
     * @param:[selectedCourse]
     * @return:java.lang.String
     **/
    @RequestMapping("/outTheCourse.do")
    public String outTheCourse(SelectedCourse selectedCourse){
        selectedCourseService.outTheCourse(selectedCourse);
        return "forward:SelectMySel.do";
    }
    /**
     * @Description:查询是否已经选择这门课
     * @param:[selectedCourse, response, modelMap]
     * @return:void
     **/
    @RequestMapping("/findTheCourse.do")
    @ResponseBody
    public JSONArray findTheCourse(SelectedCourse selectedCourse,ModelMap modelMap){
        selectedCourse.setStudentId(modelMap.get("userId").toString());
        SelectedCourse selectedCourse1 = selectedCourseService.findInTheSelCou(selectedCourse);
        JSONArray jsonArray = new JSONArray();
        jsonArray = jsonArray.fromObject(selectedCourse1);
        return  jsonArray;
    }
    /**
     * @Description:选课
     * @param:[selectedCourse, response]
     * @return:void
     **/
    @RequestMapping("/ChooseTheCourse.do")
    @ResponseBody
    public int chooseTheCourse(SelectedCourse selectedCourse,HttpServletResponse response){
        response.setCharacterEncoding("utf-8");
        int flag = selectedCourseService.chooseTheCourse(selectedCourse);
        return flag;
    }
    /**
     * @Description:注销
     * @param:[sessionStatus]
     * @return:java.lang.String
     **/
    @RequestMapping("outLogin.do")
    public String outLogin(SessionStatus sessionStatus){
        sessionStatus.setComplete();
        return "login";
    }
    /**
     * @Description:显示所有课程
     * @param:[name, request]
     * @return:java.lang.String
     **/
    @RequestMapping("/getAllCourses.do")
    public String getAllCourses(String name,HttpServletRequest request,String currentPage){
        //分页查询
        //1.计算总条数
        int total;
        if("".equals(name)||name==null){
            total= courseService.getAllCountcourse();
        }else {
            total= courseService.CourseCountOfName(name);
        }
        //2.设置每页条数
        int pageSize = 3;

        Map<String,String> myMap = paging(total,pageSize,currentPage);

        List<Course> courseList;
        if("".equals(name)||name==null){
            courseList = courseService.getAllCourse(myMap);
        }else {
            myMap.put("name",name);
            courseList = courseService.getCourseOfName(myMap);
            request.setAttribute("name",name);
        }
        int countCourse = courseService.getAllCountcourse();
        request.setAttribute("countCourse",countCourse);
        request.setAttribute("courseList",courseList);
        request.setAttribute("pageIndex",myMap.get("pageIndex"));
        request.setAttribute("totalPage",myMap.get("totalPage"));
        return "adminAllCourse";
    }
    /**
     * @Description:显示所有学生
     * @param:[searchName, request]
     * @return:java.lang.String
     **/
    @RequestMapping("/getAllStudent.do")
    public String getAllStudent(String searchName,HttpServletRequest request,String currentPage){
        //分页查询
        //1.计算总条数
        int total;
        if("".equals(searchName)||searchName==null){
            total= studentService.getAllCountStudent();
        }else {
            total= studentService.stuCountOfName(searchName);
        }
        //2.设置每页条数
        int pageSize = 3;

        Map<String,String> myMap = paging(total,pageSize,currentPage);

        List<Student> studentList;;
        if("".equals(searchName)||searchName==null){
            studentList = studentService.getAllStudent(myMap);
        }else {
            myMap.put("searchName",searchName);
            studentList = studentService.getStudentOfName(myMap);
            request.setAttribute("searchName",searchName);
        }
        DateFormat format=new SimpleDateFormat("yyyy-mm-dd");
        for(int i=0;i<studentList.size();i++){
            Student st=studentList.get(i);
            String str1=st.getBirthday();
            String str2 =st.getGrade();
            try {
                Date date1 = format.parse(str1);
                String birthday=format.format(date1);
                st.setBirthday(birthday);
                Date date2 = format.parse(str2);
                String grade=format.format(date2);
                st.setGrade(grade);
            } catch (java.text.ParseException e) {
                e.printStackTrace();
            }
        }
        int countStudent = studentService.getAllCountStudent();
        request.setAttribute("countStudent",countStudent);
        request.setAttribute("studentList",studentList);
        request.setAttribute("pageIndex",myMap.get("pageIndex"));
        request.setAttribute("totalPage",myMap.get("totalPage"));
        return "adminAllStudent";
    }
    /**
     * @Description:显示所有教师
     * @param:[searchName, request]
     * @return:java.lang.String
     **/
    @RequestMapping("/getAllTeacher.do")
    public String getAllTeacher(String searchName,HttpServletRequest request,String currentPage){
        //分页查询
        //1.计算总条数
        int total;
        if("".equals(searchName)||searchName==null){
            total= teacherService.getAllCountTeacher();
        }else {
            total= teacherService.teaCountOfName(searchName);
        }
        //2.设置每页条数
        int pageSize = 3;

        Map<String,String> myMap = paging(total,pageSize,currentPage);

        List<Teacher> teacherList;
        if("".equals(searchName)||searchName==null){
            teacherList = teacherService.getAllTeacher(myMap);
        }else {
            myMap.put("searchName",searchName);
            teacherList = teacherService.getTeacherOfName(myMap);
            request.setAttribute("searchName",searchName);
        }
        DateFormat format=new SimpleDateFormat("yyyy-mm-dd");
        for(int i=0;i<teacherList.size();i++){
            Teacher te=teacherList.get(i);
            String str1=te.getBirthday();
            String str2 =te.getGrade();
            try {
                Date date1 = format.parse(str1);
                String birthday=format.format(date1);
                te.setBirthday(birthday);
                Date date2 = format.parse(str2);
                String grade=format.format(date2);
                te.setGrade(grade);
            } catch (java.text.ParseException e) {
                e.printStackTrace();
            }
        }
        int countTeacher = teacherService.getAllCountTeacher();
        request.setAttribute("countTeacher",countTeacher);
        request.setAttribute("teacherList",teacherList);
        request.setAttribute("pageIndex",myMap.get("pageIndex"));
        request.setAttribute("totalPage",myMap.get("totalPage"));
        return "adminAllTeacher";
    }
    /**
     * @Description:得到选中课程信息
     * @param:[courseId, response]
     * @return:void
     **/
    @RequestMapping("/getTheCourse.do")
    @ResponseBody
    public List<Course> getTheCourse(String courseId,HttpServletResponse response) {
        response.setCharacterEncoding("utf-8");
        List<Course> course = courseService.getTheCourse(courseId);
        return course;
    }
    /**
     * @Description:得到所有老师的编号和姓名
     * @param:[response]
     * @return:void
     **/
    @RequestMapping("/findAllTeacherId.do")
    @ResponseBody
    public List<Teacher> findAllTeacherId(HttpServletResponse response) {
        response.setCharacterEncoding("utf-8");
        List<Teacher> teacherList = teacherService.findAllTeacherId();
        return teacherList;
    }
    /**
     * @Description:修改课程信息
     * @param:[course, response]
     * @return:void
     **/
    @RequestMapping("/changeTheCourse.do")
    @ResponseBody
    public int changeTheCourse(Course course){
        course.setTeacherId(course.getTeacherId().substring(0,3));
        course.setCollegeId(teacherService.getTheTeacher(course.getTeacherId()).getCollegeId());
        int flag = courseService.changeTheCourse(course);
        return flag;
    }
    /**
     * @Description:添加课程
     * @param:[course, response]
     * @return:void
     **/
    @RequestMapping("/addTheCourse.do")
    @ResponseBody
    public int addTheCourse(Course course) {
        course.setTeacherId(course.getTeacherId().substring(0,3));
        course.setCollegeId(teacherService.getTheTeacher(course.getTeacherId()).getCollegeId());
        int flag = courseService.addTheCourse(course);
        return flag;
    }
    /**
     * @Description:查看所选课程是否有学生选择
     * @param:[ids, response]
     * @return:void
     **/
    @RequestMapping("/findStuOfCourse.do")
    @ResponseBody
    public JSONArray findStuOfCourse(String ids) {
        String[] id = ids.split(",");
        List idsList = new ArrayList();
        for (int i=0;i<id.length;i++){
            idsList.add(i,id[i]);
        }
        List<SelectedCourse> selectedCourses = selectedCourseService.findStuOfCourse(idsList);
        JSONArray jsonArray = new JSONArray();
        jsonArray = jsonArray.fromObject(selectedCourses);
        return jsonArray;
    }
    /**
     * @Description:删除所选课程
     * @param:[ids, response]
     * @return:void
     **/
    @RequestMapping("/delTheCourse.do")
    @ResponseBody
    public int delTheCourse(String ids) {
        String[] id = ids.split(",");
        List idsList = new ArrayList();
        for (int i=0;i<id.length;i++){
            idsList.add(i,id[i]);
        }
        int flag = courseService.delTheCourse(idsList);
        return flag;
    }
    /**
     * @Description:查询选中教师信息
     * @param:[teacherId, response]
     * @return:void
     **/
    @RequestMapping("/getTheTeacher.do")
    @ResponseBody
    public JSONArray getTheTeacher(String teacherId,HttpServletResponse response) {
        response.setCharacterEncoding("utf-8");
        Teacher teacher = teacherService.getTheTeacher(teacherId);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            teacher.setBirthday(sdf.format(sdf.parse(teacher.getBirthday())));
            teacher.setGrade(sdf.format(sdf.parse(teacher.getGrade())));
        } catch (Exception e){
            e.printStackTrace();
        }
        JSONArray jsonArray = new JSONArray();
        jsonArray = jsonArray.fromObject(teacher);
        return jsonArray;
    }
    /**
     * @Description:查询所有学院信息
     * @param:[response]
     * @return:void
     **/
    @RequestMapping("/findAllCollegeId.do")
    @ResponseBody
    public JSONArray findAllCollege(HttpServletResponse response) {
        response.setCharacterEncoding("utf-8");
        List<College> collegeList = collegeService.getAllCollege();
        JSONArray jsonArray = new JSONArray();
        jsonArray = jsonArray.fromObject(collegeList);
        return jsonArray;
    }
    /**
     * @Description:修改教师信息
     * @param:[teacher, userLogin, response]
     * @return:void
     **/
    @RequestMapping("/changeTheTeacher.do")
    @ResponseBody
    public int changeTheTeacher(Teacher teacher,UserLogin userLogin,HttpServletResponse response) {
        teacher.setCollegeId(collegeService.getCollegeByName(teacher.getCollegeId()).getCollegeId());
        userLogin.setUserId(teacher.getId());
        userLogin.setUserName(teacher.getName());
        int flag1 = teacherService.changeTheTeacher(teacher);
        int flag2 = userLoginService.changeName(userLogin);
        int flag = flag1+flag2;
        return flag;
    }
    /**
     * @Description:添加教师
     * @param:[teacher, userLogin, response]
     * @return:void
     **/
    @RequestMapping("/addTheTeacher.do")
    @ResponseBody
    public int addTheTeacher(Teacher teacher,UserLogin userLogin,HttpServletResponse response) {
        teacher.setCollegeId(collegeService.getCollegeByName(teacher.getCollegeId()).getCollegeId());
        userLogin.setUserName(teacher.getName());
        int flag1 = teacherService.addTeacher(teacher);
        int flag2 = userLoginService.addTeacherUser(userLogin);
        int flag = flag1+flag2;
        return flag;
    }
    /**
     * @Description:查询所选教师的课程
     * @param:[ids, response]
     * @return:void
     **/
    @RequestMapping("/findCouOfTeacher.do")
    @ResponseBody
    public JSONArray findCouOfTeacher(String ids) {
        String[] id = ids.split(",");
        List idsList = new ArrayList();
        for (int i=0;i<id.length;i++){
            idsList.add(i,id[i]);
        }
        List<Course> courseList = courseService.findCouOfTeacher(idsList);
        JSONArray jsonArray = new JSONArray();
        jsonArray = jsonArray.fromObject(courseList);
        return jsonArray;
    }
    /**
     * @Description:删除教师
     * @param:[ids, response]
     * @return:void
     **/
    @RequestMapping("/delTheTeacher.do")
    @ResponseBody
    public int delTheTeacher(String ids) {
        String[] id = ids.split(",");
        List idsList = new ArrayList();
        for (int i=0;i<id.length;i++){
            idsList.add(i,id[i]);
        }
        int flag1 = teacherService.delTheTeacher(idsList);
        int flag2 = userLoginService.delTheUser(idsList);
        int flag = flag1+flag2;
        return flag;
    }
    /**
     * @Description:查询所选学生信息
     * @param:[studentId, response]
     * @return:void
     **/
    @RequestMapping("/getTheStudent.do")
    @ResponseBody
    public JSONArray getTheStudent(String studentId,HttpServletResponse response) {
        response.setCharacterEncoding("utf-8");
        Student student = studentService.getStudentById(studentId);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            student.setBirthday(sdf.format(sdf.parse(student.getBirthday())));
            student.setGrade(sdf.format(sdf.parse(student.getGrade())));
        } catch (Exception e){
            e.printStackTrace();
        }
        JSONArray jsonArray = new JSONArray();
        jsonArray = jsonArray.fromObject(student);
        return jsonArray;
    }
    /**
     * @Description:修改学生信息
     * @param:[student, userLogin, response]
     * @return:void
     **/
    @RequestMapping("/changeTheStudent.do")
    @ResponseBody
    public int changeTheTeacher(Student student,UserLogin userLogin) {
        student.setCollegeId(collegeService.getCollegeByName(student.getCollegeId()).getCollegeId());
        userLogin.setUserId(student.getId());
        userLogin.setUserName(student.getName());
        int flag1 = studentService.changeTheStudent(student);
        int flag2 = userLoginService.changeName(userLogin);
        int flag = flag1+flag2;
        return flag;
    }
    /**
     * @Description:添加学生
     * @param:[student, userLogin, response]
     * @return:void
     **/
    @RequestMapping("/addTheStudent.do")
    @ResponseBody
    public int addTheStudent(Student student,UserLogin userLogin) {
        student.setCollegeId(collegeService.getCollegeByName(student.getCollegeId()).getCollegeId());
        userLogin.setUserName(student.getName());
        int flag1 = studentService.addStudent(student);
        int flag2 = userLoginService.addStudentUser(userLogin);
        int flag = flag1+flag2;
        return flag;
    }
    /**
     * @Description:删除学生
     * @param:[ids, response]
     * @return:void
     **/
    @RequestMapping("/delTheStudent.do")
    @ResponseBody
    public int delTheStudent(String ids) {
        String[] id = ids.split(",");
        List idsList = new ArrayList();
        for (int i=0;i<id.length;i++){
            idsList.add(i,id[i]);
        }
        selectedCourseService.delTheStudentCourse(idsList);
        int flag1 = studentService.delTheStudent(idsList);
        int flag2 = userLoginService.delTheUser(idsList);
        int flag = flag1+flag2;
        return flag;
    }
    /**
     * @Description:前往重置用户密码页
     * @param:[]
     * @return:java.lang.String
     **/
    @RequestMapping("/goToReSet.do")
    public String goToReSet(){
        return "reSetPwd";
    }
    /**
     * @Description:重置用户密码
     * @param:[userLogin, response]
     * @return:void
     **/
    @RequestMapping("/reSetThePwd.do")
    @ResponseBody
    public int reSetThePwd(UserLogin userLogin) {
        if("1".equals(userLogin.getRole())){
            userLogin.setPassword("111222");
        }else if("2".equals(userLogin.getRole())){
            userLogin.setPassword("111111");
        }
        int flag = userLoginService.reSetThePwd(userLogin);
        return flag;
    }
}
