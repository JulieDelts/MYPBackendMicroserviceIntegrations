
namespace MYPBackendMicroserviceIntegrations.Messages
{
    public class CustomerWithAccountMessage
    {
        public CustomerMessage Customer { get; set; }
        public AccountMessage Account { get; set; }
    }
}
