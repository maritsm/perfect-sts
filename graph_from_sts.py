STS_NUMBERS = [7, 9, 25, 33, 79, 139, 367, 811, 1531, 25771, 50923, 61339, 69991]

def resolve_str(s):
    return [int(x) for x in s.split()]

if __name__ == "__main__":
    for v in STS_NUMBERS:
        output_graph = []
        try:
            with open("sts" + str(v) + ".txt", "r") as f:
                chosen_edge = f.readline()
                #print(chosen_edge)
                chosen = resolve_str(chosen_edge)
                for line in f:
                    if line == chosen_edge:
                        continue
                    else:
                        vertices = resolve_str(line)
                        for i in vertices:
                            if i in chosen:
                                vertices.pop(vertices.index(i))
                                #print(vertices)
                                output_graph.append(vertices)
                                break

        except FileNotFoundError:
            print("sts" + str(v) + ".txt: File does not exist")
            continue

        with open("graph" + str(v) + ".txt", "w") as f:
            for e in output_graph:
                f.write(f"{e[0]} {e[1]}\n")