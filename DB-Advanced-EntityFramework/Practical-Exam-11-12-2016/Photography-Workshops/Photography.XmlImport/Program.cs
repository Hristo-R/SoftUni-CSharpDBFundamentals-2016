using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using Photography.Data;
using Photography.Models;

namespace Photography.XmlImport
{
    public class Program
    {
        private const string AccesoryPath = "../../../datasets/accessories.xml";
        private const string WorkshopPath = "../../../datasets/workshops.xml";

        static void Main()
        {
            UnitOfWork unit = new UnitOfWork();
            ImportAccesoaries(unit);
        }

        private static void ImportAccesoaries(UnitOfWork unit)
        {
            XDocument document = XDocument.Load(AccesoryPath);
            var accassoriesXmls = document.Descendants("accessory");
            foreach (XElement accassoriesXml in accassoriesXmls)
            {
                var accessoryAttr = accassoriesXml.Attribute("name");

                Accessory accessory = unit.Accessories.First();

                unit.Accessories.Add(accessory);
                unit.Commit();
                Console.WriteLine("Successfully imported!");
            }
        }
    }
}
