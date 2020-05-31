package teach.service;

import org.springframework.stereotype.Service;
import teach.dao.CourseDao;
import teach.pojo.Course;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by mzh on 2018/10/10.
 */
@Service
public class CourseServiceImpl implements CourseService {
    @Resource
    CourseDao courseDao;

    /*查询教师用户自己的所有课程*/
    public List<Course> getTeacherCourses(Map<String,String> myMap){
        return courseDao.getTeacherCourses(myMap);
    }
    /*查询教师用户自己的所有课程的数量*/
    public int getTeachCourseCount(String teacherId){
        return courseDao.getTeachCourseCount(teacherId);
    }
    /*查询所有课程的数量*/
    public int getAllCountcourse(){
        return courseDao.getAllCountcourse();
    }
    /*查询符合searchName模糊查询的课程数量*/
    public int CourseCountOfName(String name){
        return courseDao.CourseCountOfName(name);
    }
    /*查询所有课程*/
    public  List<Course> getAllCourse(Map<String,String> myMap){
        return courseDao.getAllCourse(myMap);
    }
    /*查询符合searchName模糊查询的所有课程*/
    public List<Course> getCourseOfName(Map<String,String> myMap){
        return courseDao.getCourseOfName(myMap);
    }
    /*通过id查询课程*/
    public List<Course> getTheCourse(String courseId){
        return courseDao.getTheCourse(courseId);
    }
    /*修改课程信息*/
    public int changeTheCourse(Course course){
        return courseDao.changeTheCourse(course);
    }
    /*添加课程*/
    public int addTheCourse(Course course){
        return courseDao.addTheCourse(course);
    }
    /*删除课程*/
    public int delTheCourse(List ids){
        return courseDao.delTheCourse(ids);
    }
    /*管理员查询选中的教师（可以是多个）的课程*/
    public List<Course> findCouOfTeacher(List ids){
        return courseDao.findCouOfTeacher(ids);
    }
}
