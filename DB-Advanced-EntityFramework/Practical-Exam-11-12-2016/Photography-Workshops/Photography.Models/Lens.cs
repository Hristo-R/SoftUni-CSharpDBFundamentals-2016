namespace Photography.Models
{
    public class Lens
    {
        public int Id { get; set; }

        public string Make { get; set; }

        public int FocalLength { get; set; }

        public double MaxAperture { get; set; }

        public Camera CompatibleWith { get; set; }

        public Photographer Owner { get; set; }
    }
}