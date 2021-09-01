import unittest
import turing


m = turing.Machine(['scan', 'add1', 'add0'], ['+'])
m.add_tuple(['start', ' ', ' ', -1, 'scan'])
m.add_tuple(['scan', '1', '1', -1, 'add1'])
m.add_tuple(['scan', '0', '0', -1, 'add0'])
m.add_tuple(['add0', '+', ' ', -1, 'end'])
m.add_tuple(['add1', '+', ' ', -1, 'add1'])
m.add_tuple(['add1', '0', '1', 1, 'end'])
m.add_tuple(['add1', ' ', '1', -1, 'end'])
m.add_tuple(['add1', '1', '0', -1, 'add1'])
print(m)


# test validations
m.add_tuple(['start', ' ', ' ', -1, 'PreScan'])

