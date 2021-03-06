# rum

Discover available meeting rooms (Turing internal).

```
$ rum --date thursday

The authentication server says:
"To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code CVM49YUZL to authenticate."

1 August 2019        8     10    12    14    16    18
                     |..:..|..:..|..:..|..:..|..:..|
Margaret Hamilton    |  :  |  :**|  :* |**:  |*-:  |
Augusta Ada          |  :  |  :  |  :  |  :  |  :  |
Lovelace             |  :**|**:**|**:**|**:**|**:  |
Ursula Franklin      |  :* | *:**|  :* |  :**|  :  |
Florence Nightingale |  :  |**: *|  :  |  :  |  :  |
David Blackwell      |  :  |**:**|  :  |  :**|**:  |
Jack Good            |  :  |**:  |**:**|**:  |  :  |
Mary Shelley         |  :**|**:**|**:**|**:**|**:  |
Isaac Asimov         |  :**|**:**|**:**|**:**|**:  |
ACE                  |**:**|**:**|**:**|**:**|**:**|
Banburismus          |  :  | *:**|* :  | *:  |  :  |
Delilah              |  :**|**:**|**:**|**:**|**:  |
Turingery            |  :  |  :  |  :  |**:**|**:  |
```

There are two steps to installation:

1. Install Racket
2. Use Racket to install Rum

## 1. Install Racket

You can either download Racket directly from the website, or use
homebrew. Homebrew is easier if you already use it.

If you have already installed Racket, then you can skip the first part of your
selected method, but you will still need to do the second.

### EITHER: Install Racket with homebrew 

#### Homebrew installation: Part 1

```sh
brew cask install racket
```

#### Homebrew installation: Part 2

```sh
sudo sh -c 'echo $HOME/Library/Racket/7.3/bin > /etc/paths.d/Racket'
```

It's probably easiest to copy-and-paste this command. If the version of Racket
that you installed is not 7.3, change the occurence of `7.3` in the command to
the correct version.

### OR: Install Racket directly from its website

#### Website installation: Part 1

Download Racket from https://download.racket-lang.org/ and follow the
instructions to copy it into your Applications directory. Make a note of the
version number, which is probably 7.3 if you are reading this before the end of
July 2019.

#### Website installation: Part 2

In a terminal, run the following two commands (it will be most straightforward
to copy-and-paste from these instructions as it is easy to mis-type
something). If the version number you noted above is not 7.3, then change each
occurence of `7.3` in the commands to whatever the version is.

```sh
sudo sh -c 'echo /Applications/Racket\ v7.3/bin > /etc/paths.d/Racket'
```
then
```sh
sudo sh -c 'echo $HOME/Library/Racket/7.3/bin >> /etc/paths.d/Racket'
```


## 2. Tell Racket to install rum

In a new terminal, run the following command:

```sh
raco pkg install https://github.com/alan-turing-institute/rum.git
```


