using GreenCareBackend.Models;
using Microsoft.EntityFrameworkCore;


public class AppDbContext : DbContext
{
    public DbSet<Users>? Users { get; set; }
    public DbSet<Recycler>? Recyclers { get; set; }
    
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        // ...
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            // Configura la cadena de conexión a tu base de datos PostgreSQL

            optionsBuilder.UseNpgsql("Host=localhost;Database=GreenCare;Username=postgres;Password=1098825894");
        }
}
