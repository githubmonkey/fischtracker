from google.cloud import firestore
from google.api_core import datetime_helpers
import json
import sys


# remove empty keys and fix dates
def fixRecord(docdata):
    newdata = dict()
    for (key, value) in docdata.items():
        if (value is None):
            print('skipping key %s %s' % (key, value))
            continue

        if (key == 'createdAt' or key == 'updatedAt' or key == 'playedAt'):
            newdata[key] = datetime_helpers.from_rfc3339(value)
        else:
            newdata[key] = value
    return newdata


def main():
    db = firestore.Client(project='fisch-tracker')

    if len(sys.argv) != 3:
        print('usage: %s <datafile> <target col>' % sys.argv[0])
        sys.exit(1)

    datafile = sys.argv[1]
    targetcollection = sys.argv[2]

    print("Upload data from %s to %s" % (datafile, targetcollection))

    with open(datafile) as file:
        data = json.load(file)

    batch = db.batch()

    for docid in data[targetcollection]:
        docdata = data[targetcollection][docid]
        #docdata = fixRecord(docdata)
        print('docid %s' % docid)
        print('docdata %s' % docdata)
        docref = db.collection(targetcollection).document(docid)
        batch.set(docref, docdata)

    batch.commit()


if __name__ == '__main__':
    main()
