from google.cloud import firestore
from google.api_core import datetime_helpers
import json
import sys


def myconverter(o):
    if isinstance(o, datetime_helpers.DatetimeWithNanoseconds):
        return o.rfc3339()


def main():
    db = firestore.Client()

    if len(sys.argv) != 3:
        print('usage: %s <path to collection> <outfile>' % sys.argv[0])
        sys.exit(1)

    startcollection = sys.argv[1]
    outfile = sys.argv[2]

    print("Downloaded collection %s to %s" % (startcollection, outfile))

    ref = db.collection(startcollection).stream()
    result = dict()
    result[startcollection] = {}

    for doc in ref:
        docdict = doc.to_dict()
        result[startcollection][doc.id] = docdict

    with open(outfile, 'w') as fp:
        json.dump(result, fp, default=myconverter, indent=2, sort_keys=True)


if __name__ == '__main__':
    main()
