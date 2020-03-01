#!/bin/bash 

if [ -d "./deepstellar_data/mozilla_deepspeech_models_0.3.0" ]
then
	echo "Directory /path/to/dir exists. deepstellar_data/mozilla_deepspeech_models_0.3.0 "
else
	mkdir -p  deepstellar_data/mozilla_deepspeech_models_0.3.0/
	wget https://github.com/mozilla/DeepSpeech/releases/download/v0.3.0/deepspeech-0.3.0-checkpoint.tar.gz -P  deepstellar_data/
	tar -xf  ./deepstellar_data/deepspeech-0.3.0-checkpoint.tar.gz -C ./deepstellar_data//mozilla_deepspeech_models_0.3.0/
fi



if [ -d "./deepstellar_data/audio_vectors" ] 
then 
	echo "exits ./deepstellar_data/audio_vectors  "	
else 
	wget https://github.com/jornbowrl/deepstellar_plus/raw/master/data/full_k.npy -P  ./deepstellar_data/audio_vectors/
fi 



if [ -d "./deepstellar_data/mozilla_deepspeech_models_0.1.1/" ]
then
        echo "exits ./deepstellar_data/mozilla_deepspeech_models_0.1.1/ "
else
	mkdir -p  ./deepstellar_data/mozilla_deepspeech_models_0.1.1/
        wget https://github.com/mozilla/DeepSpeech/releases/download/v0.1.1/deepspeech-0.1.1-checkpoint.tar.gz  -P  ./deepstellar_data/
	tar -xf  ./deepstellar_data//deepspeech-0.1.1-checkpoint.tar.gz -C ./deepstellar_data/mozilla_deepspeech_models_0.1.1/
	mv ./deepstellar_data/mozilla_deepspeech_models_0.1.1/checkpoint  ./deepstellar_data/mozilla_deepspeech_models_0.1.1_bak
	rm ./deepstellar_data/mozilla_deepspeech_models_0.1.1
	mv ./deepstellar_data/mozilla_deepspeech_models_0.1.1_bak ./deepstellar_data/mozilla_deepspeech_models_0.1.1
fi



if [ -d "./deepstellar_data/audio_seed/" ]
then
        echo "exits ./deepstellar_data/audio_seed/ "
else

	wget https://github.com/karolpiczak/ESC-50/raw/master/audio/1-100032-A-0.wav  -P deepstellar_data/audio_seed
	wget https://github.com/karolpiczak/ESC-50/raw/master/audio/1-100038-A-14.wav  -P deepstellar_data/audio_seed
	wget https://github.com/karolpiczak/ESC-50/raw/master/audio/1-100210-A-36.wav  -P deepstellar_data/audio_seed


fi 





###### conda 


/home/lyk/anaconda3/envs/deepspeech_0.3.0/bin/pip install -r  req.txt 
/home/lyk/anaconda3/envs/deepstellar_mnist/bin/pip install -r  req.txt
