# Information  --------------------------------------------------------------------
## Script name: ViroVis.R
## Purpose of script: Visualizing the subvirales sequence space, hopefully not just eyecandy.
## Author: Uri Neri
## Date Created: 20-04-2021
## Copyright (c) Uri Neri & Benjamin Lee, 2021
## Email: uri.neri@gmail.com
# Body  --------------------------------------------------------------------
source("/media/HDD1/uri/RNA_Vir_MTs/RVMT/Misc/basicf.r")
library(data.table)
library(Biostrings)
library(phangorn)
library(castor)
library(ggtree)
library(DECIPHER)
current_path=("/media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/")
setwd(current_path)

#### Read stuff ####
fastas=list.files(path = "./db/",pattern = ".*fasta")
TabFastaList=data.frame("File"=fastas,"Group"=gsub(pattern = ".fasta",replacement = "",x = fastas))
TabFastaList$XString=lapply(TabFastaList$File,FUN = function(x) (readDNAStringSet(p0("./db/",x))))
AllSeqs=DNAStringSet()
for (i in 1:nrow(TabFastaList)){
  AllSeqs=c(AllSeqs,unlist(TabFastaList$XString[i])[[1]])
}
AllSeqs=AllSeqs[unique(names(AllSeqs))] #9,891
SubVirDT=XString2DF(AllSeqs,input_was = "seqID",trimwhite = F,addlength = T,seqcolname = "Nuc_Seq")
SubVirDT[,c(TabFastaList$Group)]=F
for (i in 1:nrow(TabFastaList)){
  w1=which(SubVirDT$seqID %in% names(unlist(TabFastaList$XString[i])[[1]]))
  SubVirDT[w1,TabFastaList$Group[i]]=T
}
SubVirDT=HeaderBreakerCb(SubVirDT,sep = " ",clb ="seqID",nclb = "")
SubVirDT=SubVirDT[,c(1:12)]
SubVirDT=Rename1Col(SubVirDT,"","SeqID_trim")

##### All vs All #### 
AllvsAll=fread("./Neri/tmpblastall/viroidDB.tsv",sep = '\t',header = F,col.names = Blastn_cols)
AllvsAll=AllvsAll[(pident>75&evalue<0.000000001&(ali_len>100)&score>160)]
# AllvsAll=`droprows<-`(AllvsAll,which(AllvsAll$query_name==AllvsAll$subject_name))
AllvsAll=CalcPcoverage(AllvsAll)
AllvsAll=AllvsAll[(pCoverage>0.9)]
# summary(AllvsAll$pCoverage)
# test1=AlignSeqs(RNAStringSet(AllSeqs) ,useStructures = T,processors=10)
# writeXStringSet(x = test1,filepath = "All.afa",width=20000)

##### Testing  #### 
AllvsAll=merge(Rename1Col(AllvsAll,"query_name","SeqID_trim"),SubVirDT[,c( "SeqID_trim","Length", "avsunviroidae", "deltavirus","pospiviroidae", "retrozymes","satellites","unclassified","viroids")],by="SeqID_trim",all.x=T,all.y=F)
AllvsAll$Type="ALL"
for (Vtype in c( "avsunviroidae", "deltavirus","pospiviroidae", "retrozymes","satellites","unclassified")){
  AllvsAll$Type[which((AllvsAll[,..Vtype][[1]]))]=Vtype
}
WriteWolfTbl(Rtbl = AllvsAll[, c("SeqID_trim","subject_name","evalue") ],filepath = "Neri/tmpblastall/AllvsAll_trim.tsv")

VtypeDT=distinct(AllvsAll[,c("SeqID_trim","Type")])
WriteWolfTbl(Rtbl = VtypeDT,filepath = "Neri/tmpblastall/VtypeDT.tsv")


MCL_1.2=ReadMcl(mclfile = "Neri/tmpblastall/VDB_allByAll_blast_Infl_1.2.mcl",col1prefix = "cls")

test2=DistanceMatrix(test1,type = "matrix",processors = 10)
# SubViroPhylo=UNJ(x = test2)
# fastme.bal(X, nni = TRUE, spr = TRUE, tbr = FALSE)
SubViroPhylo=read.tree("All.afa")

SubViroPhylo$node.label <- paste0("node_", seq(1:Nnode(SubViroPhylo,internal.only = T)))

NodeTbl=data.frame(cbind(SubViroPhylo$edge,SubViroPhylo$edge.length))
colnames(NodeTbl)=c("Parent_node","Node","Edge_Length2Parent")
NodeTbl[,"Node_Label"]=nodelab(SubViroPhylo,NodeTbl$Node);
NodeTbl[,"IsTip"]=treeio::isTip(SubViroPhylo,NodeTbl$Node);
NodeTbl=merge(data.table(NodeTbl),Rename1Col(`dropcols<-`(SubVirDT,"Nuc_Seq"),colnm ="SeqID_trim",newcolnm ="Node_Label"),by="Node_Label",all.x=T,all.y=F) 

NodeTbl=NodeTbl %>% group_by(Parent_node)
NodeTbl$ast=""
  colsn=setdiff(TabFastaList$Group,c("viroids","all"))
for (i in colsn){
  NodeTbl$ast[which(NodeTbl[,i]==T)]=i
}
NodeTbl$DistrFromRoot=get_all_distances_to_root(SubViroPhylo)[NodeTbl$Node]
vizt=ggtree(tr =SubViroPhylo)

p2 <- vizt  %<+%(Rename1Col(NodeTbl,colnm = "Node_label",newcolnm = "node.label"))

p2+geom_tree( aes(color=ast),continuous=F, size=1)

  theme(legend.position = c(.1, .8)) 
+ scale_fill_viridis_c()

  geom_label(aes(label="Node_Label"))
theme(legend.position = c(.1, .8)) + scale_fill_viridis_c()
geom_tree( aes(color=Taxa),continuous=F, size=1)+geom_label(aes(label=Taxa))
xlim(0, 8) +geom_label(aes(label=clade),  na.rm = T, size=1.9,label.size = 0.01) +
  theme(legend.position = c(0.009, 0.8),legend.key.size = unit(x = 0.01,units = "cm")) #+

plot(test3)

##### MTstats #### 
MTstat4Ben=fread(file = "/media/SSD2/SDA3/viroids/MTstat4Ben.tsv",sep ='\t',header = T)
MTstat4Ben
ViroidLikes=RemoveEmptyStrRow(fread(file = "/media/SSD2/SDA3/viroids/RhvHXb",sep ='\t',header = F,col.names = "Contig_IDs"))
ViroidLikes=HeaderBreaker(input_df = data.frame(ViroidLikes),sep = "_",clb = "Contig_IDs")
ViroidLikes$`IMG Genome ID`=as(object = ViroidLikes$splitted$X1,Class = "integer64")
ViroidLikes$splitted=NULL
ViroidLikes=merge(ViroidLikes,MTstat4Ben,by="IMG Genome ID",all.x=T,all.y=F)


##### Poor-mans MARS  #### 
# RDSs_To_Load=c("FieldsDF.RDS","IDFT.RDS","Motifs.RDS", "MiscData.RDS", "IDFT.fasta.RDS" ,"RdRpInfo.RDS","Set2Br2Prof2Clad2Info.RDS","IDFT_RdRp.RDS","MetaData.RDS","MTstats.RDS","RdRpDF.RDS")
# for (i in RDSs_To_Load) {
#   x <- gsub(x = i,pattern = ".RDS",fixed = T,replacement = "")
#   eval(call("<-", as.name(x), readRDS(p0(RDSDir,"/",i))))
# }
pospis=readDNAStringSet(filepath = "db/pospiviroidae.fasta") #filter(TabFastaList,Group=="pospiviroidae")$XString[[1]]
Seqs2DB(seqs = "db/pospiviroidae.fasta",dbFile = "Neri/DecDB",processors = 10,type = "FASTA",identifier = names(pospis))
# FindSynteny(dbFile ="Neri/DecDB",processors = 10,useFrames = FALSE )


###### sql / json ###### 
ftest=fromJSON(  "static/meta.tmp.json")
cls90=fread(sep ='\t',header = T,file = "/media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/Neri/clusterin/Cls.ID0.9.Cov0.75/Cluster_membership.tsv")
cls90$Lmems=apply(cls90,MARGIN = 1, FUN = function(x) as.char(str_split_fixed(string = x["Mems"],pattern=", ",n = Inf )))
cls90=`dropcols<-`(cls90,"Mems")
cls90Json=toJSON(cls90)
write_json(cls90Json,"cls90.JSON")

cls=cls90

# write cls reps
length(unlist(cls$Lmems)) # 9891
reps_only=AllSeqs[filter(SubVirDT,SeqID_trim %in% cls$rep)$seqID]
# writeXStringSet(reps_only,"Neri/clusterin/")
cls_AllvsAll=filter(AllvsAll,SeqID_trim %in% cls$rep)
cls_AllvsAll=filter(cls_AllvsAll,subject_name %in% cls$rep)
cls_AllvsAll=cls_AllvsAll[(pident>75&evalue<0.000000001&(ali_len>100)&score>160)]

WriteWolfTbl(Rtbl = cls_AllvsAll[,c("SeqID_trim","subject_name","score","Type","evalue")],filepath = "Neri/cls_AllvsAll.tsv")









