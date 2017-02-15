# name: spaceship
# A fish theme with spaceships in mind

set prompt_glyph ➔
set newline '
'

function _git_branch_name
    echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function fish_prompt
    set -l last_status $status
    set -l black        (set_color black)
    set -l red          (set_color red)
    set -l green        (set_color green)
    set -l yellow       (set_color yellow)
    set -l blue         (set_color blue)
    set -l magenta      (set_color magenta)
    set -l cyan         (set_color cyan)
    set -l white        (set_color white)
    set -l bg_black     (set_color -b black)
    set -l bg_red       (set_color -b red)
    set -l bg_green     (set_color -b green)
    set -l bg_yellow    (set_color -b yellow)
    set -l bg_blue      (set_color -b blue)
    set -l bg_magenta   (set_color -b magenta)
    set -l bg_cyan      (set_color -b cyan)
    set -l bg_white     (set_color -b white)
    set -l bold_black   (set_color -o black)
    set -l bold_red     (set_color -o red)
    set -l bold_green   (set_color -o green)
    set -l bold_yellow  (set_color -o yellow)
    set -l bold_blue    (set_color -o blue)
    set -l bold_magenta (set_color -o magenta)
    set -l bold_cyan    (set_color -o cyan)
    set -l bold_white   (set_color -o white)
    set -l normal       (set_color normal)
    set -l cwd $white(prompt_pwd)
    set -l uid (id -u $USER)

    echo -n -s $newline

    # Show a yellow radioactive symbol for root privileges
    if [ $uid -eq 0 ]
        echo -n -s $yellow "root" $normal " at "
    end

    # Display current path
    echo -n -s $green (prompt_pwd) $normal

    # Show git branch and dirty state
    if [ (_git_branch_name) ]
        set -l git_branch (_git_branch_name)
        set ind ""
        if [ (git_is_staged) ]
            set ind "$ind+"
        end
        if [ (git_is_dirty) ]
            set ind "$ind!"
        end
        if [ (git_untracked_files) != 0 ]
            set ind "$ind?"
        end
        if [ (git_is_stashed) ]
            set ind "$ind\$"
        end

        if [ $ind != "" ]
            set ind "[$ind] "
        end

        echo -n -s " on " $magenta "$git_branch $ind" $normal
    end

    # Turn prompt red if last command failed
    if test $last_status -ne 0
        echo -n -s $bold_red   "$newline>>> " $normal
    else
        echo -n -s $bold_green "$newline>>> " $normal
    end
end
