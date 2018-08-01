using System;
using System.Collections.Generic;
using System.IO;
using AutoMapper;
using Newtonsoft.Json;
using Photography.Data;
using Photography.Dtos;
using Photography.Models;

namespace Photography.ImportJson
{
    public class Program
    {
        private const string LensesPath = "../../../datasets/lenses.json";
        private const string CamerasPath = "../../../datasets/cameras.json";
        private const string PhotographersPath = "../../../datasets/photographers.json";

        public static void Main()
        {
            //PhotographyContext context = new PhotographyContext();
            //context.Database.Initialize(true);

            UnitOfWork unit = new UnitOfWork();
            ConfigureMapping(unit);
            ImportSolarSystems(unit);
        }

        private static void ImportSolarSystems(UnitOfWork unit)
        {
            string json = File.ReadAllText(LensesPath);
            IEnumerable<LensDto> lensDtos = JsonConvert.DeserializeObject<IEnumerable<LensDto>>(json);
            foreach (var lensDto in lensDtos)
            {
                Lens lens = Mapper.Map<Lens>(lensDto);
                unit.Lenses.Add(lens);
                unit.Commit();
                Console.WriteLine($"Successfully imported {lens.Make} {lens.FocalLength}mm f{lens.MaxAperture:F1}");
            }
        }

        private static void ConfigureMapping(UnitOfWork unit)
        {
            Mapper.Initialize(config =>
            {
                config.CreateMap<LensDto, Lens>();
            });
        }
    }
}