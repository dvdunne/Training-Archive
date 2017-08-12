Coursera Data Science Capstone Project - Text Predict
========================================================
author: An application for predicting text based on input from a user 
date: Dave Dunne 4/10/2016
autosize: false
width: 960
height: 700
transition: fade
transition-speed: fast
font-family: 'Helvetica'


Description of The Shiny App
========================================================

The **Text Predict** application allows the user to input a phrase and the application will predict the next word.

The US English-HC Corpora was used to generate the prediction model. 

This application can be found at <http://dvd940.shinyapps.io/TextPredict/>

#### Notes

1. After the application loads, it can take another 5 to 10 seconds for the model data to load. 
2. Enter a minimum of 3 words for the prediction to start. 
3. Prediction is done automatically without the user needing to press a button.

Algorithm Description
========================================================

#### Preprocessing
Ngram tables were created by processing the the corpus as follows. **Good Turing smoothing** was the last step in this process.  
<div align="left">
<img src="img\preprocessflow.png" width=552 height=76>
</div>

#### Prediction
When predicting, a **backoff** method is used where a search is made for the highest order Ngram and if that is not found then a search is made for the next highest Ngram. And so on ...
<div align="left">
<img src="img\predictflow.png" width=640 height=192>
</div>


Shiny App Usage Instructions
========================================================


<div align="left">
<img src="img\shinyhelp1.png" width=474 height=192>
</div>

A. Enter the beginning of a sentence in the input box (1)

B. The next predicted word will appear in the output pane on the right side (2)

<div align="left">
<img src="img\shinyhelp4.png" width=474 height=192>
</div>

C. If you want the three words with the highest predicted probabilities you can select this with the "Number of Predicted Words radio buttons" (3)

Additional Notes on App Function
========================================================

#### Preprocessing

1. A 10% sample of the corpus was used. 
2. Only terms with frequency of 2 or more were kept.
3. All numbers and most punctuation was removed.
4. Profanity was removed.
5. Smoothing was achieved using Good Turing Smoothing.
6. All these steps were completed offline and the resulting models stored in data frames which were uploaded to the app. 

#### Prediction

1. The model uses 4 gram, 3 gram, 2 gram and 1 gram terms.
2. Upon text input of 3 or more words, the app automatically attempts to predict by first searching a 4 gram table for a match of the last 3 words. If a match is made, then the 4 gram with the highest probability is used and the last word is displayed as the prediction. 
3. If a 4 gram match is not found, then the last two words of the input is chosen and checked against the 3 gram table and the process continues though the 2 gram and 1 gram tables until a match is found. 
4. If no match is found, then the highest probability 1 gram will be displayed ("the").

