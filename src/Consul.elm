module Consul exposing (consul, withConsulDefaults)

{-| Consul Terraform module.

@docs consul, withConsulDefaults
-}
import Terramake exposing (..)
import Terraform.AWS as AWS

type alias ConsulInput x =
    { x
        | aws_region : AWS.Region
        , cluster_name : String
        , num_servers : Int
        , num_clients : Int
    }


type alias ConsulDefaultInput x =
    { x
        | ssh_key_name : Maybe String
    }

{-| Provides default values for the optional consul input variables.
-}
withConsulDefaults : ConsulDefaultInput {}
withConsulDefaults =
    { ssh_key_name = Nothing
    }

{-| Defines a contract for Consul.
-}
consul : ConsulDefaultInput a -> ConsulInput b -> Tfvars
consul defInp inp =
    [ tfvar "aws_region" <| fromString <| AWS.regionToString inp.aws_region
    , tfvar "cluster_name" <| fromString inp.cluster_name
    , tfvar "num_servers" <| fromInt inp.num_servers
    , tfvar "num_clients" <| fromInt inp.num_clients
    , tfvar "ssh_key_name" <| fromMaybe (fromString) defInp.ssh_key_name
    ]
