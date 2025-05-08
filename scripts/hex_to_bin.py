import argparse
import binascii

parser = argparse.ArgumentParser()
parser.add_argument("-o", "--output", type=str, required=False)
parser.add_argument("input", type=str)

args = parser.parse_args()

hex_str = args.input.replace(' ', '').strip()
bin_str = binascii.unhexlify(hex_str)

if args.output != None:
  with open(args.output, "wb") as f:
    f.write(bin_str)
else:
  print(bin_str)

