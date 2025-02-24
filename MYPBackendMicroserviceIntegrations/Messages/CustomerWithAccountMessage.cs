
namespace MYPBackendMicroserviceIntegrations.Messages
{
    public class CustomerWithAccountMessage
    {
        CustomerMessage Customer { get; set; }
        AccountMessage Account { get; set; }
    }
}
