package teach.service;

import teach.pojo.Course;

import java.util.List;
import java.util.Map;

/**
 * Created by mzh on 2018/10/10.
 */
public interface CourseService {
    /*查询教师用户自己的所有课程*/
    List<Course> getTeacherCourses(Map<String,String> myMap);
    /*查询教师用户自己的所有课程的数量*/
    int getTeachCourseCount(String teacherId);
    /*查询所有课程的数量*/
    int getAllCountcourse();
    /*查询符合searchName模糊查询的课程数量*/
    int CourseCountOfName(String name);
    /*查询所有课程*/
    List<Course> getAllCourse(Map<String,String> myMap);
    /*查询符合searchName模糊查询的所有课程*/
    List<Course> getCourseOfName(Map<String,String> myMap);
    /*通过id查询课程*/
    List<Course> getTheCourse(String courseId);
    /*修改课程信息*/
    int changeTheCourse(Course course);
    /*添加课程*/
    int addTheCourse(Course course);
    /*删除课程*/
    int delTheCourse(List ids);
    /*管理员查询选中的教师（可以是多个）的课程*/
    List<Course> findCouOfTeacher(List ids);
}
