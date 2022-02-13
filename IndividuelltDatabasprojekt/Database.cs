using IndividuelltDatabasprojekt.Data;
using IndividuelltDatabasprojekt.Models;

internal static class Database
{
    public static void CheckifDbExists()
    {
        if (!File.Exists("HappyValleyTestTwo.mdf"))
        {
            WriteLine("\n\n\n\n\t\tDatabase file wasn't found :(" +
                "\n\n\t\tPress 'Enter' to terminate");
            ReadKey();
            Environment.Exit(0);
        }
    } 
    public static void PrintMenu()
    {
        while (true)
        {
            Clear();
            Write($"\n\n\t\t\t\t* (( Welcome to Happy Valley School )) * \n\n\n" +
                "  [1] Registered staff as teachers \n\n" +
                "  [2] All students\n\n" +
                "  [3] Running courses\n\n" +
                "  [4] Update a student's information\n\n" +
                "  [5] Exit \n\n\n" +
                "   \t-Choose what you want to inquire:  ");
            int.TryParse(ReadLine(), out int option);
            switch (option)
            {
                case 1:
                    Clear();
                    ShowTeachers();
                    Redirecting();
                    break;
                case 2:
                    Clear();
                    ShowStudents();
                    Redirecting();
                    break;
                case 3:
                    Clear();
                    ShowCourses();
                    Redirecting();
                    break;
                case 4:
                    Clear();
                    UpdateStudentMenu();
                    Redirecting();
                    break;
                case 5:
                    Clear();
                    WriteLine("\n\n\n\n\t\tHave a wonderful day :-)");
                    Thread.Sleep(1800);
                    return;
                default:
                    WriteLine("\t\tInvalid input!   " +
                    "Please choose from 1 - 5\n");
                    ReadKey();
                    break;
            }
        }
    }

    private static void Redirecting()
    {
        Write("\n\n\n\t\tPress 'Enter' to return to the main menu");
        ReadLine();
    }

    private static void ShowTeachers()
    {
        try
        {
            using HappyValleyContext context = new HappyValleyContext();
            IQueryable<Staff> teachers = from staff in context.Staff
                                         where staff.Position == "Teacher"
                                         select staff;
            StringBuilder sb = new StringBuilder();
            foreach (Staff teacher in teachers)
            {
                sb.Clear();
                sb.Append(teacher.FirstName + "      ");
                sb.Append(teacher.LastName + "      ");
                sb.Append(teacher.Position + "      ");
                sb.Append(teacher.EmploymentDate + "      ");
                sb.Append(teacher.Ssn + "      ");
                sb.Append(teacher.Phone + "      ");
                sb.Append(teacher.Email + "      ");
                WriteLine($"\n\n\t[{teacher.Id}]      {sb} \n" +
                    $"     ________________________________________________________" +
                    $"______________________________________________________________" +
                    $"_________________");
            }
        }
        catch (Exception ex)
        {
            WriteLine(ex.Message);
        }
    }

    private static void ShowStudents()
    {
        try
        {
            using HappyValleyContext context = new HappyValleyContext();
            IQueryable<Student> students = from student in context.Students
                                           select student;
            StringBuilder sb = new StringBuilder();
            foreach (Student student in students)
            {
                sb.Clear();
                sb.Append(student.FirstName + "         ");
                sb.Append(student.LastName + "         ");
                sb.Append(student.Ssn + "         ");
                sb.Append(student.Class + "         ");
                sb.Append(student.Email + "         ");
                WriteLine($"\n\n\t[{student.Id}]      {sb} \n" +
                    $"     ________________________________________________________" +
                    $"______________________________________________________________");
            }
        }
        catch (Exception e)
        {
            WriteLine(e.Message);
        }
    }

    private static void ShowCourses()
    {
        try
        {
            using HappyValleyContext context = new HappyValleyContext();
            List<string> students = (from course in context.Courses
                                     select course.Name).ToList();
            for (int i = 0; i < students.Count; i++)
            {
                WriteLine($"\n\n\t[{i + 1}]  {students[i]}");
            }
        }
        catch (Exception ex)
        {
            WriteLine(ex.Message);
        }
    }

    private static int SelectStudent()
    {
        try
        {
            ShowStudents();
            using HappyValleyContext context = new HappyValleyContext();
            List<int> idList = (from student in context.Students
                                select student.Id).ToList();
            int selectedId = -1;
            while (!idList.Contains(selectedId))
            {
                Write("\n\n\tPlease enter an Id to proceed: ");
                int.TryParse(ReadLine(), out selectedId);
            }
            return selectedId;
        }
        catch(Exception ex)
        {
            WriteLine(ex.Message);
            return -1;
        }
    }

    private static void UpdateStudentMenu()
    {
        Clear();
        int studentId = SelectStudent();
        while (true)
        {
            Clear();
            Write($"\n\t\t\t  Update student information  \n\n\n" +
                "  [1] First or last name \n\n" +
                "  [2] Social security number\n\n" +
                "  [3] Class year\n\n" +
                "  [4] Email\n\n" +
                "  [5] Cancel\n\n\n" +
                "   \t-Choose the field you want to update:  ");
            int.TryParse(ReadLine(), out int option);
            switch (option)
            {
                case 1:
                    Clear();
                    UpdateStudentName(studentId);
                    return;
                case 2:
                    Clear();
                    UpdateStudentSnn(studentId);
                    return;
                case 3:
                    Clear();
                    UpdateStudentClass(studentId);
                    return;
                case 4:
                    Clear();
                    UpdateStudentEmail(studentId);
                    return;
                case 5:
                    return;
                default:
                    WriteLine("\t\tInvalid input!   " +
                    "Please choose from 1 - 5\n");
                    ReadKey();
                    break;
            }
        }
    }

    private static (string, string)StudentNameInput()
    {
        Clear();
        string firstName = string.Empty;
        string lastName = string.Empty;
        while (firstName.Length < 2 || firstName.Any(char.IsDigit))
        {
            Write("\n\n\tType in the first name: ");
            firstName = ReadLine().Trim();
        }
        while (lastName.Length < 2 || lastName.Any(char.IsDigit))
        {
            Write("\n\n\tType in the last name: ");
            lastName = ReadLine().Trim();
        }
        return (firstName, lastName);
        
    }

    private static void UpdateStudentName(int selectedId)
    {
        try 
        {
            using HappyValleyContext context = new HappyValleyContext();
            Student student = (from _student in context.Students
                               where _student.Id == selectedId
                               select _student).First();
            (student.FirstName, student.LastName) = StudentNameInput();
            context.SaveChanges();
            ReviewStudent(student);
        }
        catch (Exception ex)
        {
            WriteLine(ex.Message);
        }
        
    }
    private static void ReviewStudent(Student student)
    {
        WriteLine($"\n\n\n\t[{student.Id}]    {student.FirstName}  {student.LastName}" +
    $"    {student.Ssn}    {student.Class}    {student.Email}\n" +
    $"    _____________________________________________________________" +
    $"___________________________");
    }
    private static string StudentSsnInput()
    {
        string ssn = "1000000000";
        while (ssn == "1000000000" || ssn.ToString().Length != 10 ||
            ssn.Any(char.IsLetter))
        {
            Write("\n\n\tType in the SSN (10 digits):  ");
            ssn = ReadLine().Trim();
        }
        return ssn;
    }

    private static void UpdateStudentSnn(int selectedId)
    {
        try
        {
            using HappyValleyContext context = new HappyValleyContext();
            Student student = (from _student in context.Students
                               where _student.Id == selectedId
                               select _student).First();
            student.Ssn = StudentSsnInput();
            context.SaveChanges();
            ReviewStudent(student);
        }
        catch(Exception ex)
        {
            Write(ex.Message);
        }
    }

    private static void UpdateStudentClass(int selectedId)
    {
        try
        {
            HappyValleyContext context = new HappyValleyContext();
            int classesCount = (from _student in context.Students
                                select _student.Class).Distinct().Count();

            List<string> list = (from _student in context.Students
                                 select _student.Class).Distinct().ToList();
            for (int i = 0; i < classesCount; i++)
            {
                WriteLine($"\n\n\t[{i + 1}] {list[i]}");
            }
            SelectClass(list, out string className);
            Student student = (from _student in context.Students
                               where _student.Id == selectedId
                               select _student).First();
            student.Class = className;
            context.SaveChanges();
            ReviewStudent(student);
        }
        catch (Exception ex)
        {
            WriteLine(ex.Message);
        }
    }

    private static void SelectClass(List<string> list, out string className)
    {
        int choose = 0;
        while ((choose < 1) || (choose > list.Count))
        {
            Write("\n\n\tPlease choose a class: ");

            int.TryParse(ReadLine(), out choose);
        }
        className = list[choose - 1];
    }

    private static string StudentEmailInput()
    {
        Clear();
        string email = string.Empty;
        while (email.Length < 20 || !email.Contains("@happyvalley.com"))
        {
            Write("\n\n\t\t(Must contain \'@happyvalley.com\' )" +
                "\n\n\tType in an email:  ");
            email = ReadLine().Trim();
        }
        return email;
    }

    private static void UpdateStudentEmail(int selectedId)
    {
        try
        {
            using HappyValleyContext context = new HappyValleyContext();
            Student student = (from _student in context.Students
                               where _student.Id == selectedId
                               select _student).First();
            student.Email = StudentEmailInput();
            context.SaveChanges();
            ReviewStudent(student);
        }
        catch(Exception ex)
        {
            WriteLine(ex.Message);
        }
    }
}