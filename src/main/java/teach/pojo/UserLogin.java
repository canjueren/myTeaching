package teach.pojo;

/**
 * Created by mzh on 2018/10/10.
 */
public class UserLogin {
    private String userId;
    private String userName;
    private String password;
    private String role;

    public UserLogin() {
    }

    public UserLogin(String userId, String userName, String password, String role) {
        this.password = password;
        this.role = role;
        this.userId = userId;
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
