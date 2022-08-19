#!/bin/bash

# author: Marcos Oliveira <terminalroot.com.br>
# describe: Script to create an initial structure for posts in Jekyll
# version: 1.0
# license: MIT License
# edited: Miguel Rosa <miguelrosa.programacao@gmail.com>

_usage(){
  cat <<EOF
usage: ${0##*/} options [title]
  
  Options:
    -c [title]    Create post title
    -h            Print this help message
    -v            Print version

* Script in development
EOF

}


_skell(){

    _DATE=$(date +%Y-%m-%d)
    _TIME=$(date +%H:%M:%S)

    echo "---"
    echo "layout: post"
    echo "title: \"${1}\""
    echo "date: ${_DATE} ${_TIME}"
    echo "img:  #add image => <titulo_post>/<imagem>.png|jpg|etc"
    echo "description: ''"
    echo "fig-caption:"
    echo "tags: []"
    echo "author: 'Miguel Rosa'"
    echo "---"
    echo
    echo '
'
}


_initpost(){

    _PADRAO=$(date +%Y-%m-%d)
    _URL=$(echo $1 | sed 's/+/-/g' | tr A-Z a-z | tr -d '!@#$%&*()_<>}{~?^/:\"' | tr ' ' '-' | sed 's/--//g' |
          sed 'y/áÁàÀãÃâÂéÉêÊíÍóÓõÕôÔúÚüÜçÇ/aAaAaAaAeEeEiIoOoOoOuUuUcC/' | tr -d ',.;:' | sed 's/-$//g')
    if [[ ! -f "_posts/${_PADRAO}-${_URL}.md" ]] ; then
      _skell "$1" > "_posts/$_PADRAO-$_URL.md"    
      mkdir "assets/img/posts/$_PADRAO-$_URL"
      echo -e "\e[36;1m➜ Post created successfully!\n\e[37;1m"
      echo -e "\e[37;1mPost:\e[m _posts/$_PADRAO-$_URL"
      echo -e "\e[37;1mData:\e[m _assets/img/posts/$_PADRAO-$_URL\n\n"
    else
      echo -e "\e[31;1m✖ Error: Post name Already Exists.\e[m"
    fi

}

while getopts c:vh PARAM
do 
	case "$PARAM" in
		c) _initpost "$OPTARG" ;;
		h) _usage && exit 0   ;;
		v) sed -n '/^#.*version/p' $0 | sed 's/^# //' ;;
		*) _usage && exit 1   ;;
	esac
# shift $(( OPTIND - 1 ))
done
