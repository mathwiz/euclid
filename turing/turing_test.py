import unittest
import turing


m = turing.Machine(['PreScan', 'reset', 'ReadDigit'], ['+'])
m.add_tuple(['start', ' ', ' ', -1, 'PreScan'])

print(m)
