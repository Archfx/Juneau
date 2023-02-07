# Hardware-Root-of-Trust
```diff
- This is a work in progress project
@@ Progress will be updated in readme @@
```
Objective
------

Implementing a mini Security Engine (SE) in verilog for experimentational purposed on Trusted Execution Environements. Firmware implementation is in c.

Specs
------
- [PicoRV32](https://github.com/YosysHQ/picorv32) - Size optimized 32bit RISC-V processor as the processing element
- Secure Hash Algorithm 1 (SHA1)
- ECDSA with curve p-192 for Authentication
- AES128 for Flash Encryption


Progress 

- [x] basic soc
- [x] initial firmware
- [x] SHA intergration
- [x] SHA1 driver
- [x] Sign firmware externally


TODO :

1. Authenticated Boot Loader Verification
2. Anti Rollback Prevention
3. Secure restore


## Sign the Firmware with openSSL

Generate key pair

RSA

```shell
cd fw/sign

# Generate 4096-bit RSA private key and extract public key
openssl genrsa -out key.pem 4096
openssl rsa -in key.pem -pubout > key.pub
```
Sign the firmware

```shell
openssl dgst -sign key.pem -keyform PEM -sha256 -out otp.mem.sign -binary otp.mem
hexdump -e '4/1 "%.2x" "\n"' otp.mem.txt > signature.mem
hexdump -e '4/1 "%.2x" "\n"' key.pub > pubkey.mem
cat pubkey.mem sign.mem ../opt.mem > signed.mem
```

## SoC block diagram

<img src="images/soc.png" alt="docker" width="200"/>
