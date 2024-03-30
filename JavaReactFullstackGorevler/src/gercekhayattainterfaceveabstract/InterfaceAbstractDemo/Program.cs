using InterfaceAbstractDemo.Abstracts;
using InterfaceAbstractDemo.Adapters;
using InterfaceAbstractDemo.Concretes;
using InterfaceAbstractDemo.Entities;

namespace InterfaceAbstractDemo
{
    internal class Program
    {
        static void Main(string[] args)
        {
            BaseCustomerManager customerManager = new NeroCustomerManager(new MernisServiceAdapter());
            customerManager.Save(new Customer { DateOfBirth = new DateTime(1985,1,6), FirstName = "Engin", LastName = "Demiroğ", NationalityId = "11111111111"});

            Console.ReadLine();
        }
    }
}
