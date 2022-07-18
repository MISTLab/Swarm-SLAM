
# Install the packages
pip install -r requirements.txt

# Install the packages with wheel
pip install -r requirements.txt --no-index --find-links=https://download.pytorch.org/whl/torch_stable.html

# Install the packages with wheel and install the latest version of torch
pip install -r requirements.txt --no-index --find-links=https://download.pytorch.org/whl/torch_stable.html --upgrade torch torchvision

# Install the packages with wheel and install the latest version of torch and torchvision
pip install -r requirements.txt --no-index --find-links=https://download.pytorch.org/whl/torch_stable.html --upgrade torch torchvision
