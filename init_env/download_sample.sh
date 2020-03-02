#!/bin/bash 

if [ -d "./deepstellar/applications/transcribe.py" ]
then
    echo "exist : deepstellar/applications/transcribe.py"

else
    wget -c https://raw.githubusercontent.com/jornbowrl/deepstellar_code/master/deepstellar/applications/transcribe.py -P deepstellar/applications/
fi 

if [ -d "./deepstellar_data/audio-samples/" ]
then
        echo "exits ./deepstellar_data/audio_seed/ deepstellar_data/audio-samples/"
else
    mkdir -p ./deepstellar_data/audio-samples/
    wget https://github.com/jornbowrl/deepstellar_plus/raw/master/data/audio-samples/bach.wav  -P ./deepstellar_data/audio-samples/
    wget https://github.com/jornbowrl/deepstellar_plus/raw/master/data/audio-samples/bach_adv.wav  -P ./deepstellar_data/audio-samples/
    wget https://github.com/jornbowrl/deepstellar_plus/raw/master/data/audio-samples/extra2a.wav  -P ./deepstellar_data/audio-samples/
    wget https://github.com/jornbowrl/deepstellar_plus/raw/master/data/audio-samples/extra2a_adv.wav  -P ./deepstellar_data/audio-samples/
    wget https://github.com/jornbowrl/deepstellar_plus/raw/master/data/audio-samples/extra3a.wav  -P ./deepstellar_data/audio-samples/
    wget https://github.com/jornbowrl/deepstellar_plus/raw/master/data/audio-samples/extra3a_adv.wav  -P ./deepstellar_data/audio-samples/
    wget https://github.com/jornbowrl/deepstellar_plus/raw/master/data/audio-samples/extra_01a.wav  -P ./deepstellar_data/audio-samples/
    wget https://github.com/jornbowrl/deepstellar_plus/raw/master/data/audio-samples/extra_01a_adv.wav  -P ./deepstellar_data/audio-samples/
    wget https://github.com/jornbowrl/deepstellar_plus/raw/master/data/audio-samples/extra_0a.wav  -P ./deepstellar_data/audio-samples/
    wget https://github.com/jornbowrl/deepstellar_plus/raw/master/data/audio-samples/extra_0a_adv.wav  -P ./deepstellar_data/audio-samples/

    wget https://github.com/jornbowrl/deepstellar_plus/raw/master/data/audio-samples/normal0.wav  -P ./deepstellar_data/audio-samples/
    wget https://github.com/jornbowrl/deepstellar_plus/raw/master/data/audio-samples/normal0_adv.wav  -P ./deepstellar_data/audio-samples/

fi


