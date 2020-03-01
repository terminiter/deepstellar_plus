Deepstellar Speech 
======
This repository contains our model-based analysis framework for the RNN .


## The structure of the repository
It is structured as follows:

```
├── deepstellar_data/
├── deepstellar_img_demo/
├── deepstellar/
├──├──init.sh
└──├──req.txt
├──├──README.md
```


### deepstellar/
This directory contains the core implementation for the evaluation of  in the paepr

### deepstellar_data/
This directory contains the train and temporary generated data by abstraction, feature extraction, *wav example and checkpoint_mozilla_deepspeech 


### deepstellar_img_demo/
This directory contains the use cases including the image classification for mnist 

## Usage
### Install and prepare data [tiny size for tutorial] 
```
cd /home/lyk/workspace/deepstellar_xiaoning_pc
# if file not exist, pls download 
wget https://github.com/jornbowrl/deepstellar_plus/raw/master/init_env/init.sh
sh init.sh 
```

**Note that the results depend on the precision of the automata. 
In the example, we just randomly set some parameters , 
so the results may not be very good due to that the autamoton is not the best one.
To get better results, please select better automaton. More detail pls check in paper .**



## step-1: build asbtract
 
```
 #cd /home/lyk/workspace/deepstellar_xiaoning_pc
export PYTHONPATH=`pwd`
conda activate deepstellar_mnist  
 #tf>1.4.0
python  deepstellar/applications/generate_abstrac_model.py -dl_model `pwd`/deepstellar_data/mozilla_deepspeech_models_0.3.1/ -profile_data `pwd`/deepstellar_data/audio_seed/  -profile_save_path `pwd`/deepstellar_data/audio_vectors -k 2 -m 3 -name_prefix deepspeech -abst_save_path `pwd`/deepstellar_data/audio_abst
```


The meanings of the options are:

1. `-k` determines the number of dimensions to be reduced by PCA
2. `-m` number the intervals on each dimension.
3. `-dl_model ` path of dl model
4. `-profile_data ` path of data to do the profiling
5. `-profile_save_path ` dir to save profiling raw data 
6. `-name_prefix ` name prefix when save the abstract model
7. `--abst_save_path` path to save abstract model

After the step 1, we will get one RNN model, several abstract models (i.e., automata) with different numnbers of components and the extracted features (for traning/test data) with the abstract models.
It save the information of the abstract models in `deepstellar_data/audio_abst/`



## step-2: evaluate the asbtraction :

 * 2.1, Visualize the generated the abstract model or the state 
trace of a sample

```
 #/home/lyk/workspace/deepstellar_xiaoning_pc
 # conda activate deepstellar_mnist
python deepstellar/applications/visiualizer.py -abst_model `pwd`/deepstellar_data/audio_abst/wrapper_deepspeech_2_3.pkl -type model -save_folder `pwd`/deepstellar_data/visiualization/
```
 the file save in " deepstellar_data/visiualization/model.gv.pdf"
 ![](https://github.com/jornbowrl/deepstellar_plus/raw/master/images_paper/abs_step2_copy.png)

 * 2.2, Visualize the PCA cluster 


```
python deepstellar/applications/visiualizer.py -abst_model `pwd`/deepstellar_data/audio_abst/wrapper_deepspeech2_3_10.pkl -type trace -save_folder `pwd`/deepstellar_data/visiualization/ -dl_model `pwd`/deepstellar_data/mozilla_deepspeech_models_0.1.1/ -sample `pwd`/deepstellar_data/audio_seed/1-100038-A-14.wav
```
 the file save in " deepstellar_data/visiualization/pca_trace.pdf"
 ![](https://github.com/jornbowrl/deepstellar_plus/raw/master/images_paper/pca_trace_copy.png)

**To reproduce the similar results for paper, please set -k and -m same as paper 
In the following , please select the better automaton which has m components (by setting -components m) 
based on the stability values 

The meanings of the options are:

1. `-abst_model` path to save abstract model
2. `-type` visualize type `model`, `trace`
3. `-save_folder` folder to save the figure
4. `-dl_model ` path of dl model
3. `-sample` generate trace for the sample
4. `-id` identifier for saved file name

It will output the results in the pdf [deepstellar_data/visiualization/] .

## step-3 For adversarial detection:

RQ: it will show the pattern for Adversarial Sample Detection

* step-3.1: swtich to tf 1.4.0 and export some essential variable by `exprt`

```
 #/home/lyk/workspace/deepstellar_xiaoning_pc

conda activate deepspeech_0.3.0
python -c "import tensorflow as tf ;print (tf.__version__);" 


# which python 
export python_exe=`which python`
export LD_LIBRARY_PATH=$python_exe/../../lib/python3.6/site-packages/tensorflow/:$LD_LIBRARY_PATH
export PYTHONPATH=`pwd`

# assert tf.__version__ =="1.4.0"
```

**this is important to goto 1.4.0 tf, because we just adapte the libctc_decoder_with_kenlm.so in tf_1.40 and deepspeech_0.1.1** 

* step-3.2(good): calculate the metrics for goodcase inputs

```
python deepstellar/applications/classify_adv.py -dl_model `pwd`/deepstellar_data/mozilla_deepspeech_models_0.1.1/  -ref_sample ./text2speech_adv.wav   -abst_model `pwd`/deepstellar_data/audio_abst/wrapper_deepspeech2_3_10.pkl -decoder_library  /home/lyk/deepspeech_binary/lib/libctc_decoder_with_kenlm.so -lm_binary `pwd`/deepstellar_data/mozilla_deepspeech_models_0.1.1/lm.binary -trie `pwd`/deepstellar_data/mozilla_deepspeech_models_0.1.1/trie -sample `pwd`/deepstellar_data/audio_adv_samples/sample-001606-0.wav

```

* step-3.3(bad): calculate the metrics for attacked-case inputs

```
python deepstellar/applications/classify_adv.py -dl_model `pwd`/deepstellar_data/mozilla_deepspeech_models_0.1.1/  -ref_sample ./text2speech_adv.wav   -abst_model `pwd`/deepstellar_data/audio_abst/wrapper_deepspeech2_3_10.pkl -decoder_library  /home/lyk/deepspeech_binary/lib/libctc_decoder_with_kenlm.so -lm_binary `pwd`/deepstellar_data/mozilla_deepspeech_models_0.1.1/lm.binary -trie `pwd`/deepstellar_data/mozilla_deepspeech_models_0.1.1/trie -sample `pwd`/deepstellar_data/audio_adv_samples/sample-001606-1.wav

```
* the different  between step-2.0 with step-2.1 is the last audio filename, which change from "sample-001606-0.wav" to "sample-001606-1.wav"

 


The meanings of the options are:

1. `-sample` path to the audio to classify
2. `-ref_sample` path to the audio generated by test2speech engine
3. `-dl_model` path to the checkpoint(0.1.1)
4. `-decoder_library` path to the decoder library ,default: libctc_decoder_with_kenlm.so 
5. `-lm_binary` lm_binary from mozillar deepspeech's release version, more detail pls goto https://github.com/mozilla/DeepSpeech/releases/tag/v0.1.1 






#Ackownledge
* [xiaoning](mailto:dxn0733@gmail.com)
* [wangjian](mailto:jornbowrl@gmail.com)
* [xiaofei](mailto:xiaofei.xfxie@gmail.com)
* [malei](mailto:leima.2011@gmail.com)


