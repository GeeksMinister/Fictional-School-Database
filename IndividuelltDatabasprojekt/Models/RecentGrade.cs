using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace IndividuelltDatabasprojekt.Models
{
    [Keyless]
    public partial class RecentGrade
    {
        public int StudentId { get; set; }
        [StringLength(101)]
        public string Student { get; set; } = null!;
        [StringLength(2)]
        [Unicode(false)]
        public string? Grade { get; set; }
        [StringLength(11)]
        [Unicode(false)]
        public string Subject { get; set; } = null!;
        [Column(TypeName = "date")]
        public DateTime? Date { get; set; }
        [StringLength(101)]
        public string Teacher { get; set; } = null!;
    }
}
