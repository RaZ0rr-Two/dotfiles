
local lspconfig = require'lspconfig'

lspconfig.ccls.setup {
  init_options = {
	  --compilationDatabaseDirectory = "/home/ACM-Lab/Softwares/Installed/ccls/Debug" ;
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
			resourceDir = "/usr/lib/llvm-7/lib/clang/7.0.1/include" ;
    };
  };
  cmd = { 
			'ccls',  
		  '--log-file=/tmp/ccls.log',
			'-v=1';
	};
  --filetypes = { "c", "cpp", "objc", "objcpp" } ;
	--capabilities = capabilities ;
	--root_dir = vim.loop.cwd ;
	--root_dir = root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".ccls") or '/home/ACM-Lab/.Test' ;
	--root_dir = {'echo', 'getcwd()'} ;
  -- "--log-file=/tmp/ccls.log -v=1"
}
