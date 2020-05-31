package teach.service;

import org.springframework.stereotype.Service;
import teach.dao.StudentDao;
import teach.pojo.Student;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by mzh on 2018/10/10.
 */
@Service
public class StudentServiceImpl implements StudentService {
    @Resource
    StudentDao studentDao;

    /*通过id查询学生信息*/
    public Student getStudentById(String id){
        return studentDao.getStudentById(id);
    }
    /*所有学生数量*/
    public int getAllCountStudent(){
        return studentDao.getAllCountStudent();
    }
    /*查询所有学生信息*/
    public List<Student> getAllStudent(Map<String,String> myMap){
        return studentDao.getAllStudent(myMap);
    }
    /*修改学生信息*/
    public int changeTheStudent(Student student){
        return studentDao.changeTheStudent(student);
    }
    /*添加学生*/
    public int addStudent(Student student){
        return studentDao.addStudent(student);
    }
    /*删除学生*/
    public int delTheStudent(List ids){
        return studentDao.delTheStudent(ids);
    }
    /*查询符合searchName相关模糊搜索的学生数量*/
    public int stuCountOfName(String searchName){
        return studentDao.stuCountOfName(searchName);
    }
    /*查询符合searchName相关模糊搜索的学生*/
    public  List<Student> getStudentOfName(Map<String,String> myMap){
        return studentDao.getStudentOfName(myMap);
    }
}
