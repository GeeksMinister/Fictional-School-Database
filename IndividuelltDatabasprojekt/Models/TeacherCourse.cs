using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace IndividuelltDatabasprojekt.Models
{
    [Keyless]
    [Table("TeacherCourse")]
    public partial class TeacherCourse
    {
        public int TeacherId { get; set; }
        public int CourseId { get; set; }

        [ForeignKey(nameof(CourseId))]
        public virtual Course Course { get; set; } = null!;
        [ForeignKey(nameof(TeacherId))]
        public virtual Staff Teacher { get; set; } = null!;
    }
}
