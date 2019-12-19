# My vim config

It's my vim config for rails develop on linux. Your can fork or just use it.

What vim scripts I use are list in .vimrc with `Bundle` command.

## Dependent

* vim
* git
* rake

## Install

Install will overwrite your .vimrc, .gvimrc file and .vim folder, be sure **backup your vim config** first.

    git clone https://github.com/javyliu/javy_vimrc.git
    cd javy_vimrc
    ./deploy.sh

Done.

```flow
st=>start: 开始
op=>operation: My Operation
cond=>condition: Yes or No?
e=>end
st->op->cond
cond(yes)->e
cond(no)->op
```
