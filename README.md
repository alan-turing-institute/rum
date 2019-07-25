# rum

Discover available meeting rooms (Turing internal).

There are two steps to installation:

1. Install Racket
2. Use Racket to install Rum

## 1. Install Racket

You can either download Racket directly from the website, or use
homebrew. Homebrew is easier if you already use it.

There are two parts to installing Racket: downloading it, and telling your
computer where to find it. If you have already installed Racket, then you can
skip the first of these steps, but you will still need to do the second.

### EITHER: Install with homebrew 

#### Homebrew installation: Part 1

If you use homebrew, then run this in a terminal: 
```sh
brew cask install racket
```

Make a note of the version number, which is probably 7.3 if you are reading this
before the end of July 2019.

#### Homebrew installation: Part 2

In a terminal, run the following (it will be most straightforward to
copy-and-paste from these instructions as it is easy to mis-type something). If
the version number you noted above is not 7.3, then change the `7.3` in the
command to whatever the version is.

```sh
sudo sh -c 'echo $HOME/Library/Racket/7.3/bin > /etc/paths.d/Racket'
```

### OR: Install Racket directly from its website

#### Website installation: Part 1

Download Racket from https://download.racket-lang.org/ and follow instructions
to copy it into your Applications directory. Make a note of the version number,
which is probably 7.3 if you are reading this before the end of July 2019.

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
raco pkg install https://github.com/alan-turing-institute/rum
```


