## Environment
  * CentOS 7

## Warning
  * Please do this in fresh install OS

## Usage

  ```bash
  yum install -y git
  git clone https://github.com/charlietag/os_preparation.git
  ```

  ```bash
  ./start.sh -h
  usage: start.sh
    -a                   ,  run all functions
    -i func1 func2 func3 ,  run specified functions
  ```

## Customization your own function
### Folder
  * functions/*
    * Write your own script here, **file** named start with **F_[0-9][0-9]_YourOwnFuntionName.sh**
    * Run command `./start.sh -i YourOwnFuntionName`
  * templates/*
    * Put your own templates here, **folder** named the same as **YourOwnFuntionName**
  * databag/*
    * Put your special config variables here, **file** named the same as **YourOwnFuntionName**
    * How to use
      * In databag/YourOwnFunctionName
        * local your_vars_here
      * In templates/YourOwnFunctionName/yourowntemplate_file
        * You can use ${your_vars_here}
      * In **YourOwnFuntionName** , you can call **RENDER_CP ${$CONFIG_FOLDER}/yourowntemplate_file /SomeWhere/somewhere** instead of **cp ${$CONFIG_FOLDER}/yourowntemplate_file /SomeWhere/somewhere** command

### Predefined variables

```bash
-----------lib use only--------
CURRENT_SCRIPT : /<PATH>/os_preparation/start.sh
CURRENT_FOLDER : /<PATH>/os_preparation
FUNCTIONS      : /<PATH>/os_preparation/functions
LIB            : /<PATH>/os_preparation/lib

-----------function use only--------
TEMPLATES      : /<PATH>/os_preparation/templates
TMP            : /<PATH>/os_preparation/tmp
CONFIG_FOLDER  : /<PATH>/os_preparation/templates/<FUNCTION_NAME>

-----------function use only - predefined vars--------
FIRST_ARGV     : [ -i | -a ]
ALL_ARGVS      : <FUNCTION_NAMES>
```

## Note
### Packages
  * PHP7 (Ref.https://webtatic.com/packages/php70)
  * MariaDB 10.1 (equal to MySQL 5.7)
  * nodejs (latest version - 6)

### Ruby gem config
* gem install without making document
  * Deprecated

    ~~`no-ri, no-rdoc`~~

  * Config

    ```bash
    echo "gem: --no-document" > ~/.gemrc
    ```

### Built-in vim colorscheme
* /usr/share/vim/vim72/colors

  ```bash
  colorscheme desert
  colorscheme elflord
  colorscheme koehler
  colorscheme ron
  colorscheme torte <--- Most proper
  colorscheme 256-jungle
  colorscheme lucid
  colorscheme motus
  ```

### Optional
  * VSFTPD

    ```bash
    yum install -y vsftpd
    sed -i s/^root/'#root'/g /etc/vsftpd/ftpusers
    sed -i s/^root/'#root'/g /etc/vsftpd/user_list
    ```

