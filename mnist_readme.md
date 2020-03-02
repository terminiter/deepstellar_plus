Deepstellar Speech 
======
This repository contains our model-based analysis framework for the RNN .


## The structure of the repository
It is structured as follows:

```
├── output/
├── deepstellar_img_demo/
├── deepstellar/
├──├──init.sh
└──├──req.txt
├──├──README.md
```


 ## Usage
### Install and prepare data [tiny size for tutorial] 
```
cd /home/lyk/workspace/deepstellar_xiaoning_pc
# if file not exist, pls download 
```

## step-1: build asbtract
 
```
export PYTHONPATH=`pwd`
conda activate deepstellar_mnist  
 #tf>1.4.0

cd /home/lyk/workspace/deepstellar_xiaoning_pc
cd deepstellar_img_demo

python  deepstellar/applications/generate_abstrac_model.py -dl_model `pwd`/output/mozilla_deepspeech_models_0.3.0/  -profile_save_path `pwd`/output/audio_vectors -k 2 -m 3 -name_prefix deepspeech -abst_save_path `pwd`/output/audio_abst
```

The meanings of the options are:

1. `-k` determines the number of dimensions to be reduced by PCA
2. `-m` number the intervals on each dimension.
3. `-dl_model ` path of dl model
4. `-name_prefix `  default [mnist_lstm]
5. `-profile_save_path ` dir to save profiling raw data 
7. `--abst_save_path` path to save abstract model

* In this demonstration, we only use part of the training data for profiling, which contains 2500 images in total




## step-2: evaluate the asbtraction :

 * 2.1, Visualize the generated the abstract model or the state 
trace of a sample

```
 #/home/lyk/workspace/deepstellar_xiaoning_pc
 # conda activate deepstellar_mnist
 # cd deepstellar_img_demo

python visiualizer.py -abst_model output/dtmc_models/wrapper_mnist_lstm_2_3.pkl -type model -save_folder  output/visiualization/
```

 * 2.2, Visualize the PCA cluster 


```
python visiualizer.py -abst_model output/dtmc_models/wrapper_mnist_lstm_2_3.pkl  -type trace -save_folder output/visiualization/  -dl_model saved_lstm_model/mnist-lstm-model.h5   -sample prepared_mnist_samples/samples_to_visualize/test_2.png 
```

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

It will output the results in the pdf [output/visiualization/] .

## step-3 For adversarial detection:

RQ: it will show the pattern for Adversarial Sample Detection

* step-3.0(correct): calculate the metrics for goodcase inputs

```
python classify_adv.py -dl_model saved_lstm_model/mnist-lstm-model.h5   -abst_model output/dtmc_models/wrapper_lstm-mnist_2_80.pkl -classifier  for_detection/reg_classifier_transition_2_80.pkl  -sample for_detection/adv/img_3.png 

``` 


The meanings of the options are:

1. `-sample` path to the audio to classify
2. `-dl_model` path to the checkpoint(0.1.1)
3. `-abst_model ` This is a prepared abstract model established on the full profiling of training data
4. `-classifier ` This is the pre-trained classifier specially for the 2_80 abstraction configuration






#Ackownledge


