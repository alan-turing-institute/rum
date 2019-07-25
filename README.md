# rum

Discover available meeting rooms (Turing internal)

## Installation instructions

### One-time only

#### 1. Install Racket

If you use homebrew, then: 
```sh
brew cask install racket
```

or download and install from [https://download.racket-lang.org/].


#### 2. Set your path

Configure your computer to also look for programs in the place that Racket puts
them. You should probably copy-and-paste this commmand. 

(Also, just double-check that the previous command installed Racket version 7.3,
and change the number below if it is something else.)

```sh
sudo sh -c 'echo $HOME/Library/Racket/7.3/bin > /etc/paths.d/Racket'
```

#### 3. Tell Racket to install rum

```sh
raco pkg install https://github.com/alan-turing-institute/rum
```


