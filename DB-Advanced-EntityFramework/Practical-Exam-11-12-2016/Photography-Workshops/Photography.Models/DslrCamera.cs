using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Photography.Models
{
    public class DslrCamera : Camera
    {
        public DslrCamera(string make, string model, bool? isFullFrameOrNot, int minIso, int? maxIso, int? maxShutterSpeed) 
            : base(make, model, isFullFrameOrNot, minIso, maxIso)
        {
            this.MaxShutterSpeed = maxShutterSpeed;
        }

        public int? MaxShutterSpeed { get; set; }
    }
}
