package teach.service;

import teach.pojo.UserLogin;

import java.util.List;

/**
 * Created by mzh on 2018/10/10.
 */
public interface UserLoginService {
    /*根据id和密码查询用户*/
    UserLogin loginOn(UserLogin userLogin);
    /*修改用户密码*/
    void changePwd(UserLogin userLogin);
    /*修改用户名*/
    int changeName(UserLogin userLogin);
    /*添加教师用户*/
    int addTeacherUser(UserLogin userLogin);
    /*删除用户*/
    int delTheUser(List ids);
    /*添加学生用户*/
    int addStudentUser(UserLogin userLogin);
    /*验证用户是否存在*/
    List<UserLogin> checkTheUser(String userId);
    /*重置用户密码*/
    int reSetThePwd(UserLogin userLogin);
}
