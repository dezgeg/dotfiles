python
import sys
sys.path.insert(0, '/home/tmtynkky/dotfiles/share/libstdcxx-gdb')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers(None)
end

set auto-load safe-path ~/cppgm
