## move into a folder you can write in

cd /home/rstudio

## the data are located in

# /home/rstudio/workspace/Data-Science-e-Bioinformatics/raw_data


## the index for the transcriptome is located in
## /home/rstudio/workspace/Data-Science-e-Bioinformatics/reference/chr21_transcripts_index

## first we create a folder where to store quantifications

mkdir -p quantification

## we create a symbolic link to the raw data

cd quantification
ln -s /home/rstudio/workspace/Data-Science-e-Bioinformatics/raw_data/*.gz .

## now we can quantify all samples, by running a loop with salmon and the following


for sample in `ls *_1.fasta.gz`
do
index="/home/rstudio/workspace/Data-Science-e-Bioinformatics/reference/chr21_transcripts_index"
name=${sample%_1.fasta.gz}
echo "quantifying $name"
salmon quant \
 -p 2 \
 -i $index \
 -l IU \
 -1 "${name}_1.fasta.gz" -2 "${name}_2.fasta.gz" \
 --validateMappings \
 -o "${name}.quant"
echo -e "$name done now\n"
done

### let's inspect a quantification file

cd sample_01.quant
head quant.sf

## more information on the format of the output
## https://salmon.readthedocs.io/en/latest/file_formats.html

