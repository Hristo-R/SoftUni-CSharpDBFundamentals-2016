namespace Photography.Models
{
    public class Accessory
    {
        public int Id { get; set; }

        public bool Name { get; set; }

        public Photographer Owner { get; set; }
    }
}