using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Photography.Models
{
    public class MirrorlessCamera : Camera
    {
        public MirrorlessCamera(string make, string model, bool? isFullFrameOrNot, int minIso, int? maxIso, string maxVideoResolution, int? maxFrameRate) 
            : base(make, model, isFullFrameOrNot, minIso, maxIso)
        {
            this.MaxVideoResolution = maxVideoResolution;
            this.MaxFrameRate = maxFrameRate;
        }

        [Required]
        public string MaxVideoResolution { get; set; }

        public int? MaxFrameRate  { get; set; }


    }
}