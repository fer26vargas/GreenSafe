﻿namespace GreenCareBackend.Models
{
    public class Users
    {
        public int Id { get; set; }

        public string? Name { get; set; }
        public string? Email { get; set; }
        public string ?Password { get; set; }
        public string ?Role { get; set; }
        public string? LastName { get; set; }
        public Users()
        {
                
        }
        

    }
}
