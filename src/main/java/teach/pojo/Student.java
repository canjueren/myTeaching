package teach.pojo;

/**
 * Created by mzh on 2018/10/10.
 */
public class Student {
    private String id;
    private String name;
    private String sex;
    private String birthday;
    private String grade;
    private String collegeId;

    private College college;

    public Student() {
    }

    public Student(String birthday, College college, String collegeId, String grade, String id, String name, String sex) {
        this.birthday = birthday;
        this.college = college;
        this.collegeId = collegeId;
        this.grade = grade;
        this.id = id;
        this.name = name;
        this.sex = sex;
    }

    public String getBirthday() {
        return birthday;
    }

    public College getCollege() {
        return college;
    }

    public void setCollege(College college) {
        this.college = college;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getCollegeId() {
        return collegeId;
    }

    public void setCollegeId(String collegeId) {
        this.collegeId = collegeId;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }
}
