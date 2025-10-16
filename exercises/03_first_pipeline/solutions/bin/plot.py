#!/usr/bin/env python

import argparse
import pandas as pd
import plotly.express as px

def main():
    parser = argparse.ArgumentParser(description="Plot summary statistics.")
    parser.add_argument("summary_files", nargs="+", help="Paths to summary files.")
    args = parser.parse_args()

    files: list[str] = args.summary_files

    lengths: dict[str, float] = {}
    weights: dict[str, float] = {}

    for file in files:
        with open(file, "r") as infile:
            country = ""
            lines: list[str] = infile.readlines()
            country = lines[0].strip().split("Country: ")[-1]
            lengths[country] = float(lines[2].strip().split("Mean length: ")[-1])
            weights[country] = float(lines[3].strip().split("Mean weight: ")[-1])

    lengths = dict(sorted(lengths.items(), key=lambda item: item[1]))
    weights = dict(sorted(weights.items(), key=lambda item: item[1]))

    lengths_fig = px.bar(pd.DataFrame(lengths.items(), columns=["countries", "mean length (m)"]), x="countries", y="mean length (m)", title="Mean crocodile length per country")
    lengths_fig.write_html("lengths.html")
    weights_fig = px.bar(pd.DataFrame(weights.items(), columns=["countries", "mean weight (kg)"]), x="countries", y="mean weight (kg)", title="Mean crocodile weight per country")
    weights_fig.write_html("weights.html")

if __name__ == "__main__":
    main()