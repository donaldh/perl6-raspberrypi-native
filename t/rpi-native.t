use v6;
use Test;
use RPi-native;

plan 20;

my $pi = RPi-native.new;
isa-ok $pi, RPi-native;

# GPIO pins
my @pins = $pi.gpio-pins;
is +@pins, 28, 'has 28 usable GPIO pins';
is @pins[0], 3, 'first usable GPIO is pin 3';
is @pins.tail, 40, 'last usable GPIO is pin 40';

# pin GPIO numbers
dies-ok { $pi.pin-gpio(0) }, 'pin-gpio: 0 is not a valid pin number';
dies-ok { $pi.pin-gpio(41) }, 'pin-gpio: 41 is not a valid pin number';
dies-ok { $pi.pin-gpio(1) }, 'Pin 1 is not a GPIO';
is $pi.pin-gpio(3), 2, 'Pin 3 is a GPIO';
is $pi.pin-gpio(40), 21, 'Pin 40 is a GPIO';

# pin GPIO names
dies-ok { $pi.pin-name(0) }, 'pin-name: 0 is not a valid pin number';
dies-ok { $pi.pin-name(41) }, 'pin-name: 41 is not a valid pin number';
is $pi.pin-name(1), '3.3v', 'Pin 1 is 3.3v';
is $pi.pin-name(40), 'GPIO.21', 'Pin 40 is GPIO.21';

# Out
$pi.set-function(11, out);
is $pi.function(11), out, 'Can set pin 11 function to out';
$pi.write(11, True);
is $pi.read(11), True, 'Can set pin 11 value to True';
$pi.write(11, False);
is $pi.read(11), False, 'Can set pin 11 value to False';

# In
$pi.set-function(11, in);
is $pi.function(11), in, 'Can set pin 11 function to in';
$pi.set-pull(11, down);
is $pi.read(11), False, 'Can set pin 11 to pull down';
$pi.set-pull(11, up);
is $pi.read(11), True, 'Can set pin 11 to pull up';
$pi.set-pull(11, down);
is $pi.read(11), False, 'Can set pin 11 back to pull down';