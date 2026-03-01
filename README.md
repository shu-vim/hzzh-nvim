# hzzh-nvim

Neovim plugin to highlight the boundary between half-width and full-width characters.

![screenshot](https://raw.githubusercontent.com/shu-vim/hzzh-nvim/main/screenshots/ss1.png)

## Install

### lazy.nvim

```lua
return { "shu-vim/hzzh-nvim" }
```

## Usage

Enabled by default on startup.

```vim
:HZZHEnable
:HZZHDisable
```

## Setup/Config

### Default config

```lua
return {
    "shu-vim/hzzh-nvim",
    opts = {
        highlight = 'SpellBad',
        trailing_zen = '」』）】＞',
        leading_zen = '、。：「『（【＜',
    }
}
```

---

Maintainer: Shuhei Kubota <kubota.shuhei+vim@gmail.com>
