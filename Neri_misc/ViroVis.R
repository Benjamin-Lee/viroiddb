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
writeXStringSet(x = test1,filepath = "All.afa",width=20000)

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
FindSynteny(dbFile ="Neri/DecDB",processors = 10,useFrames = FALSE )
FindSynteny
# Below - pasted Map2Cons.R from RVMT
ConsDir="ali.210416c/"
AliDir="ali.210416a/"

rdrp_faa=readAAStringSet("Degapped_merged.210416.faa")
names(rdrp_faa)=trimws(names(rdrp_faa))
rdrp_faa=rdrp_faa[intersect(names(rdrp_faa),IDFT$RdRp_ID)]
ConsA_faa=readAAStringSet("Cons_merged.210416.faa")
names(ConsA_faa)=trimws(names(ConsA_faa))


ConsC_faa=readAAStringSet("Degapped_merged.con.210416.faa")
names(ConsC_faa)=trimws(names(ConsC_faa))

ConsDF=XString2DF(faa = ConsC_faa,input_was ="ConsID",trimwhite = F,seqcolname = "ConsC_seq",addlength = T )
ConsDF2=XString2DF(faa = ConsA_faa,input_was ="ConsID",trimwhite = F,seqcolname = "ConsA_seq",addlength = T )
ConsDF3=merge(ConsDF2,ConsDF,by="ConsID",all.x=T,all.y=T)
ConsDF3$vsv=ConsDF3$ConsA_seq==ConsDF3$ConsC_seq
colnames(ConsDF3)=c("ConsID","Length.A", "ConsA_seq", "Length.C",  "ConsC_seq", "vsv")
WriteWolfTbl(filter(ConsDF3,vsv ==F),"NConsDFT.tsv")
redepremuted=setdiff(ConsC_faa,ConsA_faa)

# Simple cases - cons are the same
aliaf=data.frame(Fnym=list.files("./ali.210416a/",pattern = "*.afa"))
aliaf$Cnym=gsub(pattern = ".afa",replacement = "",x = aliaf$Fnym,fixed = T)
SimpleAli=filter(aliaf,!(Cnym %in% names(redepremuted)))
ConsC=readAAStringSet(p0(ConsDir,"c210416.con.1.afa"))

write_lines(simplalimissing,"Missing_Cons.lst")
# Heregoes <- foreach(aliafa = SimpleAli$Fnym,.combine = c) %dopar% {
for (aliafa in SimpleAli$Fnym){
  print(aliafa)
  
  AliA=readAAStringSet(p0(AliDir,aliafa))
  sect=intersect(names(AliA),names(ConsC))
  if(length(sect)==0){next}
  AC=c(AliA[sect],ConsC[sect])
  names(AC)=c("A","C")
  
  txtC <- toString(AC["C"]) #
  AZC <- unlist(gregexpr("[A-Z]",txtC ))
  txtA <- toString(AC["A"]) #
  AZA <- unlist(gregexpr("[A-Z]",txtA ))
  
  LnkTbl=data.frame("Acoor"=AZA,"Ccoor"=AZC)
  
  NewA=rep(AAStringSet(gsub(x=toString(rep("-",nchar(AC["C"]))),pattern=", ",replacement = "")),length(AliA))
  names(NewA)=names(AliA)
  
  for (ix in 1:nrow(LnkTbl)){
    # print(ix)
    
    Rplc=narrow(x = AliA,start =LnkTbl$Acoor[ix],width = 1 )
    Rplc=toString(Rplc)
    Rplc1= str_split_fixed(string = Rplc,pattern=", ",n = Inf )[1,]
    NewLoc=LnkTbl$Ccoor[ix]
    subseq(NewA, start=(rep(NewLoc,length(AliA))), width=1) <-   Rplc1
  }
  writeXStringSet(NewA,p0("ali.2042416d/",aliafa),width=20001)
  gc()
}


NotSimpleAli=filter(aliaf,Cnym %in% names(redepremuted))
NotSimpleAli=filter(NotSimpleAli,Cnym %in% ConsDF3$ConsID[which(ConsDF3$vsv ==F)])
iy=0


for (aliafa in NotSimpleAli$Fnym){
  # print(aliafa)
  
  AliA=readAAStringSet(p0(AliDir,aliafa))
  sect=intersect(names(AliA),names(ConsC))
  if(length(sect)==0){next}
  AC=c(AliA[sect],ConsC[sect])
  names(AC)=c("A","C")
  ACd=RemoveGaps(AC)
  pwn=pairwiseAlignment(scoreOnly = F,pattern =(ACd["A"]) ,subject =(ACd["C"]),type="global")
  # if(ACd["A"]==ACd["C"]){
  #   ConsDF3$vsv[which(ConsDF3$ConsID ==names(AliA[1]))] =T
  #   print(names(AliA[1]))
  #   next
  # }
  # }
  
  
  txtC <- toString(AC["C"]) #
  AZC <- unlist(gregexpr("[A-Z]",txtC ))
  txtA <- toString(AC["A"]) #
  AZA <- unlist(gregexpr("[A-Z]",txtA ))
  
  LnkTbl=data.frame("Acoor"=AZA,"Ccoor"=AZC)
  NewA=rep(AAStringSet(gsub(x=toString(rep("-",nchar(AC["C"]))),pattern=", ",replacement = "")),length(AliA))
  names(NewA)=names(AliA)
  bra=c(pwn@subject@indel@unlistData@start:(pwn@subject@indel@unlistData@width+pwn@subject@indel@unlistData@start)) # Non gap location of the chars from the original cons that corrospond to the coor of motif C., which will later be moved.
  brc=c(pwn@pattern@indel@unlistData@start:(pwn@pattern@indel@unlistData@width+pwn@pattern@indel@unlistData@start)) # Non gap location of where motif C. was inserted into. 
  
  for (ix in 1:nrow(LnkTbl)){
    print(ix)
    # if(ix %in% )
    Rplc=narrow(x = AliA,start =LnkTbl$Acoor[ix],width = 1 )
    Rplc=toString(Rplc)
    Rplc1= str_split_fixed(string = Rplc,pattern=", ",n = Inf )[1,]
    NewLoc=LnkTbl$Ccoor[ix]
    subseq(NewA, start=(rep(NewLoc,length(AliA))), width=1) <-   Rplc1
  }
  NewADF=XString2DF(NewA,input_was = "ali.210416a",seqcolname = "regapped")
  
  NewCoordsa=LnkTbl$Ccoor[bra]
  NewCoordsc=LnkTbl$Ccoor[brc]
  
  mot0=narrow(NewA,start=1,end =min(NewCoordsa)-1)
  motab=narrow(NewA,start=max(NewCoordsa),end =min(NewCoordsc)-1)
  motc=narrow(NewA,start=min(NewCoordsa),end = max(NewCoordsa)-1)
  motd=narrow(NewA,start=min(NewCoordsc),end = unique(NewA@ranges@width))
  newNewA=xscat(mot0,motab,motc,motd)
  names(newNewA)=names(NewA)
  RemoveGaps(newNewA)
  if(  toString(RemoveGaps(newNewA[1]))==toString(ACd["C"])){
    print(iy)
    iy=iy+1
  }
  # pwn2=pairwiseAlignment(RemoveGaps(newNewA[1]),ACd["C"])
  # pwn2@pattern@mismatch
  # BrowseSeqs(c(RemoveGaps(newNewA[1]),ACd["C"]),htmlFile = "test.html")
  writeXStringSet(newNewA,p0("ali.2042416d/",aliafa),width=20001)
  gc()
}

simplalimissing=list.files(path = "ali.2042416d/",pattern = ".afa")
simplalimissing=filter(SimpleAli,!(Fnym %in%simplalimissing) )
simplalimissing=filter(simplalimissing,!(Fnym %in%NotSimpleAli$Fnym) )

stopCluster(myCluster)






