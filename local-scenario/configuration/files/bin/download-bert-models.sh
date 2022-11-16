#!/bin/bash

for model in {xlnet_0_gectorv2};
do
  wget -P /var/www/gector-api/models "https://grammarly-nlp-data-public.s3.amazonaws.com/gector/${model}.th";
done
