#!/usr/bin/env bash

project_dir=$1
unity_app=$2
op=$3

if [ -z "$1" ] || [ -z "$2" ]
then
    echo "hybirdclr_link [project_dir] [unity_app] [op]"
    exit 0
fi

if [ ! -e "$unity_app" ] || [ ! -d "$unity_app" ]
then
    echo "Unity App doesn't exist, [$unity_app]"
    exit 1
fi

if [ ! -e "$unity_app" ] || [ ! -d "$unity_app" ]
then
    echo "Project doesn't exist, [$project_dir]"
    exit 1
fi

target_lib="$unity_app/Contents/il2cpp/libil2cpp"
target_lib_bk="$unity_app/Contents/il2cpp/libil2cpp_"
source_lib="$project_dir/HybridCLRData/LocalIl2CppData-OSXEditor/il2cpp/libil2cpp"

if [ "$op" = "link" ]
then
    if [ -e "$target_lib" ]
    then
        mv "$target_lib" "${target_lib_bk}"
    fi

    ln -s "$source_lib" "$target_lib"
elif [ "$op" = "unlink" ]
then
    if [ -h "$target_lib" ]
    then
        unlink "$target_lib"
    fi

    if [ -e "$target_lib_bk" ]
    then
        mv "$target_lib_bk" "${target_lib}"
    fi
else
    echo "no operation"
fi
