using GreenCareBackend.Models;
using GreenCareBackend.Services.SReciclador;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace GreenCareGreenCareBackend.Services.SReciclador
{
    public class RecicladorService  : IRecicladorService
    {

        private readonly AppDbContext _dbContext;
        //private readonly AuthenticationStateProvider AuthenticationStateProvider;
        //string key = "SecurityKeyMultas202399898985652323255629595..,s,se-22Hash24533";

        public RecicladorService(AppDbContext dbContext)
        {
            _dbContext = dbContext;
        }
        private string PasswordHash(string password)
        {
            byte[] salt = new byte[16];
            new RNGCryptoServiceProvider().GetBytes(salt);

            var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 1000);
            byte[] hash = pbkdf2.GetBytes(20);

            byte[] hashBytes = new byte[36];
            Array.Copy(salt, 0, hashBytes, 0, 16);
            Array.Copy(hash, 0, hashBytes, 16, 20);
            return Convert.ToBase64String(hashBytes);
        }

        public bool ValidatePasswordHash(string password, string dbPassword)
        {
            byte[] dbPasswordHashBytes = Convert.FromBase64String(dbPassword);

            byte[] salt = new byte[16];
            Array.Copy(dbPasswordHashBytes, 0, salt, 0, 16);

            var userPasswordBytes = new Rfc2898DeriveBytes(password, salt, 1000);
            byte[] userPasswordHash = userPasswordBytes.GetBytes(20);

            for (int i = 0; i < 20; i++)
            {
                if (dbPasswordHashBytes[i + 16] != userPasswordHash[i])
                {
                    return false;
                }
            }
            return true;
        }

        public async Task<int> RegisterAsRecycler(Recycler recycler)
        {
            try
            {
                
                if (recycler == null)
                {
                    return 0;
                }

                if (string.IsNullOrEmpty(recycler.Name) || string.IsNullOrEmpty(recycler.Document) ||
                    string.IsNullOrEmpty(recycler.Email) || string.IsNullOrEmpty(recycler.Password))
                {
                    return 0;
                }

                Recycler reciclador = new Recycler
                {
                    Name = recycler.Name,
                    Email = recycler.Email,
                    Document = recycler.Document,
                    Password = PasswordHash(recycler.Password),
                    Role = "Reciclador"
                };

                _dbContext.Recyclers.Add(reciclador);
                await _dbContext.SaveChangesAsync();
                return 1;
            }
            catch (Exception ex)
            {
                // Captura cualquier excepción y retorna el error
                Console.WriteLine($"Error al registrarse: {ex}");
                return 0;
            }
        }

        public Task<bool> HistorialRutas(int idUser)
        {
            throw new NotImplementedException();
        }


    }
}
