const { program } = require('commander')
const sleep = require('sleep')
const path = require('path')
const admin = require('firebase-admin')
const serviceAccount = require('../service_key.json')

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'firebase-adminsdk-6gebx@viroiddb.iam.gserviceaccount.com',
})
const firestore = admin.firestore()

program
  .version('0.1.0')
  .argument('<json>', 'The JSON file to upload to firebase')
  .argument('<collection>', 'The path to the collection')
  .action((json, collection) => {
    Object.entries(require(path.join(process.cwd(), json))).forEach(
      ([k, v]) => {
        firestore
          .collection(collection)
          .doc(k)
          .set(v)
          .then(() => console.log('Document written:', k))
          .catch((error) => console.error('Error adding document: ', error))
      }
    )
  })
program.parse()
