import yaml
import os

with open('beispiele.yml', 'r') as file:
    drucksets = yaml.safe_load(file)

for model in drucksets:
    print(model)
    cmd = "openscad -q --enable all -p presets.json -P '" + model['name'] + "'"
    cmd += " -o stl-dateien/" + model['stl'] + ' ' + model['scad']
    print(cmd)
    os.system(cmd)
    cmd = "openscad -q --enable all -p presets.json -P '" + model['name'] + "'"
    cmd += " -o stl-dateien/" + model['png'] + ' ' + model['scad']
    print(cmd)
    os.system(cmd)

catalog = "# Modellkatalog\n\n"
catalog += "Hier sind alle fertig als STL verfügbaren Modelle:\n\n"
catalog += "| Bild | Beschreibung | Datei |\n"
catalog += "|---|---|---|\n"

for model in drucksets:
    catalog += "| ![" + model['name'] + "](./" + model['png'] + ") | "
    catalog += model['text'] + " | " + model['stl'] + "|\n"

with open("stl-dateien/README.md", 'w') as readme:
    readme.write(catalog)