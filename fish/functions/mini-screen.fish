function mini-screen
    set rand_port (random-open-port 2>/dev/null)
    mini-port 5900 $rand_port 'vnc'
end
