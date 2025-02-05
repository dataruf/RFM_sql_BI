/* datamizi import etdik Mysql workbenche*/
SELECT * FROM rfmanalizi.sifarisler;
# burada yoxlayiriq butun stunlar gelibmi deye. gorduyumuz kimi 3 stunumuz var
#sifaris, verilme tarixi ve mebleg
#setir satina baxsaq
select count(*) from sifarisler;
#1990
#daha sonra null deyerleri silek (varsa)
#SET SQL_SAFE_UPDATES = 0;
DELETE FROM sifarisler WHERE sifaris = '';
select count(*) from sifarisler;
#sifaris stununda bos xanalar silindike 1981 setir qaldi
#bize lazim olan budur
#daha sonra uygun analizlere baslamaq olar
select  sifaris,  max(tarix)  from sifarisler group by sifaris;
select  sifaris, datediff('2020-01-31', max(tarix)) as recency from sifarisler group by sifaris;
### yuxaridaki queryden recency cedvelini elde etdik
####################################################################
select sifaris,count(sifaris) as frequency from sifarisler group by sifaris;
#burada frequency cedvelini tapdiq
####################################################################
select sifaris,sum(mebleg) as monetary from sifarisler group by sifaris;
#bu sorgu ile monetary cedvelini elde etmis olduq.
select  sifaris, datediff('2020-01-31', max(tarix)) as recency,
						count(sifaris) as frequency,
                        sum(mebleg) as monetary
from sifarisler group by sifaris;
###############################################################
#elde ounan yekun cedvele gore 1-5 arasi skorlara bolek
select  sifaris, datediff('2020-01-31', max(tarix)) as recency,
						count(sifaris) as frequency,
                        sum(mebleg) as monetary
from sifarisler group by sifaris;
CREATE TEMPORARY TABLE rfm 
select  sifaris, datediff('2020-01-31', max(tarix)) as recency,
						count(sifaris) as frequency,
                        sum(mebleg) as monetary
from sifarisler group by sifaris;
select * from rfm;
CREATE TEMPORARY TABLE rfm2	
    select sifaris, recency, frequency, monetary,
			ntile(5) over (order by recency desc) as R,
            ntile(5) over (order by frequency ) as F,
            ntile(5) over (order by monetary ) as M
from rfm;
select * from rfm1;
CREATE TEMPORARY TABLE rfmdata1
	select sifaris, recency, frequency, monetary,r,f,m,
    concat(concat(r,f),m) as RFM
from rfm1;



select * from rfmdata1;
