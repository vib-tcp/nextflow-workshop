#!/usr/bin/env python

def main():
    lengths: list[float] = []
    weights: list[float] = []
    names: dict[str,int] = {}

    with open("${file}") as f:
        lines: list[str] = f.readlines()
        header: list[str] = lines[0].strip().split("\t")
        lengths_index: int = header.index("Observed_Length_(m)")
        weights_index: int = header.index("Observed_Weight_(kg)")
        name_index: int = header.index("Common_Name")
        lines = lines[1:]
        for line in lines:
            prep_line: list[str] = line.strip().split("\t")
            lengths.append(float(prep_line[lengths_index]))
            weights.append(float(prep_line[weights_index]))
            name: str = prep_line[name_index]
            if name not in names:
                names[name] = 0
            names[name] += 1

    with open("${country}_summary.txt", "w") as outfile:
        outfile.write(f"Country: ${country}\\n")
        outfile.write(f"Mean length: {sum(lengths)/len(lengths)}\\n")
        outfile.write(f"Mean weight: {sum(weights)/len(weights)}\\n")
        outfile.write("Occurences:\\n")
        for name, count in names.items():
            outfile.write(f" - {name}: {count}\\n")

if __name__ == "__main__":
    main()