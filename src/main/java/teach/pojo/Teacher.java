package teach.pojo;

/**
 * Created by mzh on 2018/10/10.
 */
public class Teacher {
    private String id;
    private String name;
    private String sex;
    private String birthday;
    private String degree;
    private String title;
    private String grade;
    private String collegeId;

    private College college
            ;
    public Teacher() {
    }

    public Teacher(String birthday, College college, String collegeId, String degree, String grade,
                   String id, String name, String sex, String title) {
        this.birthday = birthday;
        this.college = college;
        this.collegeId = collegeId;
        this.degree = degree;
        this.grade = grade;
        this.id = id;
        this.name = name;
        this.sex = sex;
        this.title = title;
    }

    public College getCollege() {
        return college;
    }

    public void setCollege(College college) {
        this.college = college;
    }

    public String getBirthday() {
        return birthday;
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

    public String getDegree() {
        return degree;
    }

    public void setDegree(String degree) {
        this.degree = degree;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
