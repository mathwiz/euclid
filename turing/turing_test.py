import unittest
import turing


# m = turing.Machine(['scan', 'add1', 'add0'], ['+'])
# m.add_tuple(['start', ' ', ' ', -1, 'scan'])
# m.add_tuple(['scan', '1', '1', -1, 'add1'])
# m.add_tuple(['scan', '0', '0', -1, 'add0'])
# m.add_tuple(['add0', '+', ' ', -1, 'end'])
# m.add_tuple(['add1', '+', ' ', -1, 'add1'])
# m.add_tuple(['add1', '0', '1', 1, 'end'])
# m.add_tuple(['add1', ' ', '1', -1, 'end'])
# m.add_tuple(['add1', '1', '0', -1, 'add1'])
# print(m)

# test validations
# m.add_tuple(['start', ' ', ' ', -1, 'PreScan'])

def run_tape(machine, tape):
    machine.set_tape(tape)
    show_state(machine, tape)
    while machine.step():
        show_state(machine, tape)
    print("final tape:" + machine.get_tape() + ":")
    print("")

def show_state(machine, tape):
    print((' ' * machine.get_position()) + '*')
    print(machine.get_tape())
    

incrementer = turing.AddOneDigit()
# print(incrementer)

atape = '1+1'
print('tape:' + atape)
run_tape(incrementer, atape)

atape = '11+1'
print('tape:' + atape)
run_tape(incrementer, atape)

atape = '1011+1'
print('tape:' + atape)
run_tape(incrementer, atape)

atape = '1+0'
print('tape:' + atape)
run_tape(incrementer, atape)

atape = '0+0'
print('tape:' + atape)
run_tape(incrementer, atape)

atape = '1011+0'
print('tape:' + atape)
run_tape(incrementer, atape)


adder = turing.Addition()

atape = '1011+11111'
print('tape:' + atape)
run_tape(adder, atape)

atape = '11+101'
print('tape:' + atape)
run_tape(adder, atape)
