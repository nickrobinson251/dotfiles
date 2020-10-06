function fish_prompt --description 'Write out the prompt'
    set -l color_cwd
    set -l suffix
    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix '>'
    end
    if set -q AWS_PROFILE
        echo -n -s "[$AWS_PROFILE] " (set_color normal)
    else if set -q AWS_ACCESS_KEY_ID
        # We are in the context of an AWS profile, but we don't know which one.
        echo -n -s (set_color yellow) "[???] " (set_color normal)
    end
    echo -n -s "$USER" @ (prompt_hostname) ' ' (set_color $color_cwd) (prompt_pwd) (set_color normal) "$suffix "
end
