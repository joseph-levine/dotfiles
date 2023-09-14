function work-screen
    set rand_port (random-open-port 2>/dev/null)
    work-port 5900 $rand_port 'vnc'
end
