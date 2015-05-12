/* media-outlets.pig
This script will go through all the Canadian political parties and interest groups and extract links containing the texts in var c. 

Main issue? What to look for? Might get an RA to generate list of all newspaper URLs. (seed: http://en.wikipedia.org/wiki/List_of_newspapers_in_Canada)
*/

register 'target/warcbase-0.1.0-SNAPSHOT-fatjar.jar';

DEFINE ArcLoader org.warcbase.pig.ArcLoader();
DEFINE ExtractLinks org.warcbase.pig.piggybank.ExtractLinks();
DEFINE ExtractTopLevelDomain org.warcbase.pig.piggybank.ExtractTopLevelDomain();

raw = load '/shared/collections/CanadianPoliticalParties/arc/' using ArcLoader as
  (url: chararray, date: chararray, mime: chararray, content: bytearray);

a = filter raw by mime == 'text/html' and date is not null;
b = foreach a generate SUBSTRING(date, 0, 6) as date, url, FLATTEN(ExtractLinks((chararray) content));
c = foreach b generate $0 as date, ExtractTopLevelDomain($1) as source, REGEX_EXTRACT($2, '.*(nationalpost|globeandmail|torontostar|macleans|torontosun).*', 1) as target;
d = filter c by target is not null;
e = group d by (date, source, target);
f = foreach e generate FLATTEN(group), COUNT(d);
g = order f by $0;

store g into 'cpp.newspaper-use/';