# Rename all items in a directory to lower case
for i in *; do mv "$i" "${i,,}"; done
