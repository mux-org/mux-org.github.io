import sys
from pathlib import Path

sys.path.insert(0, str(Path('utils/tcspy').resolve()))


project = 'mux'
extensions = ['muxdoc']

todo_include_todos = True
