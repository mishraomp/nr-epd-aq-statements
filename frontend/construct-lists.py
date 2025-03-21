import datetime
import os
import re

import yaml

"""
This script generates two files as part of the pre-render process for quarto site generation

RECENTS_FILE_NAME will contain a yaml list of files with a date attribute newer than RECENT_THRESHOLD_DAYS

SSB_FILE_NAME will contain any with an `ssb` meta attribute set to True

These are then used in custom listings within the qmd markup
"""

# editable -- consider posts less than RECENT_THRESHOLD_DAYS days old to be "recent"
# Hardcoded below to 1 day for smoky skies bulletins with ice = Issue metadata
RECENT_THRESHOLD_DAYS = 5
RECENTS_FILE_NAME = '_recent_statements.yaml'

SSB_FILE_NAME = '_ssb.yaml'

# globals. do not modify.
INPUT_FILES = os.getenv('QUARTO_PROJECT_INPUT_FILES').split("\n")
HEADER_REGEX = re.compile('^---\n((.*\n)+)---\n', re.MULTILINE)

RECENT_STATEMENTS = []
SMOKY_SKIES_BULLETINS = []


def process_input_files():
    for f in INPUT_FILES:
        if not f:
            continue  # skip empty input lines

        print("processing input file: {file}".format(file=f))

        with open(f, 'r') as file:
            contents = file.read()
            match = HEADER_REGEX.search(contents)
            if match:
                doc_preamble = match.group(1)
                parsed_header = yaml.safe_load(doc_preamble)

                # what goes in the generated yaml
                entry_from_header = {
                    'path': f,
                    'title': parsed_header['title'],
                    'type': parsed_header['type'] if 'type' in parsed_header else 'N/A',
                    'ice': parsed_header['ice'] if 'ice' in parsed_header else 'N/A',
                    'date': parsed_header['date'] if 'date' in parsed_header else None,
                    'location': parsed_header['location'] if 'location' in parsed_header else None,
                }

                if 'type' in parsed_header and parsed_header['type'].lower() == 'ssb':
                    if 'date' in parsed_header:
                        age = (datetime.date.today() - parsed_header['date']).days
                        threshold = RECENT_THRESHOLD_DAYS

                        if 'ice' in parsed_header and parsed_header['ice'].lower() == 'issue':
                            threshold = 1  # Only 1 day for SSB with ice = Issue

                        if age < threshold:
                            SMOKY_SKIES_BULLETINS.append(entry_from_header)

                # not mutually exclusive with ssb
                if 'date' in parsed_header:
                    skip = False

                    # uncomment this stanza to exclude SSB from recent statements list
                    #   if 'type' in parsed_header and parsed_header['type'].lower() == 'ssb':
                    #      skip = True

                    if not skip:
                        age = (datetime.date.today() - parsed_header['date']).days
                        if age < RECENT_THRESHOLD_DAYS:
                            RECENT_STATEMENTS.append(entry_from_header)


print(yaml.safe_dump(INPUT_FILES))

process_input_files()

with open(RECENTS_FILE_NAME, 'w') as output_file:
    yaml.safe_dump(RECENT_STATEMENTS, output_file)

with open(SSB_FILE_NAME, 'w') as output_file:
    yaml.safe_dump(SMOKY_SKIES_BULLETINS, output_file)
