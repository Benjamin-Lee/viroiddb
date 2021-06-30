testrna=readDNAStringSet("/media/SSD2/SDA3/neri/FireGrounds/Cls.ID0.90.Cov0.75.82-Aligned.fasta")
testrna=StaggerAlignment(myXStringSet = testrna,processors = 10)
p <- PredictDBN(testrna,type = "structures")
head(p)
BrowseSeqs(testrna, patterns=p) 

library(RRNA)
## Create a CT file from bracket notation and sequence ###
ct=makeCt( "((((...(((((((....)))))))...((((...))))...))))",
           "CCCCAAAGGGGGGGAUUACCCCUCCUUUAAAAGGGUUUUCCCCCCC")

## Create a coordinate file based on the CT file ###
dat=ct2coord(ct)

### Create a plot of the secondary structure ###
RNAPlot(dat)

### Plot positions 1:4 as green and 43:46 circles ## 
### and show the legend
ranges=data.frame(min=c(1,43),max=c(4,46),col=c(2,3),
                  desc=c("Region 1","Region 2")
)
RNAPlot(dat,ranges,labTF=TRUE)

### Highlight the sequences CUCCU and CCCCAAA ###

RNAPlot(dat,hl=c("CUCCU","CCCCAAA"),seqcol=c(2,4),labTF=TRUE,main="RNA Molecule")

### Modify specific positions ####

RNAPlot( dat, modspec=TRUE, modp=c(1:4,43:46),mod=c(17,17,15,15,16,16,16,16),
         modcol=c(rep(2,2),rep(3,2),rep(4,4))
)

### RNA Plot with nucleotides ###
RNAPlot(dat,nt=TRUE)

### RNA plot with nucleotides
RNAPlot( dat,nt=TRUE,modspec=TRUE,modp=c(1:4,43:46),
         mod=c(17,17,15,15,16,16,16,16),
         modcol=c(rep(2,2),rep(3,2),rep(4,4))
)

### RNA Plot wiht nucleotides and dots ###

RNAPlot(dat)
RNAPlot(dat,nt=TRUE,add=TRUE,dp=0.75)


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

library(seleniumPipes)
library(RSelenium) 
library(magick) 


rD <- rsDriver(browser = "firefox",port =as.integer(4445))
remDr <- rD[["client"]]


dbn=ReadDBN("db/2021-06-06/avsunviroidae.rc.dbn",return_type = "BS",includes_MFE = T)
tmpvar=c()
for (i in 1:length(dbn)) {
  tmppp =PopForna(dbn[i],pop=F,returl=T)
  tmpvar=append(tmpvar,tmppp)
  seqnametrim=str_split_fixed(string = names(dbn[i]),pattern = " ",n=Inf)[1]
  remDr$navigate(tmppp)
  Sys.sleep(time = 1.)
  webElem <- remDr$findElement(using = "xpath",value = '//*[@id="plotting-area"]')
  tmpsvg= unlist(webElem$getElementAttribute("outerHTML"))
  writeLines(text = tmpsvg,con = p0("./Neri/test/",seqnametrim,".rc.svg"))
}

##### Bash #####
'
for i in ./*".svg"; do
ini_name=$(basename $i ".svg")
rsvg-convert -f pdf -o ../test5/t.pdf $i --no-keep-image-data
pdf-crop-margins -v -s -u ../test5/t.pdf  -o ../test4/"$ini_name".pdf
done
'
tempredo=c("MG662374.1", "MG662373.1", "MG662372.1", "MF093720.1", "MF093719.1", "MG770884.1", "MK791516.1", "MK791515.1","NC_011362.1")


for (ix in tempredo) {
  i=grep(pattern = ix,x = names(dbn),fixed = T)
  tmppp=PopForna(dbn[i],pop=F,returl=T)
  tmpvar=append(tmpvar,tmppp)
  seqnametrim=str_split_fixed(string = names(dbn[i]),pattern = " ",n=Inf)[1]
  remDr$navigate(tmppp)
  Sys.sleep(time = 01.3)
  webElem <- remDr$findElement(using = "xpath",value = '//*[@id="plotting-area"]')
  tmpsvg= unlist(webElem$getElementAttribute("outerHTML"))
  writeLines(text = tmpsvg,con = p0("./Neri/test/",seqnametrim,".svg"))
}









