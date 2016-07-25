#!/usr/bin/env zsh

SCRATCH_DIR=~/bachbot/scratch

if [ ! -e ${SCRATCH_DIR}/harm_out ]; then
  mkdir ${SCRATCH_DIR}/harm_out
fi

cd ~/bachbot/scripts/harm_model/
for utf_file in ${SCRATCH_DIR}/*mask*.utf; do
  print "Now processing ${utf_file:t:r}"
  fp=${SCRATCH_DIR}/harm_out/${utf_file:t}
  if [ -e $fp ]; then
    rm $fp
  fi
  th harmonize.lua \
    -checkpoint ${SCRATCH_DIR}/checkpoints/seq_length=128,wordvec=32,num_layers=3,rnn_size=256,dropout=0.3,batchnorm=1,lr=2e-3/checkpoint_5300.t7 \
    -input $utf_file \
    > $fp
done

# TODO: handle output path
# for utf_file in ${SCRATCH_DIR}/harm_out/*.utf; do
#   bachbot decode decode_utf \
#     --utf-to-txt-json ${SCRATCH_DIR}/utf_to_txt.json \
#     $utf_file
# done
