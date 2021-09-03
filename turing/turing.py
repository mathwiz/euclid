class Machine:
    def __init__(self, states, symbols):
        self.init_moves()
        self.init_states(states)
        self.init_symbols(symbols)
        self.init_quintuples()
        self.init_machine()

    def __repr__(self):
        quintuples = list(self.quintuples.values())
        quintuples.sort()
        return str(quintuples)

    def init_machine(self):
        self.pos = 0
        self.state = 'start'

    def init_moves(self):
        self.moves = { -1, 0, 1 }

    def init_states(self, states):
        self.states = { 'start', 'end' }
        self.states.update([ s.lower() for s in states])

    def init_symbols(self, symbols):
        self.symbols = { ' ', '0', '1' }
        self.symbols.update(symbols)
        
    def init_quintuples(self):
        self.quintuples = { }
        
    def add_tuple(self, quintuple):
        quintuple[0] = quintuple[0].lower()
        quintuple[4] = quintuple[4].lower()
        if (val := quintuple[3]) not in self.moves:
            raise ValueError("Illegal move value: %s" %(val))
        if (val := quintuple[1]) not in self.symbols:
            raise ValueError("Illegal tape read value: %s" %(val))
        if (val := quintuple[2]) not in self.symbols:
            raise ValueError("Illegal tape write value: %s" %(val))
        if (val := quintuple[0]) not in self.states:
            raise ValueError("Illegal initial state value: %s" %(val))
        if (val := quintuple[4]) not in self.states:
            raise ValueError("Illegal successor state value: %s" %(val))
        k = quintuple[0], quintuple[1]
        if (k in self.quintuples):
            existing = self.quintuples[k]
            raise ValueError("%s already exists in %s" %(k, exisiting))
        self.quintuples[k] = quintuple
        return True

    def get_quintuple(self, state, symbol):
        return self.quintuples[(state, symbol)]

    def set_tape(self, tapeString):
        self.tape = list(tapeString)
        self.init_machine()

    def get_tape(self):
        return "".join(self.tape)

    def get_state(self):
        return self.state

    def get_position(self):
        return self.pos

    def step(self):
        if self.state != 'end':
            q = self.get_quintuple(self.state, self.tape[self.pos])
            self.tape[self.pos] = q[2]
            self.change_tape(q[3])
            self.state = q[4]
            return True
        return False

    def change_tape(self, move):
        newpos = self.pos + move
        if newpos < 0:
            self.tape.insert(0, ' ')
            newpos = 0
        elif newpos == len(self.tape):
            self.tape.insert(newpos, ' ')
        self.pos = newpos

    def exec_all(self):
        while self.step():
            pass
        return self.get_tape()
        

class Addition(Machine):
    def __init__(self, \
                 states = ['prescan', 'prepaddend', 'reset', 'readdigit', 'add0', 'add1', 'carry1', 'carry0', 'completesum', 'trimend', 'finishtrim', 'clean'], \
                 symbols = ['+', '&', '@', '/']):
        Machine.__init__(self, states, symbols)
        self.add_tuple(['start', '1', '1', 1, 'start'])
        self.add_tuple(['start', '0', '0', 1, 'start'])
        self.add_tuple(['start', '+', '+', 1, 'start'])
        self.add_tuple(['start', ' ', ' ', -1, 'prescan'])
        self.add_tuple(['prescan', '0', '0', -1, 'prescan'])
        self.add_tuple(['prescan', '1', '1', -1, 'prescan'])
        self.add_tuple(['prescan', '+', '+', -1, 'prepaddend'])
        self.add_tuple(['prepaddend', '1', '&', 1, 'reset'])
        self.add_tuple(['prepaddend', '0', '@', 1, 'reset'])
        self.add_tuple(['reset', '/', '/', 1, 'reset'])
        self.add_tuple(['reset', '&', '&', 1, 'reset'])
        self.add_tuple(['reset', '@', '@', 1, 'reset'])
        self.add_tuple(['reset', '+', '+', 1, 'reset'])
        self.add_tuple(['reset', '0', '0', 1, 'reset'])
        self.add_tuple(['reset', '1', '1', 1, 'reset'])
        self.add_tuple(['reset', ' ', ' ', -1, 'readdigit'])
        self.add_tuple(['readdigit', '/', '/', -1, 'readdigit'])
        self.add_tuple(['readdigit', '0', '/', -1, 'add0'])
        self.add_tuple(['readdigit', '1', '/', -1, 'add1'])
        self.add_tuple(['readdigit', '+', '+', -1, 'completesum'])
        self.add_tuple(['add0', '+', '+', -1, 'add0'])
        self.add_tuple(['add0', '0', '0', -1, 'add0'])
        self.add_tuple(['add0', '1', '1', -1, 'add0'])
        self.add_tuple(['add0', '&', '1', -1, 'carry0'])
        self.add_tuple(['add0', '@', '0', -1, 'carry0'])
        self.add_tuple(['add1', '+', '+', -1, 'add1'])
        self.add_tuple(['add1', '0', '0', -1, 'add1'])
        self.add_tuple(['add1', '1', '1', -1, 'add1'])
        self.add_tuple(['add1', '&', '0', -1, 'carry1'])
        self.add_tuple(['add1', '@', '1', -1, 'carry0'])
        self.add_tuple(['carry1', '1', '@', -1, 'carry1'])
        self.add_tuple(['carry1', '0', '&', -1, 'carry0'])
        self.add_tuple(['carry1', ' ', '&', -1, 'carry0'])
        self.add_tuple(['carry1', '&', '@', -1, 'carry1'])
        self.add_tuple(['carry1', '@', '&', -1, 'carry0'])
        self.add_tuple(['carry0', '1', '&', -1, 'carry0'])
        self.add_tuple(['carry0', '0', '@', -1, 'carry0'])
        self.add_tuple(['carry0', '&', '&', -1, 'carry0'])
        self.add_tuple(['carry0', '@', '@', -1, 'carry0'])
        self.add_tuple(['carry0', ' ', ' ', 1, 'reset'])
        self.add_tuple(['completesum', '1', '1', -1, 'completesum'])
        self.add_tuple(['completesum', '0', '0', -1, 'completesum'])
        self.add_tuple(['completesum', '&', '1', -1, 'completesum'])
        self.add_tuple(['completesum', '^', '1', -1, 'carry1'])
        self.add_tuple(['completesum', '@', '0', -1, 'completesum'])
        self.add_tuple(['completesum', ' ', ' ', 1, 'trimend'])
        self.add_tuple(['trimend', '0', ' ', 1, 'finishtrim'])
        self.add_tuple(['trimend', '1', '1', 1, 'finishtrim'])
        self.add_tuple(['finishtrim', '0', '0', 1, 'finishtrim'])
        self.add_tuple(['finishtrim', '1', '1', 1, 'finishtrim'])
        self.add_tuple(['finishtrim', '+', '+', -1, 'clean'])
        self.add_tuple(['clean', '0', '0', 1, 'clean'])
        self.add_tuple(['clean', '1', '1', 1, 'clean'])
        self.add_tuple(['clean', '+', ' ', 1, 'clean'])
        self.add_tuple(['clean', '/', ' ', 1, 'clean'])
        self.add_tuple(['clean', ' ', ' ', 0, 'end'])
             


class AddOneDigit(Machine):
    def __init__(self, states = ['prescan', 'scan', 'add0', 'add1'], symbols = ['+']):
        Machine.__init__(self, states, symbols)
        self.add_tuple(['start', '1', '1', 1, 'prescan'])
        self.add_tuple(['start', '0', '0', 1, 'prescan'])
        self.add_tuple(['prescan', '0', '0', 1, 'prescan'])
        self.add_tuple(['prescan', '1', '1', 1, 'prescan'])
        self.add_tuple(['prescan', '+', '+', 1, 'prescan'])
        self.add_tuple(['prescan', ' ', ' ', -1, 'scan'])
        self.add_tuple(['scan', '1', ' ', -1, 'add1'])
        self.add_tuple(['scan', '0', ' ', -1, 'add0'])
        self.add_tuple(['add0', '+', ' ', -1, 'end'])
        self.add_tuple(['add1', '+', ' ', -1, 'add1'])
        self.add_tuple(['add1', '0', '1', 1, 'end'])
        self.add_tuple(['add1', ' ', '1', -1, 'end'])
        self.add_tuple(['add1', '1', '0', -1, 'add1'])
             


