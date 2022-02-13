using System;
using System.Collections.Generic;
using IndividuelltDatabasprojekt.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace IndividuelltDatabasprojekt.Data
{
    public partial class HappyValleyContext : DbContext
    {
        public HappyValleyContext()
        {
        }

        public HappyValleyContext(DbContextOptions<HappyValleyContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Course> Courses { get; set; } = null!;
        public virtual DbSet<English> Englishes { get; set; } = null!;
        public virtual DbSet<Models.Math> Maths { get; set; } = null!;
        public virtual DbSet<Programming> Programmings { get; set; } = null!;
        public virtual DbSet<RecentGrade> RecentGrades { get; set; } = null!;
        public virtual DbSet<Student> Students { get; set; } = null!;
        public virtual DbSet<TeacherCourse> TeacherCourses { get; set; } = null!;
        public virtual DbSet<Staff> Staff { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Server=(LocalDB)" +
                    "\\MSSQLLocalDB; AttachDbFilename=|DataDirectory|" +
                    "\\HappyValleyTestTwo.mdf; Integrated Security=True;" +
                    " Trusted_Connection=True");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<English>(entity =>
            {
                entity.Property(e => e.Grade).IsFixedLength();
            });

            modelBuilder.Entity<Models.Math>(entity =>
            {
                entity.Property(e => e.Grade).IsFixedLength();
            });

            modelBuilder.Entity<Programming>(entity =>
            {
                entity.Property(e => e.Grade).IsFixedLength();
            });

            modelBuilder.Entity<RecentGrade>(entity =>
            {
                entity.ToView("Recent Grades");

                entity.Property(e => e.Grade).IsFixedLength();
            });

            modelBuilder.Entity<Student>(entity =>
            {
                entity.Property(e => e.Ssn).IsFixedLength();
            });

            modelBuilder.Entity<TeacherCourse>(entity =>
            {
                entity.HasOne(d => d.Course)
                    .WithMany()
                    .HasForeignKey(d => d.CourseId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__TeacherCo__Cours__3D5E1FD2");

                entity.HasOne(d => d.Teacher)
                    .WithMany()
                    .HasForeignKey(d => d.TeacherId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__TeacherCo__Teach__3C69FB99");
            });

            modelBuilder.Entity<Staff>(entity =>
            {
                entity.Property(e => e.Ssn).IsFixedLength();
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
