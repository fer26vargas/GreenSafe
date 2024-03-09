using GreenCareBackend.Models;
using GreenCareBackend.Services.SUser;
using Microsoft.AspNetCore.Mvc;

namespace GreenCare.Controllers
{
    public class UserController : ControllerBase
    {
        private readonly IUserService _userService;
        public UserController(IUserService userService)
        {
            _userService = userService;
        }


        [HttpPost("Register")]
        
        public async Task<ActionResult> Register([FromBody] Users userDto)
        {
            try
            {
                if (userDto == null || string.IsNullOrEmpty(userDto.Email) || string.IsNullOrEmpty(userDto.Password) || string.IsNullOrEmpty(userDto.Role) || string.IsNullOrEmpty(userDto.Name))
                {
                    return BadRequest("Campos incompletos");
                }

                var usuariocreado = await _userService.UserRegistrationAsync(userDto);

                if (usuariocreado.Success)
                {
                    return Ok("Usuario creado con éxito");
                }
                else
                {
                    return StatusCode(500, usuariocreado.Message);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en el controlador Register: {ex}");
                return StatusCode(500, "Error interno del servidor");
            }
        }


        //controlador IniciarSeSion
        [HttpPost("SingIn")]
        public async Task<ActionResult> SingIn([FromQuery] string email, string pass)
        {
            try
            {
                if (email != null && pass != null)
                {
                    var token = await _userService.UserLoginAsync(email, pass);
                    return Ok(token);
                } 
                else
                {
                    return BadRequest("Correo o contraseña incorrectos");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en el controlador SingIn: {ex}");
                return StatusCode(500, "Error interno del servidor");
            }
        }

    }
}
