#!/usr/bin/env python

import argparse

def main():
    parser = argparse.ArgumentParser(description="Split TSV file by country")
    parser.add_argument("input", type=str, help="Input TSV file")
    args = parser.parse_args()
    input_file:str = args.input

    data_by_country: dict[str,list[str]] = {}
    header: list[str] = ""

    with open(input_file, "r") as data:
        lines: list[str] = data.readlines()
        prep_header = lines[0].strip().split("\t")[1:]
        country_index: int = prep_header.index("Country/Region")
        header = "\t".join(prep_header)
        lines = lines[1:]
        for line in lines:
            prep_line: list[str] = line.strip().split("\t")[1:]
            country = prep_line[country_index]
            if country not in data_by_country:
                data_by_country[country] = []
            data_by_country[country].append("\t".join(prep_line))
    
    for country, lines in data_by_country.items():
        with open(f"{country}.tsv", "w") as outfile:
            outfile.write(header + "\n")
            outfile.writelines([f"{line}\n" for line in lines])

if __name__ == "__main__":
    main()