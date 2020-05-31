package teach.service;

import org.springframework.stereotype.Service;
import teach.dao.SelectedCourseDao;
import teach.pojo.SelectedCourse;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by mzh on 2018/10/10.
 */
@Service
public class SelectedCourseServiceImpl implements SelectedCourseService {
    @Resource
    SelectedCourseDao selectedCourseDao;

    /*查询选某门课的学生*/
    public List<SelectedCourse> stuOfMyCourse(Map<String,String> myMap){
        return selectedCourseDao.stuOfMyCourse(myMap);
    }
    /*查询选某门课的学生数量*/
    public int getTotalStuOfCourse(String courseId){
        return selectedCourseDao.getTotalStuOfCourse(courseId);
    }
    /*打分*/
    public void upScore(SelectedCourse selectedCourse){
        selectedCourseDao.upScore(selectedCourse);
    }
    /*查询已选课程*/
    public List<SelectedCourse> SelectMySel(Map<String,String> myMap){
        return selectedCourseDao.SelectMySel(myMap);
    }
    /*查询已修课程*/
    public List<SelectedCourse> SelectMyGet(Map<String,String> myMap){
        return selectedCourseDao.SelectMyGet(myMap);
    }
    /*查询已选课程数量*/
    public int SelectMySelTotal(String studentId){
        return selectedCourseDao.SelectMySelTotal(studentId);
    }
    /*查询已修课程数量*/
    public int SelectMyGetTotal(String studentId){
        return selectedCourseDao.SelectMyGetTotal(studentId);
    }
    /*退课*/
    public void outTheCourse(SelectedCourse selectedCourse){
        selectedCourseDao.outTheCourse(selectedCourse);
    }
    /*查询是否已选这门课程*/
    public SelectedCourse findInTheSelCou(SelectedCourse selectedCourse){
        return selectedCourseDao.findInTheSelCou(selectedCourse);
    }
    /*选课*/
    public int chooseTheCourse(SelectedCourse selectedCourse){
        return selectedCourseDao.chooseTheCourse(selectedCourse);
    }
    /*查询选某些课的学生*/
    public List<SelectedCourse> findStuOfCourse(List ids){
        return selectedCourseDao.findStuOfCourse(ids);
    }
    /*删除所选学生的选课和修课信息*/
    public void delTheStudentCourse(List ids){
        selectedCourseDao.delTheStudentCourse(ids);
    }
    /*查询选某门课的学生id*/
    public List<SelectedCourse> getAllStuOfCouId(String courseId){
        return selectedCourseDao.getAllStuOfCouId(courseId);
    }
}
