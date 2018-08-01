namespace Photography.Data
{
    using Interfaces;
    using Models;

    public class UnitOfWork : IUnitOfWork
    {
        private PhotographyContext context;

        private IRepository<Accessory> accessories;
        private IRepository<Camera> cameras;
        private IRepository<Lens> lenses;
        private IRepository<Photographer> photographers;
        private IRepository<Workshop> workshops;

        public UnitOfWork()
        {
            this.context = new PhotographyContext();
        }

        public IRepository<Accessory> Accessories => this.accessories ?? (this.accessories = new Repository<Accessory>(this.context.Accessories));

        public IRepository<Camera> Cameras => this.cameras ?? (this.cameras = new Repository<Camera>(this.context.Cameras));

        public IRepository<Photographer> Photographers => this.photographers ?? (this.photographers = new Repository<Photographer>(this.context.Photographers));

        public IRepository<Lens> Lenses => this.lenses ?? (this.lenses = new Repository<Lens>(this.context.Lenses));

        public IRepository<Workshop> Workshops => this.workshops ?? (this.workshops = new Repository<Workshop>(this.context.Workshops));

        public void Commit()
        {
            this.context.SaveChanges();
        }
    }
}