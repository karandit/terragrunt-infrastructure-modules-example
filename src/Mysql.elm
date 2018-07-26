module Mysql exposing (mysql)

{-| Mysql Terraform module.

@docs mysql
-}

import Terramake exposing (..)
import Terraform.AWS as AWS
import Terraform.AWS.RDS as RDS


type alias MysqlInput x =
    { x
        | aws_region : AWS.Region
        , name : String
        , instance_class : RDS.DbInstanceType
        , allocated_storage : Int
        , storage_type : RDS.StorageType
        , master_username : String
        , master_password : String
    }


{-| Defines a contract for Mysql.
-}
mysql : MysqlInput a -> Tfvars
mysql inp =
    [ tfvar "aws_region" <| fromString <| AWS.regionToString inp.aws_region
    , tfvar "name" <| fromString inp.name
    , tfvar "instance_class" <| fromString <| RDS.dbInstanceTypeToString inp.instance_class
    , tfvar "allocated_storage" <| fromInt inp.allocated_storage
    , tfvar "storage_type" <|fromString <| RDS.storageTypeToString inp.storage_type
    , tfvar "master_username" <| fromString inp.master_username
    , tfvar "master_password" <| fromString inp.master_password
    ]
