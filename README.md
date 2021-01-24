# Lisa
Documentation repos for LISA, Listen and Infer Sound Automa. A short presentation is available [here](https://www.dropbox.com/s/1ddzlee5ejinccg/liviani_defense_presentation_hires.pdf?dl=0)

Lisa is an acoustic platform running on Raspberry PI, the main target is enable a dual direction of speech in both directions. The main features are:
* Offline computation (no access to external services). Privacy and Availability
* Tracking sources' Direction of Arrival
* Robust to environmental noise
* ROS interface for robotics applications
* Command input (vs open transcription) oriented
* Modular design for future non speech sound recognition 

LISA is embodied as a concurrent systems of nodes using MQTT and the Hermes Protocol. A wrapper to interact with ROS systems is available.

![Lisa Logo](https://github.com/lawrence-iviani/lisa/blob/main/img/lisa_logo_%201_lr.png)


An integration a further development of other open sources package, the most important:

* [ODAS](https://github.com/introlab/odas/wiki)
* [RHASSPY](https://rhasspy.readthedocs.io/en/latest/)

For my [thesis](https://www.dropbox.com/s/nq09ug1i9p7nsnz/Liviani_Thesis_booka4_final.pdf?dl=0) at the [FZI](https://www.fzi.de/de/forschung/forschungsfelder/detail/ffeld/service-robotik-und-mobile-manipulation/) a collaborative application in a shared workspace, based on [KolRob](http://kolrob.de/), was developed. 
An extension with the robot was performed using:
* [ROS](https://www.ros.org/)
* [FlexBE](http://wiki.ros.org/flexbe)

## Supported Hardware
See [Available microphone-hats](https://github.com/lawrence-iviani/lisa/blob/main/docs/install.md#microphone-hats)

* [Matrix Voice](https://matrix-io.github.io/matrix-documentation/matrix-voice/overview/)
* [Respeaker Square Array 4 mics](https://wiki.seeedstudio.com/ReSpeaker_4_Mic_Array_for_Raspberry_Pi/)
* [Respeaker Linear Array 4 mics](https://wiki.seeedstudio.com/ReSpeaker_4-Mic_Linear_Array_Kit_for_Raspberry_Pi/)

## Installation

See in  [readme in docs](https://github.com/lawrence-iviani/lisa/blob/main/docs/readme.md) for a quick start and installation from scratch (hw included).


## LISA SW Components

![LISA KolBot](https://github.com/lawrence-iviani/lisa/blob/main/img/LISA-KolRob-integration.png)

* [rhasspy-lisa-odas-hermes](https://github.com/lawrence-iviani/rhasspy-lisa-odas-hermes), the input module for Rhasspy. Acquire and select the track(s) and stream via Hermes protocol.

* [An interface in C/Pyhton ](https://github.com/lawrence-iviani/lisa-odas), receive ODAS information and could make some signal processing (denoise?). Used by rhasspy-lisa-odas-hermes

* [lisa-mqtt-ros-bridge](https://github.com/lawrence-iviani/lisa-mqtt-ros-bridge), the context session bridge between ROS clients/listeners and the internal Hermes protocol.

* [lisa-interaction-msgs](https://github.com/lawrence-iviani/lisa-interaction-msgs), messages, services used by client, like rqt or flexbe states.

* [lisa-shared-ws-flexbe-integration](https://github.com/lawrence-iviani/lisa_shared_ws_flexbe_integration)

* [lisa-flexbe-states](https://github.com/lawrence-iviani/lisa-flexbe-states), flexbe states for beahvioural state machine with acoustic interaction.

* [rhasspy-lisa-led-manager](https://github.com/lawrence-iviani/rhasspy-lisa-led-manager), led manager syncronized with the hermes protocol or API (todo).

# Results

Different platform was tested to determine under different condition of noise the values of:

![Lisa Logo](https://github.com/lawrence-iviani/lisa/blob/main/img/setup_basic.png)

* Time lantency in waking up, speech to text transcription and intent recognition.
* Intent error Rate.

![Lisa Logo](https://github.com/lawrence-iviani/lisa/blob/main/img/snr_vs_ier.png)
![Lisa Logo](https://github.com/lawrence-iviani/lisa/blob/main/img/latency_times_source70db.png)

From a usability perspective a usability test was performed with several human testers in a collaborative workspace shaerd with a [Robot (Project KolRob)](http://kolrob.de/). An application of screwing  4 screws into mechanical parts was used as reference application (click on imnage for a video link).

[![KolRob Collabortive Screws](https://github.com/lawrence-iviani/lisa/blob/main/img/kolbot_3.png)](https://www.youtube.com/watch?v=tPZQSKHbyq8&list=PLNwYeWqirr_4pzVoIIvbSWgzg_S10A9QT&index=10)

The following interaction indexes were deterimined with a video recording

![Free Time](https://github.com/lawrence-iviani/lisa/blob/main/img/FT.png)
![Robot Attention Demand](https://github.com/lawrence-iviani/lisa/blob/main/img/RAD.png)
![Fanout](https://github.com/lawrence-iviani/lisa/blob/main/img/FANOUT.png)


And a questionnaire filled by the tester to assess the improvement with and without LISA

![Subjective Evaluation without Acoustic Channel](https://github.com/lawrence-iviani/lisa/blob/main/img/subj_validation_1.png)
![Subjective Evaluation with Acoustic Channel](https://github.com/lawrence-iviani/lisa/blob/main/img/subj_validation_2.png)
![Subjective Improvement](https://github.com/lawrence-iviani/lisa/blob/main/img/subj_validation_3.png)

Link to [test profiler](https://github.com/lawrence-iviani/lisa_profiler) containing the acquisition, processing, results, and the original data.

Video examples:

* As input command device with [RQT example](https://www.dropbox.com/home/video%20lisa?preview=RQT_1.avi)
* As operator with [acoustic interaction input](https://www.dropbox.com/s/i7w6ukjgry3g6cm/operator_kolrob.avi?dl=0)


# External SW Components

The most notable components used integrated in LISA are:

## ODAS
[ODAS](https://github.com/introlab/odas) stands for Open embeddeD Audition System. This is a library dedicated to perform sound source localization, tracking, separation and post-filtering. ODAS is coded entirely in C, for more portability, and is optimized to run easily on low-cost embedded hardware. ODAS is free and open source.


## RHASSPY 

[Rhasspy](https://rhasspy.readthedocs.io/en/latest/) (pronounced RAH-SPEE) is an open source, fully offline voice assistant toolkit for many languages that works well with Home Assistant, Hass.io, and Node-RED.

## Speech Recognition

ASR engine used and evaluted.

### KALDI 

[Kaldi](https://kaldi-asr.org/) is a toolkit for speech recognition, intended for use by speech recognition researchers and professionals. Find the code repository on [git](http://github.com/kaldi-asr/kaldi)

### DEEPSPEECH

Only evaluated:

[DeepSpeech](https://github.com/mozilla/DeepSpeech) is an open source Speech-To-Text engine, using a model trained by machine learning techniques based on Baidu's Deep Speech research paper. Project DeepSpeech uses Google's TensorFlow to make the implementation easier.

Documentation for installation, usage, and training models is available on [deepspeech.readthedocs.io](http://deepspeech.readthedocs.io/?badge=latest)


