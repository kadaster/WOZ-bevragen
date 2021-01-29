# flake8: noqa

# import all models into this package
# if you have many models here with many references from one model to another this may
# raise a RecursionError
# to avoid this, import only the models that you directly need like:
# from from openapi_client.model.pet import Pet
# or import this package, but before doing it, use:
# import sys
# sys.setrecursionlimit(n)

from openapi_client.model.adres import Adres
from openapi_client.model.bad_request_foutbericht import BadRequestFoutbericht
from openapi_client.model.bad_request_foutbericht_all_of import BadRequestFoutberichtAllOf
from openapi_client.model.belanghebbende import Belanghebbende
from openapi_client.model.belanghebbende_eigenaar import BelanghebbendeEigenaar
from openapi_client.model.belanghebbende_eigenaar_all_of import BelanghebbendeEigenaarAllOf
from openapi_client.model.foutbericht import Foutbericht
from openapi_client.model.hal_collection_links import HalCollectionLinks
from openapi_client.model.hal_link import HalLink
from openapi_client.model.invalid_params import InvalidParams
from openapi_client.model.object_aanduiding import ObjectAanduiding
from openapi_client.model.object_aanduiding_all_of import ObjectAanduidingAllOf
from openapi_client.model.persoon_type_enum import PersoonTypeEnum
from openapi_client.model.waarde import Waarde
from openapi_client.model.waardetabel import Waardetabel
from openapi_client.model.woz_object import WozObject
from openapi_client.model.woz_object_basis_links import WozObjectBasisLinks
from openapi_client.model.woz_object_hal import WozObjectHal
from openapi_client.model.woz_object_hal_all_of import WozObjectHalAllOf
from openapi_client.model.woz_object_hal_collectie import WozObjectHalCollectie
from openapi_client.model.woz_object_hal_collectie_embedded import WozObjectHalCollectieEmbedded
