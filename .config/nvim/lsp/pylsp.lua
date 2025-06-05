return {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
        flake8 = {
          enabled = true,
          executable = 'pflake8',
        },
      },
    }
  }
}
