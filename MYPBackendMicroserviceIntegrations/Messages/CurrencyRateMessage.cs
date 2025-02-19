using MYPBackendMicroserviceIntegrations.Enums;

namespace MYPBackendMicroserviceIntegrations.Messages
{
    public class CurrencyRateMessage
    {
        public Currency BaseCurrency { get; set; }
        public Dictionary<string, decimal> Rates { get; set; }
        public DateTime Date { get; set; }
    }
}
