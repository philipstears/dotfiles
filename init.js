var repos = [
    "https://github.com/kien/ctrlp.vim",
    "https://github.com/goatslacker/mango.vim",
    "https://github.com/ahayman/vim-nodejs-complete",
    "https://github.com/tpope/vim-surround",
    "https://github.com/jelera/vim-javascript-syntax",
    "https://github.com/leafgarland/typescript-vim",
    "https://github.com/jgdavey/vim-railscasts",
    "https://github.com/groenewege/vim-less",
    "https://github.com/clausreinke/typescript-tools",
    "https://github.com/jimenezrick/vimerl",
    "https://github.com/scrooloose/syntastic",
    "https://github.com/scrooloose/nerdtree",
    "https://github.com/Lokaltog/vim-powerline",
    "https://github.com/othree/html5.vim",
    "https://github.com/tpope/vim-fugitive",
];

var spawn = require("child_process").spawn;
var path = require("path");
var bundleDir = path.join(__dirname, ".vim/bundle");

function runNext() {
    if (repos.length === 0) return;

    var repo = repos.shift();

    var repoName = repo.substr(repo.lastIndexOf("/"));

    var repoDir = path.join(bundleDir, repoName);

    var proc = spawn("git", ["clone", repo, repoDir]);

    proc.stdout.on("data", function(data) {
        console.log(data.toString("utf8"));
    });

    proc.stderr.on("data", function(data) {
        console.log(data.toString("utf8"));
    });

    proc.on("exit", function() {
        runNext();
    });
}

runNext();
