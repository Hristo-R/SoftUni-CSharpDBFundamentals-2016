using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Security.AccessControl;
using System.Text;
using System.Threading.Tasks;

namespace Photography.Models
{
    public class Camera
    {
        public Camera(string make, string model, bool? isFullFrameOrNot, int minIso, int? maxIso)
        {
            this.Make = make;
            this.Model = model;
            this.IsFullFrameOrNot = isFullFrameOrNot;
            this.MinIso = minIso;
            this.MaxIso = maxIso;
        }

        public int Id { get; set; }

        [Required]
        public string Make { get; set; }

        [Required]
        public string Model { get; set; }

        public bool? IsFullFrameOrNot { get; set; }

        [Required]
        public int MinIso { get; set; }
        
        public int? MaxIso { get; set; }
    }
}
