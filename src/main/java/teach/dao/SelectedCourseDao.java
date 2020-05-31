package teach.dao;

import teach.pojo.SelectedCourse;

import java.util.List;
import java.util.Map;

/**
 * Created by mzh on 2018/10/10.
 */
public interface SelectedCourseDao {
    /*查询选某门课的学生*/
    List<SelectedCourse> stuOfMyCourse(Map<String,String> myMap);
    /*查询选某门课的学生数量*/
    int getTotalStuOfCourse(String courseId);
    /*打分*/
    void upScore(SelectedCourse selectedCourse);
    /*查询已选课程*/
    List<SelectedCourse> SelectMySel(Map<String,String> myMap);
    /*查询已修课程*/
    List<SelectedCourse> SelectMyGet(Map<String,String> myMap);
    /*查询已选课程数量*/
    int SelectMySelTotal(String studentId);
    /*查询已修课程数量*/
    int SelectMyGetTotal(String studentId);
    /*退课*/
    void outTheCourse(SelectedCourse selectedCourse);
    /*查询是否已选这门课程*/
    SelectedCourse findInTheSelCou(SelectedCourse selectedCourse);
    /*选课*/
    int chooseTheCourse(SelectedCourse selectedCourse);
    /*查询选某些课的学生*/
    List<SelectedCourse> findStuOfCourse(List ids);
    /*删除所选学生的选课和修课信息*/
    void delTheStudentCourse(List ids);
    /*查询选某门课的学生*/
    List<SelectedCourse> getAllStuOfCouId(String courseId);
}
