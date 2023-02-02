# Generate the signed firmware

# Inputs compiled firmware , Private Key , version tag

# Firmware Structure
# | header | flash |

# Header Structure
# | fw size (4bytes) | version tag (4bytes) | digest(32bytes) | signature (64bytes) |


import sys
import subprocess


firmware = str(sys.argv[1])
privateKey = str(sys.argv[2])
version = int(sys.argv[3])

# Generate the Digest of the firmware
digest_command = "openssl dgst -sign " + privateKey + " -keyform PEM -sha256 -out digest.out -binary " + firmware
process = subprocess.Popen(digest_command, shell=True, stdout=subprocess.PIPE)
process.wait()


# Generate the Hexdump from the digest
hexdump = """hexdump -e '4/1 "%.2x" "\n"' digest.out > digest.mem"""
process = subprocess.Popen(hexdump, shell=True, stdout=subprocess.PIPE)
process.wait()

# Generaing the signed firmware

f = open("signed.mem", "w")
f.write('{:08x}'.format(200)+"\n")
f.write('{:08x}'.format(version)+"\n")
with open("digest.mem", 'r') as dgst:
    for row in dgst:
        f.write(row)
f.write('{:08x}'.format(0xffffffff)+"\n")
with open(firmware, 'r') as dgst:
    for row in dgst:
        f.write(row)
f.close()
