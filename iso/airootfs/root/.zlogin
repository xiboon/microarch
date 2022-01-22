# fix for screen readers
if grep -Fq 'accessibility=' /proc/cmdline &> /dev/null; then
    setopt SINGLE_LINE_ZLE
fi

chmod +x /usr/local/bin/*
chmod +x ~/.automated_script
~/.automated_script