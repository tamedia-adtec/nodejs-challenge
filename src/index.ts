// EXAMPLE HTTP SERVER
import http from 'http';

const PORT = process.env.PORT || 3000;

const requestListener = (req: http.IncomingMessage, res: http.ServerResponse) => {
	res.writeHead(200);
	const data = {
		message: 'Hello, world!'
	};
	const jsonContent = JSON.stringify(data);
	res.end(jsonContent);
};

const server = http.createServer(requestListener);

server.listen(PORT, () => {
	console.log(`Server is listening at port ${ PORT }.`);
});
