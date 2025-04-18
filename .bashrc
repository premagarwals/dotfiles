#xhost +local:

export PS1='\n \[\033[94m\]╔═❁ \[\033[0m\]\[\033[33m\]𝖌𝖆𝖗𝖚𝖉𝖆\[\033[0m\] ◈ \[\033[31m\]4𝖗𝖈𝖍\[\033[0m\] \[\033[94m\]✦\[\033[1;38;5;137m\] \w \[\033[0m\]\[\033[94m\]❖═◖\[\033[1;49;5;199m\] ᎮᏒᏋᎷ \[\033[0m\]\[\033[94m\]◗══❀ \n ╚══❂ \[\033[0m\]'

neofetch --ascii ~/banner.txt
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias vnv='source .venv/bin/activate'
export GPG_TTY=$(tty)
alias run='sed -i "s/u^^^e/REPLACED/g" *.txt'


export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

rrun() {
    mkdir -p bin
    rustc -C opt-level=3 "$1.rs" -o "bin/$1" && ./bin/"$1" < .inp > .out
    echo "====< OUTPUT >===="
    mapfile -t actual_lines < .out
    mapfile -t expected_lines < .ans

    difference_found=0

    total_lines=${#expected_lines[@]}
    if [ ${#actual_lines[@]} -gt $total_lines ]; then
        total_lines=${#actual_lines[@]}
    fi

    for (( i=0; i<total_lines; i++ )); do
        expected_line="${expected_lines[i]:-}"
        actual_line="${actual_lines[i]:-}"
        
        if [ "$expected_line" = "$actual_line" ]; then
            echo "$actual_line"
        else
            echo "expected{ $expected_line } <- found{ $actual_line } <LINE $((i+1))>"
            difference_found=1
        fi
    done

    if [ $difference_found -eq 0 ]; then
        echo "====< CORRECT >===="
    else
        echo "====< WRONG >===="
    fi
}

crun() {
    mkdir -p bin
    g++ -O3 "$1.c" -o "bin/$1" && ./bin/"$1" < .inp > .out
    echo "====< OUTPUT >===="
    mapfile -t actual_lines < .out
    mapfile -t expected_lines < .ans

    difference_found=0

    total_lines=${#expected_lines[@]}
    if [ ${#actual_lines[@]} -gt $total_lines ]; then
        total_lines=${#actual_lines[@]}
    fi

    for (( i=0; i<total_lines; i++ )); do
        expected_line="${expected_lines[i]:-}"
        actual_line="${actual_lines[i]:-}"
        
        if [ "$expected_line" = "$actual_line" ]; then
            echo "$actual_line"
        else
            echo "expected{ $expected_line } <- found{ $actual_line } <LINE $((i+1))>"
            difference_found=1
        fi
    done

    if [ $difference_found -eq 0 ]; then
        echo "====< CORRECT >===="
    else
        echo "====< WRONG >===="
    fi
}
