using GreenCareBackend.Models;
using System.Threading.Tasks;

namespace GreenCareBackend.Services.SUser
{
    public interface IUserService
    {
        Task<(bool Success, string Message)> UserRegistrationAsync(Users user);
        
        Task<string> UserLoginAsync(string username, string pass);
        bool ValidatePasswordHash(string password, string dbpassword);
        Task<int> SingIn(string email, string pass);
        Task<int> SingOut();

    }
}
