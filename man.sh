#!/bin/bash

inputs=(
moc
mpv
brave
sxiv
st
ranger
dwm
zathura
git
shell
tools
ydl
ffmpeg
vim
)

sel=`printf "%s\n" ${inputs[@]} | dmenu` || exit

{
printf "%s\n" ${inputs[@]} | grep -qw "$sel" &&
echo "$sel:"

case "$sel" in
moc) cat << _PAGE

    tab         : FILES, playlist
    enter       : play
    p           : pause-play
    ^r          : enable random
    a ^a        : add a FILE, all-file
    h l         : skip
    ^s          : playlist save
    C           : playlist clear
    L           : show lyrics
    u j d       : playlist item-move remove
    g           : search
    n b         : next, back
    q Q         : quit-but-pay, quit

_PAGE
;;

mpv) cat << _PAGE

    hjkl PGUP   : seek
    ^BS BS      : mark, jump-to-mark
    [ ] \       : speed, normal
    i p         : name, progress
    s S         : screenshots
    - =         : audio delay
    m           : mute
    _ a         : cycle  video, audio
    v c         : subtitle enable, cycle
    z Z         : adjust subtitle delay
    r R         : move subtitle
    x X         : subtitle size
    , .         : pause-frame
    f           : full-screen
    q Q         : quit save-pos-q

_PAGE
;;

brave) cat << _PAGE

    ^t ^w       : new tab, close
    ^T          : undo tab closing
    ^tab ^TAB   : tab shifting
    ^f          : search
    ^+ ^-       : page size
    ^H          : history
    ^r          : reload
    ^B          : toggle bookmark bar
    <F11>       : full-screen

_PAGE
;;

sxiv) cat << _PAGE

    cr bs       : change mode
    = _         : zoom
    g G         : goto first last
    D           : delete
    b           : bar visibility
    f           : full screen
    hjkl        : scroll and move
    | -         : flip
    , .         : next previous
    w e         : fit-width zoom100
    < >         : rotate
    m M         : mark reverse-mark
    ^space      : pay/stop animation
    s           : slideshow
    q           : quit

_PAGE
;;

st) cat << _PAGE

    ^= ^-       : zoom
    ^y          : replace
    ^s ^q       : toggle freezes
    ^l          : clear

_PAGE
;;

ranger) cat << _PAGE

    j k         : down up directory
    gh gm gr    : home media root
    BS          : view hidden FILE
    / n         : search FILE, cycle match
    dd dD       : cut, delete(selected)
    yy uy dc    : copy unyank memory
    pp po pP    : paste p-overwrite, p-queued
    w dd J K    : working-process, end, priority
    gg G        : first and last
    i           : view in a bigger window
    R           : reload-refresh
    space       : mark FILE
    v uv        : mark-all, unmark-all
    cw I A      : rename
    ^n tab      : new-tab, cycle
    q           : quit

_PAGE
;;

dwm) cat << _PAGE

    alt num     : see tag [0-all]
    ^alt nums   : see multiple tags
    alt NUM     : move to tag [0-all]
    ^alt NUMS   : move to multiple tags
    alt p       : dmenu
    alt Tab     : toggle selected tags
    alt cr      : open terminal
    alt space   : bring to master
    alt j,k     : move windows
    alt h,l     : resize windows
    alt C       : close
    alt Q       : logout
    alt i,I     : inc dec master spilts
    alt b       : bar
    alt sp t f  : mode

_PAGE
;;

zathura) cat << _PAGE

    hjkl        : move
    = -         : zoom
    o O         : open document
    d f <F5>    : dual full presentation
    a s         : height-fit width-fit
    tab         : open index
    <num>g      : go to page
    / n N       : search, cycle
    i           : black
    r           : rotate
    q           : quit

_PAGE
;;

git) cat << _PAGE

    config --global user.name 'albert'
    remote add origin <full-url>
    init                [creates .git dir]
    clone repo-name     [make local copy]
    add FILEname        [FILES to be committed]
    commit -m 'message' [use --amend to edit commit msg]
    push origin master  [push to server]
    diff                [show changes after last commit]
    log --oneline       [see all commits]
    status              [see the FILE changed]
    rebase -i id        [edit commits interactively]
    revert <id>         [undo particular commit]
    reset --hard <id>   [come back to a commit]

_PAGE
;;

shell) cat << _PAGE

    shutdown reboot     [power commands]
    pwd, cd .. -        [see the location, ..back -previous]
    ls -a -l            [list, -a all, -l long]
    history             [view previous cmds]
    cp from/ to/        [*.jpg patern, -r, -i prompt]
    mv from/ to/        [also used to rename]
    rm                  [-r, -f all, -i ptompt]
    man cmd,app         [display manual]
    alias a='abc'       [define pet short name]
    cmd > FILE.txt      [stdout to a file, < stdin. >> append]
    su sudo             [substitute, super user do]
    chmod ugo FILE      [4-read 2-write 1-execute, replace u g o ]
                        [chmod 755 myFILE, u-user g-group o-other]
    chown user FILE     [giving ownership to user]
    ps aux, htop        [all processes, also note- kill pid]
    free -m             [ram memory usage]
    useradd userdel     [user management]
    mkdir name          [rmdir to remove]
    FILE name           [know file format]
    cat, tac            [print FILES, tac for reverse]
    less, more          [FILE viewer]
    head -n 13 FILE     [first 13 lines, also use tail]
    sort FILE           [-n numerical, -r reverse]
    tr a-z A-Z          [translate]
    unique FILE         [displays only unique line]
    wc FILE             [word count, -l line, -w word]
    nl FILE             [dispaly with numbered lines]

_PAGE
;;

tools) cat << _PAGE

    nmtui                      [network manager tui]
    date +"%d-%m-%y"           [%A day %I hour %M min]
    cal mm yyyy                [use -A2 -B2]
    fdisk 'dev-name'           [list options, -l list]
    mkfs.ext4 'dev-name/part'  [format partition]
    mount dev/sdc1 media/usb   [usb dir must exist]
    unmount media/usb_dir      [unmount]
    zip -r FILE.zip DIR        [compress DIR]
    unzip FILE.zip             [decompress]
    find # -name alb.jpg       [search inside #]
    grep -i "word" FILE        [search in document]
    fduped -R -N -d /path      [delete duplicate FILES]
    name, nameall, -name       [sequence bulkrename]

    pdfseparate -f 2 -l 3 in.pdf %d.pdf [creates 2 3 .pdf]
    pdfunite 1.pdf 2.psf out.pdf        [merged to out.pdf]

_PAGE
;;

ydl) cat << _PAGE

    -F, -f 'Format'            [-F to list, -f to specify]

    --playlist-items 2, 4-8    [playlist videos index]
    -o '%(title)s.%(ext)s'     [output name format]
    -i                         [ignore errors and continue]

    -x  [ffmpeg is used if audio-only formats are absent]
        --audio-format 'mp3'
        --audio-quality 0      [0-best, 5-default]

    --write-sub                [Write subtitle FILE]

    --batch-FILE 'file'        [list file, one URL per line]

_PAGE
;;

ffmpeg) cat << _PAGE

    -i in.avi out.mp4                 [converting]
    -i in.avi out.mp3                 [extract audio]
    -i in.mp4 -an out.mp4             [extract video]
    -i s.mp4 -i a.mp3 -shortest v.mp4 [merge audio and video]

    ffmpeg -i in.mp3 -filter# out.mp3 [replace # with below filters]
    :a "volume=k"                     [k scalar, k=2 double, k=0.5 half]
    :v "crop=w=600:h=400:x=100:y=200" [w-width h-height x-top y-left ]
    :v "scale=w=852:h=-1"             [proportional resolution scaling]
    :v "rotate=30*PI/180"             [rotate 30degree clockwise]
    "eq= brightness=0:                [equalization 1 0 1 is normal]
         contrast=1:                  [an change of +-0.3 is enough]
         saturation=1"

    -f concat -safe 0 -i list.txt -c copy out.mkv
    [list.txt contain{FILE 'name1'} one per line]

    -i in.mkv -ss starttime -to endtime out.mkv
    [time hh:mm:ss.ooo/ss.ooo/ss]

    -i in.mkv -filter:v "setpts=0.5*PTS" -filter:a "atempo=2.0" out.mkv
    [double speed a=2.0|v=0.5, a=n|v=1/n where 0< n <2]

    cat * | ffmpeg -framerate n -f image2pipe -i a.mp3 -acodec copy out.mkv
    [slide show, n = number of imgs/total audio seconds]

_PAGE
;;

vim) cat << _PAGE

        document
        move
        select
        edit
        insert
        replace
        back
        search
        repeat
        netrw
        autocomplete
        spell
        bookmark
        mapping
        plugin
        encryption
        register

    ---albert's vim manual since 09 Nov, 18---

    ---document---
    :q      [quit]
    :q!     [without saving]
    :w      [save]
    :wq     [save quit]
    :w name    [save with file name ]
    :w >> F    [append to a file 'F']
    :a,b w F   [save lines a to b to 'F']
    :cd %:p:h  [change to file's directory]
               [%:p gives the full named path]

    ---move---
    j k     [left right]

    w b     [word]
    e       [word-end]
    f F     [find find-back]

    0 $     [line first, end]
    ^       [first-nonempty]
    h l     [line]

    gh gl   [ignore wrap]
    ( )     [sentence]
    { }     [paragraph]

    ^e ^y   [scroll]
    ^u ^d   [page]
    gg G    [beginning end]


    ---select---
    v     [visual mode]
    V     [visual line mode]
    ^V    [visual box]

    [below cmd apply on selected text]
    d     [delete]
    c	  [change]
    y     [yank]
    >     [shift right]
    <     [shift left]

    gU    [uppercase]
    gu    [lowercase]
    ~     [togglecase]


    ---edit---
    x       [delete single]
    ^a      [increment num]
    dw      [word]
    da#     [in #, with #]
    di#     [in #, without #]
    dt#     [till #]
    dd      [line]
    J       [text wrap]
    [try 0 $ ^ ( ) { } g G]
    [same works for 'c' and 'y']


    ---insert---
    i a     [insert append]
    I A     [line first, end]
    p P     [paste below above]
    :r name [insert file content]
    :r cmd  [insert cmd output]


    ---replace---
    r       [replace single]
    R       [replace mode]
    :%s/abc/xyx   [replace abc with xyz]
    :%s/abc/xyx/g [replace all abc]
    :%s/abc/xyx/c [ask for confirmation each time]
    :g/^\s*$/d    [remove blank lines]


    ---back---
    u        [undo]
    ^r       [redo]
    :early 2 [back version before 2 min]


    ---search---
    /abc  [word or pattern after cursor , cycle n-N]
    :find abc  [filename, cycle tab-TAB, open enter]
    [use 'vs' and 'sp' to open in split]


    ---repeat---
    <num><key>  [repeats <key> num times]
    .           [dot cmd]
    :norm cmd   [apply line wise, selected lines]
    qa <cmd> q  [use @a to perform, a is variable]


    ---netrw---
    vs <directoryname>  [verticals split]
    sp <directoryname>  [horizontal split]
    i    [key to cycle between netrw views]
    ^ww  [key to cycle between splits]


    ---autocomplete---
    ^n      [general, ^n cycle]
    ^x      [filename, ^f cycle]
            [^p to cycle reverse for both]

    ---spell----
    :set spell!
    [s  ]s  [cycle error words]
    z=      [suggestion list, num enter]
    zg  zug [add and remove to dictionary]


    ---bookmark---
    ma      [mark with varible a]
    \`a      [jump to the mark]


    ---maping---
    <mode>map <key> <:comand>


    ---plugin---
    :PluginInstall  :PluginClean  :PluginUpdate
    cp ~/.vim/bundle/base16-vim/colors/* ~/.vim/colors/


    ---encryption---
    :X         [enable]
    :set key=  [disable]


    ---register---
    "ya       [copy to 'a' register]
    "yb       [paste from 'b' register]
    "y+       [ '+' system clipboard]

_PAGE
;;

*)
    man $sel 2>/dev/null || echo "Manual not found." ;;

esac
} | dmenu -l 20 >/dev/null
