const functions = require("firebase-functions");
exports.signUp = functions.https.onCall((data, context) => {
  return "Success from my function!";
});

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
