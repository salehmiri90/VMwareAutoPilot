#Provided by Saleh Miri

variable "access_ip" {
  description = "List of IP need to add on NSXT"
  type        = list(string)
  default     = []
}

variable "vault_token" {
  type    = string
  default = "hvsdqgbnFWfguKuWRCikuZuiFJGBGYkEnZYU"
}
