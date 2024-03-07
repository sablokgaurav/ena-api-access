alignment () {
   # a streamline function for accessing the ENA archives using the API access.
   #!/usr/bin/env bash
   # -*- coding:  utf-8 -*-
   # Author: Gaurav Sablok
   # date: 2024-3-5
   echo "process the alignment"
   echo "checking the alignment tags"
   echo "making the environment"
   sudo apt-get install lastz
   sudo apt-get install muscle
   sudo apt-get install iqtree
   sudo apt-get install raxml-ng
   sudo apt-get install model-ng
   if [[ ! -z $projectid ]]
   then 
        echo "the alignment tags doesnt exist"   
   else
   project=$projectid
   echo "creating the downloader"
   wget -F "https://www.ebi.ac.uk/ena/browser/view/"+"$projectid" -o "$projectid"+"file.txt"
   for i in $(cat "$projectid"+"file.txt" | cut -f 2 -d ":" | \ 
              grep SAME | cut -f 1 -d ",") \ 
   do \
      echo wget -F https://www.ebi.ac.uk/ena/browser/view/${i}?show=related-records; \
   done
   declare -a idrecords=()
   for i in $(cat filereport_read_run_PRJEB55353_json.txt | cut -f 2 -d ":" | grep SAME | cut -f 1 -d ",")
         do 
         idrecords+=("${i}")
    done
    if [[ -z "${i}" ]]
    then
     echo "processing has been finished" 
    exit 1
   for i in ${idrecords[*]};
   do
        echo https://www.ebi.ac.uk/ena/browser/api/fasta/links/sample\?accession\="${i}"\&result\=sequence\&includeLinks\=false >> "${i}"_downloaded.fasta
   done
   echo "finished all the fasta from the API"
   cat *.fasta > alldownloaded.fasta

}
