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
                        retval.Add(waarde);
                    }
                }
                else
                {
                    if(waarde.Ingangsdatum > val.Ingangsdatum)
                    {
                        retval.Remove(val);
                        retval.Add(waarde);
                    }
                }
            }

            return retval.OrderByDescending(x => x.Waardepeildatum)
                         .ThenByDescending(x => x.Ingangsdatum);
        }
    }
}
