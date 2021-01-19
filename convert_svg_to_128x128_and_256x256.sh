#!/bin/bash

CONVERT=`which convert`
CP=`which cp`
LS=`which ls`
MV=`which mv`
RM=`which rm`
RSVG_CONVERT=`which rsvg-convert`

FLAG_WIDTHS=(120 240)
WIDTHS=(128 256)


idx=0

for width in "${WIDTHS[@]}"; do
  flag_width=${FLAG_WIDTHS[$idx]}
  echo "Flags for ${width}x${width} (${flag_width}x${flag_width})"
  for i in `${LS} -1 _source/svg/`; do 
    echo "Converting ${width}x${width} ${i}..."
    ${RSVG_CONVERT} -a -w ${flag_width} -h ${flag_width} _source/svg/$i > ${width}x${width}/$i-rsvg.png
    ${CONVERT} -background none -resize ${flag_width}x${flag_width} -gravity center -extent ${width}x${width} ${width}x${width}/$i-rsvg.png ${width}x${width}/$i.png
    ${MV} ${width}x${width}/$i.png ${width}x${width}/${i%.*}.png
    ${CP} ${width}x${width}/${i%.*}.png ${i%.*}/flat/${width}.png
    ${RM} -f ${width}x${width}/$i-rsvg.png
  done
  ((idx++))
done
