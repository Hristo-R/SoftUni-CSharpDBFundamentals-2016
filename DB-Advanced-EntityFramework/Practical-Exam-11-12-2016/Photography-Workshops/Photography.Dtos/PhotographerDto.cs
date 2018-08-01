using System.Collections.Generic;

namespace Photography.Dtos
{
    public class PhotographerDto
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Phone { get; set; }
        public IEnumerable<int> Lenses { get; set; }
    }
}