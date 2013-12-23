var repos = [
	"https://github.com/kien/ctrlp.vim"
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
		console.log(data);
	});

	proc.stderr.on("data", function(data) {
		console.log(data);
	});

	proc.on("exit", function() {
		runNext();
	});
}
