package teach.service;

import teach.pojo.College;

import java.util.List;

/**
 * Created by mzh on 2018/10/10.
 */
public interface CollegeService {
    /*通过id查询college*/
    College getCollegeById(String collegeId);
    /*查询所有college*/
    List<College> getAllCollege();
    /*通过学院名查询college*/
    College getCollegeByName(String collegeName);
}
