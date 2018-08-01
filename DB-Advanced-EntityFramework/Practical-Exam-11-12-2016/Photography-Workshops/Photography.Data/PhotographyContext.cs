using System.Data.Entity.ModelConfiguration.Conventions;
using Photography.Models;

namespace Photography.Data
{
    using System;
    using System.Data.Entity;
    using System.Linq;

    public class PhotographyContext : DbContext
    {
        public PhotographyContext()
            : base("name=PhotographyContext")
        {
        }
        public virtual DbSet<Accessory> Accessories { get; set; }

        public virtual DbSet<Camera> Cameras { get; set; }

        public virtual DbSet<Lens> Lenses { get; set; }

        public virtual DbSet<Photographer> Photographers { get; set; }

        public virtual DbSet<Workshop> Workshops { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {

            modelBuilder.Conventions.Remove<OneToManyCascadeDeleteConvention>();

            modelBuilder.Entity<Photographer>()
               .HasRequired(p => p.PrimaryCamera)
               .WithMany()
               .WillCascadeOnDelete(false);

            modelBuilder.Entity<Photographer>()
               .HasRequired(p => p.SecondaryCamera)
               .WithMany()
               .WillCascadeOnDelete(false);
        }
    }
}