
using MYPBackendMicroserviceIntegrations.Enums;

namespace MYPBackendMicroserviceIntegrations.Messages
{
    public class AccountMessage
    {
        public Guid Id { get; set; }
        public bool IsDeactivated { get; set; }
        public Guid CustomerId { get; set; }
        public DateTime DateCreated { get; set; }
        public Currency Currency { get; set; }
    }
}
