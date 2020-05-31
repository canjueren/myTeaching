package teach.service;

import teach.pojo.Student;

import java.util.List;
import java.util.Map;

/**
 * Created by mzh on 2018/10/10.
 */
public interface StudentService {
    /*通过id查询学生信息*/
    Student getStudentById(String id);
    /*所有学生数量*/
    int getAllCountStudent();
    /*查询所有学生信息*/
    List<Student> getAllStudent(Map<String,String> myMap);
    /*修改学生信息*/
    int changeTheStudent(Student student);
    /*添加学生*/
    int addStudent(Student student);
    /*删除学生*/
    int delTheStudent(List ids);
    /*查询符合searchName相关模糊搜索的学生数量*/
    int stuCountOfName(String searchName);
    /*查询符合searchName相关模糊搜索的学生*/
    List<Student> getStudentOfName(Map<String,String> myMap);
}
