import os
from pathlib import Path
from typing import Generator

from .reader import MoleculeEntry, Reader
from .reader_registry import register_reader

__all__ = ["FileReader"]


@register_reader
class FileReader(Reader):
    def __init__(self, data_dir="."):
        super().__init__()
        self.data_dir = Path(data_dir)

    def read(self, filename, explore) -> Generator[MoleculeEntry, None, None]:
        assert isinstance(filename, str), "input must be a string"

        try:
            path = Path(filename)

            if not path.is_absolute():
                path = self.data_dir / path
        except:
            raise ValueError("input must be a valid path")

        assert self.data_dir in path.parents, "input must be a relative path"
        assert path.exists(), "input must be a valid file"

        with open(path, "rb") as f:
            for entry in explore(f):
                if len(entry.source) == 1 and entry.source[0] == "raw_input":
                    source = tuple()
                else:
                    source = entry.source
                yield entry._replace(source=tuple([filename, *source]))

    def __repr__(self):
        return f"FileReader()"
