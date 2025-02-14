﻿
using MYPBackendMicroserviceIntegrations.Enums;

namespace MYPBackendMicroserviceIntegrations.Messages
{
    public class CustomerMessage
    {
        public Guid Id { get; set; }
        public bool IsDeactivated { get; set; }
        public Role Role { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public DateOnly BirthDate { get; set; }
        public DateTime? CustomVipDueDate { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }
}
