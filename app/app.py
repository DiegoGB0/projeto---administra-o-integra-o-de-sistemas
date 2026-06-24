from http.server import HTTPServer, SimpleHTTPRequestHandler

server = HTTPServer(("0.0.0.0", 5000), SimpleHTTPRequestHandler)

print("Servidor iniciado na porta 5000")
server.serve_forever()