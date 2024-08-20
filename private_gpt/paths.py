from pathlib import Path

# from private_gpt.constants import PROJECT_ROOT_PATH
from private_gpt.settings.settings import settings


# def _absolute_or_from_project_root(path: str) -> Path:
#     if path.startswith("/"):
#         return Path(path)
#     return PROJECT_ROOT_PATH / path


models_path: Path = Path(settings().paths.models_path)
models_cache_path: Path = Path(settings().paths.models_cache_path)
docs_path: Path = Path(settings().paths.docs_path)
local_data_path: Path = Path(settings().data.local_data_folder)
