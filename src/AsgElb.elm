module AsgElb exposing (asgElb)

{-| Terraform module for Auto Scaling Group and Elastic Load Balancer.

@docs asgElb
-}

import Terramake exposing (..)
import Terraform.AWS as AWS
import Terraform.AWS.EC2 as EC2

type alias AsgElbInput x =
    { x
        | aws_region : AWS.Region
        , name : String
        , instance_type : EC2.InstanceType
        , min_size : Int
        , max_size : Int
        , server_port : Int
        , elb_port : Int
    }


{-| Defines a contract for Auto Scaling Group and Elastic Load Balancer.
-}
asgElb : AsgElbInput a -> Tfvars
asgElb inp =
    [ tfvar "aws_region" <| fromString <| AWS.regionToString inp.aws_region
    , tfvar "name" <| fromString inp.name
    , tfvar "instance_type" <| fromString <| EC2.instanceTypeToString inp.instance_type
    , tfvar "min_size" <| fromInt inp.min_size
    , tfvar "max_size" <| fromInt inp.max_size
    , tfvar "server_port" <| fromInt inp.server_port
    , tfvar "elb_port" <| fromInt inp.elb_port
    ]
