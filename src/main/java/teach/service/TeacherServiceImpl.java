package teach.service;

import org.springframework.stereotype.Service;
import teach.dao.TeacherDao;
import teach.pojo.Teacher;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by mzh on 2018/10/10.
 */
@Service
public class TeacherServiceImpl implements TeacherService {
    @Resource
    TeacherDao teacherDao;

    /*查询所有教师数量*/
    public int getAllCountTeacher(){
        return teacherDao.getAllCountTeacher();
    }
    /*查询所有教师信息*/
    public List<Teacher> getAllTeacher(Map<String,String> myMap){
        return teacherDao.getAllTeacher(myMap);
    }
    /*查询所有教师id*/
    public List<Teacher> findAllTeacherId(){
        return teacherDao.findAllTeacherId();
    }
    /*通过id查询教师*/
    public Teacher getTheTeacher(String id){
        return teacherDao.getTheTeacher(id);
    }
    /*修改教师信息*/
    public int changeTheTeacher(Teacher teacher){
        return teacherDao.changeTheTeacher(teacher);
    }
    /*添加教师*/
    public int addTeacher(Teacher teacher){
        return teacherDao.addTeacher(teacher);
    }
    /*删除教师*/
    public int delTheTeacher(List ids){
        return teacherDao.delTheTeacher(ids);
    }
    /*查询searchName模糊相关的所有教师数量*/
    public int teaCountOfName(String searchName){
        return teacherDao.teaCountOfName(searchName);
    }
    /*查询searchName模糊相关的所有教师*/
    public List<Teacher> getTeacherOfName(Map<String,String> myMap){
        return teacherDao.getTeacherOfName(myMap);
    }
}
