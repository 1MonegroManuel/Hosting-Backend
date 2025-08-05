using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;

namespace HostingServiceBackend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private static List<Usuario> usuarios = new List<Usuario>
        {
            new Usuario { Username = "manu", Password = "1234" },
            new Usuario { Username = "admin", Password = "admin123" },
            new Usuario { Username = "gaston", Password = "admin123" }
        };

        [HttpPost("login")]
        public IActionResult Login([FromBody] UsuarioLogin datos)
        {
            var user = usuarios.FirstOrDefault(u => u.Username == datos.Username && u.Password == datos.Password);
            if (user == null)
                return Unauthorized();

            return Ok(new { token = "token_falso_para_demo" });
        }
    }

    public class Usuario
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }

    public class UsuarioLogin
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }
}
