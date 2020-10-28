function fish_title
    if [ $_ = 'fish' ]
	set -g fish_prompt_pwd_dir_length 10
        echo $USER@(hostname):(prompt_pwd)
    else
        echo $argv[1]
    end
end
