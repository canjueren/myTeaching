package teach.service;

import org.springframework.stereotype.Service;
import teach.dao.CollegeDao;
import teach.pojo.College;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by mzh on 2018/10/10.
 */
@Service
public class CollegeServiceImpl implements CollegeService {
    @Resource
    CollegeDao collegeDao;
    /*通过id查询college*/
    public College getCollegeById(String collegeId){
        return collegeDao.getCollegeById(collegeId);
    }
    /*查询所有college*/
    public List<College> getAllCollege(){
        return collegeDao.getAllCollege();
    }
    /*通过学院名查询college*/
    public College getCollegeByName(String collegeName){
        return collegeDao.getCollegeByName(collegeName);
    }
}
