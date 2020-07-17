set -e
# RUN USING: '. ./create_nvim_venv.sh'
#update-alternatives --install /usr/bin/python python /usr/bin/python3 0
echo ">>>>>>> Creating venv for neovim"
#pyenv virtualenv system neovim3
pyenv activate neovim3
pip install -U pip wheel setuptools
pip install -U neovim pyramid cornice cornice_swagger colander mongoengine flake8 pylint pep8 requests bcrypt flask ipdb
pyenv deactivate
