all: mutants

repo = metadatatools
codecov_token = 92c09c8a-f80e-4220-af6d-1b8bb79be8f1

.PHONY: all clean format install lint mutants tests

clean:
	rm --force .mutmut-cache
	rm --recursive --force ${repo}.egg-info
	rm --recursive --force ${repo}/__pycache__
	rm --recursive --force tests/__pycache__

format:
	black --check --line-length 100 ${repo}
	black --check --line-length 100 tests

install:
	pip install --editable .

lint:
	flake8 --max-line-length 100 ${repo}
	flake8 --max-line-length 100 tests
	pylint ${repo}
	pylint tests

mutants:
	mutmut run --paths-to-mutate ${repo}

tests: install
	pytest --cov=${repo} --cov-report=xml --verbose && \
	codecov --token=${codecov_token}

import: install
	python -c "import metadatatools" && printf "\n\nÉXITO: Sí pude importar datatools\n\n" || { printf "\n\nERROR: No pude importar datatools\n\n"; exit 1; }
