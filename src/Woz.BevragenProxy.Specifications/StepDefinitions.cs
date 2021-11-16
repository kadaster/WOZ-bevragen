using FluentAssertions;
using System;
using System.Collections.Generic;
using System.Linq;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Woz.BevragenProxy.Domain;

namespace Woz.BevragenProxy.Specifications
{
    [Binding]
    public class StepDefinitions
    {
        DataTransferObjects.WozObject WozObject { get; set; }
        IEnumerable<DataTransferObjects.Waarde> actual { get; set; }

        [Given(@"een WOZ-object bevat geen waarden")]
        public void GivenEenWOZ_ObjectBevatGeenWaarden()
        {
            WozObject = new DataTransferObjects.WozObject
            {
                Waarden = null
            };
        }

        [Given(@"een WOZ-object bevat de volgende waarden")]
        public void GivenEenWOZ_ObjectBevatDeVolgendeWaarden(Table table)
        {
            WozObject = new DataTransferObjects.WozObject
            {
                Waarden = table.CreateSet<DataTransferObjects.Waarde>().ToList()
            };
        }

        [When(@"de relevante waarden zijn bepaald voor het WOZ-object")]
        public void WhenDeRelevanteWaardenZijnBepaaldVoorHetWOZ_Object()
        {
            actual = WozObject.Waarden.BepaalRelevanteWaarden();
        }

        [Then(@"bevat het WOZ-object geen waarden")]
        public void ThenBevatHetWOZ_ObjectGeenWaarden()
        {
            actual.Should().BeNull();
        }

        [Then(@"bevat het WOZ-object de volgende waarden")]
        public void ThenBevatHetWOZ_ObjectDeVolgendeWaarden(Table table)
        {
            actual.Should().BeEquivalentTo(table.CreateSet<DataTransferObjects.Waarde>());
        }

        [Then(@"heeft de waarden van het WOZ-object geen property indicatieBezwaarBeroep")]
        public void ThenHeeftDeWaardenVanHetWOZ_ObjectGeenProperty()
        {
            actual.All(x => x.IndicatieBezwaarBeroep == null).Should().BeTrue();
        }
    }
}
