package teach.service;

import org.springframework.stereotype.Service;
import teach.dao.UserLoginDao;
import teach.pojo.UserLogin;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by mzh on 2018/10/10.
 */
@Service
public class UserLoginServiceImpl implements UserLoginService {
    @Resource
    UserLoginDao userLoginDao;

    /*根据id和密码查询用户*/
    public UserLogin loginOn(UserLogin userLogin){
        return userLoginDao.loginOn(userLogin);
    }
    /*修改用户密码*/
    public void changePwd(UserLogin userLogin){
        userLoginDao.changePwd(userLogin);
    }
    /*修改用户名*/
    public int changeName(UserLogin userLogin){
        return userLoginDao.changeName(userLogin);
    }
    /*添加教师用户*/
    public int addTeacherUser(UserLogin userLogin){
        return userLoginDao.addTeacherUser(userLogin);
    }
    /*删除用户*/
    public int delTheUser(List ids){
        return userLoginDao.delTheUser(ids);
    }
    /*添加学生用户*/
    public int addStudentUser(UserLogin userLogin){
        return userLoginDao.addStudentUser(userLogin);
    }
    /*验证用户是否存在*/
    public List<UserLogin> checkTheUser(String userId){
        return userLoginDao.checkTheUser(userId);
    }
    /*重置用户密码*/
    public int reSetThePwd(UserLogin userLogin){
        return userLoginDao.reSetThePwd(userLogin);
    }
}
