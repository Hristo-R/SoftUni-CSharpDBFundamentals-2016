using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Photography.Models
{
    public class Photographer
    {
        public Photographer()
        {
            this.Lenses = new HashSet<Lens>();
            this.Accessories = new HashSet<Accessory>();
            this.ParticipateInWorkshops = new HashSet<Workshop>();
            this.TrainerInWorkshops = new HashSet<Workshop>();
        }

        public int Id { get; set; }

        [Required]
        public string FirstName { get; set; }

        [Required, MinLength(2), MaxLength(50)]
        public string LastName { get; set; }

        public string Phone { get; set; }

        [Required]
        public Camera PrimaryCamera { get; set; }

        public Camera SecondaryCamera { get; set; }

        public virtual ICollection<Lens> Lenses  { get; set; }

        public virtual ICollection<Accessory> Accessories { get; set; }

        public virtual ICollection<Workshop> ParticipateInWorkshops { get; set; }

        public virtual ICollection<Workshop> TrainerInWorkshops { get; set; }
    }
}
