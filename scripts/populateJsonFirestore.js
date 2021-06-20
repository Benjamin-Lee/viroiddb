const admin = require('firebase-admin')
const serviceAccount = require('../service_key.json')

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'firebase-adminsdk-6gebx@viroiddb.iam.gserviceaccount.com',
})
const firestore = admin.firestore()

Object.entries(require('../static/meta.tmp.json')).forEach(([k, v]) => {
  firestore
    .collection('sequences')
    .doc(k)
    .set(v)
    .then(() => console.log('Document written:', k))
    .catch((error) => console.error('Error adding document: ', error))
})
