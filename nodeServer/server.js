var sys = require("sys"),
my_http = require("http");

var our_data = ["Hello World!"];

setInterval(function() {
	sys.puts("Adding an entry to our_data");
	var now = new Date();
	our_data.push(now.toUTCString());
}, 30 * 1000);

my_http.createServer(function(request,response) {
	sys.puts("Incoming request");
	setTimeout(function() {
		response.writeHeader(200, {"Content-Type": "text/plain"});
		our_data.forEach(function(entry) {
			response.write(entry + "\n");
		});
		response.end();
	}, 2500);
}).listen(8080);

sys.puts("Server Running on 8080");
