library(data.table)
library(Biostrings)
library(plyr); library(dplyr)

HeaderBreakerCb <- function(input_df,sep=".",clb="id",nclb=hedclbs){
  i= colnames(input_df)
  input_df=cbind(input_df,data.frame(do.call('rbind', strsplit(as.character(as.data.frame(input_df)[,c(clb)]), sep, fixed=T)),stringsAsFactors = F))
  colnames(input_df)=c(i,nclb)
  return(input_df)
}

{
  args <- commandArgs(trailingOnly=T)
  input_clu=as.character(args[2])
  input_fas=as.character(args[1])
  Cls_Prefix=as.character(args[3])
  # output=as.character(args[4])
}
# 
# input_clu="/media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/Neri/clusterin/Clusteringfiles/all.clu_cluster.tsv"
# input_fas='/media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/db/all.fasta'
# min_cluster_size=1
# THREADS=10
# Cls_Prefix="Cls.ID0.90.Cov0.75."
BnF=basename(input_clu)
BnP=normalizePath(input_clu)
BnP1=unlist(strsplit(BnP, BnF, fixed = T)[1])
BnPFas=input_fas
print(BnPFas)

input_fasta=readAAStringSet(BnPFas)
names(input_fasta)=HeaderBreakerCb(input_df = data.frame("iddd"=names(input_fasta)),sep = " ",clb ="iddd",nclb = c("new_nuc_id.frame","new_nuc_id","frame") )$new_nuc_id.frame
# writeXStringSet(input_fasta,paste0("asdasdasd.fasta"))

setwd(BnP1)
output=paste0(BnP1,"/cluster_membership")
print(BnP)
dir.create(output)

print(output)

cx <- fread(input = BnP,data.table = T,skip = 0,header = F,sep = '\t',col.names = c("rep","mem"))
cxc= cx %>% group_by(rep) 
cxc=cxc %>% summarise(
  lmem= list(unlist(list(mem))),
  Mems=toString(unlist(mem)))
cxc$Nseq=lengths(cxc$lmem)
cxc$Cls_ID=paste0(Cls_Prefix,1:nrow(cxc))
setwd(output)
print("Started ")
print(getwd())

write.table(cxc[,c("Cls_ID","rep","Mems","Nseq")],paste0("./Cluster_membership.tsv"),quote=F, row.names = F, col.names = T ,sep = "\t")

dmsfunc <-function(aa,ab){
  writeXStringSet(aa,paste0(ab,".fasta"),width=20001)
  return(1)
}
for (i in 1:nrow(cxc)){
  dmsfunc(aa = input_fasta[intersect(names(input_fasta),unlist(cxc[i,"lmem"]))],ab = cxc[i,"Cls_ID"])
}
gc()
print("Finished ")
