{

    "workbench.sideBar.location": "right",

    "editor.wordWrap": "off",

    "vim.leader": ";",

    "vim.useSystemClipboard": true,

    "vim.easymotion": true,

    "vim.hlsearch": true,

    "vim.otherModesKeyBindingsNonRecursive": [

        {

            "before": [

                "leader","b"

            ],

            "after": [],

            "commands": [

                {

                    "command": "workbench.action.toggleSidebarVisibility",

                    "args": []

                }

            ]

        },

        {

            "before": [ "<space>" ],

            "after":[":"]

        },

        {

            "before": [ "<leader>", "w" ],

            "after":[],

            "commands": [

                {

                    "command": "workbench.action.files.save",

                    "args": []

                }

            ]

        },

        {

            "before": [ "<C-w>", "c" ],

            "after":[],

            "commands": [

                {

                    "command": "workbench.action.closeActiveEditor",

                    "args": []

                }

            ]

        }

    ],



    // "terminal.integrated.shell.windows": "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",

    "window.zoomLevel": 0,

    "terminal.integrated.rightClickCopyPaste": false,

    "search.exclude": {

        "**/node_modules": true,

        "**/bower_components": true

    },

    // "terminal.integrated.shell.windows": "C:\\Windows\\sysnative\\bash.exe",

    "terminal.integrated.shell.windows": "D:\\cmder\\vendor\\git-for-windows\\bin\\bash.exe",

     "terminal.integrated.shellArgs.windows": [ "-l" ],

    "vim.handleKeys": {

    }

}
