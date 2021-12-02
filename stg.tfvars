key_name = "stg-key-pair"
key_pair_tags = {
  Created     = "Terraform"
  Environment = "staging"
}
resource_group_name_idp                 = "stg-idp-rg"
resource_group_display_name_idp         = "stg-idp-rg"
resource_group_name_maintenance         = "stg-maintenance-rg"
resource_group_display_name_maintenance = "stg-maintenance-rg"

vpc_name = "stg-vpc"
vpc_tags = {
  Created     = "Terraform"
  Environment = "staging"
}

vswitch_name = "stg-vswitch"
vswitch_tags = {
  Created     = "Terraform"
  Environment = "staging"
}

security_group_name = "stg-sg"

instance_name = "stg-idp-ecs"
instance_type = "ecs.g6.large"
host_name     = "stg-idp-server"
slb_name      = "stg-slb"
slb_spec      = "slb.s1.small"
slb_tags = {
  Created     = "Terraform"
  Environment = "staging"
}

virtual_server_group_name = "stg-v-server-group"

ssl_certificates = {
  tls_cipher_policy = "tls_cipher_policy_1_2"
}

project_name      = "stg-log-project-1"
system_store_name = "stg-log-store-system"
auth_store_name   = "stg-log-store-authn"

kvstore_instance_name = "stg-redis-instance"

kvstore_account_name     = "redisuser"
kvstore_account_password = "ViUsgtMzR7S5tiMi5FfY"

eip_address_in_name  = "stg-eip-address-in"
eip_address_out_name = "stg-eip-address-out"
nat_gateway_name     = "stg-nat-gateway"
slb_server_cert_name = "stg-slb-server-cert"

slb_server_cert_certificate = "-----BEGIN CERTIFICATE-----\nMIIDCTCCAfGgAwIBAgIUEZZ/33i4pcYg3IIk7eWktesJumkwDQYJKoZIhvcNAQELBQAwFDESMBAGA1UEAwwJbG9jYWxob3N0MB4XDTIxMTEyNjAxMTc1M1oXDTMxMTEyNDAxMTc1M1owFDESMBAGA1UEAwwJbG9jYWxob3N0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAz6+H6DbofRGUrDj09xCPlXR2v0kxOz55wd/h7sKiTJ0UiQE8pbDRmcYzN65anE7a7ngZvq4cvoXJLSIFni7fznTACa7D5nUcxzFBKArspQC9XScr0/o8UGcjR2IvGN7T9lfypkmwJdV+EYE5MVCdH1jGOPoHHqviiThCnMIn4WRu3JjtGFcVZwu21nplcxH4N3Cfde3CzB4JseZCehOi7KL5OlV6QnggHW5D8OeDuwBRvj5KaogvKLdyZpL6MWJuL2Pqm8IKckI1RtCluR1uAxwnUpGoOknzqG2ZhWvDqeeiyFJrzfHtP4Q6k6B2I1NT7UQCtLxrMqyNWOHljXqgcwIDAQABo1MwUTAdBgNVHQ4EFgQU9SdJDPJgale5um6B2aEOYverbKQwHwYDVR0jBBgwFoAU9SdJDPJgale5um6B2aEOYverbKQwDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEATyIGJNgss3Eo5vt1PrMpJ5CSHX/K9QKKBGHIYGRJsqws3Z9Wz1dnbRaSCFWVD9hwsCYhKn/xfi6lnnze6q/UlbhudIwyCZF1bPl0B+4T16pXCK6FkeGQGvF578eednEPIaBQ+e4YcevXI7zOJVEqgP/V7/pXE8cDMzhQkYIHuXxiJ/5fdIdFi+sAO3xPEQDB/vjxljHRXI0z+OoSE/7rOccRVqe9OTwiRNQ8skm+wPY3GjnyVAKaTHDrQ9qxW0WRYT6b3FWD6IjxP4P/H8oQIGAySkuz3Inxq13sRrnKfcLpqlGs9z9yacCDP7cA6MaMfSME/rZXE/subN+oMxZpdA==\n-----END CERTIFICATE-----"

slb_server_cert_privatekey = "-----BEGIN RSA PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDPr4foNuh9EZSsOPT3EI+VdHa/STE7PnnB3+HuwqJMnRSJATylsNGZxjM3rlqcTtrueBm+rhy+hcktIgWeLt/OdMAJrsPmdRzHMUEoCuylAL1dJyvT+jxQZyNHYi8Y3tP2V/KmSbAl1X4RgTkxUJ0fWMY4+gceq+KJOEKcwifhZG7cmO0YVxVnC7bWemVzEfg3cJ917cLMHgmx5kJ6E6Lsovk6VXpCeCAdbkPw54O7AFG+PkpqiC8ot3JmkvoxYm4vY+qbwgpyQjVG0KW5HW4DHCdSkag6SfOobZmFa8Op56LIUmvN8e0/hDqToHYjU1PtRAK0vGsyrI1Y4eWNeqBzAgMBAAECggEALOEPi1yiLLSp3fWI6gLIJFHAf2F/o//CK+UHW6Lvk4K2N0zvIBbvlD1CQBwLNI/Nu450ccIKMBmU+Y3KjP4wGtsbzHvZlWllSJ4aKF8D+DwKr6CRVgNTGUTQWNKcvtEYGLm0k76EtAhIb9vu0ftLmMSEQTe2ZihakbB4pItINuorD59XlFrcFf27yi+1YQD2af2Homi0ZcttYGSaH8+7i0TUKiGvaw0Laq3SRQl7YHsk1UWI1TC3JfvniyaWmk+iv6GgveywvDoGiBMNQxTsvLIiiEW+m+RMGLHpTwizxov8L2r90h5+zJGMCFWr3Ty3Iv/fkc+rme/SitTuCBVYYQKBgQD69G0fItEMBkmh1fseYJ20MDEELXzH6tpS091hrz2eSgABye0zL6vswhSq7U/OzL0BI+EtTmkV/s2KUH5YEpVnn2UE72T34WUcJghI9h/qeySxX9V5r/1HpQ4IRHUplO4EmsiQCer6/74AEhDI+S8rEEgWC5mSsJwLO5xGXFSneQKBgQDT3GoAlDEIYu46mkPsD9hP1UkxpQ81HRCb3T1c7z6oIznzu+8QgU8svu3qqxgmtIRd3Rh+RrfNhNHWUOY3mNlxcbqPoxUdrzfv6WdW5wgS4ozueadE9jM4afCBSwy/xFum3Yvu1aDC1UwXsVxoYpDUO+dhFE6/BvlAz18hXGYQSwKBgQD2NdzhkV0buQeAudmYIh5XbHiKqr4jvezZGne2oSGJLPz4xE3tzDWXIYr5b76/G+vLNJJ1ytoa9FRgAT0T15exhJat0tlywTZb+YxjWOZTPOHxDB77Noj+Q5eS0OdKFo23As0HVFOwUjztAMxrAN8gFudCibrwSkmuU5utBGUhsQKBgBXsk1OoAkL56elKmYjOQvZP/hkTGbXHYjae+ICriXJg4thkNGMi3oyk3X4RYphuydvky2oV62NrQUPKb2iFessQl9vRZpgBz+oV30nQ8rbxlt/+2t56E+bcn7ThjVoy+cEU4CxBEzfWVt+EzSlIOfCcml8jeNqv4A9i5ldPdohtAoGBAOCLG4i5Rid66t+akXl8iHHYaQM0FqiuV11ylKZs688Y844fqiSpvSGdAHF9in0SbcI+6Cv+aMK9igWTrvDwpdgJxntH3VnBIYaZnaV3zhYRt25I64Y67ZPhWJ25rUnWLcMynwROIyz8bCb7CwI4vzgOCvUUzEBLybzpVKRNbtlU\n-----END RSA PRIVATE KEY-----"

containers_image = "httpd:2.4"
container_name   = "stg-idp-container"
container_group_cpu = 2.0
container_group_memory = 4.0

nat_gateway_tags = {
  Created     = "Terraform"
  Environment = "staging"
}

eip_address_tags = {
  Created     = "Terraform"
  Environment = "staging"
}

kvstore_instance_tags = {
  Created     = "Terraform"
  Environment = "staging"
}