from setuptools import setup, find_packages
    
setup(
    # Basic info
    name='unzipcli',
    version="0.1.0",
    author='Evan Liu',
    description='Combine mostly used decompression tools to one program',

    # You need find_packages to find your package with __init__.py
    packages=find_packages(),
    # Alternatively, you can specify where to look
    # packages=find_packages('src'),
    # install_requires=[
    #     'simple-term-menu',
    # ],

    # Scripts
    entry_points={
        'console_scripts': [
            # cli_alias = Folder.filename:def_name
            'unzipcli = unzipcli.main:main',
        ]
    },
)
