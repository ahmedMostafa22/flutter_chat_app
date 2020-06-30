const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.myFunction = functions.firestore.document('{recentMessages}').onWrite((change, context) => {
    return admin.messaging().sendToTopic('recentMessages', 
    { notification: { title: change.data().userEmail,
         body: change.data().message,},data: { title: change.data().userEmail,
         body: change.data().message,}});
})
