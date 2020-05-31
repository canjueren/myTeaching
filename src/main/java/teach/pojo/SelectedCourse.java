package teach.pojo;

/**
 * Created by Administrator on 2018/10/10.
 */
public class SelectedCourse {
    private String courseId;
    private String studentId;
    private String mark;

    private Student student;
    private Course course;

    public SelectedCourse() {
    }

    public SelectedCourse(String courseId, String mark, Student student, String studentId, Course course) {
        this.courseId = courseId;
        this.mark = mark;
        this.student = student;
        this.studentId = studentId;
        this.course = course;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
}
