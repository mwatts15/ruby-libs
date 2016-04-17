def dmenu (entries, prompt='select an item', height=false,
              width="100%",
              fg_color='"#FFFFFF"',
              bg_color='"#000000"',
              sel_fg_color='"#555555"',
              sel_bg_color='"#eeeeee"')
    if !height
        height=entries.count
    end
    res = ""
    font_width=14 #in pixels
    entries.collect! do |line|
        l, r = line.split("|||")
        r ? l.alignr(r.scrunch(width / font_width), width) : l
    end
    font='"Sazanami Mincho":pixelsize=' + font_width.to_s
    cmdline = "dmenu run -f -p \"#{prompt}\" -nf #{fg_color} \
    -nb #{bg_color} \
    -sb #{sel_bg_color} \
    -sf #{sel_fg_color} \
    -i -l #{height} \
    -w #{width} \
    -fn #{font}"
    IO.popen(cmdline, "w+") do |io|
        io.print(entries.join("\n"))
        #IO.popen("urxvt -e \"gdb -p #{io.pid}\"")
        io.close_write
        res = io.gets
    end
    res.to_s.chomp
end
