locals {
  default_tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
    CostCenter  = "1"
    Application = "PrivateLink"
    Owner       = "anyemail@cloudycloud.cloud"
  }

  resource_suffix = join("-", ["eu", "privatelink"])
  fw_ip           = "10.20.0.0"

  net_watchers = {
    westeurope = {
      name    = "NetworkWatcher_westeurope"
      rg_name = "NetworkWatcherRG"
    },
    northeurope = {
      name    = "NetworkWatcher_northeurope"
      rg_name = "NetworkWatcherRG"
    }
  }

  vnets = {
    external = {
      cidr               = "10.1.0.0/16"
      tgw_attachment     = "inside"
      type               = "hub"
      location           = "westeurope"
      storage_name       = "externallogsjune2023"
      diag_name          = "diagexternallogsjune2023"
      workspace          = "external-logs"
      peer_to_hub_name   = ""
      peer_to_spoke_name = ""
    },
    app = {
      cidr               = "10.2.0.0/16"
      tgw_attachment     = "appnet"
      type               = "spoke"
      location           = "westeurope"
      storage_name       = "appnetlogsjune2023"
      diag_name          = "diagappnetlogsjune2023"
      workspace          = "app-logs"
      peer_to_hub_name   = "cn-app-to-external"
      peer_to_spoke_name = "cn-external-to-app"
    },
    db = {
      cidr               = "10.3.0.0/16"
      tgw_attachment     = "dbneta"
      type               = "spoke"
      location           = "westeurope"
      storage_name       = "dblogsjune2023"
      diag_name          = "diagdblogsjune2023"
      workspace          = "db-logs"
      peer_to_hub_name   = "cn-db-to-external"
      peer_to_spoke_name = "cn-external-to-db"
    },
    plink = {
      cidr               = "192.168.0.0/16"
      tgw_attachment     = "plinka"
      type               = "plink"
      location           = "northeurope"
      storage_name       = "plinklogsjune2023"
      diag_name          = "diagplinklogsjune2023"
      workspace          = "plink-logs"
      peer_to_hub_name   = ""
      peer_to_spoke_name = ""
    }
  }

  subnets = [
    {
      name     = "mgmt"
      type     = "public"
      cidr     = "10.1.10.0/24"
      vnet     = "external"
      rtb      = "mgmt"
      nsg      = "ftd-sg"
      location = "westeurope"
      plinkpol = true
      main_rtb = false
      routes = [{
        name        = "mgmt1"
        cidr_dest   = "0.0.0.0/0"
        dest        = "Internet"
        vnet        = "external"
        rtb         = "mgmt"
        next_hop_ip = ""
      }]
    },
    {
      name     = "outside"
      type     = "public"
      cidr     = "10.1.2.0/24"
      vnet     = "external"
      rtb      = "outside"
      nsg      = "ftd-sg"
      location = "westeurope"
      plinkpol = true
      main_rtb = true
      routes = [{
        name        = "outside1"
        cidr_dest   = "0.0.0.0/0"
        dest        = "Internet"
        vnet        = "external"
        rtb         = "outside"
        next_hop_ip = ""
      }]

    },
    {
      name     = "inside"
      type     = "private"
      cidr     = "10.1.1.0/24"
      vnet     = "external"
      rtb      = "inside"
      nsg      = "internal-sg" #"ftd-sg"
      location = "westeurope"
      plinkpol = true
      main_rtb = false
      routes = [{
        name        = "inside1"
        cidr_dest   = "0.0.0.0/0"
        dest        = "VirtualAppliance"
        vnet        = "external"
        rtb         = "inside"
        next_hop_ip = local.fw_ip
        },
        {
          name        = "inside2"
          cidr_dest   = "10.2.0.0/16"
          dest        = "VirtualAppliance"
          vnet        = "external"
          rtb         = "inside"
          next_hop_ip = local.fw_ip
        },
        {
          name        = "inside3"
          cidr_dest   = "10.3.0.0/16"
          dest        = "VirtualAppliance"
          vnet        = "external"
          rtb         = "inside"
          next_hop_ip = local.fw_ip
      }]
    },
    {
      name     = "appnet"
      type     = "private"
      cidr     = "10.2.1.0/24"
      vnet     = "app"
      rtb      = "appnet"
      nsg      = "app-sg"
      location = "westeurope"
      plinkpol = true
      main_rtb = true
      routes = [{
        name        = "appnet1"
        cidr_dest   = "0.0.0.0/0"
        dest        = "VirtualAppliance"
        vnet        = "app"
        rtb         = "appnet"
        next_hop_ip = local.fw_ip
      }]
    },
    {
      name     = "dbneta"
      type     = "private"
      cidr     = "10.3.1.0/24"
      vnet     = "db"
      nsg      = "ftd-http-sg"
      location = "westeurope"
      rtb      = "dbneta"
      plinkpol = true
      main_rtb = true
      routes = [{
        name        = "dbneta1"
        cidr_dest   = "0.0.0.0/0"
        dest        = "VirtualAppliance"
        vnet        = "dbneta"
        rtb         = "database"
        next_hop_ip = local.fw_ip
      }]
    },
    {
      name     = "dbnetb"
      type     = "private"
      cidr     = "10.3.2.0/24"
      vnet     = "db"
      nsg      = "ftd-http-sg"
      location = "westeurope"
      rtb      = ""
      plinkpol = true
      main_rtb = false
      routes = [{
        name        = ""
        cidr_dest   = ""
        dest        = ""
        vnet        = ""
        rtb         = ""
        next_hop_ip = ""
      }]
    },
    {
      name     = "lbneta"
      type     = "private"
      cidr     = "192.168.0.0/24"
      vnet     = "plink"
      nsg      = "plink-app-sg"
      location = "northeurope"
      rtb      = "lbneta"
      plinkpol = false
      main_rtb = true
      routes = [{
        name        = ""
        cidr_dest   = ""
        dest        = ""
        vnet        = ""
        rtb         = ""
        next_hop_ip = ""
      }]
    }
  ]

  nsgs = {
    app-sg = {
      description = "Allow access for app vnet"
      vnet        = "app"
      location    = "westeurope"
      security_rules = {
        http = {
          priority    = 1001
          description = "Allow HTTP"
          access      = "Allow"
          direction   = "Inbound"
          from_port   = 80
          to_port     = 80
          protocol    = "Tcp"
          cidr_block  = "0.0.0.0/0"
        },
        https = {
          priority    = 1002
          description = "Allow HTTPS"
          access      = "Allow"
          direction   = "Inbound"
          from_port   = 443
          to_port     = 443
          protocol    = "Tcp"
          cidr_block  = "0.0.0.0/0"
        },
        out = {
          priority    = 1001
          description = "Allow everything"
          access      = "Allow"
          direction   = "Outbound"
          from_port   = "*"
          to_port     = "*"
          protocol    = "*"
          cidr_block  = "0.0.0.0/0"
        }
      }
    },
    ftd-http-sg = {
      description = "Allow access for external vnet"
      vnet        = "external"
      location    = "westeurope"
      security_rules = {
        http = {
          priority    = 1001
          description = "Allow HTTP"
          access      = "Allow"
          direction   = "Inbound"
          from_port   = 80
          to_port     = 80
          protocol    = "Tcp"
          cidr_block  = "0.0.0.0/0"
        },
        https = {
          priority    = 1002
          description = "Allow HTTPS"
          access      = "Allow"
          direction   = "Inbound"
          from_port   = 443
          to_port     = 443
          protocol    = "Tcp"
          cidr_block  = "0.0.0.0/0"
        },
        mysql = {
          priority    = 1003
          description = "Allow MySQL/Aurora"
          access      = "Allow"
          direction   = "Inbound"
          from_port   = 3306
          to_port     = 3306
          protocol    = "Tcp"
          cidr_block  = "10.2.0.0/16"
        },
        out = {
          priority    = 1001
          description = "Allow everything"
          access      = "Allow"
          direction   = "Outbound"
          from_port   = "*"
          to_port     = "*"
          protocol    = "*"
          cidr_block  = "0.0.0.0/0"
        }
      }
    },
    ftd-sg = {
      description = "Allow access for external vnet - ftd"
      vnet        = "external"
      location    = "westeurope"
      security_rules = {
        http = {
          priority    = 1001
          description = "Allow HTTP"
          access      = "Allow"
          direction   = "Inbound"
          from_port   = 80
          to_port     = 80
          protocol    = "Tcp"
          cidr_block  = "0.0.0.0/0"
        },
        https = {
          priority    = 1002
          description = "Allow HTTPS"
          access      = "Allow"
          direction   = "Inbound"
          from_port   = 443
          to_port     = 443
          protocol    = "Tcp"
          cidr_block  = "0.0.0.0/0"
        },
        mysql = {
          priority    = 1003
          description = "Allow SSH"
          access      = "Allow"
          direction   = "Inbound"
          from_port   = 22
          to_port     = 22
          protocol    = "Tcp"
          cidr_block  = "${var.my_ip}/32"
        },
        out = {
          priority    = 1001
          description = "Allow everything"
          access      = "Allow"
          direction   = "Outbound"
          from_port   = "*"
          to_port     = "*"
          protocol    = "*"
          cidr_block  = "0.0.0.0/0"
        }
      }
    },
    plink-app-sg = {
      description = "Deny everything inbound"
      vnet        = "plink"
      location    = "northeurope"
      security_rules = {
        http = {
          priority    = 1001
          description = "Deny everything"
          access      = "Deny"
          direction   = "Inbound"
          from_port   = "*"
          to_port     = "*"
          protocol    = "*"
          cidr_block  = "0.0.0.0/0"
        },
        out = {
          priority    = 1001
          description = "Allow everything"
          access      = "Allow"
          direction   = "Outbound"
          from_port   = "*"
          to_port     = "*"
          protocol    = "*"
          cidr_block  = "0.0.0.0/0"
        }
      }
    },
    internal-sg = {
      description = "Deny everything outbound"
      vnet        = "external"
      location    = "westeurope"
      security_rules = {
        http = {
          priority    = 1001
          description = "Allow HTTP"
          access      = "Allow"
          direction   = "Inbound"
          from_port   = 80
          to_port     = 80
          protocol    = "Tcp"
          cidr_block  = "0.0.0.0/0"
        },
        https = {
          priority    = 1002
          description = "Allow HTTPS"
          access      = "Allow"
          direction   = "Inbound"
          from_port   = 443
          to_port     = 443
          protocol    = "Tcp"
          cidr_block  = "0.0.0.0/0"
        },
        out = {
          priority    = 1001
          description = "Deny everything"
          access      = "Deny"
          direction   = "Outbound"
          from_port   = "*"
          to_port     = "*"
          protocol    = "*"
          cidr_block  = "0.0.0.0/0"
        }
      }
    }
  }

  lbs = {
    plink = {
      frontend_ip_address = "192.168.0.10"
      frontend_ip_name    = "lbi-frontend-ip"
      pip                 = "lb"
      location            = "northeurope"
      snet                = "lbneta"
    }
  }

  pips = {
    lb = {
      sku          = "Standard"
      alloc_method = "Static"
      location     = "northeurope"
    }
  }

  plinkservices = {
    plinkservice = {
      lb       = "plink"
      location = "northeurope"
      nat_ip_conf = {
        primary = {
          private_ip = "192.168.0.5"
          snet       = "lbneta"
          primary    = true
        }
      }
    }
  }
}