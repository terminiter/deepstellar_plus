## init 
```
export python_exe=/home/lyk/anaconda3/envs/deepspeech_0.3.0/bin/python

export LD_LIBRARY_PATH=$python_exe/../../lib/python3.6/site-packages/tensorflow/:$LD_LIBRARY_PATH
export PYTHONPATH=`pwd`

conda actiate deepspeech_0.3.0
cd /home/lyk/workspace/deepstellar_xiaoning_pc
```




## classify benign or adversial 
```
python deepstellar/applications/classify_adv.py -dl_model `pwd`/deepstellar_data/mozilla_deepspeech_models_0.1.1/  -ref_sample ./text2speech_adv.wav -sample `pwd`/deepstellar_data/audio_adv_samples/sample-001606-1.wav  -abst_model `pwd`/deepstellar_data/audio_abst/wrapper_deepspeech2_3_10.pkl -decoder_library  /home/lyk/deepspeech_binary/lib/libctc_decoder_with_kenlm.so -lm_binary `pwd`/deepstellar_data/mozilla_deepspeech_models_0.1.1/lm.binary -trie `pwd`/deepstellar_data/mozilla_deepspeech_models_0.1.1/trie
```




