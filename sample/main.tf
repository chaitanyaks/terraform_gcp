locals {
	user_cmd = "hostname"
	ipaddress = "hostname -i | awk '{print $3}'"
}


resource "null_resource" "ipaddress" {
  provisioner "local-exec" {
    command = "hostname -i"
  }
}

#data "external" "example" {
#	program = ["hostname"]
#}

#output output_text {
#	value = "${data.external.example.result}"
#}

output output_data {
	value = "${null_resource.ipaddress.local-exec.command}"
}
