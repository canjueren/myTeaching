package teach.pojo;

import java.util.List;

/**
 * Created by mzh on 2018/10/10.
 */
public class Course {
    private String id;
    private String courseName;
    private String teacherId;
    private String courseTime;
    private String classRoom;
    private String classWeek;
    private String courseType;
    private String collegeId;
    private String score;

    private Teacher teacher;
    private List<SelectedCourse> selectedCourse;

    public Course() {
    }

    public Course(String id, String courseName, String teacherId, String courseTime, String classRoom,
                  String classWeek, String courseType, String collegeId, String score, Teacher teacher,
                  List<SelectedCourse> selectedCourse) {
        this.id = id;
        this.courseName = courseName;
        this.teacherId = teacherId;
        this.courseTime = courseTime;
        this.classRoom = classRoom;
        this.classWeek = classWeek;
        this.courseType = courseType;
        this.collegeId = collegeId;
        this.score = score;
        this.teacher = teacher;
        this.selectedCourse = selectedCourse;
    }

    public List<SelectedCourse> getSelectedCourse() {
        return selectedCourse;
    }

    public void setSelectedCourse(List<SelectedCourse> selectedCourse) {
        this.selectedCourse = selectedCourse;
    }

    public Teacher getTeacher() {
        return teacher;
    }

    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }

    public String getClassRoom() {
        return classRoom;
    }

    public void setClassRoom(String classRoom) {
        this.classRoom = classRoom;
    }

    public String getClassWeek() {
        return classWeek;
    }

    public void setClassWeek(String classWeek) {
        this.classWeek = classWeek;
    }

    public String getCollegeId() {
        return collegeId;
    }

    public void setCollegeId(String collegeId) {
        this.collegeId = collegeId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getCourseTime() {
        return courseTime;
    }

    public void setCourseTime(String courseTime) {
        this.courseTime = courseTime;
    }

    public String getCourseType() {
        return courseType;
    }

    public void setCourseType(String courseType) {
        this.courseType = courseType;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }
}
