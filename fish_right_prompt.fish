# name: spaceship
# A fish theme with spaceships in mind

function fish_right_prompt # -d "Right side prompt message"
    set -l last_status $status
    set -l red        (set_color red)
    set -l green      (set_color green)
    set -l normal     (set_color normal)

    # Turn prompt red if last command failed
    if test $last_status -ne 0
        echo -n -s $red   (date +%H:%M:%S) $normal
    else
        echo -n -s $green (date +%H:%M:%S) $normal
    end
end
