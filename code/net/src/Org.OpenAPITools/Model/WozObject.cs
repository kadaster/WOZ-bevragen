/* 
 * Waardering onroerende zaken
 *
 * Deze API levert actuele gegevens over WOZ-objecten 
 *
 * The version of the OpenAPI document: 1.0.0
 * 
 * Generated by: https://github.com/openapitools/openapi-generator.git
 */

using System;
using System.Linq;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Runtime.Serialization;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System.ComponentModel.DataAnnotations;
using OpenAPIDateConverter = Org.OpenAPITools.Client.OpenAPIDateConverter;

namespace Org.OpenAPITools.Model
{
    /// <summary>
    /// WozObject
    /// </summary>
    [DataContract]
    public partial class WozObject :  IEquatable<WozObject>, IValidatableObject
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="WozObject" /> class.
        /// </summary>
        /// <param name="aanduiding">aanduiding.</param>
        /// <param name="adresseerbaarObjectIdentificaties">BAG identificaties van verblijfsobjecten, standplaatsen en ligplaatsen die aan dit WOZ-object verbonden zijn..</param>
        /// <param name="belanghebbendeEigenaar">belanghebbendeEigenaar.</param>
        /// <param name="belanghebbendeGebruiker">belanghebbendeGebruiker.</param>
        /// <param name="grondoppervlakte">De oppervlakte grond in vierkante meters die behoort tot het WOZ-object..</param>
        /// <param name="identificatie">Unieke identificatie van het WOZ-object.</param>
        /// <param name="kadastraalOnroerendeZaakIdentificaties">De kadastraal onroerende zaken die geheel of gedeeltelijk deel uitmaken van het WOZ-object.</param>
        /// <param name="pandIdentificaties">pandIdentificaties.</param>
        /// <param name="verantwoordelijkeGemeente">verantwoordelijkeGemeente.</param>
        /// <param name="waarden">waarden.</param>
        public WozObject(ObjectAanduiding aanduiding = default(ObjectAanduiding), List<string> adresseerbaarObjectIdentificaties = default(List<string>), BelanghebbendeEigenaar belanghebbendeEigenaar = default(BelanghebbendeEigenaar), Belanghebbende belanghebbendeGebruiker = default(Belanghebbende), int grondoppervlakte = default(int), string identificatie = default(string), List<string> kadastraalOnroerendeZaakIdentificaties = default(List<string>), List<string> pandIdentificaties = default(List<string>), Waardetabel verantwoordelijkeGemeente = default(Waardetabel), List<Waarde> waarden = default(List<Waarde>))
        {
            this.Aanduiding = aanduiding;
            this.AdresseerbaarObjectIdentificaties = adresseerbaarObjectIdentificaties;
            this.BelanghebbendeEigenaar = belanghebbendeEigenaar;
            this.BelanghebbendeGebruiker = belanghebbendeGebruiker;
            this.Grondoppervlakte = grondoppervlakte;
            this.Identificatie = identificatie;
            this.KadastraalOnroerendeZaakIdentificaties = kadastraalOnroerendeZaakIdentificaties;
            this.PandIdentificaties = pandIdentificaties;
            this.VerantwoordelijkeGemeente = verantwoordelijkeGemeente;
            this.Waarden = waarden;
        }
        
        /// <summary>
        /// Gets or Sets Aanduiding
        /// </summary>
        [DataMember(Name="aanduiding", EmitDefaultValue=false)]
        public ObjectAanduiding Aanduiding { get; set; }

        /// <summary>
        /// BAG identificaties van verblijfsobjecten, standplaatsen en ligplaatsen die aan dit WOZ-object verbonden zijn.
        /// </summary>
        /// <value>BAG identificaties van verblijfsobjecten, standplaatsen en ligplaatsen die aan dit WOZ-object verbonden zijn.</value>
        [DataMember(Name="adresseerbaarObjectIdentificaties", EmitDefaultValue=false)]
        public List<string> AdresseerbaarObjectIdentificaties { get; set; }

        /// <summary>
        /// Gets or Sets BelanghebbendeEigenaar
        /// </summary>
        [DataMember(Name="belanghebbendeEigenaar", EmitDefaultValue=false)]
        public BelanghebbendeEigenaar BelanghebbendeEigenaar { get; set; }

        /// <summary>
        /// Gets or Sets BelanghebbendeGebruiker
        /// </summary>
        [DataMember(Name="belanghebbendeGebruiker", EmitDefaultValue=false)]
        public Belanghebbende BelanghebbendeGebruiker { get; set; }

        /// <summary>
        /// De oppervlakte grond in vierkante meters die behoort tot het WOZ-object.
        /// </summary>
        /// <value>De oppervlakte grond in vierkante meters die behoort tot het WOZ-object.</value>
        [DataMember(Name="grondoppervlakte", EmitDefaultValue=false)]
        public int Grondoppervlakte { get; set; }

        /// <summary>
        /// Unieke identificatie van het WOZ-object
        /// </summary>
        /// <value>Unieke identificatie van het WOZ-object</value>
        [DataMember(Name="identificatie", EmitDefaultValue=false)]
        public string Identificatie { get; set; }

        /// <summary>
        /// De kadastraal onroerende zaken die geheel of gedeeltelijk deel uitmaken van het WOZ-object
        /// </summary>
        /// <value>De kadastraal onroerende zaken die geheel of gedeeltelijk deel uitmaken van het WOZ-object</value>
        [DataMember(Name="kadastraalOnroerendeZaakIdentificaties", EmitDefaultValue=false)]
        public List<string> KadastraalOnroerendeZaakIdentificaties { get; set; }

        /// <summary>
        /// Gets or Sets PandIdentificaties
        /// </summary>
        [DataMember(Name="pandIdentificaties", EmitDefaultValue=false)]
        public List<string> PandIdentificaties { get; set; }

        /// <summary>
        /// Gets or Sets VerantwoordelijkeGemeente
        /// </summary>
        [DataMember(Name="verantwoordelijkeGemeente", EmitDefaultValue=false)]
        public Waardetabel VerantwoordelijkeGemeente { get; set; }

        /// <summary>
        /// Gets or Sets Waarden
        /// </summary>
        [DataMember(Name="waarden", EmitDefaultValue=false)]
        public List<Waarde> Waarden { get; set; }

        /// <summary>
        /// Returns the string presentation of the object
        /// </summary>
        /// <returns>String presentation of the object</returns>
        public override string ToString()
        {
            var sb = new StringBuilder();
            sb.Append("class WozObject {\n");
            sb.Append("  Aanduiding: ").Append(Aanduiding).Append("\n");
            sb.Append("  AdresseerbaarObjectIdentificaties: ").Append(AdresseerbaarObjectIdentificaties).Append("\n");
            sb.Append("  BelanghebbendeEigenaar: ").Append(BelanghebbendeEigenaar).Append("\n");
            sb.Append("  BelanghebbendeGebruiker: ").Append(BelanghebbendeGebruiker).Append("\n");
            sb.Append("  Grondoppervlakte: ").Append(Grondoppervlakte).Append("\n");
            sb.Append("  Identificatie: ").Append(Identificatie).Append("\n");
            sb.Append("  KadastraalOnroerendeZaakIdentificaties: ").Append(KadastraalOnroerendeZaakIdentificaties).Append("\n");
            sb.Append("  PandIdentificaties: ").Append(PandIdentificaties).Append("\n");
            sb.Append("  VerantwoordelijkeGemeente: ").Append(VerantwoordelijkeGemeente).Append("\n");
            sb.Append("  Waarden: ").Append(Waarden).Append("\n");
            sb.Append("}\n");
            return sb.ToString();
        }
  
        /// <summary>
        /// Returns the JSON string presentation of the object
        /// </summary>
        /// <returns>JSON string presentation of the object</returns>
        public virtual string ToJson()
        {
            return Newtonsoft.Json.JsonConvert.SerializeObject(this, Newtonsoft.Json.Formatting.Indented);
        }

        /// <summary>
        /// Returns true if objects are equal
        /// </summary>
        /// <param name="input">Object to be compared</param>
        /// <returns>Boolean</returns>
        public override bool Equals(object input)
        {
            return this.Equals(input as WozObject);
        }

        /// <summary>
        /// Returns true if WozObject instances are equal
        /// </summary>
        /// <param name="input">Instance of WozObject to be compared</param>
        /// <returns>Boolean</returns>
        public bool Equals(WozObject input)
        {
            if (input == null)
                return false;

            return 
                (
                    this.Aanduiding == input.Aanduiding ||
                    (this.Aanduiding != null &&
                    this.Aanduiding.Equals(input.Aanduiding))
                ) && 
                (
                    this.AdresseerbaarObjectIdentificaties == input.AdresseerbaarObjectIdentificaties ||
                    this.AdresseerbaarObjectIdentificaties != null &&
                    input.AdresseerbaarObjectIdentificaties != null &&
                    this.AdresseerbaarObjectIdentificaties.SequenceEqual(input.AdresseerbaarObjectIdentificaties)
                ) && 
                (
                    this.BelanghebbendeEigenaar == input.BelanghebbendeEigenaar ||
                    (this.BelanghebbendeEigenaar != null &&
                    this.BelanghebbendeEigenaar.Equals(input.BelanghebbendeEigenaar))
                ) && 
                (
                    this.BelanghebbendeGebruiker == input.BelanghebbendeGebruiker ||
                    (this.BelanghebbendeGebruiker != null &&
                    this.BelanghebbendeGebruiker.Equals(input.BelanghebbendeGebruiker))
                ) && 
                (
                    this.Grondoppervlakte == input.Grondoppervlakte ||
                    (this.Grondoppervlakte != null &&
                    this.Grondoppervlakte.Equals(input.Grondoppervlakte))
                ) && 
                (
                    this.Identificatie == input.Identificatie ||
                    (this.Identificatie != null &&
                    this.Identificatie.Equals(input.Identificatie))
                ) && 
                (
                    this.KadastraalOnroerendeZaakIdentificaties == input.KadastraalOnroerendeZaakIdentificaties ||
                    this.KadastraalOnroerendeZaakIdentificaties != null &&
                    input.KadastraalOnroerendeZaakIdentificaties != null &&
                    this.KadastraalOnroerendeZaakIdentificaties.SequenceEqual(input.KadastraalOnroerendeZaakIdentificaties)
                ) && 
                (
                    this.PandIdentificaties == input.PandIdentificaties ||
                    this.PandIdentificaties != null &&
                    input.PandIdentificaties != null &&
                    this.PandIdentificaties.SequenceEqual(input.PandIdentificaties)
                ) && 
                (
                    this.VerantwoordelijkeGemeente == input.VerantwoordelijkeGemeente ||
                    (this.VerantwoordelijkeGemeente != null &&
                    this.VerantwoordelijkeGemeente.Equals(input.VerantwoordelijkeGemeente))
                ) && 
                (
                    this.Waarden == input.Waarden ||
                    this.Waarden != null &&
                    input.Waarden != null &&
                    this.Waarden.SequenceEqual(input.Waarden)
                );
        }

        /// <summary>
        /// Gets the hash code
        /// </summary>
        /// <returns>Hash code</returns>
        public override int GetHashCode()
        {
            unchecked // Overflow is fine, just wrap
            {
                int hashCode = 41;
                if (this.Aanduiding != null)
                    hashCode = hashCode * 59 + this.Aanduiding.GetHashCode();
                if (this.AdresseerbaarObjectIdentificaties != null)
                    hashCode = hashCode * 59 + this.AdresseerbaarObjectIdentificaties.GetHashCode();
                if (this.BelanghebbendeEigenaar != null)
                    hashCode = hashCode * 59 + this.BelanghebbendeEigenaar.GetHashCode();
                if (this.BelanghebbendeGebruiker != null)
                    hashCode = hashCode * 59 + this.BelanghebbendeGebruiker.GetHashCode();
                if (this.Grondoppervlakte != null)
                    hashCode = hashCode * 59 + this.Grondoppervlakte.GetHashCode();
                if (this.Identificatie != null)
                    hashCode = hashCode * 59 + this.Identificatie.GetHashCode();
                if (this.KadastraalOnroerendeZaakIdentificaties != null)
                    hashCode = hashCode * 59 + this.KadastraalOnroerendeZaakIdentificaties.GetHashCode();
                if (this.PandIdentificaties != null)
                    hashCode = hashCode * 59 + this.PandIdentificaties.GetHashCode();
                if (this.VerantwoordelijkeGemeente != null)
                    hashCode = hashCode * 59 + this.VerantwoordelijkeGemeente.GetHashCode();
                if (this.Waarden != null)
                    hashCode = hashCode * 59 + this.Waarden.GetHashCode();
                return hashCode;
            }
        }

        /// <summary>
        /// To validate all properties of the instance
        /// </summary>
        /// <param name="validationContext">Validation context</param>
        /// <returns>Validation Result</returns>
        IEnumerable<System.ComponentModel.DataAnnotations.ValidationResult> IValidatableObject.Validate(ValidationContext validationContext)
        {
            yield break;
        }
    }

}
