from math import floor, log2
import argparse

def convert_to_str(arr):
  output = ""
  size = len(arr)
  layers = floor(log2(size))
  itemw = max([len(str(val)) for val in arr]) + 2
  for i, val in enumerate(arr):
    l = log2(i + 1)
    if l % 1 == 0:
      output = output.rstrip()
      output += "\n" + " " * ((itemw - 1) * ((2 ** (layers - floor(l))) - 1))
    l = floor(l)
    output += f'{val:>{itemw-2}}' + ' ' * (itemw * (2 ** (layers - l + 1) - 1) - ((2 ** (layers - l + 1)) - 2 if layers - l > 0 else 0))
  return output

if __name__=="__main__":
  parser = argparse.ArgumentParser(prog='Pretty Print Heap Arrays', description='pretty prints the given array in tree form')
  parser.add_argument("-a", "--array", action='store', dest='arr_str', required=True, help="comma separated list of items")
  args = parser.parse_args()

  print(args.arr_str)
  a = args.arr_str.replace(" ", "").split(",")
  print(a)
  out = convert_to_str(a)
  print(out)

