//*set of locationsACTF stores the locationIndexData from firestore.
//Set also prevents duplicates during multiple runs of [dataFromFirestore];
Set locationsActf = {};

//*recieveInputFlag is used to control the data passed into the Stream;
bool recieveInputFlag = true;
