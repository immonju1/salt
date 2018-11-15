def application(env, startResponse):
        startResponse("200 OK", [("Content-type", "text/plain")])
        return [b"Hello World from Python 3 WSGI\n"]
