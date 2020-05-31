package teach.dao;

import teach.pojo.Teacher;

import java.util.List;
import java.util.Map;

/**
 * Created by mzh on 2018/10/10.
 */
public interface TeacherDao {
    /*查询所有教师数量*/
    int getAllCountTeacher();
    /*查询所有教师信息*/
    List<Teacher> getAllTeacher(Map<String,String> myMap);
    /*查询所有教师id*/
    List<Teacher> findAllTeacherId();
    /*通过id查询教师*/
    Teacher getTheTeacher(String id);
    /*修改教师信息*/
    int changeTheTeacher(Teacher teacher);
    /*添加教师*/
    int addTeacher(Teacher teacher);
    /*删除教师*/
    int delTheTeacher(List ids);
    /*查询searchName模糊相关的所有教师数量*/
    int teaCountOfName(String searchName);
    /*查询searchName模糊相关的所有教师*/
    List<Teacher> getTeacherOfName(Map<String,String> myMap);
}
