set -e -x
# RUN USING: '. ./create_nvim_venv.sh'
#update-alternatives --install /usr/bin/python python /usr/bin/python3 0
echo ">>>>>>> Creating venv for neovim"
#pyenv virtualenv system neovim3
pyenv activate neovim3
pip install -U pip wheel setuptools
pip install -U \
    pynvim neovim pyramid cornice cornice_swagger colander mongoengine\
    pylint pep8 requests bcrypt ipdb ipython pep8 pylint flake8 isort black\
    click
pyenv deactivate
