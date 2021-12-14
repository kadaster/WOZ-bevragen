using System.Collections.Generic;
using System.Linq;
using Woz.BevragenProxy.DataTransferObjects;

namespace Woz.BevragenProxy.Domain
{
    public static class WaardeLogic
    {
        public static IEnumerable<Waarde> BepaalRelevanteWaarden(this IEnumerable<Waarde> waarden)
        {
            if(waarden == null)
            {
                return null;
            }

            var retval = new List<Waarde>();
            foreach(var waarde in waarden.OrderByDescending(x => x.Waardepeildatum)
                                         .ThenByDescending(x => x.Ingangsdatum))
            {
                var val = retval.SingleOrDefault(x => x.Waardepeildatum == waarde.Waardepeildatum);
                if(val == null)
                {
                    if(!waarde.BeschikkingsStatussen.All(x => x == StatusBeschikkingEnum.Beschikking_vernietigd))
                    {
                        waarde.ZetIndicatieBezwaarBeroep();
                        waarde.ResetNietRelevanteProperties();
                        retval.Add(waarde);
                    }
                }
                else
                {
                    if(waarde.Ingangsdatum > val.Ingangsdatum)
                    {
                        retval.Remove(val);
                        waarde.ZetIndicatieBezwaarBeroep();
                        waarde.ResetNietRelevanteProperties();
                        retval.Add(waarde);
                    }
                }
            }

            return retval.OrderByDescending(x => x.Waardepeildatum);
        }

        public static void ZetIndicatieBezwaarBeroep(this Waarde waarde)
        {
            if(waarde.BeschikkingsStatussen.Any(x => x is StatusBeschikkingEnum.Bezwaar_ingediend
                                                       or StatusBeschikkingEnum.Beroep_aangetekend
                                                       or StatusBeschikkingEnum.Hoger_beroep_aangetekend
                                                       or StatusBeschikkingEnum.Cassatie_ingesteld))
            {
                waarde.IndicatieBezwaarBeroep = true;
            }
        }

        public static void ResetNietRelevanteProperties(this Waarde waarde)
        {
            waarde.Ingangsdatum = null;
            waarde.BeschikkingsStatussen = null;
        }
    }
}
