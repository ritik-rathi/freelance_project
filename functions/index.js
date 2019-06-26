const functions = require("firebase-functions");
const admin = require("firebase-admin");
const algoliasearch = require("algoliasearch");

const ALGOLIA_APP_ID = "0Y2ORSPTLW";
const ALGOLIA_ADMIN_KEY = "a4f9377710dbe090301c0d9645d5df4e";
const ALGOLIA_INDEX_NAME = "users";
var client = algoliasearch(ALGOLIA_APP_ID, ALGOLIA_ADMIN_KEY);
var index = client.initIndex(ALGOLIA_INDEX_NAME);
admin.initializeApp(functions.config().firebase);

exports.addFirestoreDataToAlgolia = functions.https.onRequest((req, res) => {
  var arr = [];

  admin
    .firestore()
    .collection("/society/0aklfheb/users")
    .get()
    .then(docs => {
      docs
        .forEach(doc => {
          let user = doc.data;
          user.objectID = doc.id;

          arr.push(user);
        })
        .catch(e => console.log(e));

      index.saveObject(arr, (err, content) => {
        res.status(200).send(content);
        console.log(err);
      });
      return null;
    })
    .catch(e => {
      console.log(e);
    });
});
