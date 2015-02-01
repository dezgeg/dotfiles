set auto-load safe-path /
python
import sys
import os
sys.path.insert(0, '/usr/share/gcc-%s/python/' % (os.popen('gcc -dumpversion').read().strip(),))
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers(None)
end
