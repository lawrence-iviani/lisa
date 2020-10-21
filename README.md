# Lisa
Documentation repos for LISA 


# SW Components

* [rhasspy-lisa-odas-hermes](https://github.com/lawrence-iviani/rhasspy-lisa-odas-hermes), the input module for Rhasspy. Acquire and select the track(s) and stream via Hermes protocol.

* [An interface in C/Pyhton ](https://github.com/lawrence-iviani/lisa-odas), receive ODAS information and could make some signal processing (denoise?). Used by rhasspy-lisa-odas-hermes

* [lisa-mqtt-ros-bridge](https://github.com/lawrence-iviani/lisa-mqtt-ros-bridge), the context session bridge between ROS clients/listeners and the internal Hermes protocol.

* [lisa-interaction-msgs](https://github.com/lawrence-iviani/lisa-interaction-msgs), messages, services used by client, like rqt or flexbe states.

* [lisa-flexbe-states](https://github.com/lawrence-iviani/lisa-flexbe-states), flexbe states for beahvioural state machine with acoustic interaction.

* [rhasspy-lisa-led-manager](https://github.com/lawrence-iviani/rhasspy-lisa-led-manager), led manager syncronized with the hermes protocol or API (todo).

# External SW Components

## RHASSPY 

[Rhasspy](https://rhasspy.readthedocs.io/en/latest/) (pronounced RAH-SPEE) is an open source, fully offline voice assistant toolkit for many languages that works well with Home Assistant, Hass.io, and Node-RED.

## Speech Recognition

ASR engine used.

### KALDI 

[Kaldi](https://kaldi-asr.org/) is a toolkit for speech recognition, intended for use by speech recognition researchers and professionals. Find the code repository on [git](http://github.com/kaldi-asr/kaldi)

### DEEPSPEECH

[DeepSpeech](https://github.com/mozilla/DeepSpeech) is an open source Speech-To-Text engine, using a model trained by machine learning techniques based on Baidu's Deep Speech research paper. Project DeepSpeech uses Google's TensorFlow to make the implementation easier.

Documentation for installation, usage, and training models is available on [deepspeech.readthedocs.io](http://deepspeech.readthedocs.io/?badge=latest)
