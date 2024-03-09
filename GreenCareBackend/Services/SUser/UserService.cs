
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using System.Security.Cryptography;
using GreenCareBackend.Models;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Text;
using Newtonsoft.Json;
using Microsoft.AspNetCore.Http.HttpResults;

namespace GreenCareBackend.Services.SUser
{
    public class UserService : IUserService
    {

        private readonly AppDbContext _dbContext;
        private readonly AuthenticationStateProvider AuthenticationStateProvider;
        string key = "SecurityKeyMultas202399898985652323255629595..,s,se-22Hash24533";

        public UserService(AppDbContext dbContext)
        {
            _dbContext = dbContext;
        }
        public Task<int> SingIn(string email, string pass)
        {
            throw new NotImplementedException();
        }

        public Task<int> SingOut()
        {
            throw new NotImplementedException();
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

        public async Task<(bool Success, string Message)> UserRegistrationAsync(Users user)
        {
            try
            {

                // Verificar que el objeto Users no sea nulo
                if (user == null)
                {
                    return (false, "Usuario nulo");
                }

                // Verificar que las propiedades requeridas no sean nulas o vacías
                if (string.IsNullOrEmpty(user.Name) || string.IsNullOrEmpty(user.LastName) ||
                    string.IsNullOrEmpty(user.Email) || string.IsNullOrEmpty(user.Password))
                {
                    return (false, "Campos incompletos");
                }

                // Crear una nueva instancia de Users y asignar valores
                Users newUser = new Users
                {
                    Name = user.Name,
                    LastName = user.LastName,
                    Email = user.Email,
                    Password = PasswordHash(user.Password), // Asumiendo que PasswordHash es un método válido
                    Role = "User"
                };

                // Agregar el nuevo usuario al contexto de la base de datos y guardar los cambios
                _dbContext.Users.Add(newUser);
                await _dbContext.SaveChangesAsync();

                // Retorna éxito y mensaje vacío si todo sale bien
                return (true, string.Empty);
            }
            catch (Exception ex)
            {
                // Captura cualquier excepción y retorna el error
                Console.WriteLine($"Error al registrarse: {ex}");
                return (false, "Error al registrar usuario");
            }
        }



        public async Task<string> UserLoginAsync(string? username, string? pass)
        {
            try
            {
                
                
                Users user = await _dbContext.Users.Where(c => c.Email.ToLower() == username).FirstOrDefaultAsync();

                if (user == null)
                {
                    Console.WriteLine($"Credenciales incorrectas");
                    return "Credenciales incorrectas";
                }

                if (string.IsNullOrEmpty(pass))
                {
                    Console.WriteLine("Debe ingresar contraseña");
                    return "Debe ingresar contraseña";
                }

                if (!ValidatePasswordHash(pass, user.Password))
                {
                    Console.WriteLine($"Contraseña incorrecta");
                    return "Contraseña incorrecta";
                }

                var tokenHandler = new JwtSecurityTokenHandler();
                var byteKey = Encoding.UTF8.GetBytes(key);

                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new Claim[]
                    {
                new Claim(ClaimTypes.Name, user.Name),
                new Claim("id", user.Id.ToString())
                    }),
                    Expires = DateTime.UtcNow.AddDays(7),
                    SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(byteKey), SecurityAlgorithms.HmacSha256Signature),
                };

                var token = tokenHandler.CreateToken(tokenDescriptor);
                var tokenString = tokenHandler.WriteToken(token);

                var response = new
                {
                    token = tokenString,
                    //id = user.id
                };

                // Convertir el objeto JSON a una cadena y devolverlo como respuesta
                return JsonConvert.SerializeObject(response);
            }
            catch (Exception)
            {
                Console.WriteLine($"No pueden ir nulos los campos al iniciar sesión");
                return "No pueden ir nulos los campos al iniciar sesión";
            }
        }



    }
}

