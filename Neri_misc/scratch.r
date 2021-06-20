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






library('webshot')
webshot::install_phantomjs()

dbn=ReadDBN("db/avsunviroidae.dbn",return_type = "BS",includes_MFE = T)
tmpvar=c()
for (i in 1:length(dbn[])) {
  tmppp=PopForna(dbn[i],pop=F,returl=T)
  tmpvar=append(tmpvar,tmppp)
  # webshot(url=tmppp, p0(names(dbn[i]),".png"),delay = 2,vwidth=1920,vheight = 1080)
}
webshot("https://google.com")#,"test.png")

tiger <- image_read("test.png", width = 350)
image_crop(tiger, "100x150+50")

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

rD <- rsDriver(browser = "firefox",port =as.integer(4444))
remDr <- rD[["client"]]


dbn=ReadDBN("db/avsunviroidae.dbn",return_type = "BS",includes_MFE = T)
tmpvar=c()
for (i in 1:length(dbn)) {
  tmppp=PopForna(dbn[i],pop=F,returl=T)
  tmpvar=append(tmpvar,tmppp)
  seqnametrim=str_split_fixed(string = names(dbn[i]),pattern = " ",n=Inf)[1]
remDr$navigate(tmppp)
Sys.sleep(time = 1)
# zoom_firefox(remDr, 150)
remDr$screenshot(file = p0("./Neri/Pics/",seqnametrim,".png"),display = )
tiger <- image_read( p0("./Neri/Pics/",seqnametrim,".png" ))
tiger=image_crop(tiger,repage = T,"2220x1426+70+75+200")
image_write(image = tiger,path =p0("./Neri/Pics/",seqnametrim,".1.png" ),format = "png",quality = 100,depth = 16,flatten = T)

}
  
zoom_firefox <- function(client, percent)
{
  store_page <- client$getCurrentUrl()[[1]]
  client$navigate("about:preferences")
  webElem <- client$findElement("css", "#defaultZoom")
  webElem$clickElement()
  webElem$sendKeysToElement(list(as.character(percent)))
  webElem$sendKeysToElement(list(key = "return"))
  client$navigate(store_page)
}

