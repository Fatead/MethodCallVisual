create table classinfo
(
    projectname text     null,
    classname   text     null,
    isInterface text     null,
    superclass  text     null,
    interfaces  text     null,
    modi        text     null,
    loc         int      null,
    filename    text     null,
    content     longtext null,
    id          text     null
)
    charset = utf8;

INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.config.CfFileParser', '0', '', ' ', 'public;abstract;', 25, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\config\\CfFileParser.java', '/** 
 * ??????
 * @author zhouyanjun
 * @version 1.0 2014-8-23
 */
public abstract class cffileparser {
  /** 
 * ???
 */
  public enum configitem;
{
  }
  public string value;
  private void configitem(  string value){
    this.value=value;
  }
  private string filepath;
  public abstract map<string,context> parse() throws ioexception ;
  public string getfilepath(){
    return filepath;
  }
  public void setfilepath(  string filepath){
    this.filepath=filepath;
  }
}
', '56b45f0e03c54ee38aea44ad342ce4b8');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.config.PropertiesCfParser', '0', 'com.wind.myLuence.config.CfFileParser', ' ', 'public;', 33, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\config\\PropertiesCfParser.java', '/** 
 * ?????????
 * @author zhouyanjun
 * @version 1.0 2015-1-13
 */
public class propertiescfparser extends cffileparser {
  @override public map<string,context> parse() throws ioexception {
    properties prop=new properties();
    prop.load(propertyparser.class.getresourceasstream(this.getfilepath()));
    map<string,string> configs=new hashmap<string,string>();
    enumeration<?> keys=prop.keys();
    list<string> cfitemarray=new arraylist<string>();
    while (keys.hasmoreelements()) {
      string key=(string)keys.nextelement();
      if (key.contains(configitem.beanclass.value)) {
        cfitemarray.add(key.split("\\\\.")[0]);
      }
      string value=(string)prop.get(key);
      configs.put(key,value);
    }
    map<string,context> results=new hashmap<string,context>();
    for (    string cfitem : cfitemarray) {
      context context=new context();
      for (      string key : configs.keyset()) {
        if (key.contains(cfitem)) {
          context.put(key.split("\\\\.")[1],configs.get(key));
        }
      }
      results.put(cfitem,context);
    }
    return results;
  }
}
', 'b5c4dcf5a6fd4a73bdb6e03620b1d063');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.config.XmlCfParser', '0', 'com.wind.myLuence.config.CfFileParser', ' ', 'public;', 10, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\config\\XmlCfParser.java', '/** 
 * xml???????
 * @author zhouyanjun
 * @version 1.0 2015-1-13
 */
public class xmlcfparser extends cffileparser {
  @override public map<string,context> parse(){
    return null;
  }
}
', '622ef52abdaf4e438575f844d2ba4d9f');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.Configurable', '1', '', ' ', 'public;', 8, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\Configurable.java', '/** 
 * ???
 * @author zhouyanjun
 * @version 1.0 2014-1-2
 */
public interface configurable {
  public void configure(  context context) throws configurableexception, classnotfoundexception ;
}
', '18134b1990ff46e9a0eb0542407fd1e7');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.Context', '0', '', ' ', 'public;', 68, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\Context.java', 'public class context {
  private map<string,string> parameters;
  public context(){
    parameters=collections.synchronizedmap(new hashmap<string,string>());
  }
  public context(  map<string,string> paramters){
    this();
    this.putall(paramters);
  }
  public void clear(){
    parameters.clear();
  }
  public void putall(  map<string,string> map){
    parameters.putall(map);
  }
  public void put(  string key,  string value){
    parameters.put(key,value);
  }
  public boolean getboolean(  string key,  boolean defaultvalue){
    string value=get(key);
    if (value != null) {
      return boolean.parseboolean(value.trim());
    }
    return defaultvalue;
  }
  public boolean getboolean(  string key){
    return getboolean(key,null);
  }
  public integer getinteger(  string key,  integer defaultvalue){
    string value=get(key);
    if (value != null) {
      return integer.parseint(value.trim());
    }
    return defaultvalue;
  }
  private string get(  string key,  string defaultvalue){
    string result=parameters.get(key);
    if (result != null) {
      return result;
    }
    return defaultvalue;
  }
  public integer getinteger(  string key){
    return getinteger(key,null);
  }
  public long getlong(  string key,  long defaultvalue){
    string value=get(key);
    if (value != null) {
      return long.parselong(value.trim());
    }
    return defaultvalue;
  }
  public long getlong(  string key){
    return getlong(key,null);
  }
  public string getstring(  string key){
    return get(key);
  }
  public string getstring(  string key,  string defaultvalue){
    return get(key,defaultvalue);
  }
  private string get(  string key){
    return get(key,null);
  }
  public string tostring(){
    return "{ parameters:" + parameters + " }";
  }
}
', '2a5339604f96420fa6e1692ca9412ad6');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.DataSource', '1', '', 'Configurable; ', 'public;', 18, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\DataSource.java', '/** 
 * ???
 * <p>
 * ??????????
 * </p>
 * @author zhouyanjun
 * @version 1.0 2014-4-24
 */
public interface datasource extends configurable {
  /** 
 * ??????
 */
  public void initialdataopen();
  /** 
 * ??????
 */
  public void increasedataopen();
}
', 'b0b99747f0fd45de9df5be9aff26de74');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.exception.ConfigurableException', '0', 'Exception', ' ', 'public;', 16, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\exception\\ConfigurableException.java', '/** 
 * ????
 * @author zhouyanjun
 * @version 1.0 2015-1-13
 */
public class configurableexception extends exception {
  private static final long serialversionuid=7750826735020761837l;
  public configurableexception(){
  }
  public configurableexception(  string message){
    super(message);
  }
  public configurableexception(  string message,  throwable cause){
    super(message,cause);
  }
}
', 'c94fa1f406bd42b5b2414de2474616a7');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.exception.IndexException', '0', 'Exception', ' ', 'public;', 16, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\exception\\IndexException.java', '/** 
 * ????
 * @author zhouyanjun
 * @version 1.0 2015-1-13
 */
public class indexexception extends exception {
  private static final long serialversionuid=-2049475935211044964l;
  public indexexception(){
  }
  public indexexception(  string message){
    super(message);
  }
  public indexexception(  string message,  throwable cause){
    super(message,cause);
  }
}
', '4ed9b3906ff2420a98259ed24edb52f2');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.exception.SearchException', '0', 'Exception', ' ', 'public;', 16, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\exception\\SearchException.java', '/** 
 * ????
 * @author zhouyanjun
 * @version 1.0 2015-1-13
 */
public class searchexception extends exception {
  private static final long serialversionuid=-2940773275100427250l;
  public searchexception(){
  }
  public searchexception(  string message){
    super(message);
  }
  public searchexception(  string message,  throwable cause){
    super(message,cause);
  }
}
', '1e5bc9dabc9c410198a3cebd69e9e4a6');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.factory.MyLuenceFactory', '1', '', ' ', 'public;', 6, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\factory\\MyLuenceFactory.java', 'public interface myluencefactory {
  public static string index_source_name="myluence_index_source";
  public static string searcher_name="myluence_searcher";
  public indexsource getixsourceinstance(  string name);
  public abstarctsearcher getsearcherinstance();
}
', '79da845bd4c54a14956cbde1aaec7900');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.factory.XmlMyLuenceFactory', '0', '', 'MyLuenceFactory; ', 'public;', 15, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\factory\\XmlMyLuenceFactory.java', 'public class xmlmyluencefactory implements myluencefactory {
  private beanfactory beanfactory;
  public xmlmyluencefactory(  string[] xmls){
    beanfactory=new classpathxmlapplicationcontext(xmls);
  }
  @override public indexsource getixsourceinstance(  string name){
    if (name != null && !name.isempty()) {
      return (indexsource)beanfactory.getbean(name);
    }
    return (indexsource)beanfactory.getbean(index_source_name);
  }
  @override public abstarctsearcher getsearcherinstance(){
    return (abstarctsearcher)beanfactory.getbean(searcher_name);
  }
}
', 'b7d2478070884d4cbcd8cb2573ad6fd0');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.index.AbstractIndex', '0', '', 'Index; ', 'public;abstract;', 10, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\index\\AbstractIndex.java', 'public abstract class abstractindex implements index {
  protected analyzer analyzer;
  protected directory directory;
  public analyzer getanalyzer(){
    return analyzer;
  }
  public void setanalyzer(  analyzer analyzer){
    this.analyzer=analyzer;
  }
}
', 'a4499ff7c2d541dbab18294b0c73f660');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.index.BeanIndex', '0', 'com.wind.myLuence.index.AbstractIndex', ' ', 'public;', 374, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\index\\BeanIndex.java', '/** 
 * bean????
 * @author zhouyanjun
 * @version 1.0 2014-4-24
 */
public class beanindex extends abstractindex {
  private final logger logger=loggerfactory.getlogger(this.getclass());
  private static final string analyzedindexfields="analyzedindexfields";
  private static final string notanalyzedindexfields="notanalyzedindexfields";
  private static final string storefields="storefields";
  private static final string indexfilepath="indexfilepath";
  private static final string classname="beanclass";
  private static final string analyzerclass="analyzerclass";
  private static final string pkname="pkname";
  private static final string pkname_default="id";
  private static final string pk_field="pkfields";
  private static final string datafieldname="datafieldname";
  private static final string datafieldname_default="data";
  private list<string> analyzedindexfields;
  private list<string> notanalyzedindexfields;
  private list<string> storefields;
  private class<?> clazz;
  private list<string> pkfields;
  private string pkname;
  private string datafieldname;
  private map<string,fieldlucproperty> fieldpropertymap;
  public void configure(  context context) throws configurableexception {
    try {
      string analyzerclass=context.getstring(analyzerclass);
      this.analyzer=(analyzer)class.forname(analyzerclass).newinstance();
      list<string> pojofields=new arraylist<string>();
      string classname=context.getstring(classname);
      try {
        this.clazz=class.forname(classname);
        getpojofileds(pojofields,clazz);
      }
 catch (      classnotfoundexception e1) {
        logger.error("bean class error to create.");
        throw new configurableexception(e1.getmessage(),e1);
      }
      string analyzedindexfields=context.getstring(analyzedindexfields);
      if (analyzedindexfields != null && !analyzedindexfields.isempty()) {
        this.analyzedindexfields=new arraylist<string>(arrays.aslist(analyzedindexfields.split(",")));
        if (!pojofields.containsall(this.analyzedindexfields)) {
          logger.error("indexfield''s range beyong the range of pojofields");
          throw new configurableexception("indexfield''s range beyong the range of pojofields");
        }
      }
      string notanalyzedindexfields=context.getstring(notanalyzedindexfields);
      if (notanalyzedindexfields != null && !notanalyzedindexfields.isempty()) {
        this.notanalyzedindexfields=new arraylist<string>(arrays.aslist(notanalyzedindexfields.split(",")));
        if (!pojofields.containsall(this.notanalyzedindexfields)) {
          logger.error("notanalyzedindexfields''s range beyong the range of pojofields");
          throw new configurableexception("notanalyzedindexfields''s range beyong the range of pojofields");
        }
      }
      string storefields=context.getstring(storefields);
      if (storefields != null && !storefields.isempty()) {
        this.storefields=new arraylist<string>(arrays.aslist(storefields.split(",")));
        if (!pojofields.containsall(this.storefields) && !this.storefields.contains(datafieldname_default)) {
          logger.error("storefields''s range beyong the range of pojofields");
          throw new configurableexception("storefields''s range beyong the range of pojofields");
        }
      }
      if (analyzedindexfields == null && notanalyzedindexfields == null && storefields == null) {
        logger.error("you must set one of analyzedindexfields,notanalyzedindexfields,storefields at least.");
        throw new configurableexception("you must set one of analyzedindexfields,notanalyzedindexfields,storefields at least.");
      }
      string pkfields=context.getstring(pk_field);
      if (pkfields != null && !pkfields.isempty()) {
        this.pkfields=new arraylist<string>(arrays.aslist(pkfields.split(",")));
      }
      string indexfilepath=context.getstring(indexfilepath);
      if (indexfilepath == null || indexfilepath.isempty()) {
        logger.error("indexfilepath must to be set.");
        throw new configurableexception("indexfilepath must to be set.");
      }
      try {
        this.directory=fsdirectory.open(new file(indexfilepath));
      }
 catch (      ioexception e) {
        logger.error("index file dir error to create.");
        throw new configurableexception("index file dir error to create.");
      }
      this.pkname=context.getstring(pkname,pkname_default);
      this.datafieldname=context.getstring(datafieldname,datafieldname_default);
      fieldpropertymap=getfieldlucproperty();
    }
 catch (    instantiationexception e2) {
      log.error(this.getclass(),e2.getmessage());
      throw new configurableexception(e2.getmessage(),e2);
    }
catch (    illegalaccessexception e2) {
      log.error(this.getclass(),e2.getmessage());
      throw new configurableexception(e2.getmessage(),e2);
    }
catch (    classnotfoundexception e2) {
      log.error(this.getclass(),e2.getmessage());
      throw new configurableexception(e2.getmessage(),e2);
    }
  }
  public void write(  list<object> datas) throws indexexception {
    log.info(beanindex.class,"#################### createindex  starting");
    long start=system.currenttimemillis();
    if (datas == null || datas.isempty())     return;
    indexwriter indexwriter=null;
    try {
      while (!indexwriter.islocked(directory)) {
        indexwriterconfig indexwriterconfig=new indexwriterconfig(version.lucene_8,analyzer);
        indexwriter=new indexwriter(directory,indexwriterconfig);
        indexwriter.deleteall();
        indexwriter.forcemergedeletes();
        indexwriter.commit();
        for (        object data : datas) {
          if (data == null)           continue;
          document doc=new document();
          if (this.pkfields != null) {
            list<string> pkfieldvaluelist=new arraylist<string>();
            for (            string pkfield : pkfields) {
              pkfieldvaluelist.add(getfieldvalue(clazz,pkfield,data));
            }
            stringbuilder id=new stringbuilder();
            for (            string pkfieldvalue : pkfieldvaluelist) {
              id.append(pkfieldvalue + "@");
            }
            fieldtype fieldtype=new fieldtype();
            fieldtype.setstored(true);
            fieldtype.setindexed(false);
            fieldtype.settokenized(false);
            doc.add(new field(pkname,id.substring(0,id.length() - 1),fieldtype));
          }
          for (          string fieldname : fieldpropertymap.keyset()) {
            string value=null;
            if (fieldname.equalsignorecase(datafieldname)) {
              value=jsonobject.fromobject(data,config).tostring();
            }
 else {
              value=getfieldvalue(clazz,fieldname,data);
            }
            if (value != null) {
              fieldtype fieldtype=new fieldtype();
              fieldlucproperty fieldlucproperty=fieldpropertymap.get(fieldname);
              fieldtype.setstored(fieldlucproperty.isstore());
              fieldtype.setindexed(fieldlucproperty.isindex());
              fieldtype.settokenized(fieldlucproperty.isanalyzed());
              field field=new field(fieldname,value,fieldtype);
              doc.add(field);
            }
          }
          indexwriter.adddocument(doc);
        }
        indexwriter.commit();
        break;
      }
    }
 catch (    exception e) {
      log.error(beanindex.class,e,"###############create index happened error" + e.getmessage());
    }
 finally {
      if (indexwriter != null) {
        try {
          indexwriter.close();
          indexwriter.unlock(directory);
        }
 catch (        ioexception e) {
          log.error(this.getclass(),e);
        }
        indexwriter=null;
      }
    }
    log.warn(beanindex.class,"#################### createindex  finished, this process spent " + (system.currenttimemillis() - start) / 1000 + " seconds");
  }
  @override public void append(  list<object> datas) throws indexexception {
    log.info(beanindex.class,"#################### append index  starting");
    if (datas == null || datas.isempty())     return;
    long start=system.currenttimemillis();
    indexwriter indexwriter=null;
    try {
      while (!indexwriter.islocked(directory)) {
        indexwriterconfig indexwriterconfig=new indexwriterconfig(version.lucene_46,analyzer);
        indexwriter=new indexwriter(directory,indexwriterconfig);
        for (        object data : datas) {
          if (data == null)           continue;
          document doc=new document();
          if (this.pkfields != null) {
            list<string> pkfieldvaluelist=new arraylist<string>();
            for (            string pkfield : pkfields) {
              pkfieldvaluelist.add(getfieldvalue(clazz,pkfield,data));
            }
            stringbuilder id=new stringbuilder();
            for (            string pkfieldvalue : pkfieldvaluelist) {
              id.append(pkfieldvalue + "@");
            }
            fieldtype fieldtype=new fieldtype();
            fieldtype.setstored(true);
            fieldtype.setindexed(false);
            fieldtype.settokenized(false);
            doc.add(new field(pkname,id.substring(0,id.length() - 1),fieldtype));
          }
          for (          string fieldname : fieldpropertymap.keyset()) {
            string value=null;
            if (fieldname.equalsignorecase(datafieldname)) {
              value=jsonobject.fromobject(data,config).tostring();
            }
 else {
              value=getfieldvalue(clazz,fieldname,data);
            }
            if (value != null) {
              fieldtype fieldtype=new fieldtype();
              fieldlucproperty fieldlucproperty=fieldpropertymap.get(fieldname);
              fieldtype.setstored(fieldlucproperty.isstore());
              fieldtype.setindexed(fieldlucproperty.isindex());
              fieldtype.settokenized(fieldlucproperty.isanalyzed());
              field field=new field(fieldname,value,fieldtype);
              doc.add(field);
            }
          }
          indexwriter.adddocument(doc);
        }
        indexwriter.forcemerge(50);
        indexwriter.commit();
        break;
      }
    }
 catch (    exception e) {
      log.error(beanindex.class,e,"###############append index happened error" + e.getmessage());
    }
 finally {
      if (indexwriter != null) {
        try {
          indexwriter.close();
          indexwriter.unlock(directory);
        }
 catch (        ioexception e) {
          log.error(this.getclass(),e);
        }
        indexwriter=null;
      }
    }
    log.warn(beanindex.class,"#################### append index  finished, this process spent " + (system.currenttimemillis() - start) / 1000 + " seconds");
  }
  @override public void remove() throws indexexception {
  }
  /** 
 * ?????
 * @param clazzclass????
 * @param fieldname????
 * @param data????
 * @return ??????
 * @throws exception
 */
  private string getfieldvalue(  class<?> clazz,  string fieldname,  object data) throws exception {
    string value=null;
    method m=clazz.getmethod("get" + fieldname.substring(0,1).touppercase() + fieldname.substring(1));
    string returnvaluetype=m.getreturntype().getsimplename();
    object mvalue=m.invoke(data);
    if (mvalue != null) {
      if ("string".equals(returnvaluetype) || "integer".equals(returnvaluetype) || "long".equals(returnvaluetype)|| "double".equals(returnvaluetype)|| "float".equals(returnvaluetype)|| "boolean".equals(returnvaluetype)|| "short".equalsignorecase(returnvaluetype)) {
        value=mvalue.tostring();
      }
 else       if ("date".equals(returnvaluetype)) {
        value=dateutil.timeformat((date)mvalue);
      }
 else       if ("timestamp".equals(returnvaluetype)) {
        value=dateutil.timeformat((timestamp)mvalue);
      }
 else       if ("hashmap".equals(returnvaluetype)) {
        value=jsonobject.fromobject(mvalue,config).tostring();
      }
 else       if ("arraylist".equals(returnvaluetype)) {
        value=jsonarray.fromobject(mvalue,config).tostring();
      }
 else {
        value=getfieldvalue(m.getreturntype(),fieldname,mvalue);
      }
    }
    return value;
  }
  /** 
 * ??????????
 * @param fields
 * @param clazz
 */
  private void getpojofileds(  list<string> fields,  class<?> clazz){
    method[] methods=clazz.getdeclaredmethods();
    for (    method m : methods) {
      string name=m.getname();
      if (name.startswith("get")) {
        string returnvaluetype=m.getreturntype().getsimplename();
        if ("string".equals(returnvaluetype) || "integer".equals(returnvaluetype) || "long".equals(returnvaluetype)|| "double".equals(returnvaluetype)|| "float".equals(returnvaluetype)|| "boolean".equals(returnvaluetype)|| "short".equalsignorecase(returnvaluetype)|| "date".equals(returnvaluetype)|| "timestamp".equals(returnvaluetype)|| "hashmap".equals(returnvaluetype)|| "arraylist".equals(returnvaluetype)) {
          name=name.substring(3,4).tolowercase() + name.substring(4);
        }
 else {
          getpojofileds(fields,m.getreturntype());
        }
        fields.add(name);
      }
    }
  }
  /** 
 * ?????????
 * @return
 */
  private map<string,fieldlucproperty> getfieldlucproperty(){
    map<string,fieldlucproperty> fieldpropertymap=new hashmap<string,fieldlucproperty>();
    if (analyzedindexfields != null) {
      for (      string analyzedindexfield : analyzedindexfields) {
        fieldlucproperty fieldlucproperty=new fieldlucproperty();
        fieldlucproperty.setfieldname(analyzedindexfield);
        fieldlucproperty.setanalyzed(true);
        fieldlucproperty.setstore(false);
        fieldlucproperty.setindex(true);
        fieldpropertymap.put(analyzedindexfield,fieldlucproperty);
      }
    }
    if (notanalyzedindexfields != null) {
      for (      string notanalyzedindexfield : notanalyzedindexfields) {
        fieldlucproperty fieldlucproperty=new fieldlucproperty();
        fieldlucproperty.setfieldname(notanalyzedindexfield);
        fieldlucproperty.setindex(true);
        fieldlucproperty.setanalyzed(false);
        fieldlucproperty.setstore(false);
        fieldpropertymap.put(notanalyzedindexfield,fieldlucproperty);
      }
    }
    if (storefields != null) {
      for (      string storefield : storefields) {
        if (fieldpropertymap.containskey(storefield)) {
          fieldlucproperty fieldlucproperty=fieldpropertymap.get(storefield);
          fieldlucproperty.setstore(true);
        }
 else {
          fieldlucproperty fieldlucproperty=new fieldlucproperty();
          fieldlucproperty.setfieldname(storefield);
          fieldlucproperty.setindex(false);
          fieldlucproperty.setanalyzed(false);
          fieldlucproperty.setstore(true);
          fieldpropertymap.put(storefield,fieldlucproperty);
        }
      }
    }
    return fieldpropertymap;
  }
  private static jsonconfig config;
static {
    config=new jsonconfig();
    config.registerjsonvalueprocessor(java.sql.timestamp.class,new datejsonvalueprocessor("yyyy-mm-dd hh:mm:ss"));
    config.registerjsonvalueprocessor(java.util.date.class,new datejsonvalueprocessor("yyyy-mm-dd hh:mm:ss"));
    config.registerjsonvalueprocessor(java.sql.date.class,new datejsonvalueprocessor("yyyy-mm-dd hh:mm:ss"));
  }
static class datejsonvalueprocessor implements jsonvalueprocessor {
    private string format;
    public datejsonvalueprocessor(    string format){
      this.format=format;
    }
    @override public object processarrayvalue(    object arg0,    jsonconfig arg1){
      return processobjectvalue(null,arg0,arg1);
    }
    @override public object processobjectvalue(    string key,    object value,    jsonconfig arg2){
      if (value == null) {
        return "";
      }
      if (value instanceof java.sql.timestamp) {
        string str=new simpledateformat(format).format((java.sql.timestamp)value);
        return str;
      }
      if (value instanceof java.util.date) {
        string str=new simpledateformat(format).format((java.util.date)value);
        return str;
      }
      return value.tostring();
    }
  }
}
', '8419f33c2ede4a6b80525fa3761da71c');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.index.DateJsonValueProcessor', '0', '', 'JsonValueProcessor; ', 'static;', 23, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\index\\BeanIndex.java', 'static class datejsonvalueprocessor implements jsonvalueprocessor {
  private string format;
  public datejsonvalueprocessor(  string format){
    this.format=format;
  }
  @override public object processarrayvalue(  object arg0,  jsonconfig arg1){
    return processobjectvalue(null,arg0,arg1);
  }
  @override public object processobjectvalue(  string key,  object value,  jsonconfig arg2){
    if (value == null) {
      return "";
    }
    if (value instanceof java.sql.timestamp) {
      string str=new simpledateformat(format).format((java.sql.timestamp)value);
      return str;
    }
    if (value instanceof java.util.date) {
      string str=new simpledateformat(format).format((java.util.date)value);
      return str;
    }
    return value.tostring();
  }
}
', '48fa8a9b1a144242a4ebf369109704c9');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.Index', '1', '', 'Configurable; ', 'public;', 37, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\Index.java', 'public interface index extends configurable {
  public void write(  list<object> datas) throws indexexception ;
  public void append(  list<object> datas) throws indexexception ;
  public void remove() throws indexexception ;
class fieldlucproperty {
    private string fieldname;
    private boolean isstore;
    private boolean isindex;
    private boolean isanalyzed;
    public fieldlucproperty(){
    }
    public string getfieldname(){
      return fieldname;
    }
    public void setfieldname(    string fieldname){
      this.fieldname=fieldname;
    }
    public boolean isstore(){
      return isstore;
    }
    public void setstore(    boolean isstore){
      this.isstore=isstore;
    }
    public boolean isindex(){
      return isindex;
    }
    public void setindex(    boolean isindex){
      this.isindex=isindex;
    }
    public boolean isanalyzed(){
      return isanalyzed;
    }
    public void setanalyzed(    boolean isanalyzed){
      this.isanalyzed=isanalyzed;
    }
  }
}
', '62d5d342e0df4ef2ad76d35e8d915d3c');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.FieldLucproperty', '0', '', ' ', '', 32, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\Index.java', 'class fieldlucproperty {
  private string fieldname;
  private boolean isstore;
  private boolean isindex;
  private boolean isanalyzed;
  public fieldlucproperty(){
  }
  public string getfieldname(){
    return fieldname;
  }
  public void setfieldname(  string fieldname){
    this.fieldname=fieldname;
  }
  public boolean isstore(){
    return isstore;
  }
  public void setstore(  boolean isstore){
    this.isstore=isstore;
  }
  public boolean isindex(){
    return isindex;
  }
  public void setindex(  boolean isindex){
    this.isindex=isindex;
  }
  public boolean isanalyzed(){
    return isanalyzed;
  }
  public void setanalyzed(  boolean isanalyzed){
    this.isanalyzed=isanalyzed;
  }
}
', '81082937582b4405afad51092340f9de');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.MyLuence', '0', '', ' ', 'public;', 99, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\MyLuence.java', '/** 
 * myluence
 * @author zhouyanjun
 * @version 1.0 2014-8-28
 */
public class myluence {
  private list<string> itemlist=new arraylist<string>();
  private string configpath;
  private map<string,indexsource> indexsourcemap;
  private map<string,abstarctsearcher> searchermap;
  private myluencefactory factory;
  public void init() throws ioexception, classnotfoundexception, configurableexception {
    indexsourcemap=new hashmap<string,indexsource>();
    searchermap=new hashmap<string,abstarctsearcher>();
    cffileparser cffileparser=null;
    if (configpath.contains(".properties")) {
      cffileparser=new propertiescfparser();
    }
 else     if (configpath.contains(".xml")) {
      cffileparser=new xmlcfparser();
    }
    cffileparser.setfilepath(configpath);
    map<string,context> cfcontextmap=cffileparser.parse();
    itemlist.addall(cfcontextmap.keyset());
    for (    string cfcontextkey : cfcontextmap.keyset()) {
      context context=cfcontextmap.get(cfcontextkey);
      indexsource indexsource=factory.getixsourceinstance(context.getstring(cffileparser.configitem.indexsource.value));
      indexsource.configure(context);
      indexsourcemap.put(cfcontextkey,indexsource);
      abstarctsearcher searcher=factory.getsearcherinstance();
      searcher.configure(context);
      searchermap.put(cfcontextkey,searcher);
    }
  }
  public void writeindex(){
    for (    string isourcekey : indexsourcemap.keyset()) {
      indexsourcemap.get(isourcekey).initialdataopen();
    }
  }
  public void writeindex(  string item) throws indexexception {
    if (!itemlist.contains(item)) {
      throw new indexexception("item doesn''t exist.");
    }
    indexsourcemap.get(item).initialdataopen();
  }
  public void appendindex(){
    for (    string isourcekey : indexsourcemap.keyset()) {
      indexsourcemap.get(isourcekey).increasedataopen();
    }
  }
  public void appendindex(  string item) throws indexexception {
    if (!itemlist.contains(item)) {
      throw new indexexception("item doesn''t exist.");
    }
    indexsourcemap.get(item).increasedataopen();
  }
  public <t>list<t> search(  string item,  string querystr,  sort sort,  int num) throws searchexception {
    if (!itemlist.contains(item)) {
      throw new searchexception("item doesn''t exist.");
    }
    return searchermap.get(item).search(querystr,sort,num);
  }
  public <t>list<t> search(  string item,  string[] querystr,  sort sort,  int num) throws searchexception {
    if (!itemlist.contains(item)) {
      throw new searchexception("item doesn''t exist.");
    }
    return searchermap.get(item).search(querystr,sort,num);
  }
  public <t>list<t> search(  string item,  string querystr,  sort sort,  int pagesize,  int curpage) throws searchexception {
    if (!itemlist.contains(item)) {
      throw new searchexception("item doesn''t exist.");
    }
    return searchermap.get(item).search(querystr,sort,pagesize,curpage);
  }
  public <t>list<t> exactsearch(  string item,  map<string,list<string>> searchtermmap,  sort sort,  int num) throws searchexception {
    if (!itemlist.contains(item)) {
      throw new searchexception("item doesn''t exist.");
    }
    return searchermap.get(item).exactsearch(searchtermmap,sort,1);
  }
  public <t>list<t> search(  string item,  string[] querystr,  sort sort,  int pagesize,  int curpage) throws searchexception {
    if (!itemlist.contains(item)) {
      throw new searchexception("item doesn''t exist.");
    }
    return searchermap.get(item).search(querystr,sort,pagesize,curpage);
  }
  public string getconfigpath(){
    return configpath;
  }
  public void setconfigpath(  string configpath){
    this.configpath=configpath;
  }
  public myluencefactory getfactory(){
    return factory;
  }
  public void setfactory(  myluencefactory factory){
    this.factory=factory;
  }
}
', '32f116509b69480e9b66b627cef7de44');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.PropertyParser', '0', '', ' ', 'public;', 25, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\PropertyParser.java', 'public class propertyparser {
  public static map<string,string> parse(  string filepath) throws ioexception {
    properties prop=new properties();
    prop.load(propertyparser.class.getresourceasstream(filepath));
    map<string,string> configs=new hashmap<string,string>();
    enumeration<?> keys=prop.keys();
    while (keys.hasmoreelements()) {
      string key=(string)keys.nextelement();
      string value=(string)prop.get(key);
      configs.put(key,value);
    }
    return configs;
  }
  public static void main(  string[] args){
    try {
      map<string,string> map=propertyparser.parse("/data/lucence_strategy.properties");
      for (      string key : map.keyset()) {
        system.out.println(key + "@" + map.get(key));
      }
    }
 catch (    ioexception e) {
      e.printstacktrace();
    }
  }
}
', 'f06b6bc5b5c144c3a5126fb67b1bc2f8');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.search.AbstarctSearcher', '0', '', 'Configurable; ', 'public;abstract;', 15, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\search\\AbstarctSearcher.java', 'public abstract class abstarctsearcher implements configurable {
  protected analyzer analyzer;
  protected fsdirectory directory;
  public abstract <t>list<t> search(  string querystr,  sort sort,  int num);
  public abstract <t>list<t> search(  string querystr,  sort sort,  int pagesize,  int curpage);
  public abstract <t>list<t> search(  string[] querystr,  sort sort,  int pagesize,  int curpage);
  public abstract <t>list<t> search(  string[] querystrs,  sort sort,  int num);
  public abstract <t>list<t> exactsearch(  map<string,list<string>> searchtermmap,  sort sort,  int num);
  public analyzer getanalyzer(){
    return analyzer;
  }
  public void setanalyzer(  analyzer analyzer){
    this.analyzer=analyzer;
  }
}
', 'cb9216efdd324700a904abd2825b7011');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', '0', 'com.wind.myLuence.search.AbstarctSearcher', ' ', 'public;', 361, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\search\\BeanSearcher.java', '/** 
 * bean???
 * @author zhouyanjun
 * @version 1.0 2014-8-20
 */
public class beansearcher extends abstarctsearcher {
  private final logger logger=loggerfactory.getlogger(this.getclass());
  private static final string analyzedindexfields="analyzedindexfields";
  private static final string notanalyzedindexfields="notanalyzedindexfields";
  private static final string classname="beanclass";
  private static final string storefields="storefields";
  private static final string analyzerclass="analyzerclass";
  private static final string indexfilepath="indexfilepath";
  private static final string datafieldname_default="data";
  private list<string> analyzedindexkeys=new arraylist<string>();
  private list<string> notanalyzedindexkeys=new arraylist<string>();
  private list<string> storekeys=new arraylist<string>();
  private class<?> clazz;
  private boolean hasdatakey;
{
    jsonutils.getmorpherregistry().registermorpher(new datemorpher(new string[]{"yyyy-mm-dd hh:mm:ss"}));
  }
  @suppresswarnings("unchecked") @override public <t>list<t> search(  string querystr,  sort sort,  int num){
    list<t> results=new arraylist<t>();
    try {
      indexsearcher searcher=new indexsearcher(directoryreader.open(directory));
      multifieldqueryparser parser=new multifieldqueryparser(version.lucene_46,analyzedindexkeys.toarray(new string[]{}),analyzer);
      query q=parser.parse(querystr);
      topdocs topdocs=searcher.search(q,num);
      scoredoc[] doslist=topdocs.scoredocs;
      for (int i=0; i < doslist.length; i++) {
        document doc=searcher.doc(doslist[i].doc);
        if (hasdatakey) {
          string objjson=doc.get(datafieldname_default);
          t t=(t)jsonobject.tobean(jsonobject.fromobject(objjson),clazz);
          results.add(t);
        }
 else {
          t t=(t)clazz.newinstance();
          for (          string storekey : storekeys) {
            string value=doc.get(storekey);
            map<string,string> fieldnametypes=getfieldnametype(clazz);
            setfieldvalue(clazz,storekey,value,fieldnametypes.get(storekey),t);
          }
          results.add(t);
        }
      }
    }
 catch (    parseexception e) {
      logger.error(e.getmessage(),e);
    }
catch (    ioexception e) {
      logger.error(e.getmessage(),e);
    }
catch (    exception e) {
      logger.error(e.getmessage(),e);
    }
    return results;
  }
  @suppresswarnings("unchecked") @override public <t>list<t> search(  string[] querystrs,  sort sort,  int num){
    list<t> results=new arraylist<t>();
    try {
      indexsearcher searcher=new indexsearcher(directoryreader.open(directory));
      multifieldqueryparser parser=new multifieldqueryparser(version.lucene_46,analyzedindexkeys.toarray(new string[]{}),analyzer);
      for (      string querystr : querystrs) {
        query q=parser.parse(querystr);
        topdocs topdocs=searcher.search(q,num);
        scoredoc[] doslist=topdocs.scoredocs;
        for (int i=0; i < doslist.length; i++) {
          document doc=searcher.doc(doslist[i].doc);
          if (hasdatakey) {
            string objjson=doc.get(datafieldname_default);
            t t=(t)jsonobject.tobean(jsonobject.fromobject(objjson),clazz);
            results.add(t);
          }
 else {
            t t=(t)clazz.newinstance();
            for (            string storekey : storekeys) {
              string value=doc.get(storekey);
              map<string,string> fieldnametypes=getfieldnametype(clazz);
              setfieldvalue(clazz,storekey,value,fieldnametypes.get(storekey),t);
            }
            results.add(t);
          }
        }
      }
    }
 catch (    parseexception e) {
      logger.error(e.getmessage(),e);
    }
catch (    ioexception e) {
      logger.error(e.getmessage(),e);
    }
catch (    exception e) {
      logger.error(e.getmessage(),e);
    }
    return results;
  }
  @suppresswarnings("unchecked") @override public <t>list<t> search(  string querystr,  sort sort,  int pagesize,  int curpage){
    list<t> results=new arraylist<t>();
    try {
      indexsearcher searcher=new indexsearcher(directoryreader.open(directory));
      multifieldqueryparser parser=new multifieldqueryparser(version.lucene_46,analyzedindexkeys.toarray(new string[]{}),analyzer);
      query q=parser.parse(querystr);
      topdocs topdocs=searcher.search(q,3000);
      scoredoc[] doslist=topdocs.scoredocs;
      int begin=pagesize * (curpage - 1);
      int end=math.min(begin + pagesize,doslist.length);
      for (int i=begin; i < end; i++) {
        document doc=searcher.doc(doslist[i].doc);
        if (hasdatakey) {
          string objjson=doc.get(datafieldname_default);
          t t=(t)jsonobject.tobean(jsonobject.fromobject(objjson),clazz);
          results.add(t);
        }
 else {
          t t=(t)clazz.newinstance();
          for (          string storekey : storekeys) {
            string value=doc.get(storekey);
            map<string,string> fieldnametypes=getfieldnametype(clazz);
            setfieldvalue(clazz,storekey,value,fieldnametypes.get(storekey),t);
          }
          results.add(t);
        }
      }
    }
 catch (    parseexception e) {
      logger.error(e.getmessage(),e);
    }
catch (    ioexception e) {
      logger.error(e.getmessage(),e);
    }
catch (    exception e) {
      logger.error(e.getmessage(),e);
    }
    return results;
  }
  @suppresswarnings("unchecked") @override public <t>list<t> search(  string[] querystr,  sort sort,  int pagesize,  int curpage){
    list<t> results=new arraylist<t>();
    try {
      indexsearcher searcher=new indexsearcher(directoryreader.open(directory));
      booleanquery bquery=new booleanquery();
      multifieldqueryparser parser=new multifieldqueryparser(version.lucene_46,analyzedindexkeys.toarray(new string[]{}),analyzer);
      for (int i=0; i < querystr.length; i++) {
        query query=parser.parse(querystr[i]);
        bquery.add(query,booleanclause.occur.should);
      }
      topdocs topdocs=searcher.search(bquery,3000);
      scoredoc[] doslist=topdocs.scoredocs;
      int begin=pagesize * (curpage - 1);
      int end=math.min(begin + pagesize,doslist.length);
      for (int i=begin; i < end; i++) {
        document doc=searcher.doc(doslist[i].doc);
        if (hasdatakey) {
          string objjson=doc.get(datafieldname_default);
          t t=(t)jsonobject.tobean(jsonobject.fromobject(objjson),clazz);
          results.add(t);
        }
 else {
          t t=(t)clazz.newinstance();
          for (          string storekey : storekeys) {
            string value=doc.get(storekey);
            map<string,string> fieldnametypes=getfieldnametype(clazz);
            setfieldvalue(clazz,storekey,value,fieldnametypes.get(storekey),t);
          }
          results.add(t);
        }
      }
    }
 catch (    parseexception e) {
      logger.error(e.getmessage(),e);
    }
catch (    exception e) {
      logger.error(e.getmessage(),e);
    }
    return results;
  }
  @suppresswarnings("unchecked") @override public <t>list<t> exactsearch(  map<string,list<string>> searchtermmap,  sort sort,  int num){
    list<t> results=new arraylist<t>();
    try {
      if (!notanalyzedindexkeys.containsall(searchtermmap.keyset())) {
        throw new searchexception("search key collection don''t exist.");
      }
      indexsearcher searcher=new indexsearcher(directoryreader.open(directory));
      for (      string searchkey : searchtermmap.keyset()) {
        list<string> searchtermlist=searchtermmap.get(searchkey);
        for (        string searchterm : searchtermlist) {
          query query=new termquery(new term(searchkey,searchterm));
          topdocs topdocs=searcher.search(query,num);
          scoredoc[] doslist=topdocs.scoredocs;
          for (int i=0; i < doslist.length; i++) {
            document doc=searcher.doc(doslist[i].doc);
            if (hasdatakey) {
              string objjson=doc.get(datafieldname_default);
              t t=(t)jsonobject.tobean(jsonobject.fromobject(objjson),clazz);
              results.add(t);
            }
 else {
              t t=(t)clazz.newinstance();
              for (              string storekey : storekeys) {
                string value=doc.get(storekey);
                map<string,string> fieldnametypes=getfieldnametype(clazz);
                setfieldvalue(clazz,storekey,value,fieldnametypes.get(storekey),t);
              }
              results.add(t);
            }
          }
        }
      }
    }
 catch (    parseexception e) {
      logger.error(e.getmessage(),e);
    }
catch (    exception e) {
      logger.error(e.getmessage(),e);
    }
    return results;
  }
  public void configure(  context context) throws configurableexception {
    try {
      string analyzerclass=context.getstring(analyzerclass);
      this.analyzer=(analyzer)class.forname(analyzerclass).newinstance();
      list<string> pojofields=new arraylist<string>();
      string classname=context.getstring(classname);
      try {
        this.clazz=class.forname(classname);
        getpojofileds(pojofields,clazz);
      }
 catch (      classnotfoundexception e1) {
        logger.error("bean class error to create.");
        throw new configurableexception(e1.getmessage(),e1);
      }
      string analyzedindexfields=context.getstring(analyzedindexfields);
      if (analyzedindexfields != null && !analyzedindexfields.isempty()) {
        list<string> analyzedindexfieldlist=new arraylist<string>(arrays.aslist(analyzedindexfields.split(",")));
        if (!pojofields.containsall(analyzedindexfieldlist)) {
          logger.error("indexfield''s range beyong the range of pojofields");
          throw new configurableexception("indexfield''s range beyong the range of pojofields");
        }
        analyzedindexkeys.addall(analyzedindexfieldlist);
      }
      string notanalyzedindexfields=context.getstring(notanalyzedindexfields);
      if (notanalyzedindexfields != null && !notanalyzedindexfields.isempty()) {
        list<string> notanalyzedindexfieldlist=new arraylist<string>(arrays.aslist(notanalyzedindexfields.split(",")));
        if (!pojofields.containsall(notanalyzedindexfieldlist)) {
          logger.error("notanalyzedindexfields''s range beyong the range of pojofields");
          throw new configurableexception("notanalyzedindexfields''s range beyong the range of pojofields");
        }
        notanalyzedindexkeys.addall(notanalyzedindexfieldlist);
      }
      string storefields=context.getstring(storefields);
      if (storefields != null && !storefields.isempty()) {
        list<string> storefieldlist=new arraylist<string>(arrays.aslist(storefields.split(",")));
        if (!pojofields.containsall(storefieldlist) && !storefieldlist.contains(datafieldname_default)) {
          logger.error("storefields''s range beyong the range of pojofields");
          throw new configurableexception("storefields''s range beyong the range of pojofields");
        }
        storekeys.addall(storefieldlist);
      }
      if (storekeys.contains(datafieldname_default)) {
        hasdatakey=true;
      }
      string indexfilepath=context.getstring(indexfilepath);
      if (indexfilepath == null || indexfilepath.isempty()) {
        logger.error("indexfilepath must to be set.");
        throw new configurableexception("indexfilepath must to be set.");
      }
      try {
        this.directory=fsdirectory.open(new file(indexfilepath));
      }
 catch (      ioexception e) {
        logger.error("index file dir error to create.");
        throw new configurableexception("index file dir error to create.");
      }
    }
 catch (    instantiationexception e2) {
      log.error(this.getclass(),e2.getmessage());
      throw new configurableexception(e2.getmessage(),e2);
    }
catch (    illegalaccessexception e2) {
      log.error(this.getclass(),e2.getmessage());
      throw new configurableexception(e2.getmessage(),e2);
    }
catch (    classnotfoundexception e2) {
      log.error(this.getclass(),e2.getmessage());
      throw new configurableexception(e2.getmessage(),e2);
    }
  }
  /** 
 * ??????????
 * @param fields
 * @param clazz
 */
  private void getpojofileds(  list<string> fields,  class<?> clazz){
    method[] methods=clazz.getdeclaredmethods();
    for (    method m : methods) {
      string name=m.getname();
      if (name.startswith("get")) {
        string returnvaluetype=m.getreturntype().getsimplename();
        if ("string".equals(returnvaluetype) || "integer".equals(returnvaluetype) || "long".equals(returnvaluetype)|| "double".equals(returnvaluetype)|| "float".equals(returnvaluetype)|| "boolean".equals(returnvaluetype)|| "short".equalsignorecase(returnvaluetype)|| "date".equals(returnvaluetype)|| "timestamp".equals(returnvaluetype)|| "hashmap".equals(returnvaluetype)|| "arraylist".equals(returnvaluetype)) {
          name=name.substring(3,4).tolowercase() + name.substring(4);
        }
 else {
          getpojofileds(fields,m.getreturntype());
        }
        fields.add(name);
      }
    }
  }
  private void setfieldvalue(  class<?> clazz,  string fieldname,  string fieldvalue,  string fieldtype,  object data) throws exception {
    object relvalue=null;
    if ("string".equals(fieldtype)) {
      relvalue=fieldvalue;
    }
 else     if ("integer".equals(fieldtype)) {
      relvalue=integer.parseint(fieldvalue);
    }
 else     if ("long".equals(fieldtype)) {
      relvalue=long.parselong(fieldvalue);
    }
 else     if ("double".equals(fieldtype)) {
      relvalue=double.parsedouble(fieldvalue);
    }
 else     if ("float".equals(fieldtype)) {
      relvalue=float.parsefloat(fieldvalue);
    }
 else     if ("boolean".equals(fieldtype)) {
      relvalue=boolean.parseboolean(fieldvalue);
    }
 else     if ("short".equalsignorecase(fieldtype)) {
      relvalue=short.parseshort(fieldvalue);
    }
 else     if ("date".equals(fieldtype)) {
      relvalue=dateutil.parsetime(fieldvalue);
    }
 else     if ("timestamp".equals(fieldvalue)) {
      relvalue=dateutil.parsetime(fieldvalue);
    }
 else     if ("hashmap".equals(fieldvalue)) {
      relvalue=jsonobject.tobean(jsonobject.fromobject(fieldvalue),hashmap.class);
    }
 else     if ("arraylist".equals(fieldvalue)) {
      relvalue=jsonarray.toarray(jsonarray.fromobject(fieldvalue));
    }
    method m=clazz.getmethod("set" + fieldname.substring(0,1).touppercase() + fieldname.substring(1));
    m.invoke(data,relvalue);
  }
  private map<string,string> getfieldnametype(  class<?> clazz){
    map<string,string> fieldnametypemap=new hashmap<string,string>();
    method[] methods=clazz.getdeclaredmethods();
    for (    method m : methods) {
      string name=m.getname();
      if (name.startswith("set")) {
        string returnvaluetype=m.getreturntype().getsimplename();
        name=name.substring(3,4).tolowercase() + name.substring(4);
        fieldnametypemap.put(name,returnvaluetype);
      }
    }
    return fieldnametypemap;
  }
}
', '44af68f1f2b544bd84d1a9e9017eb242');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.source.BeanSource', '0', '', 'DataSource; ', 'public;', 15, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\source\\BeanSource.java', '/** 
 * bean?
 * @author zhouyanjun
 * @version 1.0 2014-4-24
 */
public class beansource implements datasource {
  public void configure(  context context) throws configurableexception {
  }
  public void open(  index index){
  }
  @override public void initialdataopen(){
  }
  @override public void increasedataopen(){
  }
}
', 'f9a53b6e64eb48c0b9db85f6b86885bc');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', '0', 'com.wind.myLuence.source.IndexSource', ' ', 'public;', 190, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\source\\DDALDatabaseSource.java', '/** 
 * ddal???
 * @author zhouyanjun
 * @version 1.0 2014-4-24
 */
public class ddaldatabasesource extends indexsource {
  private final logger logger=loggerfactory.getlogger(ddaldatabasesource.class);
  private asynddalhelper asynhelper;
  private class<?> pojoclass;
  private incfieldrw incfieldrw;
  private map<string,string> fieldfiltermap=new hashmap<string,string>();
  public void configure(  context context) throws configurableexception, classnotfoundexception {
    string classpath=context.getstring(cffileparser.configitem.beanclass.value);
    pojoclass=class.forname(classpath);
    string incfield=context.getstring(cffileparser.configitem.incfield.value);
    if (incfield != null) {
      string indexpath=context.getstring(cffileparser.configitem.indexfilepath.value);
      string incfieldpath=indexpath + "/inc/fieldlast.txt";
      incfieldrw=new incfieldrw(incfield,new file(incfieldpath),pojoclass);
    }
    string datafilterstr=context.getstring(cffileparser.configitem.datafilter.value);
    if (datafilterstr != null) {
      string[] datafilterarray=datafilterstr.split(":");
      fieldfiltermap.put(datafilterarray[0],datafilterarray[1]);
    }
    index.configure(context);
  }
  @override public void initialdataopen(){
    dataorder order=null;
    if (incfieldrw != null) {
      order=new dataorder(incfieldrw.incfieldname,true);
    }
    list<condition> filter=new arraylist<condition>();
    if (!fieldfiltermap.isempty()) {
      for (      string field : fieldfiltermap.keyset()) {
        filter.add(new condition(field,fieldfiltermap.get(field)));
      }
    }
    asynhelper.query(pojoclass,null,integer.max_value,(filter.isempty() ? null : filter),order,new reslistcallback<object>(){
      @override public void succeed(      list<object> datas) throws exception {
        if (datas != null && !datas.isempty() && incfieldrw != null) {
          incfieldrw.writevalue(datas.get(0));
        }
        beanindex databaseindex=(beanindex)index;
        databaseindex.write(datas);
      }
      @override public void failure(      resultvo result) throws exception {
        logger.error(result.geterrormsg());
      }
    }
);
  }
  @override public void increasedataopen(){
    if (incfieldrw == null) {
      throw new nullpointerexception("increase field doesn''t set");
    }
    try {
      list<condition> filter=new arraylist<condition>();
      filter.add(new condition(incfieldrw.incfieldname,compares.more_than,incfieldrw.readvalue()));
      if (!fieldfiltermap.isempty()) {
        for (        string field : fieldfiltermap.keyset()) {
          filter.add(new condition(field,fieldfiltermap.get(field)));
        }
      }
      dataorder order=new dataorder(incfieldrw.incfieldname,true);
      asynhelper.query(pojoclass,null,filter,order,null,new reslistcallback<object>(){
        @override public void succeed(        list<object> datas) throws exception {
          if (datas != null && !datas.isempty()) {
            incfieldrw.writevalue(datas.get(0));
          }
          beanindex databaseindex=(beanindex)index;
          databaseindex.append(datas);
        }
        @override public void failure(        resultvo result) throws exception {
          logger.error(result.geterrormsg());
        }
      }
);
    }
 catch (    exception e) {
      logger.error(e.getmessage(),e);
    }
  }
class incfieldrw {
    protected file incfieldlaststore;
    protected string incfieldname;
    private class<?> clazz;
    private static final string fieldtype="type";
    private simpledateformat timeformat=new simpledateformat("yyyy-mm-dd hh:mm:ss");
    incfieldrw(    string incfieldname,    file incfieldlaststore,    class<?> clazz){
      this.incfieldname=incfieldname;
      this.incfieldlaststore=incfieldlaststore;
      this.clazz=clazz;
    }
    /** 
 * ???????
 * @param clazz
 * @param fieldname
 * @param data
 * @throws exception
 */
    protected void writevalue(    object data) throws exception {
      string value=null;
      method m=clazz.getmethod("get" + incfieldname.substring(0,1).touppercase() + incfieldname.substring(1));
      string returnvaluetype=m.getreturntype().getsimplename();
      object mvalue=m.invoke(data);
      if (mvalue != null) {
        if ("integer".equals(returnvaluetype) || "long".equals(returnvaluetype) || "short".equalsignorecase(returnvaluetype)) {
          value=mvalue.tostring();
        }
 else         if ("date".equals(returnvaluetype)) {
          value=timeformat.format((date)mvalue);
        }
 else         if ("timestamp".equals(returnvaluetype)) {
          value=timeformat.format((timestamp)mvalue);
        }
      }
      map<string,string> map=new hashmap<string,string>();
      map.put(incfieldname,value);
      map.put(fieldtype,returnvaluetype);
      jsonobjutil.savejson2file(new jsonobject(map),incfieldlaststore);
    }
    /** 
 * ???????
 * @return
 * @throws exception
 */
    protected object readvalue() throws exception {
      object result=null;
      if (incfieldlaststore.exists()) {
        string content=jsonobjutil.getfilejsoncontent(incfieldlaststore);
        jsonobject jsonobeject=new jsonobject(content);
        string value=jsonobeject.getstring(incfieldname);
        string fieldtype=jsonobeject.getstring(fieldtype);
        if ("integer".equals(fieldtype)) {
          result=integer.parseint(value);
        }
 else         if ("long".equals(fieldtype)) {
          result=long.parselong(value);
        }
 else         if ("short".equals(fieldtype)) {
          result=short.parseshort(value);
        }
 else         if ("date".equals(fieldtype)) {
          result=timeformat.parse(value);
        }
 else         if ("timestamp".equals(fieldtype)) {
          result=timeformat.parse(value);
        }
      }
      return result;
    }
  }
  public asynddalhelper getasynhelper(){
    return asynhelper;
  }
  public void setasynhelper(  asynddalhelper asynhelper){
    this.asynhelper=asynhelper;
  }
  private static jsonconfig config;
static {
    config=new jsonconfig();
    config.registerjsonvalueprocessor(java.sql.timestamp.class,new datejsonvalueprocessor("yyyy-mm-dd hh:mm:ss"));
    config.registerjsonvalueprocessor(java.util.date.class,new datejsonvalueprocessor("yyyy-mm-dd hh:mm:ss"));
    config.registerjsonvalueprocessor(java.sql.date.class,new datejsonvalueprocessor("yyyy-mm-dd hh:mm:ss"));
  }
static class datejsonvalueprocessor implements jsonvalueprocessor {
    private string format;
    public datejsonvalueprocessor(    string format){
      this.format=format;
    }
    @override public object processarrayvalue(    object arg0,    jsonconfig arg1){
      return processobjectvalue(null,arg0,arg1);
    }
    @override public object processobjectvalue(    string key,    object value,    jsonconfig arg2){
      if (value == null) {
        return "";
      }
      if (value instanceof java.sql.timestamp) {
        string str=new simpledateformat(format).format((java.sql.timestamp)value);
        return str;
      }
      if (value instanceof java.util.date) {
        string str=new simpledateformat(format).format((java.util.date)value);
        return str;
      }
      return value.tostring();
    }
  }
}
', '5758bb6542e34a99a672b355d05ba93f');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'anonymous', '0', '', ' ', '', 433, '', '', '95ec450427af42adad460523808b8cc8');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'anonymous', '0', '', ' ', '', 415, '', '', 'df3e5ac1bfa04e41bb5313c2dc29fe2d');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', '0', '', ' ', '', 70, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\source\\DDALDatabaseSource.java', 'class incfieldrw {
  protected file incfieldlaststore;
  protected string incfieldname;
  private class<?> clazz;
  private static final string fieldtype="type";
  private simpledateformat timeformat=new simpledateformat("yyyy-mm-dd hh:mm:ss");
  incfieldrw(  string incfieldname,  file incfieldlaststore,  class<?> clazz){
    this.incfieldname=incfieldname;
    this.incfieldlaststore=incfieldlaststore;
    this.clazz=clazz;
  }
  /** 
 * ???????
 * @param clazz
 * @param fieldname
 * @param data
 * @throws exception
 */
  protected void writevalue(  object data) throws exception {
    string value=null;
    method m=clazz.getmethod("get" + incfieldname.substring(0,1).touppercase() + incfieldname.substring(1));
    string returnvaluetype=m.getreturntype().getsimplename();
    object mvalue=m.invoke(data);
    if (mvalue != null) {
      if ("integer".equals(returnvaluetype) || "long".equals(returnvaluetype) || "short".equalsignorecase(returnvaluetype)) {
        value=mvalue.tostring();
      }
 else       if ("date".equals(returnvaluetype)) {
        value=timeformat.format((date)mvalue);
      }
 else       if ("timestamp".equals(returnvaluetype)) {
        value=timeformat.format((timestamp)mvalue);
      }
    }
    map<string,string> map=new hashmap<string,string>();
    map.put(incfieldname,value);
    map.put(fieldtype,returnvaluetype);
    jsonobjutil.savejson2file(new jsonobject(map),incfieldlaststore);
  }
  /** 
 * ???????
 * @return
 * @throws exception
 */
  protected object readvalue() throws exception {
    object result=null;
    if (incfieldlaststore.exists()) {
      string content=jsonobjutil.getfilejsoncontent(incfieldlaststore);
      jsonobject jsonobeject=new jsonobject(content);
      string value=jsonobeject.getstring(incfieldname);
      string fieldtype=jsonobeject.getstring(fieldtype);
      if ("integer".equals(fieldtype)) {
        result=integer.parseint(value);
      }
 else       if ("long".equals(fieldtype)) {
        result=long.parselong(value);
      }
 else       if ("short".equals(fieldtype)) {
        result=short.parseshort(value);
      }
 else       if ("date".equals(fieldtype)) {
        result=timeformat.parse(value);
      }
 else       if ("timestamp".equals(fieldtype)) {
        result=timeformat.parse(value);
      }
    }
    return result;
  }
}
', '45437f63899446bcb49c8a2904ea863a');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.source.DateJsonValueProcessor', '0', '', 'JsonValueProcessor; ', 'static;', 23, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\source\\DDALDatabaseSource.java', 'static class datejsonvalueprocessor implements jsonvalueprocessor {
  private string format;
  public datejsonvalueprocessor(  string format){
    this.format=format;
  }
  @override public object processarrayvalue(  object arg0,  jsonconfig arg1){
    return processobjectvalue(null,arg0,arg1);
  }
  @override public object processobjectvalue(  string key,  object value,  jsonconfig arg2){
    if (value == null) {
      return "";
    }
    if (value instanceof java.sql.timestamp) {
      string str=new simpledateformat(format).format((java.sql.timestamp)value);
      return str;
    }
    if (value instanceof java.util.date) {
      string str=new simpledateformat(format).format((java.util.date)value);
      return str;
    }
    return value.tostring();
  }
}
', '3dbf93ba1ed04ee4bc0f6e115815ba0e');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.source.IndexSource', '0', '', 'DataSource; ', 'public;abstract;', 14, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\source\\IndexSource.java', '/** 
 * ????
 * @author zhouyanjun
 * @version 1.0 2014-4-24
 */
public abstract class indexsource implements datasource {
  protected index index;
  public index getindex(){
    return index;
  }
  public void setindex(  index index){
    this.index=index;
  }
}
', '81f547348db542239732b72f6c8ded7e');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.myLuence.util.ClassUtil', '0', '', ' ', 'public;', 20, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\util\\ClassUtil.java', 'public class classutil {
  public static map<string,string> getfieldnametype(  class<?> clazz){
    map<string,string> fieldnametypemap=new hashmap<string,string>();
    if (clazz != null) {
      field[] fields=clazz.getdeclaredfields();
      for (int j=0; j < fields.length; j++) {
        string fieldname=fields[j].getname();
        string classpath=fields[j].gettype().getname();
        fieldnametypemap.put(fieldname,classpath);
      }
    }
    return fieldnametypemap;
  }
  public static void main(  string[] args) throws classnotfoundexception {
    map<string,string> fields=getfieldnametype(class.forname("com.snail.cloudlevel.app.assistant.res.ydlcrawlstrategy"));
    for (    string field : fields.keyset()) {
      system.out.println(field + "  :" + fields.get(field));
    }
  }
}
', '0cfa7734ebff449290ce018cc2f6048d');
INSERT INTO codegraphtest.classinfo (projectname, classname, isInterface, superclass, interfaces, modi, loc, filename, content, id) VALUES ('MyLuence-master', 'com.wind.Paint_MyLuence.util.DateUtil', '0', '', ' ', 'public;', 28, 'C:\\Users\\Zero\\Desktop\\??\\MyLuence-master\\MyLuence-master\\src\\main\\java\\com\\wind\\myLuence\\util\\DateUtil.java', '/** 
 * ??util
 * @author zhouyanjun
 * @version 1.0 2014-8-26
 */
public class dateutil {
  public final static simpledateformat timeformat=new simpledateformat("yyyy-mm-dd hh:mm:ss");
  /** 
 * ????yyyy-mm-dd hh:mm:ss????????????
 * @param date
 * @return
 * @throws parseexception
 */
  public synchronized static date parsetime(  string date) throws parseexception {
    if (date == null || date.isempty())     return null;
    date d=null;
    return timeformat.parse(date);
  }
  /** 
 * ????????yyyy-mm-dd hh:mm:ss?????????
 * @param date
 * @return
 */
  public synchronized static string timeformat(  date date){
    if (date == null)     return null;
    return timeformat.format(date);
  }
}
', '19577de8b79c4c2c97c0b81898477d4d');
create table classrelationinfo
(
    projectName  text null,
    fromClass    text null,
    frommethod   text null,
    toClass      text null,
    relationType text null,
    id           text null
)
    charset = utf8;

INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', 'com.wind.myLuence.index.BeanIndex', '', 'String,FieldLucproperty', '2', '573fb113ad454ca39198e2f7f69d4852');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', 'com.wind.myLuence.MyLuence', '', 'String,IndexSource', '2', '4dc88a7b478b4e4ab903ef646bdfbfa5');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', 'com.wind.myLuence.MyLuence', '', 'String,AbstarctSearcher', '2', 'fe414dd92daf4605a8ff0061ddd86e46');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', 'com.wind.myLuence.MyLuence', '', 'com.wind.myLuence.factory.MyLuenceFactory', '2', 'e0296f28c04048d0a4c671397e79fd82');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', '', 'com.wind.myLuence.source.IncFieldRW', '2', '92174ed9c9a2459aa72638eff4d243b5');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', 'com.wind.myLuence.source.IndexSource', '', 'com.wind.myLuence.Index', '2', 'eead1fe01bd5488a9b803143cd88b5ec');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', 'com.wind.myLuence.Context', '2', 'e979b545cd724c209bf631e3de24d46c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', 'com.wind.myLuence.Context', '2', 'f312d3da553e43b3a0a4f1f95d17b936');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', 'com.wind.myLuence.factory.MyLuenceFactory', '2', '3ff810c147d94baa9e4ca792e6e2dbaa');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', 'com.wind.myLuence.Context', '2', '38623312a0644de5a9e12100e6a8e3bd');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', 'com.wind.myLuence.Context', '2', '91b1de60b7a047b4b7a632952310e200');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', 'com.wind.myLuence.Index', '2', 'c69147b79756414c8d02494cff0460e2');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', 'com.wind.myLuence.Context', '2', 'a420a681c4c44eb68ffad3036ae8b544');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', 'com.wind.myLuence.Index', '2', 'ac7a82311d7345c9b3f5c932dc400334');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f89cbad142e2468c82b8668dff53a9aa');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '72d0844e7687402ca1418681cc5633c1');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7ea94fb43fe8439398d8d938f696ff6c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'db7f8202d5e047e885afffdcad24695d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e388f8896f1c454caf9c4ad10a80fa81');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e6af8520926a473b8f28bb464e9f6b4f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '9ce204260f2a46349fbef4a56da22b30');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e0ae51d571244ba884d3c097cfb6d8a3');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '030885a62f954349804d9a426e8c3b8c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'a73e02f4a5014dca8aa437775ce9d429');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '973934ace74740868bd6da4250f7ec77');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '4cff846a454c4c5f8ffe7ae5368b4863');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd6ed418275da4533b902cd02a98e717e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '6ec4294de84042878c0ab6519df64429');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '759dd997eea040e8afda73305a0fba6c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'bfba59cf797941738adcb21d3b5a7d97');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'ec33955a291a4ef09550488a02ca9058');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '6015eac7a8aa45c4b4f2bbdbc7fd61ff');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e935567a9337421ea1a35483549fde06');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '88f9551ca56b479a87ca891b73f7ff23');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd3f54fee1a21402b8b6d4d7276f062e9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '4a338a6e27a9466e90605ef4cde29f2e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'a55896a3feaf4493a1fa42a942364f0f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e5cb503921374656a1874234b37aa087');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c7e139c191fa4bad81bd4104c86d2a0a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e0489c9d7f3a45c191be9d90f5ce21c9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '2ac0fd3d3ee14e0692762d4f4a2f2d1e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '6ca2c5afbbd84316997c1c144e4e35ae');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1abf1181828a4fe7afc588b62043b4af');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f68d7a12c4d04939a52cf3afa9e116e5');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e9f4741adc54430891ea0cb4bb1ce4af');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '30b1de33ca1b48e9a2d086501b87a5fc');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'ab0d7e5eaacb47c1b66aea119a939532');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '2d70a8cbbc5c4d4b8d792aa12e47cc17');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'bd96f1e6444441fa8936b6098d1c925c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '691e065892294327bf879703a4b8611e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5acd7b7d507047b5beede14cd434e831');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'b05ad1b5254449768ea2cab501b33a61');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '4ba613184ad641ccbeafb5fb6ea2726c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'fe47d31c051d406387f0121d27feabab');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '9ceae2f6126741fc87434c3219a267f7');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '160ff3d9328a4e53b4f129e52c9652c5');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '69231cfc1a7449f8a77f8e3124a92dbf');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '70d514f56c294167a6042aa4746ce929');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '58ce29f553c84348b723c77f3d87bfd8');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '34dbef76a44c4982960e58ccaac68fc1');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '286384cd12904c6ea49fecc01fc46b23');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '4cb09c4b7b4246d4aff0212f79a5b4de');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e42141cd160e41e9942b68c273fe2363');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e2bdda8b716a46acbebc611b9d15b784');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'fa28f550d8344e0d864bbed86158dc8c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1bd44766177e4e879b6ecb1b019e0e34');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '0dfc0f725482424f90d3338f1ded2b68');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '932229a3d54d43a8aa4c232d05ee3949');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8d1eab52f6834e6da41c251b726fbcb6');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3b6eb886c5534af289fd2c44ebf08438');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'ef7b55155fcf4e3c978059b15d58aa13');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '2838830e13e046fbb769c6fa256f064a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1d2290df72134a79a829fd5559b9c5cc');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '0b8ed88731af4d19b717867464868c6f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '84648e812c0e4a76b02874fc84be3e78');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'a00c397b2d9140e3b57d05a2a6265211');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1c71da27e3104161a58dcbf4057b3d6f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd404411da0b34e63900b5125fbe30de5');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '27c0890b1a85468cad82ff083a058a4b');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '9e4f5f6c36ea4f148cb697cf3690d3ed');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd66d48cbc22741dfa81bb391bd6c5372');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '121c93a415f646f390ffab9aa886c06c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '90317cb0631949bc81a7e021e2adf3fa');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '6fc6885672204f6d8bad23b3014a8c33');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '059670c8436244458dcf5736772616c1');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f78f98f6ff9d43eaa43c99e873ff318d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '13f2fd271c4647cda9c93bf4ba6d7a25');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '64a41f83ac2b478f80521c9ab8e11d13');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5f63f251628f4a558d47596f8728807e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1d79360a24a64570a8cf955f62dd5b5a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd1f368edfabf4924aef28d5ed411b039');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '23ac46c6844d4277b902a3ff1e6a1f79');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '335b87e15ad546dd87aec4b04abc9c54');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e9958f14b9c8426692fa23fae80aa35a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '80b0ccb52570447789042e1554234471');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'a574771518564308bdbe89bb902e8eab');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '088dafab7fb446ea89bba29d24e70a04');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'a6510fb172834e038d9d0edcfb7364be');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '59f83ddde0494c90aee72d02f6bf8b12');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5ee8205a25f844efa9785db1e2e99cd8');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '4ea13376972c4704b8ca5d6d4c7c5cff');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7c16ddbca2e94707bc8e3ceb1ab96cc2');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1b14f0fd3109490280facecbb31b1857');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'fa63dfdd4d884a13a5f8902ee33a1c22');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '50d4da5a1cef40289e5fdc03acbbd4ca');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '68092a4f517d460aa43be3c9caa574a4');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'ec932d4d94764415b13f69d337186268');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1abfc18d4103493698d7c9e76daccc91');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f050319007db44258950ae00abf5df67');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f51228684fbe410a97c8892cbc33d35e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '938c1fa70b18404d8fa44eaeb62ff967');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'b3597702c02f45b1a5684334eb8816db');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '6411a0b23c9e48a19e862862fac7215e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '0700ec92e8dc422d8795a9598f866bae');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7ad35515f30344359d7f4db4202f0e6a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '82b88c204a194a1dbf4dbb8f058a8f45');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '10f975c4890b49a0b1e648571aca7b95');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c831398e55374a8ca15d07e15fa270a5');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '4de392c044be42b38d3b0eed7a9bfda4');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'def6eb9b18954329abefeac99c1e890d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '01a0e2d01ef740b3bd83bfd9d5965a33');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c82072b734114bdca3f317d6a8b050d9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '69a20be48ca645688e376c757ca90e66');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7ed8e3ad5d5b4de48b0c95a17fb2105c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '047fc5229c9a4af2a7df81cf19e79512');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'eb3157581b65487d87ffb633b46a1599');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '28d80f229c7543c98e643a3b277e4961');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '57e7f947dfab409a849117423735151f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'dcaf727a3118477d8658dcb4115c48af');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd4bc57fb51734915b245d1218c11b3d5');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'cb1afd7f3eec4ead9873021cae9b0295');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '6fa082589f8848ffaba734401a18ef95');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '153034c510344731bc424a60270f0c40');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e2f96b854425489492b9e314393d3912');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '78296eb225054939a929b10ff8f47047');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '64c1827d7b324cb68cef0bc850d3e271');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1edb282c99764ecfb8f4380b6c208a8b');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '36dbd95da71e40e59fe024d48bf767fa');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3ef32e83af2046ed82fb2c8cd6c735ed');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '76569e93a74f47769877e9ba466d4a39');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '81e587ac326e4a1e88ecb78913fc0573');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '29d4c7ada9f64c9aa667556537299f11');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '58936015bf0d4e35bad8422a2d10f3be');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd3b1ff790a4149568b41cb40f1a14dc6');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'feb5a0c8fcbc4830b21639027b0213fd');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '92899b2ade3247fe988577e826e8f72d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1ca68e59861642cfae8f752291764e9d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '54b4695701db4849b3dc85ae73e37299');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f4da63db42b64f45a67bf6e909833926');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '6f967e0269164445ae2c28ad7ecb415a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c0816fc79f9540369f96e7a55cae10a8');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'efc90e0931254f67b02155a3545be882');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '9d39a41ac6114eecbc6af8195cf8ebd9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '058545461d644f7d9128e3c489a578bc');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '82eaef5af0ed43ba8c219ad98afb388a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '52fe4b93743b4e2abc9c7dede528a258');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '0f68ae540fbd4a848aa80b0d3151cdce');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '62b498a26d3e4d9d8087c6a1fbee2097');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f5a190724cfe4f2e9c88a885dc9116a6');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'cd7373a78a044289bebe127e3ed13304');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c98798e7cbd943a782ea8f0890202161');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '60af7549ef41486195a2439c1c734325');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '0260bd926a9d4cf3afaf7727d6de1ca9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'a6ba5af3e66f4d89af4282f248b2f616');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '367c0866874d42cea71380a62091adea');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e5f041d9875d4e9a9945479709edaa0e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'aeb5393991bb44658007c620e216ae1e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '4bcebeced89b4e1e80dff1c1459de8d9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '2b2384aea553456a912b05a75d0f0f63');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '07c07311dfab4948a8e37d24dc4e93fc');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c52d1e384cc3438bb403d82d97208ccd');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '93b930ae83a942ca811f81ee6a810a09');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1301014f5a0142eaa85527162ab38968');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '691cb1945fba494587d620425fdfc66e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3890739a75d34f44856a3d81879e480f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '9cc8ec9b39c942c4ba88657cdc9824ed');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '4107172609c04a5b9c1e29555934e74a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1cdc158b6691436492fe7a66341e8e3b');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'ff10c7db76514ad3a170d44fb8b4ef76');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '30fb5071b770442490998df411331372');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3b733b499ace4bbaaeb7a617b4330c1c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7ebf064f30444c7da956070cd23a350d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7f3df7a24580450e81488eb6738c1236');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8b2923ddb1704d7ab11c2f776b6490fe');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5d83a4a2799646d6bf8a3e1c275af388');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f9cb9407f09a4820acdc60e97583528b');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8ad154fa5f664330a0262447e86b52a7');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd5d54d8a2725439d9a1ac4bf1945c90c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e0673c6a2a4d4b86a515718326d23f18');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '49fc6c3734164c7ca2b71464e7a75814');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'ef9208e9da7741789fd8380eedeb1776');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c180aefc99514482929a78584d1f9738');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '0a7a73fe813b46cf8f78b42542c768e5');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1b3f8b757a8c489ea1cfb957ae2fa899');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '16bf0a532e6c4c18be8201a893f1afe6');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '07eef418b0c24d468e93a0b1f1d315cb');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e412c73c10714b688a73e06cb4edd9f2');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '97fead136fa4499fba025bf39a5fa523');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'a8ccbf48acc5476dba9b09cb36a4da92');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'bf3e5def7f994095b35125570463bb00');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd4b042f0296f47269cea3506723d2b96');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5a1b79754eb145b8942673846f8bb820');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '354e414e633248809670eb731998b130');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7ba880d4d026408f9260cb79ee339967');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'faed093692264a05a035c2a50f513575');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'da8323a4bc654d7fb722b3d7b0192f39');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'b7cdf12605b145ca8ca1066fc80aead0');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'a0d597a604e946518a69f989bce5301e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '151f41ff8da2419386fcd3d0dad161f3');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c1d15d3679b64296a7e571eccc839019');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '038833faed234c90bcbdcdffb017a1ba');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'efda52b1372344b7af92730e508f2dea');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '273836e282a14829b334369d4a8428e0');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '0604a4bc9c1e41ac83fd6302f8fa9d30');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '684ddf13487442a18b059ecba6336396');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '42f50bb63a40431885fddbfbdffd8e92');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'a31453059e3c46c18301c98200da4876');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'b2d7bacfebee467ea9a86aee6f491123');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c669b011271d4e8d95804d22f1f8b746');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c82322cd1dab4c26ad3b82f339c71b65');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '00dc7a773491451e9f1c58367c89463c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '73b072a6a0864acb9bd94439a04036e2');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1463297e34884977bd3f4a1a9af5dfed');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '21c9732f746d4b049380d0018f7cbfb9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c27428743b1d4fd99a464cf8533c37e9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '06fde13ebbfd408b81eabea97b04ecd9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'b5a4641c70724d0eb654da472cee5fdb');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '18a9cd13a9f84f9b981ff2bf9c31f0f8');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '91df923d686f4f91a449aa901ef6a75a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'b910ff43d4a0405381bb490fb2cd6cbb');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd461fa0e1c96427ba450b4b3a7857c82');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '091c5541edeb4bdb9f1b2e868a7685da');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'bb7ac1be155d4797920bfccc72e959bb');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e2a3294c809749298b466ba3d4ef828a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '4259f10f04374d0b83de738fb63b043e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'cd857b91ee914631ba7a62b25eea73bd');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'dc6447eedacf4ca7ab22940f166f1365');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'eb8f0cb790a04f69aa91062d53c0cd75');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'b352eabc1a024d61be5fb7073a4f2960');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7729a27e46974f6ebc243a9258e7e205');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e63c9133de174acdbdeb5a5f3009785b');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '02710bc82c0349b9bd491dc057f3e8b1');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f5e9f8df2f86453c99b6990dd0953e8a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'eed53b373cc24dc8bd6efaa74ee2cfda');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3557dce3dc0547c182aca98df391cb67');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c4de84177db944658e593a3b381dd47d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '758ae6914d8647fa92537da80f8fe53e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '759de51980144b9dbeae0cb06dacae2d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1df2a91482ba4ca48dd45464644aaaaa');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '13cee2b4f51e4e8cb164468f60a6591f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'ce5198f2592b4c7c99369f767a0b3e4e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'b67311080f994e988137eaf9620cf3f6');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '71ef6920e8a445c4b27a4367eea0ac10');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '328c5103866b43a89deb7fc15528e7b1');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c31b79b2b1534923973cb599cc807d75');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '86b1a2731f4740ad9a96d741eb3b4230');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3cf3485c0fb64f51a8cf134c2eeb3762');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'eea39e7cd0ed48f497528bf59330dd30');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '39f0b415af23434a8f1f9fbf80484dfa');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '668a7db2dcc34ea0b699ff919b189591');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e0450e0926b4458cb3df5703d1ed1e39');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '964ed6c36c0f498cbbf4f7934f19fdab');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd3929e59b07547dfbee6232b525f122a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '4fa8aa87a2c14cfd887f7c393d7996db');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '75d2e109afed46abb35d01327f25e8fc');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c4686628f8064142a22f316bb4d569aa');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c980a16625d0416d844fee9368a480b1');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1159dbf3379f417e88ea2b9851e91039');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'ee8ed17631ae4786a1dd17842486318a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '851bc0ea7eee4200ba8dc82082964a37');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e018e0c7a03a46e5a5eb1294bee73346');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5be2de3700bd449f97af675c7ef4fa39');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'af9e954c3df34d4a888f7f0d5f11846d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3d484b2e8750492ba75df3662e8ba3f2');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '0b8894c7a41144b095d28a6f0a201d37');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '64d8d3e7890f456881d90807489bac54');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'ae2f4bb025da439bbc28ec5a87284ae1');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e031005b4e3a4e30bbb3c725374a86d7');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'bf8d21c2837e4bfb85e4cc3cc5c83c73');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '650436a3be294c5f9ff5b8bba2fbc363');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd23138b356c34564a274420dea5b98e3');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'bb80182ad15742d7833912e34d9be949');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '04872f8a99f34af49e935d2b9f3d2273');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '07064442a5024499b9f3e95b0801c4c3');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd44d4da53b6247aba5b7f2385b125dd6');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '85bc762a55e94835bedb18358eb4ff77');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8035725bace549edbfb1f10e9738e4f1');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '14ed2c94f55d446c87426e063dfac4cf');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '0af52908a85245a088e0b5a8407bc203');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '595a08ca19e740498339fd6073a3d94f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '0ff2965a9bd0496fb4f80e54567cb852');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd063fb15f5a5489b9e9d429dfb1946b8');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'a9f9d9c2a13049a8b2a4da5c4b743c08');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f1b8b91037ac44f18d45a9428097baae');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5a71995069b74b628416e097cd65d700');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '9a3efa5d6be1431cab7741577ee15d73');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '548e68837a5a415583edb7ddfc5b4de9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'bee705ea34a4496d9700cb04cf449c34');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'b399cb19d2cd4839b3f791f2fdeac487');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1ad5e03bd5584cf48cd0a7a4882af89a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '40ac9f83231d4e6e81a522632f3e3a2a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '48a1dac204114d1e89edd631f85d9f12');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '4392e7e80824414b974c367fc71033a3');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '965a1f984fb34159aa3c851c4268402c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '451ddbf3e8a246519fa3dc14ac57aae5');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '759caffa689443cdb3f6a0d10e23b78a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'fa91734294ac4f05b671aaf8797e4222');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7aca06699c224fc38dadde01aabebe00');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1e1b6c2aab244d1bb130f39158f5b587');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'ff6f2153fa6c40cca3d39d76ef271e57');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '01797f16a9a240599d68458e48e2ea16');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8b175e3a07a44f6a830c284cda1a8ae3');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3cf0e9b3eea749108ac1c313b5437597');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '41bfbaf33c9d4729aa1a4b0b4a2e3cd9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '47909e3b775b44dba7a2fef80724eb51');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8aacefc5ae7849f38d78d4c85c54d6f7');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '42f096ccc61d4c5aaf10370b4807c3d7');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '64888b48481944e2bb0f8a9149a9b1ca');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '0627424d2b044b5485dfac3bc5f506b2');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '62530088ee7a4eba9d073350e02cf40b');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '65921344378d4e3cb3c88340fe382fa4');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e7c8eb6f9ca14484a90edfa5ba32f7b9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8f741a7db3874783ade52c45775ce99f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '6ae326fc5f344fc599724b0b852812f1');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'ace639dda957402a858b32dd4c374562');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'b65dbcd8beb1433593dce569e1f6693e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f44fbed511f14cd4a51ced6b5f9f83d4');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '20e182ec5d8f470a945ee56e18d1376c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3fcbcb55fd8844f6aa51bef9e6c36e58');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '2628e79966234e41a05b93ac2c28175f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '9ef55065efda4ebfa1d51a96a39c9519');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5b2e5f07661e4b12aeabfdd23b84d18d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f9816304bbf041e9a32b0128d383aa39');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'bc5f171d21824d62a17262197d55d60b');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '62e67a19d51e49a78bf152765453cd14');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '475372eaa3fb43b090bafd0c31d9b9f9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '476cba72d7ac401682895eb6bb5c2b18');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'feddbb2885864130af3833d4ec533b0f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '264271895c8245f8aec2f2cf0615e68c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'fb80a0e9dc504790a2b081db0ea7f1a1');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'fe2e211239b8470f848e791e54ca19ed');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7bd654d108f9495596773aa06d86874a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '66e4e6bfd85c40f4ad39f27cb32f39aa');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e7c79ae6448946d1ab46f7d567a682c3');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '6901af8c983e427cb5caea4683965eb0');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '6d64ff3362ad4d8e86de5748296027fc');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '39d8ad01a74b4257b383fbd69eafd753');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1f69f673b7ba4dafbe5bcfb6c5079a05');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7f2f7c504c974a27a45a4bea2c0ae74f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd0a5567eeef04053b8fcc377d92031b2');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '17e3bbdeaa624d8cac1c119a0cf6b450');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'aa76f3d26ebd45b9abaecd5f88719419');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '58ece3b1a7454cc4a88d99ff6c186ac4');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '155aa034e8f8450ea9cae81ce0d41b03');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '80c1aef11f2449be9d635a6dc15a2b33');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '787059abff494e0e83fbeae1d93a1ea2');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '96ba767fee5c43248c44711b27dd9a9e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '9614b048cca14bb999bcbd41341c9e8b');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e2a6f7daaf3e428e8eb4de1aaa466bcb');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3de572a7ff334b98bfb7028b571fa10d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1025a3a11e224906b781179ef1e17efd');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8d4794200c1f4171b09bbe5e62bf4406');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd62a73e867744c8fa1aba45eb0baeb92');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '37737a85bd0741d4b9bd8e0931de34cd');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '6ad70f013cad4f6b8ac3af462f11d662');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '71d84e1f965d436380957c701a81427d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f79f0e8a3e43475385fdedf23e53fe7c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd41e49d3c2b24d9e97687cab54a36c3b');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f9301bc9d54b4d0e8e7bbf7cf0a2b475');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '84704138c04247a99ec1fe4e58561e74');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '63c26f28cff04b29a4c1850b15706667');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '49de4bb9b2654554ac0a2f1d844e80ad');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '6b1fed9ed7ef4973884c9f46157fd25f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '094919e45c774b45a7e0000cbff919b0');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e62935860f0b403cadab977e21215e0a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'a6666d9d0f704772a93046cdcf7a6236');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '14dc9b34fb204f9b871d9db1dae93fc9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd2bcd2e3cd784e9b9ed5ef6a78c8af13');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'aceb1ae445d8483e9c0127a2c12dbfa9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c76075ddf940417eb5423a08a93e8271');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'eba9e9563f164c718df97afa627cb6e7');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd5aca362a2a54ca8b04c5977d1fea7d8');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '10fc69c8e7164f31a2702fbd5196d866');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8c109864ca67474b89626fff651f58ce');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7b25bc317f774c898586987dd1ceb350');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'cd72f512483a4d96beaf6390bc46c186');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'fefd3015ef804492bc2b0814b9f24d2c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '9a5140daad7a4ef5bb7490e4c23a7f25');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '0d867ea9c44043f49df45efd9e528e60');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '144d1c712bb342f68ee0e07b1a7a8c66');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '22a0a237ea5e408682b49295ad9f905a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '4695855d26c2457283ce93120e92131e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'a33678bc81dc4cdaac7a5d8291fa986c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7a7e4979bb564a569307c85ee952b0da');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3780fef3f8204a5ebe26bc24b635ca16');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f8be7a8da7114d8f9ef607c2cd289aeb');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd01124b810e042a18af515e9afde4405');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8626a7cdc7724730af7a31c29452b847');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '10379bce45dc4893b9c636c1bb89ecca');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7f0bbef11aa34168bacf5481049eebe6');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '9c8f6fe513ff4f39bf638b7b581845ef');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd0824b64ecca4a1c9ffdc4f2255580a7');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'a68246f84ea148f194ead5187863cf77');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'dea37fea0aac4a91b9b611ecebdd8c35');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c84f95bf465f434aa2cb4770855176b9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '52da7d903c8b4eef93894f96f5cde556');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7fad14971acf4601adcc9e18f0cf7fa1');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'bffe430756cb40819817db5f94ea8966');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '08a282430ad848c08083e9eeac0d5fe2');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '96fe1ad41af54941a630de57e635c3da');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd7cab15a8385441dabb145f6bdd89ecd');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5cb9db93847e44a99788382eaf02828b');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3c0227d47abc469abb46ba084e5bb875');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '71a4ac86c7424707828a6e5585472ba3');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8c588cfe13ce491f9a9a355f96b1fb2e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1a4c7b4719c541d6a10cc1a8d74a6f19');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7fedcc9c230b44159ab484d504ed56ad');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd5dc586ad5f44fc6b1640e6a8eee33e1');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1a4b965a4fb848c99a1340b6dbe46779');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c3690031cc2a4114a4bb0b386642d556');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'dfec533918c147c1b248b6d536994855');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '353fb56fd6414436b12511703e60b5f4');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '992f4a7b58a74bbab79cbfa7917847c8');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7403239a381548f298669ddfddbf9fe0');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '40493652094c4ff480d2437555b22612');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '07d5f964ffb444daac77b401b83fff25');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd41609de49ac42d68d2380cfed2c9d45');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3c8b97588c274b26ba1e2786cb351209');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '65b2a4e4c1c548ff814620907b95cfcb');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '110cd5ac732347aa86e75bb53b04ea59');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3b94efc2f17144f1ba9137270cc28f91');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'af929ed00f2d4df9b22f8a62c116d48f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '4ecf0f3c57764b53ab49167ad38d3bdf');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'acb0561891544193b5a75a8c6def8121');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '2d54410a65ce4d7085836be6bd70f426');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '818e308b752149f6a90aec9a69942944');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'cabd64ba25644845aeb05f22ef8dcb19');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '55d13c0c22294badb2dbbbff1d61431d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '230f4ad9e2ea409eb32e1ea8eaa0338c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '152617ff5fe54338b81bb1681c0376eb');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'b6eef754848b4ea189d30115087fded6');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7767044a198547519d57a67bbfca032e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7c515fdd8fe04d498d64f8122db8b094');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'cfcbfd927b0f4e1ab5903078fcf34106');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '86084d70daed4bb1a1a856397de26c59');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e1309b0e892a42499db67ae25c5b6189');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'de12d5159b4443b5a9ba475c647f15c3');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '40d2b9ed4c194872bd66a03e2fa15ea0');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c3e9c321b799436a868c51fb00942ba5');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1d141a3d61a04ad092795186596cc196');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'cb69b911f4be400aa8f8684b2aa54c18');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8a3ffb79df45418a8387bcbe5b7ab560');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '504b14438a2847ffb6f1098a4ca1e461');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '9f91dc3f784f43488ddc5c5d55d34d26');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'fddf47bf66c34e17b528832ac5c87b35');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '6efe927072614df0a18ab815403fd0d0');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'fa3c9cdff460426383005945079e5cb4');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '19c438c4c4b741dfa74264ecf348c4c8');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c808e735393b4b58b2c098b3dd4c380e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'ceb36943a9ca42aab4da985fff82b24b');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '308e74eb5f0040978a3f5a5e870abaa0');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8c00fe90107d4c488847896fb9c82ca2');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'ce018aecc27e45ef8cfbd20f875bd33f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '185a2fd1884e45c2bbf2ab99fa3b5c84');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd16428b3da8e4676b2417f6614e1ae36');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'bedfb2fca7de4d5ba94e1f3305450f77');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '4f45d12e96b94ab59f90ed632ad564e0');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f0eb342792de4985acaaaa224ca49fc3');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '78637e74b3134ec4be37ed7ead362cc5');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'eec0f1bd0bb2472ebce95b17b464057a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8b2b460d35af428d8d443a01b4dcb37e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '74fd30fa75304b0bbf9c2875b59afeca');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '665adff5a7cb43f6ae40cf3e746f08e1');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f0aa303d25dc4d56b579ad6b81ad68c6');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '026259400bc740269fe62fe6dbd92584');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'fda97656edb94ef2b23cb568e721a205');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e8cc6220e4b648129040516df8d7c937');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '16ae224787e54bf5ae670d3210394d32');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '4296c4d91073403abd808640d8c47b95');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8b1ac2aecbfa48669af48234f5a0f9e7');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '45ad432c9b6d434586dc24abc2dc84ec');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '64ab60fe0f404888b4cdc9def172c78e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '2ddd106b884a4098a086a8fb09b4dd83');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '0c09ecba8170433db3589fc0daa44b39');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '821ac88018c042bebb072c40b8ece919');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd3f3724bfae242e4b0c7d7466a61b64e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5d873e03d4af4f18a5650f5b913138b2');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3a3adcdc5a394aa6a94d81f228dbf3ee');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '1905457ad27446018d989c30255da67c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c2f4552f93314668bc2b9e7c192086aa');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '90ae317448d742cda5e2b1884071bf56');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '6dc9826c822546dd862c5ed038a77e9a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'b9e524eb1c41498083715d95ba051cda');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '01bebaba6d2242b8995dbfdee21c0c0a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8477f03faa3a4e298dc64ade3e364f00');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '9588e7b56cd4462fa2547aa1f91757c6');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5834a43b4b9349b692e2bdd4f59f9d23');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '208028cbc2664031823c4046fcfb220f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '31d3f28e29de4a8aa3089e3f28e7271c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5543679551a448bdb6d660caa57a3b35');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '603af5db0ea94a6f90f1a9dc80aa9a9b');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '44db98e98ede42b792bdbb98a5087339');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f060fb6d4d2b441abd6a8ea1eaef66ce');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '81c948ad7fb446f187a84bf8b30c9422');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'efb137d1649247d2a258e4f84e2806c9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '2c2b75150d694659879c0fa095c9680c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c86cf75094204461a7f17907ff4d3535');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'b02ab736ba9d4b2f8573c849071cc86e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f39170efb493426e94fdcc50979fead8');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'ca31b9f35f534ca19ce000093dd571f3');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'e55c378c3c11436aa4dc8d9e6e43eca1');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5cc6a8e9d411454b8bd3ac4976b6c130');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '93b7ced44e5b44f192bfa23542472e82');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c2c6209e456147ae940bbbb1fabc3f12');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5c110988c86e4b66a71795dfa51ebfd0');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'b7a860d0eb4e4d5a9ab5b1183cf00e8a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5fc32a5f96554ee5a8cdaf984b635c8e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '31539f4711cd4622ad2db1aafbffe689');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd9ba3efcf0034b2eb690acbfde1b057f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'fcc4464e02974416b37270403e40fdd1');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f7f99c352aa54d9caf267cedca3c358f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'caeaf980ed5244f29d9ea279ddad5f3b');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '0dbaa626f0404ce099cfa113556c8de4');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '8b431784df054fb7882a0c563a290198');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '6f0feb3be27741369cf0163759e8a77a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd04d08e1247f47ed94e6365ec17c5eda');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'de30197c2c32470181cbd16d6cf397cd');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '16d7793a9f9949cd87861b61ccccdc78');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7f7112e0705d46f8a202abfeda23c509');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '22e8949b6f864deba7c2b6007c46c9a6');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'ebf0c1e3690b4f79b67ed3e0f1195cc8');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f48039fc7d504086a3aa6639055de37d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '230c138df292474283774b5f5e42bdd5');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '310915401a3740779c4a638fe2fc13cd');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'bffbeed88c604fc98529ae0950001602');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c009532a3ca142759d6808ac0bdb307d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '62965b80d88f41d1a0be399bde3af3ba');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '997cad7d355849ab9acad331084a6b33');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7af14b7ad365430890fef3ef7e4dc111');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '599a450fef6549e0b8f34b1241e69479');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '18ed4a21066b47949ba3dac8a589e8d6');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '9ccfe3d0e24e481b8c1136b54d764226');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3e06b9bda41745b89a53c5af233116b9');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'fa5b995ee13844bcbdcdcba98c92ec88');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '0e3bd47e2cf94c2f936f7bf27c18fef3');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'dfcddabdd3f74746bc2576a6080a28f2');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c7c6afaac04e4b23aa10453ee1fb4e6e');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c511e46ba9e34e82a4e3c684fc526776');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'fabc386cf8ed4f4dbf599908a29b7ca6');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'dfeb92135be24ebb9cb6370fa8a3af2b');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '747b28af7084404585e00bcefa524fd7');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '925348e358394cb6b23daa65f6d84bd5');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '41e5d44b4c0a4bb0a098063e114d0282');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'd65bf8e548d54032bf5dc6ea267f644c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '3f43ceb3157f4e268706e911b93a4182');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'bb2355f3719f47b8bea82dcc1c2e670b');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '9a3884587c0e4d78a644567ed0bb170a');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'be525cd76069487b815e37b1f3650855');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '723f1c29f9cb4f0daf66f78b6316f43d');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '2e97c574ac7041afb783981e8bb8d8b7');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'f8ddd807e62c4955aae069b0c6c3c25f');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '49fe7a5e44ea4fffad899cc7a37ad30c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '521d24daaa244b5ebe38e5c154873167');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '5ad123ba9f94466d8c032c20ebdd2f64');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '763982a219554abfaa52f2afa965fe14');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'c0bcdc0840c64258ac8b97679bb9c1e7');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', 'da7be405716745ef8a45cd2674405a8c');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '2d87ae340e0e4210b44b9aeffe801ac3');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7a40f0d872954d558f4bc500f0b34867');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '195ac605b4aa44a280316dbf168628eb');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '7d42358d04f143b78c30521560290f65');
INSERT INTO codegraphtest.classrelationinfo (projectName, fromClass, frommethod, toClass, relationType, id) VALUES ('MyLuence-master', '', '', '', '1', '727654d466724909b31690789ae69d1c');
create table cluster
(
    projectName text null,
    clustertype text null,
    methodList  text null,
    name        text null,
    id          text null
)
    charset = utf8;


create table fieldinfo
(
    projectName text null,
    fieldname   text null,
    classname   text null,
    dataType    text null,
    modi        text null,
    id          text null
)
    charset = utf8;

INSERT INTO codegraphtest.fieldinfo (projectName, fieldname, classname, dataType, modi, id) VALUES ('MyLuence-master', 'fieldPropertyMap', 'com.wind.myLuence.index.BeanIndex', 'Map<String,FieldLucproperty>', 'private;', 'dfe46c4037f74b5b824f526112530471');
INSERT INTO codegraphtest.fieldinfo (projectName, fieldname, classname, dataType, modi, id) VALUES ('MyLuence-master', 'indexSourceMap', 'com.wind.myLuence.MyLuence', 'Map<String,IndexSource>', 'private;', '3d59584a950f4fd08e4bfb01b22c7340');
INSERT INTO codegraphtest.fieldinfo (projectName, fieldname, classname, dataType, modi, id) VALUES ('MyLuence-master', 'searcherMap', 'com.wind.myLuence.MyLuence', 'Map<String,AbstarctSearcher>', 'private;', 'f516417839d14876a20b1e3061d58458');
INSERT INTO codegraphtest.fieldinfo (projectName, fieldname, classname, dataType, modi, id) VALUES ('MyLuence-master', 'factory', 'com.wind.myLuence.MyLuence', 'com.wind.myLuence.factory.MyLuenceFactory', 'private;', '197f02c2940144a8ab3e76ae044ab3cd');
INSERT INTO codegraphtest.fieldinfo (projectName, fieldname, classname, dataType, modi, id) VALUES ('MyLuence-master', 'incFieldRW', 'com.wind.myLuence.source.DDALDatabaseSource', 'com.wind.myLuence.source.IncFieldRW', 'private;', '7692bbe20d5f49faa68ba6b55239e07f');
INSERT INTO codegraphtest.fieldinfo (projectName, fieldname, classname, dataType, modi, id) VALUES ('MyLuence-master', 'index', 'com.wind.myLuence.source.IndexSource', 'com.wind.myLuence.Index', 'protected;', '47379c3e32e74145ac356a5460a8c822');
create table methodcallinfo
(
    id                 text null,
    project_name       text null,
    caller_class_name  text null,
    caller_method_name text null,
    caller_param       text null,
    caller_return_type text null,
    callee_class_name  text null,
    callee_method_name text null,
    callee_param       text null,
    callee_return_type text null
);

INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('28e485773f014e92acd21302e279a652', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'Exactsearch', '["Map<String, List<String>>","Sort","int"]', null, 'java.util.Map', 'keySet', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c29b439a9913461e9e0b7155cd889e4c', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'Exactsearch', '["Map<String, List<String>>","Sort","int"]', null, 'java.util.List', 'containsAll', '["notAnalyzedIndexKeys"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e9067b5d156b446eb5d7622dc44f766f', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'Exactsearch', '["Map<String, List<String>>","Sort","int"]', null, 'java.util.Map', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c139782efd22498abec7fee5bd9b8303', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'Exactsearch', '["Map<String, List<String>>","Sort","int"]', null, 'org.apache.lucene.search.IndexSearcher', 'search', '["Query","Integer"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('6308a9440d5a420d9f361484e3dbac87', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'Exactsearch', '["Map<String, List<String>>","Sort","int"]', null, 'org.apache.lucene.search.IndexSearcher', 'doc', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('a5b76831ee0c458f8d4ec9977c683503', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'Exactsearch', '["Map<String, List<String>>","Sort","int"]', null, 'org.apache.lucene.document.Document', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('9305dfdb65f34760a6ce32f4bbf11be9', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'Exactsearch', '["Map<String, List<String>>","Sort","int"]', null, 'java.util.List', 'add', '["T"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f0279595f6914582a331ab86a392854d', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'Exactsearch', '["Map<String, List<String>>","Sort","int"]', null, 'com.wind.myLuence.search.BeanSearcher', 'getFieldNameType', '["Class<?>"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('109d2b0a226b418fb00b4ba4f25fff8a', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'Exactsearch', '["Map<String, List<String>>","Sort","int"]', null, 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","BeanSearcher","T"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c1eb9be771ec4302993e8247fcd28506', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'Exactsearch', '["Map<String, List<String>>","Sort","int"]', null, 'e', 'getMessage', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('94c3f852e1034917887f4356bdafa589', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'Exactsearch', '["Map<String, List<String>>","Sort","int"]', null, 'org.slf4j.Logger', 'error', '["logger","logger"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e57aea6893bb43b5a8f9192d8e073943', 'MyLuence-master', 'com.wind.Paint_MyLuence.util.DateUtil', 'parseTime', '["String"]', null, 'java.String', 'isEmpty', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('663cfb8897f64cbe9688e2e9f783d353', 'MyLuence-master', 'com.wind.Paint_MyLuence.util.DateUtil', 'parseTime', '["String"]', null, 'java.text.SimpleDateFormat', 'parse', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('fc10d202ce6342dcba6e107f3dc25b01', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldLucProperty', '[]', null, 'com.wind.myLuence.index.FieldLucproperty', 'setFieldName', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('0313dcc03246412b96f6ce1070876df1', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldLucProperty', '[]', null, 'com.wind.myLuence.index.FieldLucproperty', 'setAnalyzed', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('5921314ae83943858bfe8641817592a3', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldLucProperty', '[]', null, 'com.wind.myLuence.index.FieldLucproperty', 'setStore', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('4aa9d9f8d04b4d9397c005c5a28106d2', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldLucProperty', '[]', null, 'com.wind.myLuence.index.FieldLucproperty', 'setIndex', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('561ee539053c478ea110a77c50248af5', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldLucProperty', '[]', null, 'java.util.Map', 'put', '["String","FieldLucproperty"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c1230481b6154d149e018833bd2c0552', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldLucProperty', '[]', null, 'java.util.Map', 'containsKey', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('01bea472f4a2427887ee215147ed48fe', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldLucProperty', '[]', null, 'java.util.Map', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('1706685361df40978d0f945c5c1bb8de', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'appendIndex', '[]', null, 'java.util.Map', 'keySet', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('5d8d3d82ebc04d8db558ffae0c31c2a4', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'appendIndex', '[]', null, 'java.util.Map', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('3aba6c74776e489ca56a4297b6edfee6', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'appendIndex', '[]', null, 'indexSourceMap.get(iSourceKey)', 'IncreaseDataOpen', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('7212468ccc784942bf0662e2ac9e16fa', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'appendIndex', '[]', null, 'java.util.List', 'contains', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('036d730fca8c4c90a842747a9f3d07be', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'appendIndex', '[]', null, 'indexSourceMap.get(item)', 'IncreaseDataOpen', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('b3559b5196df476dae5f2f9c8e04b9b6', 'MyLuence-master', 'com.wind.myLuence.Context', 'getInteger', '["String","Integer"]', null, 'com.wind.myLuence.Context', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e025d99dd2af4507831cd8baecf92301', 'MyLuence-master', 'com.wind.myLuence.Context', 'getInteger', '["String","Integer"]', null, 'java.lang.String', 'trim', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('a6bb9b21bbee456689fdfa83a1ee9015', 'MyLuence-master', 'com.wind.myLuence.Context', 'getInteger', '["String","Integer"]', null, 'com.wind.myLuence.Context', 'getInteger', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('4b920eedbd634249ae02062f725ca580', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getFieldNameType', '["Class<?>"]', null, 'java.Class', 'getDeclaredMethods', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('7543c601604a4faebdf4055e462f3b15', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getFieldNameType', '["Class<?>"]', null, 'java.lang.reflect.Method', 'getName', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('ff69494a5d014c509f1ab6f65876c735', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getFieldNameType', '["Class<?>"]', null, 'java.lang.String', 'startsWith', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('279cb96f95ca4e0788f262b10904b423', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getFieldNameType', '["Class<?>"]', null, 'java.lang.reflect.Method', 'getReturnType', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8bf6ba74e843440b8e4c8b549e002151', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getFieldNameType', '["Class<?>"]', null, 'm.getReturnType()', 'getSimpleName', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('48cb2ebf405e4c89a9137d1655294903', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getFieldNameType', '["Class<?>"]', null, 'java.util.Map', 'put', '["String","String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('6a8386e2e5464a4dbbda44741df5869c', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'search', '["String","String","Sort","int"]', null, 'java.util.List', 'contains', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8edacc021a184383865ba362adfa16ce', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'search', '["String","String","Sort","int"]', null, 'java.util.Map', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('9b93b9365adb450ebf0e2032658f41cf', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'search', '["String","String","Sort","int"]', null, 'searcherMap.get(item)', 'search', '["String","Sort","Integer"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('32573cc9fb6c4306a597a7bf1114cfe0', 'MyLuence-master', 'com.wind.myLuence.PropertyParser', 'parse', '["String"]', null, 'PropertyParser.class', 'getResourceAsStream', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('b85a8ee169564700ac60503d816d28a1', 'MyLuence-master', 'com.wind.myLuence.PropertyParser', 'parse', '["String"]', null, 'java.util.Properties', 'load', '["prop"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('23e7f40232ab48a88add6ea93beba34a', 'MyLuence-master', 'com.wind.myLuence.PropertyParser', 'parse', '["String"]', null, 'java.util.Properties', 'keys', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8d2f1bbb4855456383668491a455dfec', 'MyLuence-master', 'com.wind.myLuence.PropertyParser', 'parse', '["String"]', null, 'java.util.Enumeration', 'hasMoreElements', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e5eee2491db145b888ab10228d26e1a0', 'MyLuence-master', 'com.wind.myLuence.PropertyParser', 'parse', '["String"]', null, 'java.util.Map', 'put', '["String","String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('105008b76c6e495aa1bf47d793dc84f2', 'MyLuence-master', 'com.wind.myLuence.Context', 'getLong', '["String","Long"]', null, 'com.wind.myLuence.Context', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('effad62932454af59f8abafadf6d9833', 'MyLuence-master', 'com.wind.myLuence.Context', 'getLong', '["String","Long"]', null, 'java.lang.String', 'trim', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('da8abaac58ee45428e0b77f32e138c66', 'MyLuence-master', 'com.wind.myLuence.Context', 'getLong', '["String","Long"]', null, 'com.wind.myLuence.Context', 'getLong', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('d5acb591ea084bb2b6999c5410a8d56c', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'InitialDataOpen', '[]', null, 'java.util.Map', 'isEmpty', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('bd868d965684458cb8ff606d69632a28', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'InitialDataOpen', '[]', null, 'java.util.Map', 'keySet', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f32c5f3f49e845abb36ef6135eb28499', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'InitialDataOpen', '[]', null, 'java.util.List', 'add', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('efe4c5850a08483cb6e5cca5e03e6a3c', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'InitialDataOpen', '[]', null, 'com.d1xn.ddal.client.socket.AsynDDALHelper', 'query', '["Class<?>","DataOrder"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('dc2817d38c614cfab7987819eff20152', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'writeValue', '["Object"]', null, 'java.lang.Class', 'getMethod', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e267bf4b44c94f15821ec9bd82ef2ff3', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'writeValue', '["Object"]', null, 'java.lang.reflect.Method', 'getReturnType', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e30cb288345948a9a8517cca5797783d', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'writeValue', '["Object"]', null, 'm.getReturnType()', 'getSimpleName', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('38527ab0193e4fa49b3c26058203d6a7', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'writeValue', '["Object"]', null, 'java.lang.reflect.Method', 'invoke', '["Object"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('27e99752b68a40a990b8d8181fa1eb3c', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'writeValue', '["Object"]', null, '"Short"', 'equalsIgnoreCase', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('89b4ccb984af4fb1966b5bb7fa738be0', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'writeValue', '["Object"]', null, '"Long"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('fe3d846afb8a4727a6c46c4ea01289a1', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'writeValue', '["Object"]', null, '"Integer"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('89d1d72f8bd54a1bb4adfff55986722e', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'writeValue', '["Object"]', null, 'java.lang.Object', 'toString', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('41207826ff644889bf956a8fc7c18227', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'writeValue', '["Object"]', null, '"Date"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('604fddf1a6ba4e60b9bbb5dc4152e020', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'writeValue', '["Object"]', null, 'java.text.SimpleDateFormat', 'format', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('94a58f4a747e49d78f97789e0ec4680a', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'writeValue', '["Object"]', null, '"Timestamp"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('7a35d51f19974330b4204c14113d05a6', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'writeValue', '["Object"]', null, 'java.util.Map', 'put', '["String","String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('6f03f03df08e46cf96d3bd9521ca97bc', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'writeValue', '["Object"]', null, 'JSONObjUtil', 'saveJson2File', '["File"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('d97651fbd6cf4284a7c50b179abec16c', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'configure', '["Context"]', null, 'com.wind.myLuence.Context', 'getString', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('73a4803ab23845c68d39d62554a3e88e', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'configure', '["Context"]', null, 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8c128f636da1491fbfe6b79b6e0f42ef', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'configure', '["Context"]', null, 'org.slf4j.Logger', 'error', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('ca110a7ec4fb46ffbd690038b9fcd6be', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'configure', '["Context"]', null, 'java.lang.String', 'isEmpty', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('d526de8a1f2c45e3bcf3120d6ea047db', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'configure', '["Context"]', null, 'java.util.List', 'containsAll', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('50d99f50c96e4ab6a1308aa4574d116b', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'configure', '["Context"]', null, 'this.storeFields', 'contains', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f75c2b73f8e54c42879914c4b0703f19', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'configure', '["Context"]', null, 'FSDirectory', 'open', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('7f4f087e1d0647dbbdeae707c4a93718', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'configure', '["Context"]', null, 'com.wind.myLuence.index.BeanIndex', 'getFieldLucProperty', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('9d2bfeb495214ca8a76b1b0ebd9ad935', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'configure', '["Context"]', null, 'BeanIndex', 'getClass', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('9eea78e8a1ab41efae0e2a114ca841e1', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'configure', '["Context"]', null, 'e2', 'getMessage', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('a331c81bf94841d4a88561171fbbaa72', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'configure', '["Context"]', null, 'Log', 'error', '["Log","Log"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('39f19c4e35b34751aea82b9dda9764e4', 'MyLuence-master', 'com.wind.myLuence.source.DateJsonValueProcessor', 'processObjectValue', '["String","Object","JsonConfig"]', null, 'new SimpleDateFormat(format)', 'format', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('2fac05cdee5f43afa6574851ddf009e0', 'MyLuence-master', 'com.wind.myLuence.source.DateJsonValueProcessor', 'processObjectValue', '["String","Object","JsonConfig"]', null, 'java.Object', 'toString', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c5287bb190004e579c7e8c4e4118b0bd', 'MyLuence-master', 'com.wind.myLuence.PropertyParser', 'main', '["String[]"]', null, 'PropertyParser', 'parse', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('9d79f80674394ab8b2445abecef62784', 'MyLuence-master', 'com.wind.myLuence.PropertyParser', 'main', '["String[]"]', null, 'java.util.Map', 'keySet', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('83be2a77a5be4d37b89e1cd89a14568c', 'MyLuence-master', 'com.wind.myLuence.PropertyParser', 'main', '["String[]"]', null, 'System.out', 'println', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('477a55a24e9642f3ab9d7b9c9ee644a2', 'MyLuence-master', 'com.wind.myLuence.PropertyParser', 'main', '["String[]"]', null, 'e', 'printStackTrace', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('d729601ef423472a95b42752d6226834', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'Exactsearch', '["String","Map<String, List<String>>","Sort","int"]', null, 'java.util.List', 'contains', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('1c9d0ed85b8843f581deb528659274c6', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'Exactsearch', '["String","Map<String, List<String>>","Sort","int"]', null, 'java.util.Map', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('a7d8074b8c084468a685499f14ef03f0', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'Exactsearch', '["String","Map<String, List<String>>","Sort","int"]', null, 'searcherMap.get(item)', 'Exactsearch', '["Map<String, List<String>>","Sort"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('4e4fc7985c9a403c8449ef69da9d5b88', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, 'java.Class', 'getDeclaredMethods', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('35bcc7a8bbf34972a4c429b47a9a8a4b', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, 'java.lang.reflect.Method', 'getName', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c33dc76adc994a82a59b91ed5a98735c', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, 'java.lang.String', 'startsWith', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('247e16c715024d6da8579c69a7ef9ccb', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, 'java.lang.reflect.Method', 'getReturnType', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('a50d9119afd045c3a8693152247113bf', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, 'm.getReturnType()', 'getSimpleName', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('efec7877a710434ba4becc6f803eb004', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"ArrayList"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('72d30cb27d994d8a89c4e6d267784e16', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"HashMap"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('5f2a139af3bf41f2a9de9fee8085a007', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Timestamp"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('6e45667f38b946f3b2a3645ff19e0a34', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Date"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('aeff26c79c2041489a9d75935888ea80', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Short"', 'equalsIgnoreCase', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('337384393911410bbce4952522353290', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Boolean"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('3d7f69760569412da3edbe54f1399912', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Float"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8529baeebf0c4ac8bcdb69296881c66e', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Double"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('93882df922af4339adf11e49600e7946', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Long"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e902495f9fef42cbaecbe033a487bc3b', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Integer"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('098bcb89525a4e02a17242a22c4e2a91', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"String"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('4588c16c6d6e42f5a531f37241b7c2f2', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","BeanSearcher"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c2201d34191d47e79067cfd6a266a9f8', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null, 'java.util.List', 'add', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8a1796534f8341fcad821364bc764c54', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, '"String"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('0c767b921a814c2a806121090d51a72d', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, '"Integer"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('194dcd1d9a2a4cf1b92a73ba904c5c85', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, '"Long"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('432b73b955e74b3d9a7370876405f521', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, '"Double"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f4a20e7a9dfd4165b5ab26d1b766c142', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, '"Float"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('858423d6aacd43faafe21d954496caf8', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, '"Boolean"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('aa1d4005d4784d169b79de834de4d7c6', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, '"Short"', 'equalsIgnoreCase', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('0853c4a888b4461393799c800effb417', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, '"Date"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f1dfaefb12f14da69987b586f3b5852e', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, 'DateUtil', 'parseTime', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('84c952535a5c4c7686311d2f67468a14', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, '"Timestamp"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('682c9f7afd58407b826df8329be848b2', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, '"HashMap"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e6776c72cb9c4d0aaed2ee7ece7fe71a', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, 'JSONObject', 'fromObject', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('fced458ff9ea4ce6b1ed2d5dccfd166f', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, 'JSONObject', 'toBean', '["JSONObject"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('cd33e46c0fba4af9aa6fd15ece4e996f', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, '"ArrayList"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('40eb438f3d104b4bb3446ef1354d2d5c', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, 'JSONArray', 'fromObject', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('27e8141ef00743c9a47548b14ca0b137', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, 'JSONArray', 'toArray', '["JSONArray"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('a61ab54ca7064559945f25c50cc6e577', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, 'java.Class', 'getMethod', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('493a843e4e644a46bbda4d9863af55c3', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","String","Object"]', null, 'java.lang.reflect.Method', 'invoke', '["Object","Object"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('39d2485087f84c609d51e7320833b731', 'MyLuence-master', 'com.wind.myLuence.Context', 'put', '["String","String"]', null, 'java.util.Map', 'put', '["String","String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('4c1f312df147453484ba9a97fe808cc8', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'configure', '["Context"]', null, 'com.wind.myLuence.Context', 'getString', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('d1029ccdc3cc4bc38edbcdeba1e385a4', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'configure', '["Context"]', null, 'java.lang.String', 'split', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('3803b3a778fc4d5186aec241127848ca', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'configure', '["Context"]', null, 'java.util.Map', 'put', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e5a08e0a55c44be6bed5ad22910bd908', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'configure', '["Context"]', null, 'index', 'configure', '["Context"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('27c2992396fb44199897527d478c96d3', 'MyLuence-master', 'com.wind.Paint_MyLuence.util.DateUtil', 'timeFormat', '["Date"]', null, 'java.text.SimpleDateFormat', 'format', '["Date"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e159ecbd1e9b4ed2b0aab3c6f5399779', 'MyLuence-master', 'com.wind.myLuence.index.DateJsonValueProcessor', 'processObjectValue', '["String","Object","JsonConfig"]', null, 'new SimpleDateFormat(format)', 'format', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('19b65767226846dab18183cba91c33e1', 'MyLuence-master', 'com.wind.myLuence.index.DateJsonValueProcessor', 'processObjectValue', '["String","Object","JsonConfig"]', null, 'java.Object', 'toString', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('50404c0be5fc42fa9b22aba24373c36c', 'MyLuence-master', 'com.wind.myLuence.util.ClassUtil', 'main', '["String[]"]', null, 'com.wind.myLuence.util.ClassUtil', 'getFieldNameType', '["ClassUtil"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('eb344075c87747618faae9d3c5779f30', 'MyLuence-master', 'com.wind.myLuence.util.ClassUtil', 'main', '["String[]"]', null, 'java.util.Map', 'keySet', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('400fb315e8a74965a2166d8787827b36', 'MyLuence-master', 'com.wind.myLuence.util.ClassUtil', 'main', '["String[]"]', null, 'System.out', 'println', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('54dadb6e033342929e88d7323153c07a', 'MyLuence-master', 'com.wind.myLuence.index.DateJsonValueProcessor', 'processArrayValue', '["Object","JsonConfig"]', null, 'com.wind.myLuence.index.DateJsonValueProcessor', 'processObjectValue', '["Object","JsonConfig"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c0ec35f0838349e8a286efc302602cf4', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'writeIndex', '[]', null, 'java.util.Map', 'keySet', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('81aba42b275d4426b12491a68b55d34a', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'writeIndex', '[]', null, 'java.util.Map', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('7b1f7e065b4e4b9cad404a8c8382c4b6', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'writeIndex', '[]', null, 'indexSourceMap.get(iSourceKey)', 'InitialDataOpen', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('0a91d1839cc44907bc3ef2d693c3f751', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'writeIndex', '[]', null, 'java.util.List', 'contains', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('a02c696ecf4c4272acf74782eb3a14f3', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'writeIndex', '[]', null, 'indexSourceMap.get(item)', 'InitialDataOpen', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('65ef2c052194435ea4e306a0abfcc20b', 'MyLuence-master', 'com.wind.myLuence.factory.XmlMyLuenceFactory', 'getIxSourceInstance', '["String"]', null, 'java.String', 'isEmpty', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('3b9280ff9b4b437094d2bfacf1f4ce01', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'init', '[]', null, 'java.lang.String', 'contains', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('d005c5bec06346d09b64ef93fe1df67c', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'init', '[]', null, 'com.wind.myLuence.config.CfFileParser', 'setFilePath', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('52d0d4774db4483b86a46f98af99115c', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'init', '[]', null, 'com.wind.myLuence.config.CfFileParser', 'parse', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('4c5dd3eaa86b4ca19c291b758f4136aa', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'init', '[]', null, 'java.util.Map', 'keySet', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('22ad1b3e85f74b6daa0f6324f3517a2e', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'init', '[]', null, 'java.util.List', 'addAll', '["itemList"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e4e27afcdaa1428b9c7610bcb6b31ac5', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'init', '[]', null, 'java.util.Map', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('756c2c7607514fa28c724967a43d7898', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'init', '[]', null, 'com.wind.myLuence.Context', 'getString', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('ebc360e80c3141a78e700dc8ee9f1035', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'init', '[]', null, 'com.wind.myLuence.factory.MyLuenceFactory', 'getIxSourceInstance', '["factory"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('7303ec21355d4e36a4cc51b16019023b', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'init', '[]', null, 'com.wind.myLuence.source.IndexSource', 'configure', '["Context"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('530b10790e1348f4af8d675a9e284d59', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'init', '[]', null, 'java.util.Map', 'put', '["String","IndexSource"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('ed09a89778fa4555a18f9917aca70aae', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'init', '[]', null, 'com.wind.myLuence.factory.MyLuenceFactory', 'getSearcherInstance', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('d0a9824f56db4f338576b6ed8518b7ba', 'MyLuence-master', 'com.wind.myLuence.MyLuence', 'init', '[]', null, 'com.wind.myLuence.search.AbstarctSearcher', 'configure', '["Context"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('4c0adc3735fd4044b1b7a5d1eb825d1b', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'succeed', '["List<Object>"]', null, 'java.util.List', 'isEmpty', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('15666efe857b42818c3f8271a923dba0', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'succeed', '["List<Object>"]', null, 'java.util.List', 'get', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('5f777cb5333947289684ed4b639ae850', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'succeed', '["List<Object>"]', null, 'com.wind.myLuence.source.IncFieldRW', 'writeValue', '["incFieldRW"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c483e0918ed8447da9e71514229048d3', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'succeed', '["List<Object>"]', null, 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('45ebcfb5c1a5414293000abfaae9c5c1', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'succeed', '["List<Object>"]', null, 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('4fd08fffba6f4fe1b8d1b007bedc4cb4', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'failure', '["ResultVO"]', null, 'com.d1xn.common.vo.ResultVO', 'getErrorMsg', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('291c8f2dda3145c3b7d2c79b4885c805', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'failure', '["ResultVO"]', null, 'org.slf4j.Logger', 'error', '["logger"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c4e3bf2cb0374dccacd122fc834f7cd3', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'Log', 'info', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f7abfd1b64734b369b1c91ffe1d06930', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'java.util.List', 'isEmpty', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('d3ba41d7e1804f868a8d0fd5fcfafea4', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'IndexWriter', 'isLocked', '["IndexWriter"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('1b8e1011219847928c649160b5ef9405', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'org.apache.lucene.index.IndexWriter', 'deleteAll', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8bb00142cebe4d1c99f32238e9320bf6', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'org.apache.lucene.index.IndexWriter', 'forceMergeDeletes', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('d0181cd79dc945b9bc1c9d23bf37c986', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'org.apache.lucene.index.IndexWriter', 'commit', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('7187963beee14593b4bd475c2af977a0', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('6094628745e34bd18a882728d45be62c', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'java.util.List', 'add', '["pkFieldValueList"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('0ee36a62a9a64a8b8e95ce560adcc53b', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'java.lang.StringBuilder', 'append', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('70b6e38d2d444190ae9ab7ae20476fd2', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'org.apache.lucene.document.FieldType', 'setStored', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c1b2e52338a54cd898d779f51b1e3ce3', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'org.apache.lucene.document.FieldType', 'setIndexed', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('ce4f940745304110814fe229eaae812a', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'org.apache.lucene.document.FieldType', 'setTokenized', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('dea5bbee304b47c6a40b386dbd2a9fd7', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'org.apache.lucene.document.Document', 'add', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('86ee8718f0b2420ca2f34ae9e6b842da', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'java.util.Map', 'keySet', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e8ea38d6e5424ff2bbde99c821e31728', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'java.lang.String', 'equalsIgnoreCase', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8be43b61b59144b1911b0e877f752e15', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'JSONObject', 'fromObject', '["Object","JSONObject"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('56160cbf39624ebd96c972da21597f6c', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'JSONObject.fromObject(data, config)', 'toString', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f0380102d4ec4085acb08d65463d152b', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'java.util.Map', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f1a5f80f2ccf4d41b6f071c496e97b77', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'com.wind.myLuence.index.FieldLucproperty', 'isStore', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('2a66fd6e24b6458f8cb60ea39369d0f6', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'com.wind.myLuence.index.FieldLucproperty', 'isIndex', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('51921f2a1e2146c481b8265b964fe5e1', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'com.wind.myLuence.index.FieldLucproperty', 'isAnalyzed', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('2151b759117f46c6a4d75609d1b9bfa4', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'org.apache.lucene.index.IndexWriter', 'addDocument', '["Document"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('a64cbe0a9bac4f2baa1cc7ccde72bb1a', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'Log', 'error', '["Log"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c2e04e79e49442cdbc3af3ab2fe1c559', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'org.apache.lucene.index.IndexWriter', 'close', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('6ccc12b8650b43149a102d0b32b34693', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'IndexWriter', 'unlock', '["IndexWriter"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('7764340f957649ba9f299ffa550cd9b0', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'BeanIndex', 'getClass', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('cdc91a94c70b4db4b8328d39c3a3e70b', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'write', '["List<Object>"]', null, 'Log', 'warn', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8f5fae3a7aa2460db82594877df53166', 'MyLuence-master', 'com.wind.myLuence.Context', 'get', '["String","String"]', null, 'java.util.Map', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e28dc8d021ed4b038e49a0ef0001e4ca', 'MyLuence-master', 'com.wind.myLuence.Context', 'get', '["String","String"]', null, 'com.wind.myLuence.Context', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('a0127699800c4ebeb1cd8028359a75bc', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'Log', 'info', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('b254afe962df4ce0b822529f06d51459', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'java.util.List', 'isEmpty', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('85258a47a9aa4532b81379300a9bc5a2', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'IndexWriter', 'isLocked', '["IndexWriter"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('cb2ce27129474d8b8cb602790bdf0ecd', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c5ff6101722a403e943c7d54db5eda77', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'java.util.List', 'add', '["pkFieldValueList"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('316bee67dd0a4b178aadc30e91ac94de', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'java.lang.StringBuilder', 'append', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e99fcb6444e44b4e87308d06af6ef72b', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'org.apache.lucene.document.FieldType', 'setStored', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c81bc3d8d63d4a3ba0992232ee6033df', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'org.apache.lucene.document.FieldType', 'setIndexed', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('7b8766946c4b440682fae54fae434252', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'org.apache.lucene.document.FieldType', 'setTokenized', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('ecb559e9603f48c48823abff94f0dd63', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'org.apache.lucene.document.Document', 'add', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('109432b2d43d459eb6d77ca653aee1d9', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'java.util.Map', 'keySet', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('b759f3a324a540cbba52fb6652f55bdb', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'java.lang.String', 'equalsIgnoreCase', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c411ff9060a7441780db779369024c58', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'JSONObject', 'fromObject', '["Object","JSONObject"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('6fc01c6f6b834218bed98e465341a223', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'JSONObject.fromObject(data, config)', 'toString', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('168dfa1b07454aec9b33119e4c5373f3', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'java.util.Map', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('900a4acb08d245958f25d7f7475b6de8', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'com.wind.myLuence.index.FieldLucproperty', 'isStore', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f97594b83c2241298501626be8577077', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'com.wind.myLuence.index.FieldLucproperty', 'isIndex', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('d438d706c52742c8a07b25aa1ac1fdd5', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'com.wind.myLuence.index.FieldLucproperty', 'isAnalyzed', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('4b64cfc102504b11be1d4e8871e27f37', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'org.apache.lucene.index.IndexWriter', 'addDocument', '["Document"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('a82885c358844a31b5f91faf5ea69de1', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'org.apache.lucene.index.IndexWriter', 'forceMerge', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('fa1f5e15c49e44cc9bcbc07ec6fb3307', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'org.apache.lucene.index.IndexWriter', 'commit', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('157d25ca07d040d5b0b22a6df896f2d0', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'Log', 'error', '["Log"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('054549cf6e9044ceacbe0eb811e3ba8a', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'org.apache.lucene.index.IndexWriter', 'close', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('12c22cbe8f0a4c65bf44d32318589c71', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'IndexWriter', 'unlock', '["IndexWriter"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('b86ce5465a66494195c4e0388eb98753', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'BeanIndex', 'getClass', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('ce16724276cc46b98b477a1caa3a2664', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'append', '["List<Object>"]', null, 'Log', 'warn', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('fb488defff7046978f943949f8f71c61', 'MyLuence-master', 'com.wind.myLuence.Context', 'clear', '[]', null, 'java.util.Map', 'clear', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('72de3629377c41b3bdc78d8bf82a9152', 'MyLuence-master', 'com.wind.myLuence.source.DateJsonValueProcessor', 'processArrayValue', '["Object","JsonConfig"]', null, 'com.wind.myLuence.source.DateJsonValueProcessor', 'processObjectValue', '["Object","JsonConfig"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('d28779de79ea4715a80531eb6a13ce43', 'MyLuence-master', 'com.wind.myLuence.Context', 'getString', '["String"]', null, 'com.wind.myLuence.Context', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('118cf3a950d64f778e0f3ccb47836385', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'IncreaseDataOpen', '[]', null, 'java.util.List', 'add', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8af75ac382a04784aa7496392698fa8a', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'IncreaseDataOpen', '[]', null, 'java.util.Map', 'isEmpty', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('acb9e515c7804ef9af1b55a0087f60ae', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'IncreaseDataOpen', '[]', null, 'java.util.Map', 'keySet', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('7b3589e787f94eee8ba18c690f4c48b4', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'IncreaseDataOpen', '[]', null, 'com.d1xn.ddal.client.socket.AsynDDALHelper', 'query', '["Class<?>","List<Condition>","DataOrder"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('052ddffb3f3c456fad16b682a0062173', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'IncreaseDataOpen', '[]', null, 'e', 'getMessage', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('36dc98c1dd4046d885af91ed9e86e8b4', 'MyLuence-master', 'com.wind.myLuence.source.DDALDatabaseSource', 'IncreaseDataOpen', '[]', null, 'org.slf4j.Logger', 'error', '["logger","logger"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f80100a536e84118b1862180dc6d7440', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'readValue', '[]', null, 'java.io.File', 'exists', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('cea74db9cad5498da2815a142daf3c72', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'readValue', '[]', null, 'JSONObjUtil', 'getFileJSONContent', '["File"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f42579ef82204c1090465bd58facce0f', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'readValue', '[]', null, 'com.d1xn.common.json.JSONObject', 'getString', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('6a22581c14684e8f9b7d9a25ff6da015', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'readValue', '[]', null, '"Integer"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('d303b1446028402b93a44896e317357d', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'readValue', '[]', null, '"Long"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('482f17b3cce649e198f559cde7673ab3', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'readValue', '[]', null, '"Short"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('752cd4db24824784b13ab22043a190f5', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'readValue', '[]', null, '"Date"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('b5dcfecb68f54526b50d42c9ba510985', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'readValue', '[]', null, 'java.text.SimpleDateFormat', 'parse', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('7d4b0a13a3cb44c6b6825106b3b9253d', 'MyLuence-master', 'com.wind.myLuence.source.IncFieldRW', 'readValue', '[]', null, '"Timestamp"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('97905feb0c31462e948b4722a334459a', 'MyLuence-master', 'com.wind.myLuence.util.ClassUtil', 'getFieldNameType', '["Class<?>"]', null, 'java.Class', 'getDeclaredFields', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('9066cc37ca1b4342aa77b5bfc36f6144', 'MyLuence-master', 'com.wind.myLuence.util.ClassUtil', 'getFieldNameType', '["Class<?>"]', null, 'fields[j]', 'getName', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('9b34528311144ef694e04ccb2ee049ea', 'MyLuence-master', 'com.wind.myLuence.util.ClassUtil', 'getFieldNameType', '["Class<?>"]', null, 'fields[j]', 'getType', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('1e7ccdd08ac347fcb994b3864b5e3cb0', 'MyLuence-master', 'com.wind.myLuence.util.ClassUtil', 'getFieldNameType', '["Class<?>"]', null, 'fields[j].getType()', 'getName', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('06236028114f4249bd825c11a391e6cd', 'MyLuence-master', 'com.wind.myLuence.util.ClassUtil', 'getFieldNameType', '["Class<?>"]', null, 'java.util.Map', 'put', '["String","String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('306bbd58700e48eda6ac112b7448f155', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'configure', '["Context"]', null, 'com.wind.myLuence.Context', 'getString', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('72026375297f46cfa57f6afcab823277', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'configure', '["Context"]', null, 'com.wind.myLuence.search.BeanSearcher', 'getPojoFileds', '["List<String>","Class<?>"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('de2e6bfe481f438c90d798358ec0006b', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'configure', '["Context"]', null, 'org.slf4j.Logger', 'error', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('34b45793b88743dfbb79cfba3a0e7cd5', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'configure', '["Context"]', null, 'java.lang.String', 'isEmpty', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('be4021fce1004a27bd5b4f2eb4e75acb', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'configure', '["Context"]', null, 'java.util.List', 'containsAll', '["List<String>"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('5a08514f3fb4460c8f62d4d0f3cc2609', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'configure', '["Context"]', null, 'java.util.List', 'addAll', '["List<String>"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f8b5a9b86eb34e57a7107830edaaa100', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'configure', '["Context"]', null, 'java.util.List', 'contains', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('0efeb03ae0824716a3c0f95054b0d18f', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'configure', '["Context"]', null, 'FSDirectory', 'open', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('fc5fa2162bf44485851c6def297134ff', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'configure', '["Context"]', null, 'BeanSearcher', 'getClass', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('dfeeca79eb284fa0a4bc3c2552f716ea', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'configure', '["Context"]', null, 'e2', 'getMessage', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('3c3a4d807c3a49d8a8d01eba21399233', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'configure', '["Context"]', null, 'Log', 'error', '["Log","Log"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c699926d8a8b46f59cc2013c7d531d68', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, 'java.Class', 'getMethod', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8ea465b652474222a698d40871fec016', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, 'java.lang.reflect.Method', 'getReturnType', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8bd52bd88c9141b48a945f1c85da6842', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, 'm.getReturnType()', 'getSimpleName', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('917654b0159f44308988982a8b476a53', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, 'java.lang.reflect.Method', 'invoke', '["Object"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('fb13182d6dfe4a2aa15e1e4f6c9e7cc5', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, '"Short"', 'equalsIgnoreCase', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('0f258fceb7be4472a277e7936474189d', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, '"Boolean"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('afd6668484764297b658ce1cf29d1a8d', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, '"Float"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f4cc395e4a244f99b4311a4bc3ac794f', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, '"Double"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('d3d33d26b5fe4d299edc83c77a03ba6e', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, '"Long"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8b8dafd29db7464ea4f5638a09684108', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, '"Integer"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('23022515e3a5498eabf46627c6bbee92', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, '"String"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('21bc7aa799ee4872939326387b9adafa', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, 'java.lang.Object', 'toString', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('b78100c30e0547269486fdd53a52c84d', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, '"Date"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('09bb018acc5d469991bca4410af77597', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, 'DateUtil', 'timeFormat', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('486616482c8f4d1cb6e240b22c78a142', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, '"Timestamp"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('ddc6cd2962464a8d8911537f89e3f35e', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, '"HashMap"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('ee1b62754af94221a70632de072cf27d', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, 'JSONObject', 'fromObject', '["Object","JSONObject"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('cec656bcc85f42a9811d382cf5e46703', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, 'JSONObject.fromObject(mValue, config)', 'toString', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('a0a37f1f3d144641b16649c2cace64af', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, '"ArrayList"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('1031976ba5c04212a02e456385eed1eb', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, 'JSONArray', 'fromObject', '["Object","JSONArray"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('a1bf72e6fa174d0ca9f38eb0ad96e894', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, 'JSONArray.fromObject(mValue, config)', 'toString', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('cd6e7849731c4e37b78c8ebd8a94b62b', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["Class<?>","String","Object"]', null, 'com.wind.myLuence.index.BeanIndex', 'getFieldValue', '["BeanIndex","String","Object"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('84c59157311a4cf1a600d8447ea1b020', 'MyLuence-master', 'com.wind.myLuence.Context', 'getBoolean', '["String","Boolean"]', null, 'com.wind.myLuence.Context', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('723091d4f2124d2094fbc7c3e65a8ad2', 'MyLuence-master', 'com.wind.myLuence.Context', 'getBoolean', '["String","Boolean"]', null, 'java.lang.String', 'trim', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('359f7e957117482b8ea4e01d1092f9da', 'MyLuence-master', 'com.wind.myLuence.Context', 'getBoolean', '["String","Boolean"]', null, 'com.wind.myLuence.Context', 'getBoolean', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('05951ccdd6ab40379e3618b6242b40f6', 'MyLuence-master', 'com.wind.myLuence.Context', 'putAll', '["Map<String, String>"]', null, 'java.util.Map', 'putAll', '["Map<String, String>"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('c35c6384d97443cf872cf04eed49a552', 'MyLuence-master', 'com.wind.myLuence.config.PropertiesCfParser', 'parse', '[]', null, 'PropertiesCfParser', 'getFilePath', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('9001c05b0a364b1b9602be5f95df6dd8', 'MyLuence-master', 'com.wind.myLuence.config.PropertiesCfParser', 'parse', '[]', null, 'PropertyParser.class', 'getResourceAsStream', '["PropertyParser.class"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('1c5d6585e5224fb2b2ed3dc127454ab8', 'MyLuence-master', 'com.wind.myLuence.config.PropertiesCfParser', 'parse', '[]', null, 'java.util.Properties', 'load', '["prop"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('3a166f0c42c44fd6a84e116e535cb191', 'MyLuence-master', 'com.wind.myLuence.config.PropertiesCfParser', 'parse', '[]', null, 'java.util.Properties', 'keys', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('a165980c70444110801685baf297ac76', 'MyLuence-master', 'com.wind.myLuence.config.PropertiesCfParser', 'parse', '[]', null, 'java.util.Enumeration', 'hasMoreElements', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('99872fe3dbc847dcafc6fbeac90bfcca', 'MyLuence-master', 'com.wind.myLuence.config.PropertiesCfParser', 'parse', '[]', null, 'java.lang.String', 'contains', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('86b7e6b2f2d7451d9b033b3f886b178a', 'MyLuence-master', 'com.wind.myLuence.config.PropertiesCfParser', 'parse', '[]', null, 'java.util.List', 'add', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('cdeff3a0f89b4b67894da905cdca8895', 'MyLuence-master', 'com.wind.myLuence.config.PropertiesCfParser', 'parse', '[]', null, 'java.util.Map', 'put', '["String","String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('9ef13502068f45a6824027719ec9ff37', 'MyLuence-master', 'com.wind.myLuence.config.PropertiesCfParser', 'parse', '[]', null, 'java.util.Map', 'keySet', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('85f80db5681e4ff68d9092004e41f020', 'MyLuence-master', 'com.wind.myLuence.config.PropertiesCfParser', 'parse', '[]', null, 'java.util.Map', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('63277a192828473088f2409050bb1467', 'MyLuence-master', 'com.wind.myLuence.config.PropertiesCfParser', 'parse', '[]', null, 'com.wind.myLuence.Context', 'put', '["context"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('08d98569ce904e02b2d49bd90bfbbb5c', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, 'java.Class', 'getDeclaredMethods', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('2ac86fee8d7c4e1780bf67b9ff269403', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, 'java.lang.reflect.Method', 'getName', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('15c190d2a51146b3b185dbc13d2e9123', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, 'java.lang.String', 'startsWith', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f929ce7c9a76482696ab3cb771bee1dd', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, 'java.lang.reflect.Method', 'getReturnType', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f7692bce45c24a3c9ed511108af3b350', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, 'm.getReturnType()', 'getSimpleName', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('304974e1b7f142959b50a6e82426c219', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"ArrayList"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('5eb99dd7f6ea4caca9ebb6779d760a48', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"HashMap"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('fe66f9aa3b3d48fdba2f2604344221b5', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Timestamp"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('39910ebe0c4c4fe894f480687a3c7973', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Date"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8a413324a83d414abea15c80e490f814', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Short"', 'equalsIgnoreCase', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e542f0e25731437b93eaa615cd2de61d', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Boolean"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('3eb332550da24b4787bea77eda25b328', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Float"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('5df416cd822f448d94d28ce6a3a60978', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Double"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8698b868870f4f03bbaafdc42cf1ac41', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Long"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('61a9e31a062f4a3ba4ec69be4421ff26', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"Integer"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('b993908875964a1c9eb8f346f93228a1', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, '"String"', 'equals', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('a90781e8386b4b189ea8788b8e425964', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","BeanIndex"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('d31d1817a78e46b8a8625367eb9a8e97', 'MyLuence-master', 'com.wind.myLuence.index.BeanIndex', 'getPojoFileds', '["List<String>","Class<?>"]', null, 'java.util.List', 'add', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('f6a1d282beba4bdd98127ca7631b0dbc', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'search', '["String","Sort","int"]', null, 'org.apache.lucene.queryparser.classic.MultiFieldQueryParser', 'parse', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('8da39bdb360547c09fe6e533e4ba987f', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'search', '["String","Sort","int"]', null, 'org.apache.lucene.search.IndexSearcher', 'search', '["Query","Integer"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('ce6a572acc8e4715a3a0149889756c43', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'search', '["String","Sort","int"]', null, 'org.apache.lucene.search.IndexSearcher', 'doc', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('fcc60ac82cd247438daada11a2339719', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'search', '["String","Sort","int"]', null, 'org.apache.lucene.document.Document', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('7034e1c8b40d42cfb05fa125b8679907', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'search', '["String","Sort","int"]', null, 'java.util.List', 'add', '["T"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('03c200285a694f56bc063dd00a22ff1b', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'search', '["String","Sort","int"]', null, 'com.wind.myLuence.search.BeanSearcher', 'getFieldNameType', '["Class<?>"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('4d1d52e54ab8486ebd7bbd6c9f0a87e7', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'search', '["String","Sort","int"]', null, 'java.util.Map', 'get', '["String"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('26d8956536e44a458e04696e74cf9e3c', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'search', '["String","Sort","int"]', null, 'com.wind.myLuence.search.BeanSearcher', 'setFieldValue', '["Class<?>","String","String","BeanSearcher","T"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('ef762fb1fe4541a589dbe9d356144527', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'search', '["String","Sort","int"]', null, 'e', 'getMessage', '[]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('3dbfe5666c874e6499f3b62483461f96', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'search', '["String","Sort","int"]', null, 'org.slf4j.Logger', 'error', '["logger","logger"]', null);
INSERT INTO codegraphtest.methodcallinfo (id, project_name, caller_class_name, caller_method_name, caller_param, caller_return_type, callee_class_name, callee_method_name, callee_param, callee_return_type) VALUES ('e11d13d7a47b4d7fa8a9d61075d2417a', 'MyLuence-master', 'com.wind.myLuence.search.BeanSearcher', 'search', '["String","Sort","int"]', null, 'org.apache.lucene.search.BooleanQuery', 'add', '["Query"]', null);
create table methodinfo
(
    projectName      text null,
    name             text null,
    javadoc          text null,
    classname        text null,
    returnType       text null,
    modi             text null,
    throwExceptions  text null,
    isConstructor    text null,
    content          text null,
    methodParameters text null,
    id               text null
)
    charset = utf8;

INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'ConfigItem', null, 'com.wind.myLuence.config.CfFileParser', '', 'private;', null, '0', 'private void ConfigItem(String value){
  this.value=value;
}
', '[String value]', 'cf145fdb95da4aeaa096af697641eb16');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'parse', null, 'com.wind.myLuence.config.CfFileParser', 'Map<String,Context>', 'public;abstract;', null, '0', 'public abstract Map<String,Context> parse() throws IOException ;
', '[]', '2b2bd97187cb42fe95e74bbed74e32e6');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getFilePath', null, 'com.wind.myLuence.config.CfFileParser', 'String', 'public;', null, '0', 'public String getFilePath(){
  return filePath;
}
', '[]', 'a2a7d75f53bc4e01b69410aabe351a1d');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'setFilePath', null, 'com.wind.myLuence.config.CfFileParser', 'void', 'public;', null, '0', 'public void setFilePath(String filePath){
  this.filePath=filePath;
}
', '[String filePath]', '935441c66c0b4d08bf4e804b64c43475');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'parse', null, 'com.wind.myLuence.config.PropertiesCfParser', 'Map<String,Context>', '@Override;public;', null, '0', '@Override public Map<String,Context> parse() throws IOException {
  Properties prop=new Properties();
  prop.load(PropertyParser.class.getResourceAsStream(this.getFilePath()));
  Map<String,String> configs=new HashMap<String,String>();
  Enumeration<?> keys=prop.keys();
  List<String> cfItemArray=new ArrayList<String>();
  while (keys.hasMoreElements()) {
    String key=(String)keys.nextElement();
    if (key.contains(ConfigItem.BEANCLASS.value)) {
      cfItemArray.add(key.split("\\\\.")[0]);
    }
    String value=(String)prop.get(key);
    configs.put(key,value);
  }
  Map<String,Context> results=new HashMap<String,Context>();
  for (  String cfItem : cfItemArray) {
    Context context=new Context();
    for (    String key : configs.keySet()) {
      if (key.contains(cfItem)) {
        context.put(key.split("\\\\.")[1],configs.get(key));
      }
    }
    results.put(cfItem,context);
  }
  return results;
}
', '[]', 'e7bb0b00203b4f7b8a6a47eddee82ada');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'parse', null, 'com.wind.myLuence.config.XmlCfParser', 'Map<String,Context>', '@Override;public;', null, '0', '@Override public Map<String,Context> parse(){
  return null;
}
', '[]', '3392cd0d894947768b406fb2430fde21');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'configure', null, 'com.wind.myLuence.Configurable', 'void', 'public;', null, '0', 'public void configure(Context context) throws ConfigurableException, ClassNotFoundException ;
', '[Context context]', '5bd68ef822e7409cbf90dd2f95c00351');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'Context', null, 'com.wind.myLuence.Context', '', 'public;', null, '1', 'public Context(){
  parameters=Collections.synchronizedMap(new HashMap<String,String>());
}
', '[]', 'b9f30a14cac14bd78f95492c8fae747b');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'Context', null, 'com.wind.myLuence.Context', '', 'public;', null, '1', 'public Context(Map<String,String> paramters){
  this();
  this.putAll(paramters);
}
', '[Map<String,String> paramters]', 'c963e762de4a45549d571ca2469e918c');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'clear', null, 'com.wind.myLuence.Context', 'void', 'public;', null, '0', 'public void clear(){
  parameters.clear();
}
', '[]', '4b1ce5caa94e46d68dcdaee8e030b341');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'putAll', null, 'com.wind.myLuence.Context', 'void', 'public;', null, '0', 'public void putAll(Map<String,String> map){
  parameters.putAll(map);
}
', '[Map<String,String> map]', '24f96dccd8cc4a8595e1485f6923c3ff');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'put', null, 'com.wind.myLuence.Context', 'void', 'public;', null, '0', 'public void put(String key,String value){
  parameters.put(key,value);
}
', '[String key, String value]', '07d67a7eab8e4947abb16976459f4119');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getBoolean', null, 'com.wind.myLuence.Context', 'Boolean', 'public;', null, '0', 'public Boolean getBoolean(String key,Boolean defaultValue){
  String value=get(key);
  if (value != null) {
    return Boolean.parseBoolean(value.trim());
  }
  return defaultValue;
}
', '[String key, Boolean defaultValue]', '6448f5f3463c45c5bb683d965f955f84');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getBoolean', null, 'com.wind.myLuence.Context', 'Boolean', 'public;', null, '0', 'public Boolean getBoolean(String key){
  return getBoolean(key,null);
}
', '[String key]', '07c61e6087b249948c83e24085681c8b');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getInteger', null, 'com.wind.myLuence.Context', 'Integer', 'public;', null, '0', 'public Integer getInteger(String key,Integer defaultValue){
  String value=get(key);
  if (value != null) {
    return Integer.parseInt(value.trim());
  }
  return defaultValue;
}
', '[String key, Integer defaultValue]', 'cb17bccd5dca4527a5b46c273217c834');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'get', null, 'com.wind.myLuence.Context', 'String', 'private;', null, '0', 'private String get(String key,String defaultValue){
  String result=parameters.get(key);
  if (result != null) {
    return result;
  }
  return defaultValue;
}
', '[String key, String defaultValue]', '8d4505a4bc904c21adeb9d3fb8abda47');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getInteger', null, 'com.wind.myLuence.Context', 'Integer', 'public;', null, '0', 'public Integer getInteger(String key){
  return getInteger(key,null);
}
', '[String key]', '4f304088a5d643dbb5bd35aa7fc7bfe3');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getLong', null, 'com.wind.myLuence.Context', 'Long', 'public;', null, '0', 'public Long getLong(String key,Long defaultValue){
  String value=get(key);
  if (value != null) {
    return Long.parseLong(value.trim());
  }
  return defaultValue;
}
', '[String key, Long defaultValue]', 'c05df8f83879475d88578ae422d04dda');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getLong', null, 'com.wind.myLuence.Context', 'Long', 'public;', null, '0', 'public Long getLong(String key){
  return getLong(key,null);
}
', '[String key]', 'e465ad299729485b87e735cbbcbfc29c');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getString', null, 'com.wind.myLuence.Context', 'String', 'public;', null, '0', 'public String getString(String key){
  return get(key);
}
', '[String key]', '1df88f23e46b433bb2eee9f99900621a');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getString', null, 'com.wind.myLuence.Context', 'String', 'public;', null, '0', 'public String getString(String key,String defaultValue){
  return get(key,defaultValue);
}
', '[String key, String defaultValue]', 'f9ab458f88b94d538f78afb643fe5387');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'get', null, 'com.wind.myLuence.Context', 'String', 'private;', null, '0', 'private String get(String key){
  return get(key,null);
}
', '[String key]', '56c3ef1840e44009a3077b0a59606ca3');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'toString', null, 'com.wind.myLuence.Context', 'String', 'public;', null, '0', 'public String toString(){
  return "{ parameters:" + parameters + " }";
}
', '[]', '90ea0b7d1bcf465e908bdeae3046f8be');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'InitialDataOpen', null, 'com.wind.myLuence.DataSource', 'void', 'public;', null, '0', '/** 
 * ??????
 */
public void InitialDataOpen();
', '[]', '4eea6d815a974f1e99c14e17f0a992cc');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'IncreaseDataOpen', null, 'com.wind.myLuence.DataSource', 'void', 'public;', null, '0', '/** 
 * ??????
 */
public void IncreaseDataOpen();
', '[]', 'f41f195f394a416e8e1f71c46b4e0443');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'ConfigurableException', null, 'com.wind.myLuence.exception.ConfigurableException', '', 'public;', null, '1', 'public ConfigurableException(){
}
', '[]', 'f19b93070b1443cd8277d20ebc6e754c');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'ConfigurableException', null, 'com.wind.myLuence.exception.ConfigurableException', '', 'public;', null, '1', 'public ConfigurableException(String message){
  super(message);
}
', '[String message]', 'd415ab88a26d4dc68eeb67c6826712a6');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'ConfigurableException', null, 'com.wind.myLuence.exception.ConfigurableException', '', 'public;', null, '1', 'public ConfigurableException(String message,Throwable cause){
  super(message,cause);
}
', '[String message, Throwable cause]', '1b69ff4d49184446b9932baf11b14fde');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'IndexException', null, 'com.wind.myLuence.exception.IndexException', '', 'public;', null, '1', 'public IndexException(){
}
', '[]', '810081a7e8d244b8af60eaeb59fd08a3');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'IndexException', null, 'com.wind.myLuence.exception.IndexException', '', 'public;', null, '1', 'public IndexException(String message){
  super(message);
}
', '[String message]', 'a8bdb52cb67640488a02e46ac4328188');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'IndexException', null, 'com.wind.myLuence.exception.IndexException', '', 'public;', null, '1', 'public IndexException(String message,Throwable cause){
  super(message,cause);
}
', '[String message, Throwable cause]', '05ea2c98833b4b6eb4a7c1790ca3136e');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'SearchException', null, 'com.wind.myLuence.exception.SearchException', '', 'public;', null, '1', 'public SearchException(){
}
', '[]', '98434cb1d7a9409292354a7174ddced8');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'SearchException', null, 'com.wind.myLuence.exception.SearchException', '', 'public;', null, '1', 'public SearchException(String message){
  super(message);
}
', '[String message]', '64769602acf0412d892aa935c1de8d1f');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'SearchException', null, 'com.wind.myLuence.exception.SearchException', '', 'public;', null, '1', 'public SearchException(String message,Throwable cause){
  super(message,cause);
}
', '[String message, Throwable cause]', '900f75fca55a40528fb81b9758f59ba8');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getIxSourceInstance', null, 'com.wind.myLuence.factory.MyLuenceFactory', 'IndexSource', 'public;', null, '0', 'public IndexSource getIxSourceInstance(String name);
', '[String name]', '2a72e808f54549638aa2898e407347f6');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getSearcherInstance', null, 'com.wind.myLuence.factory.MyLuenceFactory', 'AbstarctSearcher', 'public;', null, '0', 'public AbstarctSearcher getSearcherInstance();
', '[]', '72d1e91759c74b92978a4d35a8f7479d');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'XmlMyLuenceFactory', null, 'com.wind.myLuence.factory.XmlMyLuenceFactory', '', 'public;', null, '1', 'public XmlMyLuenceFactory(String[] xmls){
  beanFactory=new ClassPathXmlApplicationContext(xmls);
}
', '[String[] xmls]', 'e63d5bbef2634f91bab78db13682405f');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getIxSourceInstance', null, 'com.wind.myLuence.factory.XmlMyLuenceFactory', 'IndexSource', '@Override;public;', null, '0', '@Override public IndexSource getIxSourceInstance(String name){
  if (name != null && !name.isEmpty()) {
    return (IndexSource)beanFactory.getBean(name);
  }
  return (IndexSource)beanFactory.getBean(INDEX_SOURCE_NAME);
}
', '[String name]', '0fa07f89ac25488c956b6abd06604c71');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getSearcherInstance', null, 'com.wind.myLuence.factory.XmlMyLuenceFactory', 'AbstarctSearcher', '@Override;public;', null, '0', '@Override public AbstarctSearcher getSearcherInstance(){
  return (AbstarctSearcher)beanFactory.getBean(SEARCHER_NAME);
}
', '[]', '99461b5aaad04c51b4038b3ca16c8996');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getAnalyzer', null, 'com.wind.myLuence.index.AbstractIndex', 'Analyzer', 'public;', null, '0', 'public Analyzer getAnalyzer(){
  return analyzer;
}
', '[]', 'c5de29b9681a445ca07fe36ab3f7f685');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'setAnalyzer', null, 'com.wind.myLuence.index.AbstractIndex', 'void', 'public;', null, '0', 'public void setAnalyzer(Analyzer analyzer){
  this.analyzer=analyzer;
}
', '[Analyzer analyzer]', 'f8b224b1d5de4194b6ef3f283d366b58');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'configure', null, 'com.wind.myLuence.index.BeanIndex', 'void', 'public;', null, '0', 'public void configure(Context context) throws ConfigurableException {
  try {
    String analyzerClass=context.getString(ANALYZERCLASS);
    this.analyzer=(Analyzer)Class.forName(analyzerClass).newInstance();
    List<String> pojoFields=new ArrayList<String>();
    String className=context.getString(CLASSNAME);
    try {
      this.clazz=Class.forName(className);
      getPojoFileds(pojoFields,clazz);
    }
 catch (    ClassNotFoundException e1) {
      logger.error("bean class error to create.");
      throw new ConfigurableException(e1.getMessage(),e1);
    }
    String analyzedIndexFields=context.getString(ANALYZEDINDEXFIELDS);
    if (analyzedIndexFields != null && !analyzedIndexFields.isEmpty()) {
      this.analyzedIndexFields=new ArrayList<String>(Arrays.asList(analyzedIndexFields.split(",")));
      if (!pojoFields.containsAll(this.analyzedIndexFields)) {
        logger.error("indexField''s range beyong the range of pojoFields");
        throw new ConfigurableException("indexField''s range beyong the range of pojoFields");
      }
    }
    String notAnalyzedIndexFields=context.getString(NOTANALYZEDINDEXFIELDS);
    if (notAnalyzedIndexFields != null && !notAnalyzedIndexFields.isEmpty()) {
      this.notAnalyzedIndexFields=new ArrayList<String>(Arrays.asList(notAnalyzedIndexFields.split(",")));
      if (!pojoFields.containsAll(this.notAnalyzedIndexFields)) {
        logger.error("notAnalyzedIndexFields''s range beyong the range of pojoFields");
        throw new ConfigurableException("notAnalyzedIndexFields''s range beyong the range of pojoFields");
      }
    }
    String storeFields=context.getString(STOREFIELDS);
    if (storeFields != null && !storeFields.isEmpty()) {
      this.storeFields=new ArrayList<String>(Arrays.asList(storeFields.split(",")));
      if (!pojoFields.containsAll(this.storeFields) && !this.storeFields.contains(DATAFIELDNAME_DEFAULT)) {
        logger.error("storeFields''s range beyong the range of pojoFields");
        throw new ConfigurableException("storeFields''s range beyong the range of pojoFields");
      }
    }
    if (analyzedIndexFields == null && notAnalyzedIndexFields == null && storeFields == null) {
      logger.error("You must set one of analyzedIndexFields,notAnalyzedIndexFields,storeFields at least.");
      throw new ConfigurableException("You must set one of analyzedIndexFields,notAnalyzedIndexFields,storeFields at least.");
    }
    String pkFields=context.getString(PK_FIELD);
    if (pkFields != null && !pkFields.isEmpty()) {
      this.pkFields=new ArrayList<String>(Arrays.asList(pkFields.split(",")));
    }
    String indexFilePath=context.getString(INDEXFILEPATH);
    if (indexFilePath == null || indexFilePath.isEmpty()) {
      logger.error("indexFilePath must to be set.");
      throw new ConfigurableException("indexFilePath must to be set.");
    }
    try {
      this.directory=FSDirectory.open(new File(indexFilePath));
    }
 catch (    IOException e) {
      logger.error("index file dir error to create.");
      throw new ConfigurableException("index file dir error to create.");
    }
    this.pkName=context.getString(PKNAME,PKNAME_DEFAULT);
    this.dataFieldName=context.getString(DATAFIELDNAME,DATAFIELDNAME_DEFAULT);
    fieldPropertyMap=getFieldLucProperty();
  }
 catch (  InstantiationException e2) {
    Log.error(this.getClass(),e2.getMessage());
    throw new ConfigurableException(e2.getMessage(),e2);
  }
catch (  IllegalAccessException e2) {
    Log.error(this.getClass(),e2.getMessage());
    throw new ConfigurableException(e2.getMessage(),e2);
  }
catch (  ClassNotFoundException e2) {
    Log.error(this.getClass(),e2.getMessage());
    throw new ConfigurableException(e2.getMessage(),e2);
  }
}
', '[Context context]', 'c589edb007344e6f95cbc62ff3cf6941');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'write', null, 'com.wind.myLuence.index.BeanIndex', 'void', 'public;', null, '0', 'public void write(List<Object> datas) throws IndexException {
  Log.info(BeanIndex.class,"#################### createIndex  starting");
  long start=System.currentTimeMillis();
  if (datas == null || datas.isEmpty())   return;
  IndexWriter indexWriter=null;
  try {
    while (!IndexWriter.isLocked(directory)) {
      IndexWriterConfig indexWriterConfig=new IndexWriterConfig(Version.LUCENE_8,analyzer);
      indexWriter=new IndexWriter(directory,indexWriterConfig);
      indexWriter.deleteAll();
      indexWriter.forceMergeDeletes();
      indexWriter.commit();
      for (      Object data : datas) {
        if (data == null)         continue;
        Document doc=new Document();
        if (this.pkFields != null) {
          List<String> pkFieldValueList=new ArrayList<String>();
          for (          String pkField : pkFields) {
            pkFieldValueList.add(getFieldValue(clazz,pkField,data));
          }
          StringBuilder id=new StringBuilder();
          for (          String pkFieldValue : pkFieldValueList) {
            id.append(pkFieldValue + "@");
          }
          FieldType fieldType=new FieldType();
          fieldType.setStored(true);
          fieldType.setIndexed(false);
          fieldType.setTokenized(false);
          doc.add(new Field(pkName,id.substring(0,id.length() - 1),fieldType));
        }
        for (        String fieldName : fieldPropertyMap.keySet()) {
          String value=null;
          if (fieldName.equalsIgnoreCase(dataFieldName)) {
            value=JSONObject.fromObject(data,config).toString();
          }
 else {
            value=getFieldValue(clazz,fieldName,data);
          }
          if (value != null) {
            FieldType fieldType=new FieldType();
            FieldLucproperty fieldLucproperty=fieldPropertyMap.get(fieldName);
            fieldType.setStored(fieldLucproperty.isStore());
            fieldType.setIndexed(fieldLucproperty.isIndex());
            fieldType.setTokenized(fieldLucproperty.isAnalyzed());
            Field field=new Field(fieldName,value,fieldType);
            doc.add(field);
          }
        }
        indexWriter.addDocument(doc);
      }
      indexWriter.commit();
      break;
    }
  }
 catch (  Exception e) {
    Log.error(BeanIndex.class,e,"###############create index happened error" + e.getMessage());
  }
 finally {
    if (indexWriter != null) {
      try {
        indexWriter.close();
        IndexWriter.unlock(directory);
      }
 catch (      IOException e) {
        Log.error(this.getClass(),e);
      }
      indexWriter=null;
    }
  }
  Log.warn(BeanIndex.class,"#################### createIndex  finished, this process spent " + (System.currentTimeMillis() - start) / 1000 + " seconds");
}
', '[List<Object> datas]', '87945e7057b24d568827e12558657fef');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'append', null, 'com.wind.myLuence.index.BeanIndex', 'void', '@Override;public;', null, '0', '@Override public void append(List<Object> datas) throws IndexException {
  Log.info(BeanIndex.class,"#################### append index  starting");
  if (datas == null || datas.isEmpty())   return;
  long start=System.currentTimeMillis();
  IndexWriter indexWriter=null;
  try {
    while (!IndexWriter.isLocked(directory)) {
      IndexWriterConfig indexWriterConfig=new IndexWriterConfig(Version.LUCENE_46,analyzer);
      indexWriter=new IndexWriter(directory,indexWriterConfig);
      for (      Object data : datas) {
        if (data == null)         continue;
        Document doc=new Document();
        if (this.pkFields != null) {
          List<String> pkFieldValueList=new ArrayList<String>();
          for (          String pkField : pkFields) {
            pkFieldValueList.add(getFieldValue(clazz,pkField,data));
          }
          StringBuilder id=new StringBuilder();
          for (          String pkFieldValue : pkFieldValueList) {
            id.append(pkFieldValue + "@");
          }
          FieldType fieldType=new FieldType();
          fieldType.setStored(true);
          fieldType.setIndexed(false);
          fieldType.setTokenized(false);
          doc.add(new Field(pkName,id.substring(0,id.length() - 1),fieldType));
        }
        for (        String fieldName : fieldPropertyMap.keySet()) {
          String value=null;
          if (fieldName.equalsIgnoreCase(dataFieldName)) {
            value=JSONObject.fromObject(data,config).toString();
          }
 else {
            value=getFieldValue(clazz,fieldName,data);
          }
          if (value != null) {
            FieldType fieldType=new FieldType();
            FieldLucproperty fieldLucproperty=fieldPropertyMap.get(fieldName);
            fieldType.setStored(fieldLucproperty.isStore());
            fieldType.setIndexed(fieldLucproperty.isIndex());
            fieldType.setTokenized(fieldLucproperty.isAnalyzed());
            Field field=new Field(fieldName,value,fieldType);
            doc.add(field);
          }
        }
        indexWriter.addDocument(doc);
      }
      indexWriter.forceMerge(50);
      indexWriter.commit();
      break;
    }
  }
 catch (  Exception e) {
    Log.error(BeanIndex.class,e,"###############append index happened error" + e.getMessage());
  }
 finally {
    if (indexWriter != null) {
      try {
        indexWriter.close();
        IndexWriter.unlock(directory);
      }
 catch (      IOException e) {
        Log.error(this.getClass(),e);
      }
      indexWriter=null;
    }
  }
  Log.warn(BeanIndex.class,"#################### append index  finished, this process spent " + (System.currentTimeMillis() - start) / 1000 + " seconds");
}
', '[List<Object> datas]', '91de6c6eb24647a49a867187f1bac776');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'remove', null, 'com.wind.myLuence.index.BeanIndex', 'void', '@Override;public;', null, '0', '@Override public void remove() throws IndexException {
}
', '[]', '3bf05e382256437a9ea372129e07dc88');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getFieldValue', null, 'com.wind.myLuence.index.BeanIndex', 'String', 'private;', null, '0', '/** 
 * ?????
 * @param clazzClass????
 * @param fieldName????
 * @param data????
 * @return ??????
 * @throws Exception
 */
private String getFieldValue(Class<?> clazz,String fieldName,Object data) throws Exception {
  String value=null;
  Method m=clazz.getMethod("get" + fieldName.substring(0,1).toUpperCase() + fieldName.substring(1));
  String returnValueType=m.getReturnType().getSimpleName();
  Object mValue=m.invoke(data);
  if (mValue != null) {
    if ("String".equals(returnValueType) || "Integer".equals(returnValueType) || "Long".equals(returnValueType)|| "Double".equals(returnValueType)|| "Float".equals(returnValueType)|| "Boolean".equals(returnValueType)|| "Short".equalsIgnoreCase(returnValueType)) {
      value=mValue.toString();
    }
 else     if ("Date".equals(returnValueType)) {
      value=DateUtil.timeFormat((Date)mValue);
    }
 else     if ("Timestamp".equals(returnValueType)) {
      value=DateUtil.timeFormat((Timestamp)mValue);
    }
 else     if ("HashMap".equals(returnValueType)) {
      value=JSONObject.fromObject(mValue,config).toString();
    }
 else     if ("ArrayList".equals(returnValueType)) {
      value=JSONArray.fromObject(mValue,config).toString();
    }
 else {
      value=getFieldValue(m.getReturnType(),fieldName,mValue);
    }
  }
  return value;
}
', '[Class<?> clazz, String fieldName, Object data]', 'd301e88b616046e498b586bf490acf46');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getPojoFileds', null, 'com.wind.myLuence.index.BeanIndex', 'void', 'private;', null, '0', '/** 
 * ??????????
 * @param fields
 * @param clazz
 */
private void getPojoFileds(List<String> fields,Class<?> clazz){
  Method[] methods=clazz.getDeclaredMethods();
  for (  Method m : methods) {
    String name=m.getName();
    if (name.startsWith("get")) {
      String returnValueType=m.getReturnType().getSimpleName();
      if ("String".equals(returnValueType) || "Integer".equals(returnValueType) || "Long".equals(returnValueType)|| "Double".equals(returnValueType)|| "Float".equals(returnValueType)|| "Boolean".equals(returnValueType)|| "Short".equalsIgnoreCase(returnValueType)|| "Date".equals(returnValueType)|| "Timestamp".equals(returnValueType)|| "HashMap".equals(returnValueType)|| "ArrayList".equals(returnValueType)) {
        name=name.substring(3,4).toLowerCase() + name.substring(4);
      }
 else {
        getPojoFileds(fields,m.getReturnType());
      }
      fields.add(name);
    }
  }
}
', '[List<String> fields, Class<?> clazz]', '6cb08d1b4a35441b8f04e2bd2fc71617');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getFieldLucProperty', null, 'com.wind.myLuence.index.BeanIndex', 'Map<String,FieldLucproperty>', 'private;', null, '0', '/** 
 * ?????????
 * @return
 */
private Map<String,FieldLucproperty> getFieldLucProperty(){
  Map<String,FieldLucproperty> fieldPropertyMap=new HashMap<String,FieldLucproperty>();
  if (analyzedIndexFields != null) {
    for (    String analyzedIndexField : analyzedIndexFields) {
      FieldLucproperty fieldLucproperty=new FieldLucproperty();
      fieldLucproperty.setFieldName(analyzedIndexField);
      fieldLucproperty.setAnalyzed(true);
      fieldLucproperty.setStore(false);
      fieldLucproperty.setIndex(true);
      fieldPropertyMap.put(analyzedIndexField,fieldLucproperty);
    }
  }
  if (notAnalyzedIndexFields != null) {
    for (    String notAnalyzedIndexField : notAnalyzedIndexFields) {
      FieldLucproperty fieldLucproperty=new FieldLucproperty();
      fieldLucproperty.setFieldName(notAnalyzedIndexField);
      fieldLucproperty.setIndex(true);
      fieldLucproperty.setAnalyzed(false);
      fieldLucproperty.setStore(false);
      fieldPropertyMap.put(notAnalyzedIndexField,fieldLucproperty);
    }
  }
  if (storeFields != null) {
    for (    String storeField : storeFields) {
      if (fieldPropertyMap.containsKey(storeField)) {
        FieldLucproperty fieldLucproperty=fieldPropertyMap.get(storeField);
        fieldLucproperty.setStore(true);
      }
 else {
        FieldLucproperty fieldLucproperty=new FieldLucproperty();
        fieldLucproperty.setFieldName(storeField);
        fieldLucproperty.setIndex(false);
        fieldLucproperty.setAnalyzed(false);
        fieldLucproperty.setStore(true);
        fieldPropertyMap.put(storeField,fieldLucproperty);
      }
    }
  }
  return fieldPropertyMap;
}
', '[]', '03ca9190cba74fc98cdc041211986eea');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'DateJsonValueProcessor', null, 'com.wind.myLuence.index.DateJsonValueProcessor', '', 'public;', null, '1', 'public DateJsonValueProcessor(String format){
  this.format=format;
}
', '[String format]', '93e642a6ff484992a4c182c465b3fa7c');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'processArrayValue', null, 'com.wind.myLuence.index.DateJsonValueProcessor', 'Object', '@Override;public;', null, '0', '@Override public Object processArrayValue(Object arg0,JsonConfig arg1){
  return processObjectValue(null,arg0,arg1);
}
', '[Object arg0, JsonConfig arg1]', 'a9ba0168a42e4f4eb01377ddb528a129');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'processObjectValue', null, 'com.wind.myLuence.index.DateJsonValueProcessor', 'Object', '@Override;public;', null, '0', '@Override public Object processObjectValue(String key,Object value,JsonConfig arg2){
  if (value == null) {
    return "";
  }
  if (value instanceof java.sql.Timestamp) {
    String str=new SimpleDateFormat(format).format((java.sql.Timestamp)value);
    return str;
  }
  if (value instanceof java.util.Date) {
    String str=new SimpleDateFormat(format).format((java.util.Date)value);
    return str;
  }
  return value.toString();
}
', '[String key, Object value, JsonConfig arg2]', 'b0ff710c61be413abe18341cfc4b4079');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'write', null, 'com.wind.myLuence.Index', 'void', 'public;', null, '0', 'public void write(List<Object> datas) throws IndexException ;
', '[List<Object> datas]', '9cdc90c467e04713b541f4881e90ebbd');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'append', null, 'com.wind.myLuence.Index', 'void', 'public;', null, '0', 'public void append(List<Object> datas) throws IndexException ;
', '[List<Object> datas]', '27fe5f4fa6874f2c9f98ece584a1dafd');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'remove', null, 'com.wind.myLuence.Index', 'void', 'public;', null, '0', 'public void remove() throws IndexException ;
', '[]', '3eb73edd0d7c463886d18b1a4791f1ce');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'FieldLucproperty', null, 'com.wind.myLuence.FieldLucproperty', '', 'public;', null, '1', 'public FieldLucproperty(){
}
', '[]', 'b1f27f70646a4eb88e5d5b780f9c586e');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getFieldName', null, 'com.wind.myLuence.FieldLucproperty', 'String', 'public;', null, '0', 'public String getFieldName(){
  return fieldName;
}
', '[]', '8e6cc5f7d2004f4bae2cdad3eb7ce84d');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'setFieldName', null, 'com.wind.myLuence.FieldLucproperty', 'void', 'public;', null, '0', 'public void setFieldName(String fieldName){
  this.fieldName=fieldName;
}
', '[String fieldName]', 'd2b22b5dd1114ed2977ee4c90132cdb8');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'isStore', null, 'com.wind.myLuence.FieldLucproperty', 'boolean', 'public;', null, '0', 'public boolean isStore(){
  return isStore;
}
', '[]', 'fc640ae4ec0e413ca8c96d3209238c7a');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'setStore', null, 'com.wind.myLuence.FieldLucproperty', 'void', 'public;', null, '0', 'public void setStore(boolean isStore){
  this.isStore=isStore;
}
', '[boolean isStore]', '6a584526cdba48298e50dcb6c24bb0b3');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'isIndex', null, 'com.wind.myLuence.FieldLucproperty', 'boolean', 'public;', null, '0', 'public boolean isIndex(){
  return isIndex;
}
', '[]', '3901466091d94eab9c4a16b52cf8d8fd');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'setIndex', null, 'com.wind.myLuence.FieldLucproperty', 'void', 'public;', null, '0', 'public void setIndex(boolean isIndex){
  this.isIndex=isIndex;
}
', '[boolean isIndex]', '36afedef7ec24ca9b727bc943b586264');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'isAnalyzed', null, 'com.wind.myLuence.FieldLucproperty', 'boolean', 'public;', null, '0', 'public boolean isAnalyzed(){
  return isAnalyzed;
}
', '[]', 'ce5ff59f541f44f3a0ce9b85c8d1af84');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'setAnalyzed', null, 'com.wind.myLuence.FieldLucproperty', 'void', 'public;', null, '0', 'public void setAnalyzed(boolean isAnalyzed){
  this.isAnalyzed=isAnalyzed;
}
', '[boolean isAnalyzed]', '87ec57e3efdc4410a4bb7ea1930e8898');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'init', null, 'com.wind.myLuence.MyLuence', 'void', 'public;', null, '0', 'public void init() throws IOException, ClassNotFoundException, ConfigurableException {
  indexSourceMap=new HashMap<String,IndexSource>();
  searcherMap=new HashMap<String,AbstarctSearcher>();
  CfFileParser cfFileParser=null;
  if (configPath.contains(".properties")) {
    cfFileParser=new PropertiesCfParser();
  }
 else   if (configPath.contains(".xml")) {
    cfFileParser=new XmlCfParser();
  }
  cfFileParser.setFilePath(configPath);
  Map<String,Context> cfContextMap=cfFileParser.parse();
  itemList.addAll(cfContextMap.keySet());
  for (  String cfContextKey : cfContextMap.keySet()) {
    Context context=cfContextMap.get(cfContextKey);
    IndexSource indexSource=factory.getIxSourceInstance(context.getString(CfFileParser.ConfigItem.INDEXSOURCE.value));
    indexSource.configure(context);
    indexSourceMap.put(cfContextKey,indexSource);
    AbstarctSearcher searcher=factory.getSearcherInstance();
    searcher.configure(context);
    searcherMap.put(cfContextKey,searcher);
  }
}
', '[]', 'ddbd046f1202480187ea4deb130c41fd');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'writeIndex', null, 'com.wind.myLuence.MyLuence', 'void', 'public;', null, '0', 'public void writeIndex(){
  for (  String iSourceKey : indexSourceMap.keySet()) {
    indexSourceMap.get(iSourceKey).InitialDataOpen();
  }
}
', '[]', 'daac8d66e51c480e97bdb162a4d40142');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'writeIndex', null, 'com.wind.myLuence.MyLuence', 'void', 'public;', null, '0', 'public void writeIndex(String item) throws IndexException {
  if (!itemList.contains(item)) {
    throw new IndexException("item doesn''t exist.");
  }
  indexSourceMap.get(item).InitialDataOpen();
}
', '[String item]', 'f24f644134e14183b42f9dca237844aa');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'appendIndex', null, 'com.wind.myLuence.MyLuence', 'void', 'public;', null, '0', 'public void appendIndex(){
  for (  String iSourceKey : indexSourceMap.keySet()) {
    indexSourceMap.get(iSourceKey).IncreaseDataOpen();
  }
}
', '[]', 'b820b23ab1c64231ae62bcd4db1bdf50');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'appendIndex', null, 'com.wind.myLuence.MyLuence', 'void', 'public;', null, '0', 'public void appendIndex(String item) throws IndexException {
  if (!itemList.contains(item)) {
    throw new IndexException("item doesn''t exist.");
  }
  indexSourceMap.get(item).IncreaseDataOpen();
}
', '[String item]', '853b4aed745e47aaa58f7ef1f13e79fe');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'search', null, 'com.wind.myLuence.MyLuence', 'List<T>', 'public;', null, '0', 'public <T>List<T> search(String item,String queryStr,Sort sort,int num) throws SearchException {
  if (!itemList.contains(item)) {
    throw new SearchException("item doesn''t exist.");
  }
  return searcherMap.get(item).search(queryStr,sort,num);
}
', '[String item, String queryStr, Sort sort, int num]', '8dbeb75499c740caa43e7e4ff467d927');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'search', null, 'com.wind.myLuence.MyLuence', 'List<T>', 'public;', null, '0', 'public <T>List<T> search(String item,String[] queryStr,Sort sort,int num) throws SearchException {
  if (!itemList.contains(item)) {
    throw new SearchException("item doesn''t exist.");
  }
  return searcherMap.get(item).search(queryStr,sort,num);
}
', '[String item, String[] queryStr, Sort sort, int num]', '3c6522bd42944119b29eb7ae69a6090a');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'search', null, 'com.wind.myLuence.MyLuence', 'List<T>', 'public;', null, '0', 'public <T>List<T> search(String item,String queryStr,Sort sort,int pageSize,int curPage) throws SearchException {
  if (!itemList.contains(item)) {
    throw new SearchException("item doesn''t exist.");
  }
  return searcherMap.get(item).search(queryStr,sort,pageSize,curPage);
}
', '[String item, String queryStr, Sort sort, int pageSize, int curPage]', '2ad07ad7aec44c53b1cad297ecadf63f');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'Exactsearch', null, 'com.wind.myLuence.MyLuence', 'List<T>', 'public;', null, '0', 'public <T>List<T> Exactsearch(String item,Map<String,List<String>> searchTermMap,Sort sort,int num) throws SearchException {
  if (!itemList.contains(item)) {
    throw new SearchException("item doesn''t exist.");
  }
  return searcherMap.get(item).Exactsearch(searchTermMap,sort,1);
}
', '[String item, Map<String,List<String>> searchTermMap, Sort sort, int num]', '2cdeff96cdd247b9ba7798d29f61154a');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'search', null, 'com.wind.myLuence.MyLuence', 'List<T>', 'public;', null, '0', 'public <T>List<T> search(String item,String[] queryStr,Sort sort,int pageSize,int curPage) throws SearchException {
  if (!itemList.contains(item)) {
    throw new SearchException("item doesn''t exist.");
  }
  return searcherMap.get(item).search(queryStr,sort,pageSize,curPage);
}
', '[String item, String[] queryStr, Sort sort, int pageSize, int curPage]', '2855fb39a10749fd80726e558cfe320d');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getConfigPath', null, 'com.wind.myLuence.MyLuence', 'String', 'public;', null, '0', 'public String getConfigPath(){
  return configPath;
}
', '[]', 'c6746adac4af4352a932cb8e0758bd02');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'setConfigPath', null, 'com.wind.myLuence.MyLuence', 'void', 'public;', null, '0', 'public void setConfigPath(String configPath){
  this.configPath=configPath;
}
', '[String configPath]', '36fe1187815f4e959b8c0f60de372560');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getFactory', null, 'com.wind.myLuence.MyLuence', 'MyLuenceFactory', 'public;', null, '0', 'public MyLuenceFactory getFactory(){
  return factory;
}
', '[]', '2cde15b58309479d88d17dae0ce006e6');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'setFactory', null, 'com.wind.myLuence.MyLuence', 'void', 'public;', null, '0', 'public void setFactory(MyLuenceFactory factory){
  this.factory=factory;
}
', '[MyLuenceFactory factory]', '645876f226844e57a89ac59fc980f619');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'parse', null, 'com.wind.myLuence.PropertyParser', 'Map<String,String>', 'public;static;', null, '0', 'public static Map<String,String> parse(String filePath) throws IOException {
  Properties prop=new Properties();
  prop.load(PropertyParser.class.getResourceAsStream(filePath));
  Map<String,String> configs=new HashMap<String,String>();
  Enumeration<?> keys=prop.keys();
  while (keys.hasMoreElements()) {
    String key=(String)keys.nextElement();
    String value=(String)prop.get(key);
    configs.put(key,value);
  }
  return configs;
}
', '[String filePath]', '303397b2efb04a52917d9e31cc28a6bd');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'main', null, 'com.wind.myLuence.PropertyParser', 'void', 'public;static;', null, '0', 'public static void main(String[] args){
  try {
    Map<String,String> map=PropertyParser.parse("/data/lucence_strategy.properties");
    for (    String key : map.keySet()) {
      System.out.println(key + "@" + map.get(key));
    }
  }
 catch (  IOException e) {
    e.printStackTrace();
  }
}
', '[String[] args]', '71271e1b7922464993635b5ef22a032e');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'search', null, 'com.wind.myLuence.search.AbstarctSearcher', 'List<T>', 'public;abstract;', null, '0', 'public abstract <T>List<T> search(String queryStr,Sort sort,int num);
', '[String queryStr, Sort sort, int num]', 'c3fc7021af954fdbb1c1cb6ed7330ee1');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'search', null, 'com.wind.myLuence.search.AbstarctSearcher', 'List<T>', 'public;abstract;', null, '0', 'public abstract <T>List<T> search(String queryStr,Sort sort,int pageSize,int curPage);
', '[String queryStr, Sort sort, int pageSize, int curPage]', '07dc651e3337498ea410e7b998047fd1');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'search', null, 'com.wind.myLuence.search.AbstarctSearcher', 'List<T>', 'public;abstract;', null, '0', 'public abstract <T>List<T> search(String[] queryStr,Sort sort,int pageSize,int curPage);
', '[String[] queryStr, Sort sort, int pageSize, int curPage]', 'eb8a2e656614450bbf9ec6b2d9d729c7');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'search', null, 'com.wind.myLuence.search.AbstarctSearcher', 'List<T>', 'public;abstract;', null, '0', 'public abstract <T>List<T> search(String[] queryStrs,Sort sort,int num);
', '[String[] queryStrs, Sort sort, int num]', '7fc5f5528d5a43aca0c41acd20a7ebed');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'Exactsearch', null, 'com.wind.myLuence.search.AbstarctSearcher', 'List<T>', 'public;abstract;', null, '0', 'public abstract <T>List<T> Exactsearch(Map<String,List<String>> searchTermMap,Sort sort,int num);
', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', 'af8b8d38c62e401c8db8dbe8e821ac9f');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getAnalyzer', null, 'com.wind.myLuence.search.AbstarctSearcher', 'Analyzer', 'public;', null, '0', 'public Analyzer getAnalyzer(){
  return analyzer;
}
', '[]', 'e51078bed3634d1399c0810c0f5bc24e');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'setAnalyzer', null, 'com.wind.myLuence.search.AbstarctSearcher', 'void', 'public;', null, '0', 'public void setAnalyzer(Analyzer analyzer){
  this.analyzer=analyzer;
}
', '[Analyzer analyzer]', '1accc1249a2d4374bda0f7e505315f70');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'search', null, 'com.wind.myLuence.search.BeanSearcher', 'List<T>', '@SuppressWarnings("unchecked");@Override;public;', null, '0', '@SuppressWarnings("unchecked") @Override public <T>List<T> search(String queryStr,Sort sort,int num){
  List<T> results=new ArrayList<T>();
  try {
    IndexSearcher searcher=new IndexSearcher(DirectoryReader.open(directory));
    MultiFieldQueryParser parser=new MultiFieldQueryParser(Version.LUCENE_46,analyzedIndexKeys.toArray(new String[]{}),analyzer);
    Query q=parser.parse(queryStr);
    TopDocs topDocs=searcher.search(q,num);
    ScoreDoc[] dosList=topDocs.scoreDocs;
    for (int i=0; i < dosList.length; i++) {
      Document doc=searcher.doc(dosList[i].doc);
      if (hasDataKey) {
        String objJson=doc.get(DATAFIELDNAME_DEFAULT);
        T t=(T)JSONObject.toBean(JSONObject.fromObject(objJson),clazz);
        results.add(t);
      }
 else {
        T t=(T)clazz.newInstance();
        for (        String storeKey : storeKeys) {
          String value=doc.get(storeKey);
          Map<String,String> fieldNameTypes=getFieldNameType(clazz);
          setFieldValue(clazz,storeKey,value,fieldNameTypes.get(storeKey),t);
        }
        results.add(t);
      }
    }
  }
 catch (  ParseException e) {
    logger.error(e.getMessage(),e);
  }
catch (  IOException e) {
    logger.error(e.getMessage(),e);
  }
catch (  Exception e) {
    logger.error(e.getMessage(),e);
  }
  return results;
}
', '[String queryStr, Sort sort, int num]', '3260dea5de434d358a296ab94de301aa');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'search', null, 'com.wind.myLuence.search.BeanSearcher', 'List<T>', '@SuppressWarnings("unchecked");@Override;public;', null, '0', '@SuppressWarnings("unchecked") @Override public <T>List<T> search(String[] queryStrs,Sort sort,int num){
  List<T> results=new ArrayList<T>();
  try {
    IndexSearcher searcher=new IndexSearcher(DirectoryReader.open(directory));
    MultiFieldQueryParser parser=new MultiFieldQueryParser(Version.LUCENE_46,analyzedIndexKeys.toArray(new String[]{}),analyzer);
    for (    String queryStr : queryStrs) {
      Query q=parser.parse(queryStr);
      TopDocs topDocs=searcher.search(q,num);
      ScoreDoc[] dosList=topDocs.scoreDocs;
      for (int i=0; i < dosList.length; i++) {
        Document doc=searcher.doc(dosList[i].doc);
        if (hasDataKey) {
          String objJson=doc.get(DATAFIELDNAME_DEFAULT);
          T t=(T)JSONObject.toBean(JSONObject.fromObject(objJson),clazz);
          results.add(t);
        }
 else {
          T t=(T)clazz.newInstance();
          for (          String storeKey : storeKeys) {
            String value=doc.get(storeKey);
            Map<String,String> fieldNameTypes=getFieldNameType(clazz);
            setFieldValue(clazz,storeKey,value,fieldNameTypes.get(storeKey),t);
          }
          results.add(t);
        }
      }
    }
  }
 catch (  ParseException e) {
    logger.error(e.getMessage(),e);
  }
catch (  IOException e) {
    logger.error(e.getMessage(),e);
  }
catch (  Exception e) {
    logger.error(e.getMessage(),e);
  }
  return results;
}
', '[String[] queryStrs, Sort sort, int num]', '7abfb0acafa14bb9906582ef84a8f04a');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'search', null, 'com.wind.myLuence.search.BeanSearcher', 'List<T>', '@SuppressWarnings("unchecked");@Override;public;', null, '0', '@SuppressWarnings("unchecked") @Override public <T>List<T> search(String queryStr,Sort sort,int pageSize,int curPage){
  List<T> results=new ArrayList<T>();
  try {
    IndexSearcher searcher=new IndexSearcher(DirectoryReader.open(directory));
    MultiFieldQueryParser parser=new MultiFieldQueryParser(Version.LUCENE_46,analyzedIndexKeys.toArray(new String[]{}),analyzer);
    Query q=parser.parse(queryStr);
    TopDocs topDocs=searcher.search(q,3000);
    ScoreDoc[] dosList=topDocs.scoreDocs;
    int begin=pageSize * (curPage - 1);
    int end=Math.min(begin + pageSize,dosList.length);
    for (int i=begin; i < end; i++) {
      Document doc=searcher.doc(dosList[i].doc);
      if (hasDataKey) {
        String objJson=doc.get(DATAFIELDNAME_DEFAULT);
        T t=(T)JSONObject.toBean(JSONObject.fromObject(objJson),clazz);
        results.add(t);
      }
 else {
        T t=(T)clazz.newInstance();
        for (        String storeKey : storeKeys) {
          String value=doc.get(storeKey);
          Map<String,String> fieldNameTypes=getFieldNameType(clazz);
          setFieldValue(clazz,storeKey,value,fieldNameTypes.get(storeKey),t);
        }
        results.add(t);
      }
    }
  }
 catch (  ParseException e) {
    logger.error(e.getMessage(),e);
  }
catch (  IOException e) {
    logger.error(e.getMessage(),e);
  }
catch (  Exception e) {
    logger.error(e.getMessage(),e);
  }
  return results;
}
', '[String queryStr, Sort sort, int pageSize, int curPage]', '2db49308635a43a49acb038293dc5886');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'search', null, 'com.wind.myLuence.search.BeanSearcher', 'List<T>', '@SuppressWarnings("unchecked");@Override;public;', null, '0', '@SuppressWarnings("unchecked") @Override public <T>List<T> search(String[] queryStr,Sort sort,int pageSize,int curPage){
  List<T> results=new ArrayList<T>();
  try {
    IndexSearcher searcher=new IndexSearcher(DirectoryReader.open(directory));
    BooleanQuery Bquery=new BooleanQuery();
    MultiFieldQueryParser parser=new MultiFieldQueryParser(Version.LUCENE_46,analyzedIndexKeys.toArray(new String[]{}),analyzer);
    for (int i=0; i < queryStr.length; i++) {
      Query query=parser.parse(queryStr[i]);
      Bquery.add(query,BooleanClause.Occur.SHOULD);
    }
    TopDocs topDocs=searcher.search(Bquery,3000);
    ScoreDoc[] dosList=topDocs.scoreDocs;
    int begin=pageSize * (curPage - 1);
    int end=Math.min(begin + pageSize,dosList.length);
    for (int i=begin; i < end; i++) {
      Document doc=searcher.doc(dosList[i].doc);
      if (hasDataKey) {
        String objJson=doc.get(DATAFIELDNAME_DEFAULT);
        T t=(T)JSONObject.toBean(JSONObject.fromObject(objJson),clazz);
        results.add(t);
      }
 else {
        T t=(T)clazz.newInstance();
        for (        String storeKey : storeKeys) {
          String value=doc.get(storeKey);
          Map<String,String> fieldNameTypes=getFieldNameType(clazz);
          setFieldValue(clazz,storeKey,value,fieldNameTypes.get(storeKey),t);
        }
        results.add(t);
      }
    }
  }
 catch (  ParseException e) {
    logger.error(e.getMessage(),e);
  }
catch (  Exception e) {
    logger.error(e.getMessage(),e);
  }
  return results;
}
', '[String[] queryStr, Sort sort, int pageSize, int curPage]', 'b3ff965a4ce74e999c808f55de6b0c5d');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'Exactsearch', null, 'com.wind.myLuence.search.BeanSearcher', 'List<T>', '@SuppressWarnings("unchecked");@Override;public;', null, '0', '@SuppressWarnings("unchecked") @Override public <T>List<T> Exactsearch(Map<String,List<String>> searchTermMap,Sort sort,int num){
  List<T> results=new ArrayList<T>();
  try {
    if (!notAnalyzedIndexKeys.containsAll(searchTermMap.keySet())) {
      throw new SearchException("search key collection don''t exist.");
    }
    IndexSearcher searcher=new IndexSearcher(DirectoryReader.open(directory));
    for (    String searchKey : searchTermMap.keySet()) {
      List<String> searchTermList=searchTermMap.get(searchKey);
      for (      String searchTerm : searchTermList) {
        Query query=new TermQuery(new Term(searchKey,searchTerm));
        TopDocs topDocs=searcher.search(query,num);
        ScoreDoc[] dosList=topDocs.scoreDocs;
        for (int i=0; i < dosList.length; i++) {
          Document doc=searcher.doc(dosList[i].doc);
          if (hasDataKey) {
            String objJson=doc.get(DATAFIELDNAME_DEFAULT);
            T t=(T)JSONObject.toBean(JSONObject.fromObject(objJson),clazz);
            results.add(t);
          }
 else {
            T t=(T)clazz.newInstance();
            for (            String storeKey : storeKeys) {
              String value=doc.get(storeKey);
              Map<String,String> fieldNameTypes=getFieldNameType(clazz);
              setFieldValue(clazz,storeKey,value,fieldNameTypes.get(storeKey),t);
            }
            results.add(t);
          }
        }
      }
    }
  }
 catch (  ParseException e) {
    logger.error(e.getMessage(),e);
  }
catch (  Exception e) {
    logger.error(e.getMessage(),e);
  }
  return results;
}
', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '37ea6c20d2d445ca9c68b3e8ab314fb2');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'configure', null, 'com.wind.myLuence.search.BeanSearcher', 'void', 'public;', null, '0', 'public void configure(Context context) throws ConfigurableException {
  try {
    String analyzerClass=context.getString(ANALYZERCLASS);
    this.analyzer=(Analyzer)Class.forName(analyzerClass).newInstance();
    List<String> pojoFields=new ArrayList<String>();
    String className=context.getString(CLASSNAME);
    try {
      this.clazz=Class.forName(className);
      getPojoFileds(pojoFields,clazz);
    }
 catch (    ClassNotFoundException e1) {
      logger.error("bean class error to create.");
      throw new ConfigurableException(e1.getMessage(),e1);
    }
    String analyzedIndexFields=context.getString(ANALYZEDINDEXFIELDS);
    if (analyzedIndexFields != null && !analyzedIndexFields.isEmpty()) {
      List<String> analyzedIndexFieldList=new ArrayList<String>(Arrays.asList(analyzedIndexFields.split(",")));
      if (!pojoFields.containsAll(analyzedIndexFieldList)) {
        logger.error("indexField''s range beyong the range of pojoFields");
        throw new ConfigurableException("indexField''s range beyong the range of pojoFields");
      }
      analyzedIndexKeys.addAll(analyzedIndexFieldList);
    }
    String notAnalyzedIndexFields=context.getString(NOTANALYZEDINDEXFIELDS);
    if (notAnalyzedIndexFields != null && !notAnalyzedIndexFields.isEmpty()) {
      List<String> notAnalyzedIndexFieldList=new ArrayList<String>(Arrays.asList(notAnalyzedIndexFields.split(",")));
      if (!pojoFields.containsAll(notAnalyzedIndexFieldList)) {
        logger.error("notAnalyzedIndexFields''s range beyong the range of pojoFields");
        throw new ConfigurableException("notAnalyzedIndexFields''s range beyong the range of pojoFields");
      }
      notAnalyzedIndexKeys.addAll(notAnalyzedIndexFieldList);
    }
    String storeFields=context.getString(STOREFIELDS);
    if (storeFields != null && !storeFields.isEmpty()) {
      List<String> storeFieldList=new ArrayList<String>(Arrays.asList(storeFields.split(",")));
      if (!pojoFields.containsAll(storeFieldList) && !storeFieldList.contains(DATAFIELDNAME_DEFAULT)) {
        logger.error("storeFields''s range beyong the range of pojoFields");
        throw new ConfigurableException("storeFields''s range beyong the range of pojoFields");
      }
      storeKeys.addAll(storeFieldList);
    }
    if (storeKeys.contains(DATAFIELDNAME_DEFAULT)) {
      hasDataKey=true;
    }
    String indexFilePath=context.getString(INDEXFILEPATH);
    if (indexFilePath == null || indexFilePath.isEmpty()) {
      logger.error("indexFilePath must to be set.");
      throw new ConfigurableException("indexFilePath must to be set.");
    }
    try {
      this.directory=FSDirectory.open(new File(indexFilePath));
    }
 catch (    IOException e) {
      logger.error("index file dir error to create.");
      throw new ConfigurableException("index file dir error to create.");
    }
  }
 catch (  InstantiationException e2) {
    Log.error(this.getClass(),e2.getMessage());
    throw new ConfigurableException(e2.getMessage(),e2);
  }
catch (  IllegalAccessException e2) {
    Log.error(this.getClass(),e2.getMessage());
    throw new ConfigurableException(e2.getMessage(),e2);
  }
catch (  ClassNotFoundException e2) {
    Log.error(this.getClass(),e2.getMessage());
    throw new ConfigurableException(e2.getMessage(),e2);
  }
}
', '[Context context]', '214a347fcf344ba18796217b640e18aa');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getPojoFileds', null, 'com.wind.myLuence.search.BeanSearcher', 'void', 'private;', null, '0', '/** 
 * ??????????
 * @param fields
 * @param clazz
 */
private void getPojoFileds(List<String> fields,Class<?> clazz){
  Method[] methods=clazz.getDeclaredMethods();
  for (  Method m : methods) {
    String name=m.getName();
    if (name.startsWith("get")) {
      String returnValueType=m.getReturnType().getSimpleName();
      if ("String".equals(returnValueType) || "Integer".equals(returnValueType) || "Long".equals(returnValueType)|| "Double".equals(returnValueType)|| "Float".equals(returnValueType)|| "Boolean".equals(returnValueType)|| "Short".equalsIgnoreCase(returnValueType)|| "Date".equals(returnValueType)|| "Timestamp".equals(returnValueType)|| "HashMap".equals(returnValueType)|| "ArrayList".equals(returnValueType)) {
        name=name.substring(3,4).toLowerCase() + name.substring(4);
      }
 else {
        getPojoFileds(fields,m.getReturnType());
      }
      fields.add(name);
    }
  }
}
', '[List<String> fields, Class<?> clazz]', 'f1e6212c19c14e67959b0654fa2206e0');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'setFieldValue', null, 'com.wind.myLuence.search.BeanSearcher', 'void', 'private;', null, '0', 'private void setFieldValue(Class<?> clazz,String fieldName,String fieldvalue,String fieldType,Object data) throws Exception {
  Object relValue=null;
  if ("String".equals(fieldType)) {
    relValue=fieldvalue;
  }
 else   if ("Integer".equals(fieldType)) {
    relValue=Integer.parseInt(fieldvalue);
  }
 else   if ("Long".equals(fieldType)) {
    relValue=Long.parseLong(fieldvalue);
  }
 else   if ("Double".equals(fieldType)) {
    relValue=Double.parseDouble(fieldvalue);
  }
 else   if ("Float".equals(fieldType)) {
    relValue=Float.parseFloat(fieldvalue);
  }
 else   if ("Boolean".equals(fieldType)) {
    relValue=Boolean.parseBoolean(fieldvalue);
  }
 else   if ("Short".equalsIgnoreCase(fieldType)) {
    relValue=Short.parseShort(fieldvalue);
  }
 else   if ("Date".equals(fieldType)) {
    relValue=DateUtil.parseTime(fieldvalue);
  }
 else   if ("Timestamp".equals(fieldvalue)) {
    relValue=DateUtil.parseTime(fieldvalue);
  }
 else   if ("HashMap".equals(fieldvalue)) {
    relValue=JSONObject.toBean(JSONObject.fromObject(fieldvalue),HashMap.class);
  }
 else   if ("ArrayList".equals(fieldvalue)) {
    relValue=JSONArray.toArray(JSONArray.fromObject(fieldvalue));
  }
  Method m=clazz.getMethod("set" + fieldName.substring(0,1).toUpperCase() + fieldName.substring(1));
  m.invoke(data,relValue);
}
', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '2bbb7ac62bf44b2d9408f23c5aa3b75c');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getFieldNameType', null, 'com.wind.myLuence.search.BeanSearcher', 'Map<String,String>', 'private;', null, '0', 'private Map<String,String> getFieldNameType(Class<?> clazz){
  Map<String,String> fieldNameTypeMap=new HashMap<String,String>();
  Method[] methods=clazz.getDeclaredMethods();
  for (  Method m : methods) {
    String name=m.getName();
    if (name.startsWith("set")) {
      String returnValueType=m.getReturnType().getSimpleName();
      name=name.substring(3,4).toLowerCase() + name.substring(4);
      fieldNameTypeMap.put(name,returnValueType);
    }
  }
  return fieldNameTypeMap;
}
', '[Class<?> clazz]', '6be8bda729064080823baf35e13f4158');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'configure', null, 'com.wind.myLuence.source.BeanSource', 'void', 'public;', null, '0', 'public void configure(Context context) throws ConfigurableException {
}
', '[Context context]', '724ec90413fa4a05ba28fc9dbde9e504');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'open', null, 'com.wind.myLuence.source.BeanSource', 'void', 'public;', null, '0', 'public void open(Index index){
}
', '[Index index]', '6bb769881fed434fbb1ef93db7b1fe68');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'InitialDataOpen', null, 'com.wind.myLuence.source.BeanSource', 'void', '@Override;public;', null, '0', '@Override public void InitialDataOpen(){
}
', '[]', '796a4d83ea884b938831154a1355bc21');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'IncreaseDataOpen', null, 'com.wind.myLuence.source.BeanSource', 'void', '@Override;public;', null, '0', '@Override public void IncreaseDataOpen(){
}
', '[]', '696d42dc4b4e495aba9e9107a628dfda');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'configure', null, 'com.wind.myLuence.source.DDALDatabaseSource', 'void', 'public;', null, '0', 'public void configure(Context context) throws ConfigurableException, ClassNotFoundException {
  String classPath=context.getString(CfFileParser.ConfigItem.BEANCLASS.value);
  pojoClass=Class.forName(classPath);
  String incField=context.getString(CfFileParser.ConfigItem.INCFIELD.value);
  if (incField != null) {
    String indexPath=context.getString(CfFileParser.ConfigItem.INDEXFILEPATH.value);
    String incFieldPath=indexPath + "/inc/fieldLast.txt";
    incFieldRW=new IncFieldRW(incField,new File(incFieldPath),pojoClass);
  }
  String dataFilterStr=context.getString(CfFileParser.ConfigItem.DATAFILTER.value);
  if (dataFilterStr != null) {
    String[] dataFilterArray=dataFilterStr.split(":");
    fieldFilterMap.put(dataFilterArray[0],dataFilterArray[1]);
  }
  index.configure(context);
}
', '[Context context]', '16e13d1900d74ed3bccf3e15c5847972');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'InitialDataOpen', null, 'com.wind.myLuence.source.DDALDatabaseSource', 'void', '@Override;public;', null, '0', '@Override public void InitialDataOpen(){
  DataOrder order=null;
  if (incFieldRW != null) {
    order=new DataOrder(incFieldRW.incFieldName,true);
  }
  List<Condition> filter=new ArrayList<Condition>();
  if (!fieldFilterMap.isEmpty()) {
    for (    String field : fieldFilterMap.keySet()) {
      filter.add(new Condition(field,fieldFilterMap.get(field)));
    }
  }
  asynHelper.query(pojoClass,null,Integer.MAX_VALUE,(filter.isEmpty() ? null : filter),order,new ResListCallback<Object>(){
    @Override public void succeed(    List<Object> datas) throws Exception {
      if (datas != null && !datas.isEmpty() && incFieldRW != null) {
        incFieldRW.writeValue(datas.get(0));
      }
      BeanIndex databaseIndex=(BeanIndex)index;
      databaseIndex.write(datas);
    }
    @Override public void failure(    ResultVO result) throws Exception {
      logger.error(result.getErrorMsg());
    }
  }
);
}
', '[]', 'e56e5076761a47e89cf37d7feeffddcf');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'IncreaseDataOpen', null, 'com.wind.myLuence.source.DDALDatabaseSource', 'void', '@Override;public;', null, '0', '@Override public void IncreaseDataOpen(){
  if (incFieldRW == null) {
    throw new NullPointerException("increase field doesn''t set");
  }
  try {
    List<Condition> filter=new ArrayList<Condition>();
    filter.add(new Condition(incFieldRW.incFieldName,Compares.MORE_THAN,incFieldRW.readValue()));
    if (!fieldFilterMap.isEmpty()) {
      for (      String field : fieldFilterMap.keySet()) {
        filter.add(new Condition(field,fieldFilterMap.get(field)));
      }
    }
    DataOrder order=new DataOrder(incFieldRW.incFieldName,true);
    asynHelper.query(pojoClass,null,filter,order,null,new ResListCallback<Object>(){
      @Override public void succeed(      List<Object> datas) throws Exception {
        if (datas != null && !datas.isEmpty()) {
          incFieldRW.writeValue(datas.get(0));
        }
        BeanIndex databaseIndex=(BeanIndex)index;
        databaseIndex.append(datas);
      }
      @Override public void failure(      ResultVO result) throws Exception {
        logger.error(result.getErrorMsg());
      }
    }
);
  }
 catch (  Exception e) {
    logger.error(e.getMessage(),e);
  }
}
', '[]', '867351b37c70401ebda80a49af552bbd');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getAsynHelper', null, 'com.wind.myLuence.source.DDALDatabaseSource', 'AsynDDALHelper', 'public;', null, '0', 'public AsynDDALHelper getAsynHelper(){
  return asynHelper;
}
', '[]', '1baae31d0f914c9f9b75b68463acd7c6');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'setAsynHelper', null, 'com.wind.myLuence.source.DDALDatabaseSource', 'void', 'public;', null, '0', 'public void setAsynHelper(AsynDDALHelper asynHelper){
  this.asynHelper=asynHelper;
}
', '[AsynDDALHelper asynHelper]', '173b7ccc3e964241b9d5f075216b54af');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'IncFieldRW', null, 'com.wind.myLuence.source.IncFieldRW', '', '', null, '1', 'IncFieldRW(String incFieldName,File incFieldLastStore,Class<?> clazz){
  this.incFieldName=incFieldName;
  this.incFieldLastStore=incFieldLastStore;
  this.clazz=clazz;
}
', '[String incFieldName, File incFieldLastStore, Class<?> clazz]', '3b541b202b2c49809741726d6c897fb5');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'writeValue', null, 'com.wind.myLuence.source.IncFieldRW', 'void', 'protected;', null, '0', '/** 
 * ???????
 * @param clazz
 * @param fieldName
 * @param data
 * @throws Exception
 */
protected void writeValue(Object data) throws Exception {
  String value=null;
  Method m=clazz.getMethod("get" + incFieldName.substring(0,1).toUpperCase() + incFieldName.substring(1));
  String returnValueType=m.getReturnType().getSimpleName();
  Object mValue=m.invoke(data);
  if (mValue != null) {
    if ("Integer".equals(returnValueType) || "Long".equals(returnValueType) || "Short".equalsIgnoreCase(returnValueType)) {
      value=mValue.toString();
    }
 else     if ("Date".equals(returnValueType)) {
      value=TimeFormat.format((Date)mValue);
    }
 else     if ("Timestamp".equals(returnValueType)) {
      value=TimeFormat.format((Timestamp)mValue);
    }
  }
  Map<String,String> map=new HashMap<String,String>();
  map.put(incFieldName,value);
  map.put(FIELDTYPE,returnValueType);
  JSONObjUtil.saveJson2File(new JSONObject(map),incFieldLastStore);
}
', '[Object data]', '993e2d188b244b40adb9ffbfe979ce36');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'readValue', null, 'com.wind.myLuence.source.IncFieldRW', 'Object', 'protected;', null, '0', '/** 
 * ???????
 * @return
 * @throws Exception
 */
protected Object readValue() throws Exception {
  Object result=null;
  if (incFieldLastStore.exists()) {
    String content=JSONObjUtil.getFileJSONContent(incFieldLastStore);
    JSONObject jsonObeject=new JSONObject(content);
    String value=jsonObeject.getString(incFieldName);
    String fieldType=jsonObeject.getString(FIELDTYPE);
    if ("Integer".equals(fieldType)) {
      result=Integer.parseInt(value);
    }
 else     if ("Long".equals(fieldType)) {
      result=Long.parseLong(value);
    }
 else     if ("Short".equals(fieldType)) {
      result=Short.parseShort(value);
    }
 else     if ("Date".equals(fieldType)) {
      result=TimeFormat.parse(value);
    }
 else     if ("Timestamp".equals(fieldType)) {
      result=TimeFormat.parse(value);
    }
  }
  return result;
}
', '[]', 'd7aa5e19611e4a8e9ea543b40f6641b6');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'DateJsonValueProcessor', null, 'com.wind.myLuence.source.DateJsonValueProcessor', '', 'public;', null, '1', 'public DateJsonValueProcessor(String format){
  this.format=format;
}
', '[String format]', '0630680a3bb24b8a9cd4651ebaf9ae85');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'processArrayValue', null, 'com.wind.myLuence.source.DateJsonValueProcessor', 'Object', '@Override;public;', null, '0', '@Override public Object processArrayValue(Object arg0,JsonConfig arg1){
  return processObjectValue(null,arg0,arg1);
}
', '[Object arg0, JsonConfig arg1]', 'e9fecc67a23848a08adba6f5a02bc9bf');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'processObjectValue', null, 'com.wind.myLuence.source.DateJsonValueProcessor', 'Object', '@Override;public;', null, '0', '@Override public Object processObjectValue(String key,Object value,JsonConfig arg2){
  if (value == null) {
    return "";
  }
  if (value instanceof java.sql.Timestamp) {
    String str=new SimpleDateFormat(format).format((java.sql.Timestamp)value);
    return str;
  }
  if (value instanceof java.util.Date) {
    String str=new SimpleDateFormat(format).format((java.util.Date)value);
    return str;
  }
  return value.toString();
}
', '[String key, Object value, JsonConfig arg2]', '86b2838e036f4659a21f6645c15338de');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getIndex', null, 'com.wind.myLuence.source.IndexSource', 'Index', 'public;', null, '0', 'public Index getIndex(){
  return index;
}
', '[]', 'd513c5c8611f476cb07d11e2493e8726');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'setIndex', null, 'com.wind.myLuence.source.IndexSource', 'void', 'public;', null, '0', 'public void setIndex(Index index){
  this.index=index;
}
', '[Index index]', 'ed48a52bfd824bc6bfbef5b925532379');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'getFieldNameType', null, 'com.wind.myLuence.util.ClassUtil', 'Map<String,String>', 'public;static;', null, '0', 'public static Map<String,String> getFieldNameType(Class<?> clazz){
  Map<String,String> fieldNameTypeMap=new HashMap<String,String>();
  if (clazz != null) {
    Field[] fields=clazz.getDeclaredFields();
    for (int j=0; j < fields.length; j++) {
      String fieldName=fields[j].getName();
      String classPath=fields[j].getType().getName();
      fieldNameTypeMap.put(fieldName,classPath);
    }
  }
  return fieldNameTypeMap;
}
', '[Class<?> clazz]', '49579a29b458412b8de9ab5253d0ffb4');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'main', null, 'com.wind.myLuence.util.ClassUtil', 'void', 'public;static;', null, '0', 'public static void main(String[] args) throws ClassNotFoundException {
  Map<String,String> fields=getFieldNameType(Class.forName("com.snail.cloudlevel.app.assistant.res.YdlCrawlStrategy"));
  for (  String field : fields.keySet()) {
    System.out.println(field + "  :" + fields.get(field));
  }
}
', '[String[] args]', '66f38c19e7b14df4814df4f6aab3daf8');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'parseTime', null, 'com.wind.Paint_MyLuence.util.DateUtil', 'Date', 'public;synchronized;static;', null, '0', '/** 
 * ????yyyy-mm-dd HH:mm:ss????????????
 * @param date
 * @return
 * @throws ParseException
 */
public synchronized static Date parseTime(String date) throws ParseException {
  if (date == null || date.isEmpty())   return null;
  Date d=null;
  return TimeFormat.parse(date);
}
', '[String date]', '3f2ac69e0fe84c2086836107e5f8f7b2');
INSERT INTO codegraphtest.methodinfo (projectName, name, javadoc, classname, returnType, modi, throwExceptions, isConstructor, content, methodParameters, id) VALUES ('MyLuence-master', 'timeFormat', null, 'com.wind.Paint_MyLuence.util.DateUtil', 'String', 'public;synchronized;static;', null, '0', '/** 
 * ????????yyyy-mm-dd HH:mm:ss?????????
 * @param date
 * @return
 */
public synchronized static String timeFormat(Date date){
  if (date == null)   return null;
  return TimeFormat.format(date);
}
', '[Date date]', '5f8fbafc9a0747aeb173353250dd5c07');
create table methodinvocationinfo
(
    projectName            text null,
    invocateVariant        text null,
    callMethodName         text null,
    calledMethodName       text null,
    callMethodParameters   text null,
    calledMethodParameters text null,
    callMethodReturnType   text null,
    calledMethodReturnType text null,
    id                     text null
)
    charset = utf8;

INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'prop', 'parse', 'load', '[]', '', 'Map<String,Context>', '', 'b2f51bfcf6d84a8a8f2d09322c3c86eb');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'PropertyParser.class', 'parse', 'getResourceAsStream', '[]', '', 'Map<String,Context>', '', 'f0e4e342fb514bf4b5460db0ac1a10ee');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'this', 'parse', 'getFilePath', '[]', '', 'Map<String,Context>', '', 'ab02a63369964203abf1d117fa212f2b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'prop', 'parse', 'keys', '[]', '', 'Map<String,Context>', '', '7830da9786b74de1ab0d4ad9e76228cb');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'keys', 'parse', 'hasMoreElements', '[]', '', 'Map<String,Context>', '', 'fb6450bb60764229a00da0e6fe4f3623');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'keys', 'parse', 'nextElement', '[]', '', 'Map<String,Context>', '', '524be8301c7248a6b7cd1fd2a5558d3e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'key', 'parse', 'contains', '[]', '', 'Map<String,Context>', '', '27770b1b91cb459d81aed771f319d128');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'cfItemArray', 'parse', 'add', '[]', '', 'Map<String,Context>', '', 'c80d2dc79bd349a0b7bb4f19fef57892');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'key', 'parse', 'split', '[]', '', 'Map<String,Context>', '', '4a9f18a8a669464397eef6ed970c6350');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'prop', 'parse', 'get', '[]', '', 'Map<String,Context>', '', '1dbbe35e02554779b4acf0e3ae44422d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'configs', 'parse', 'put', '[]', '', 'Map<String,Context>', '', '8b04e2ed036844d998be9a12c84e0f9a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'configs', 'parse', 'keySet', '[]', '', 'Map<String,Context>', '', '56344d7c0f6448b08c0185ff227b3969');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'key', 'parse', 'contains', '[]', '', 'Map<String,Context>', '', 'c039a0b7401a40bdb73108807c9f5b6d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'parse', 'put', '[]', '', 'Map<String,Context>', '', '35d2b7b692274ddeaded7afb0fd5045c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'key', 'parse', 'split', '[]', '', 'Map<String,Context>', '', '6f1bcc404309463ba2b7285ec4646093');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'configs', 'parse', 'get', '[]', '', 'Map<String,Context>', '', '22b45d20ca0f41e2bd7c973679113647');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'results', 'parse', 'put', '[]', '', 'Map<String,Context>', '', '33dd95a9ca5d4a6685dc40e21a155545');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Collections', 'Context', 'synchronizedMap', '[]', '', '', '', 'd6319e5b187749c585fdb0f7545a5ab6');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'this', 'Context', 'putAll', '[Map<String,String> paramters]', '', '', '', '5fd93c72905140ccaa7af3daec3251f1');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'parameters', 'clear', 'clear', '[]', '', 'void', '', 'f341255dda8a4f79976390dd3f15ff02');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'parameters', 'putAll', 'putAll', '[Map<String,String> map]', '', 'void', '', 'efe478aa189f42efad637090c60e8e7f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'parameters', 'put', 'put', '[String key, String value]', '', 'void', '', 'd0021832e1ba4a998fc022b1e9b01677');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Boolean', 'getBoolean', 'parseBoolean', '[String key, Boolean defaultValue]', '', 'Boolean', '', 'b5f877f0b33845cb8f177c3c7d4da8da');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'value', 'getBoolean', 'trim', '[String key, Boolean defaultValue]', '', 'Boolean', '', '7cfaaeae51754224b4e3ff63205372f0');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Integer', 'getInteger', 'parseInt', '[String key, Integer defaultValue]', '', 'Integer', '', '4503b5711fcc44b283b63a3e20ade2b4');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'value', 'getInteger', 'trim', '[String key, Integer defaultValue]', '', 'Integer', '', '50cef86661b7457182f7d74f57639db3');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'parameters', 'get', 'get', '[String key, String defaultValue]', '', 'String', '', 'ae0df40ed57d4b59ad9de5d41946644d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Long', 'getLong', 'parseLong', '[String key, Long defaultValue]', '', 'Long', '', '27b6db83de21487b9ff11879d351319e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'value', 'getLong', 'trim', '[String key, Long defaultValue]', '', 'Long', '', '0d6014eeeabe45419607ce8affef9088');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'name', 'getIxSourceInstance', 'isEmpty', '[String name]', '', 'IndexSource', '', 'f7fadd185f2c4cd2a9620e84fcb8e5ea');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'beanFactory', 'getIxSourceInstance', 'getBean', '[String name]', '', 'IndexSource', '', '6d037ef23aa040929dd351d61b7c83a2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'beanFactory', 'getIxSourceInstance', 'getBean', '[String name]', '', 'IndexSource', '', 'a7616dd373f9446692a9151c29e16c27');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'beanFactory', 'getSearcherInstance', 'getBean', '[]', '', 'AbstarctSearcher', '', '2577b6d51327436c91dd49c802806af2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', '2175d34bac7442c5b8ba998374727206');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Class.forName(analyzerClass)', 'configure', 'newInstance', '[Context context]', '', 'void', '', 'ba1ceb89237642a8a4671b6d1428cc8d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Class', 'configure', 'forName', '[Context context]', '', 'void', '', '602f67f69fb04a81bb56518dfc10740e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', '25a03c9db9be4b57b3077656f508380d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Class', 'configure', 'forName', '[Context context]', '', 'void', '', 'e4496817cccc47ebb076aa9e2e666b81');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'configure', 'error', '[Context context]', '', 'void', '', 'f89446cf13fc4b72a08b10949c2b60da');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e1', 'configure', 'getMessage', '[Context context]', '', 'void', '', '2c62bcc9a5a84524980a0d04c0b6441c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', '82edd0b10bd2415da05ae45e92e53b0b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'analyzedIndexFields', 'configure', 'isEmpty', '[Context context]', '', 'void', '', '65e50f3aa61d47cd8b61a9b4bbbbdf43');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Arrays', 'configure', 'asList', '[Context context]', '', 'void', '', 'e9209b83eac245f390a64de0ef5b0e73');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'analyzedIndexFields', 'configure', 'split', '[Context context]', '', 'void', '', 'ab1c2893ecb04df3b9c80353d0a47411');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'pojoFields', 'configure', 'containsAll', '[Context context]', '', 'void', '', 'a0ab4bf86c7f4b7e9996bd70be7bda4c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'configure', 'error', '[Context context]', '', 'void', '', 'ead5ed3897c44ce7871974a5a9b9b5ce');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', '4d52f77b32dc4865b0f6155b9cfb3664');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'notAnalyzedIndexFields', 'configure', 'isEmpty', '[Context context]', '', 'void', '', '19090e3a4dc84acf84e99db233d3c8e2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Arrays', 'configure', 'asList', '[Context context]', '', 'void', '', 'c9dab7ef7a3b42179523e5e6779d54b8');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'notAnalyzedIndexFields', 'configure', 'split', '[Context context]', '', 'void', '', '896f1cfe244e43d8b5ff58f4a7e30838');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'pojoFields', 'configure', 'containsAll', '[Context context]', '', 'void', '', '4346b98da0644eab862195195ba862e6');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'configure', 'error', '[Context context]', '', 'void', '', 'f6784a6eaa2a45a1b13017f0ca2abd0b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', '5b1dd485a6d44b42aac6d892e624d54f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'storeFields', 'configure', 'isEmpty', '[Context context]', '', 'void', '', 'aefb633b79cb4a639138ef80c945c1c0');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Arrays', 'configure', 'asList', '[Context context]', '', 'void', '', '00b5c389037b46b3a5172fb3f2b08c58');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'storeFields', 'configure', 'split', '[Context context]', '', 'void', '', '809ccf7d4030441ab7d88608c7d0185b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'pojoFields', 'configure', 'containsAll', '[Context context]', '', 'void', '', '4b692734a70d47d4a936921aacdf17b7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'this.storeFields', 'configure', 'contains', '[Context context]', '', 'void', '', '68d07bdb36774c8bae3d341190c16930');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'configure', 'error', '[Context context]', '', 'void', '', 'ea3d2df079ed48da90f83394dc024ee5');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'configure', 'error', '[Context context]', '', 'void', '', '4e1eba33ab9444fd89048cde9f647d51');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', '5a368691f6b8489eb92f6df3b89fef01');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'pkFields', 'configure', 'isEmpty', '[Context context]', '', 'void', '', '056a2cabe5154f918ec934e226db51d2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Arrays', 'configure', 'asList', '[Context context]', '', 'void', '', '42d29828678045ac9a0b80e1bafb21d8');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'pkFields', 'configure', 'split', '[Context context]', '', 'void', '', 'd65f70f96ac743f0bbdcad794b85c17a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', '87eb8b39bbf34d2480ad832afed26e3d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexFilePath', 'configure', 'isEmpty', '[Context context]', '', 'void', '', 'e8347c84517d475c86834b9427d44e0d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'configure', 'error', '[Context context]', '', 'void', '', 'd64b69b7752d4e6084d9595ddcb490d8');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'FSDirectory', 'configure', 'open', '[Context context]', '', 'void', '', 'baec596a833949e6b6a9d0c902d18748');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'configure', 'error', '[Context context]', '', 'void', '', 'f04d14ad3db34829a859a625e244a30a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', '8d9f92c49bfa4a0bb7cd112969e2b154');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', 'a5728d28552b48a280383cd2d44cfb96');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Log', 'configure', 'error', '[Context context]', '', 'void', '', '2fd81dfdc5eb443cb1a0d8766e687089');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'this', 'configure', 'getClass', '[Context context]', '', 'void', '', 'a5787c4a4f3a477ca761c065b7aca3ea');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e2', 'configure', 'getMessage', '[Context context]', '', 'void', '', '4f006804e73041c4af06a42045a2616d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e2', 'configure', 'getMessage', '[Context context]', '', 'void', '', '4fe0b545e5d4405eb8bb98fa53ec1c5b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Log', 'configure', 'error', '[Context context]', '', 'void', '', '154bb100593d4eee89b84b21bd95741d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'this', 'configure', 'getClass', '[Context context]', '', 'void', '', '6c80da7e7db341ebb7ff34ef28491776');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e2', 'configure', 'getMessage', '[Context context]', '', 'void', '', '582cf334786b4183a93c3fc4e1c8ef9a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e2', 'configure', 'getMessage', '[Context context]', '', 'void', '', 'f7d4513c92dd42d786984d800ad4625a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Log', 'configure', 'error', '[Context context]', '', 'void', '', 'b4c3ca5145b341deba6ced8938ff3ddd');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'this', 'configure', 'getClass', '[Context context]', '', 'void', '', '5de2aac13f914b26820b24c1fe310318');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e2', 'configure', 'getMessage', '[Context context]', '', 'void', '', '8ed74fd9dd8c42848f043c5a0a6a7a16');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e2', 'configure', 'getMessage', '[Context context]', '', 'void', '', '34eec3f51d754e248f76cfd6284d657d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Log', 'write', 'info', '[List<Object> datas]', '', 'void', '', '53e316ae01db4a97a35ee41a5c4b8d1f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'System', 'write', 'currentTimeMillis', '[List<Object> datas]', '', 'void', '', 'e13f431edb0b4fb4a8501ea29ace6bb7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'datas', 'write', 'isEmpty', '[List<Object> datas]', '', 'void', '', '60752d4ec2ad4844bd83c37d91b1833c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'IndexWriter', 'write', 'isLocked', '[List<Object> datas]', '', 'void', '', 'cdb7932a531848959eff576ae1380efb');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexWriter', 'write', 'deleteAll', '[List<Object> datas]', '', 'void', '', '814949c8f03f44b88aba6fdf2b05804b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexWriter', 'write', 'forceMergeDeletes', '[List<Object> datas]', '', 'void', '', '2237953462534bfdb6f31af89e31b7b0');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexWriter', 'write', 'commit', '[List<Object> datas]', '', 'void', '', '728a2e8d0ebb41d883bcac6d3030d6e2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'pkFieldValueList', 'write', 'add', '[List<Object> datas]', '', 'void', '', 'b9fa0ce65ff94867b6c9eccd8a5ad537');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'id', 'write', 'append', '[List<Object> datas]', '', 'void', '', 'cb497fcaefeb40209b81bcf9bc577be6');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldType', 'write', 'setStored', '[List<Object> datas]', '', 'void', '', 'ffec2e017b1a46eab48d10e6695c7aa9');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldType', 'write', 'setIndexed', '[List<Object> datas]', '', 'void', '', '7d82d757198d4d5282b2fc348c636600');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldType', 'write', 'setTokenized', '[List<Object> datas]', '', 'void', '', '3e7db34062124c839cd05b25e5676ad2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'doc', 'write', 'add', '[List<Object> datas]', '', 'void', '', 'f9095334c46e4e66b7920cdf74fe5127');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'id', 'write', 'substring', '[List<Object> datas]', '', 'void', '', '4b4632f6beea4cd8b081ec8387e550c2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'id', 'write', 'length', '[List<Object> datas]', '', 'void', '', '17a6dcd2fcc441c79aabc6c6e0e32ec8');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldPropertyMap', 'write', 'keySet', '[List<Object> datas]', '', 'void', '', 'b875852c623c46a38656f97751a4b4d4');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldName', 'write', 'equalsIgnoreCase', '[List<Object> datas]', '', 'void', '', '7f3ffc3c900d47048ef0cd59c50e36d2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject.fromObject(data,config)', 'write', 'toString', '[List<Object> datas]', '', 'void', '', 'cbafd26923074433bf6be4cc4f3598e7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject', 'write', 'fromObject', '[List<Object> datas]', '', 'void', '', '4c210efd6329496ba505f0ea897307ac');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldPropertyMap', 'write', 'get', '[List<Object> datas]', '', 'void', '', '84205aa72b7441f688c630f9cc2a5342');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldType', 'write', 'setStored', '[List<Object> datas]', '', 'void', '', 'be8cb62a9fce4b97842ec2ad8a051ff3');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'write', 'isStore', '[List<Object> datas]', '', 'void', '', '6cecacd8b39f41b6ae4e5fc68017b9e8');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldType', 'write', 'setIndexed', '[List<Object> datas]', '', 'void', '', '70d352c8deec4fa59ec257c64e37ead6');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'write', 'isIndex', '[List<Object> datas]', '', 'void', '', '0d6d38bdcd3347a784980f99ec77f923');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldType', 'write', 'setTokenized', '[List<Object> datas]', '', 'void', '', 'a3bec8bacb6e4e8b97ebab0fe2292315');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'write', 'isAnalyzed', '[List<Object> datas]', '', 'void', '', 'd5a021b78e774af2a8e3faf00697efca');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'doc', 'write', 'add', '[List<Object> datas]', '', 'void', '', '13c0de68ea88467da89626d4bdb99321');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexWriter', 'write', 'addDocument', '[List<Object> datas]', '', 'void', '', '80789be654ee42428af9b56dd7304d1a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexWriter', 'write', 'commit', '[List<Object> datas]', '', 'void', '', 'f467c601c36a4f7ab6a31d19160d5c15');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Log', 'write', 'error', '[List<Object> datas]', '', 'void', '', '3dbc7fa1567d4faeb2b7734e3cb1e2fa');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'write', 'getMessage', '[List<Object> datas]', '', 'void', '', 'e4358297decd4e148e167a0bf2872d2a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexWriter', 'write', 'close', '[List<Object> datas]', '', 'void', '', '57a0f851b6f54bb59d6d117f1c25c4e6');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'IndexWriter', 'write', 'unlock', '[List<Object> datas]', '', 'void', '', 'bb541f57a0e541e98ec77ab389adda96');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Log', 'write', 'error', '[List<Object> datas]', '', 'void', '', 'e2bf9cc8ed614582ab1498cdf9c9ce03');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'this', 'write', 'getClass', '[List<Object> datas]', '', 'void', '', '64c7c9c7592c49daaa7d0e9db8b9256f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Log', 'write', 'warn', '[List<Object> datas]', '', 'void', '', 'e241ca7a056247308e214ba429a948a2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'System', 'write', 'currentTimeMillis', '[List<Object> datas]', '', 'void', '', '44c7f537105d43fa93bc6d7b303d8f58');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Log', 'append', 'info', '[List<Object> datas]', '', 'void', '', '453d60ed3fa14b7daef9df0817882f48');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'datas', 'append', 'isEmpty', '[List<Object> datas]', '', 'void', '', '08bf89f891c44b519543fd106d7f4c4f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'System', 'append', 'currentTimeMillis', '[List<Object> datas]', '', 'void', '', 'b07a53f3684448ab9899016c8c4fbbe0');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'IndexWriter', 'append', 'isLocked', '[List<Object> datas]', '', 'void', '', '1497df453c024a489bf8376690eb3de8');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'pkFieldValueList', 'append', 'add', '[List<Object> datas]', '', 'void', '', '76216110e4d54cf08faa61d8782f0a1d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'id', 'append', 'append', '[List<Object> datas]', '', 'void', '', 'e87c4a4b2bd94e06ba9da323d395c588');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldType', 'append', 'setStored', '[List<Object> datas]', '', 'void', '', '70b560db15b947ee9b3b68d996ae28ad');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldType', 'append', 'setIndexed', '[List<Object> datas]', '', 'void', '', '7835c81849a7486e90e3c9f0b0855fb1');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldType', 'append', 'setTokenized', '[List<Object> datas]', '', 'void', '', 'db3aab1f8d864ea699a3ea6f84a162d1');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'doc', 'append', 'add', '[List<Object> datas]', '', 'void', '', '0f3800e8fdd149c9b94dd6cc5522f898');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'id', 'append', 'substring', '[List<Object> datas]', '', 'void', '', '5b7e3be89bdd4053a2df0218b3326811');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'id', 'append', 'length', '[List<Object> datas]', '', 'void', '', 'd8c1edd4f8f147a9b1e54817cebae406');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldPropertyMap', 'append', 'keySet', '[List<Object> datas]', '', 'void', '', '4191dbe8ea5b444ab1aa3ffb9dfcc7ed');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldName', 'append', 'equalsIgnoreCase', '[List<Object> datas]', '', 'void', '', '8c12663b5bb64f7fbd3092dcd60ffca4');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject.fromObject(data,config)', 'append', 'toString', '[List<Object> datas]', '', 'void', '', '87926756514940f38b02e7ea6f7420ab');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject', 'append', 'fromObject', '[List<Object> datas]', '', 'void', '', '5cf6d83ea519489f968f2d6a0beb0a96');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldPropertyMap', 'append', 'get', '[List<Object> datas]', '', 'void', '', '3766000d6d1d4d6b8139aa7d0928ebb4');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldType', 'append', 'setStored', '[List<Object> datas]', '', 'void', '', '7041d4e4df924c759701d041c533aaa5');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'append', 'isStore', '[List<Object> datas]', '', 'void', '', '5c7dfd81a7ef44c287445c604ac95492');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldType', 'append', 'setIndexed', '[List<Object> datas]', '', 'void', '', 'eba7763998d3444d9eb99bc2ceab2895');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'append', 'isIndex', '[List<Object> datas]', '', 'void', '', '6b28c4254ff14be79b0e273af49852bf');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldType', 'append', 'setTokenized', '[List<Object> datas]', '', 'void', '', '2cb6cca9244042d996995bfa654d4378');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'append', 'isAnalyzed', '[List<Object> datas]', '', 'void', '', '24cdc19b51d04b67bd4da451902ecb3c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'doc', 'append', 'add', '[List<Object> datas]', '', 'void', '', '3ddb48fb309a489bb728517d1fcbde6c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexWriter', 'append', 'addDocument', '[List<Object> datas]', '', 'void', '', '15ec3a3577e44856b8409858eb58a6d2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexWriter', 'append', 'forceMerge', '[List<Object> datas]', '', 'void', '', '3ea2fab8a3da46c8b06c91cebc356172');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexWriter', 'append', 'commit', '[List<Object> datas]', '', 'void', '', '156810c9503e4a40a2da422a6b1bbb65');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Log', 'append', 'error', '[List<Object> datas]', '', 'void', '', '1f9e5fca2e7d4837b878a716964aba6c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'append', 'getMessage', '[List<Object> datas]', '', 'void', '', '3bd0aa5d3cd247f49b30244b6d8bcb57');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexWriter', 'append', 'close', '[List<Object> datas]', '', 'void', '', 'd2959e8a7de44909a79a9b962234021b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'IndexWriter', 'append', 'unlock', '[List<Object> datas]', '', 'void', '', '876ff3c986ee48b798157deaba4cb201');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Log', 'append', 'error', '[List<Object> datas]', '', 'void', '', '872a4ac65dad45d08e8644b924e459f9');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'this', 'append', 'getClass', '[List<Object> datas]', '', 'void', '', '9b8dcb493558405eb15bae1433c8d749');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Log', 'append', 'warn', '[List<Object> datas]', '', 'void', '', '703eeae6c99a48ef82266bb3761c8aef');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'System', 'append', 'currentTimeMillis', '[List<Object> datas]', '', 'void', '', '46edfa28f89045b09c62bc3885877173');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'clazz', 'getFieldValue', 'getMethod', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', 'c151125b1568448b9a1e79fdc500a688');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldName.substring(0,1)', 'getFieldValue', 'toUpperCase', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '4d2dd60e50ba47249fb11a94ab054319');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldName', 'getFieldValue', 'substring', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '6fb521cf644e43a3b034eec12c4fbf74');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldName', 'getFieldValue', 'substring', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', 'eeb0a66da861432e8026d646c8f5673f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm.getReturnType()', 'getFieldValue', 'getSimpleName', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '0c667a7e6e42410899e32ff43efd3eff');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm', 'getFieldValue', 'getReturnType', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', 'eaa1bd9c8fe9489bb7261fc09ae216df');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm', 'getFieldValue', 'invoke', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '5aefa5f14eb84dec891f9bdc7b749161');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"String"', 'getFieldValue', 'equals', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '9a9421a40ec249079fb78079c6c90e1f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Integer"', 'getFieldValue', 'equals', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '31950824f39f4963b42a2cd22af08f6d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Long"', 'getFieldValue', 'equals', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', 'b427d0035e944cff82c9c911642d1481');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Double"', 'getFieldValue', 'equals', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', 'ef8704beef244782b0fdd08802bdb4b3');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Float"', 'getFieldValue', 'equals', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '5b2c8830ca0645729cc72b4b19f56096');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Boolean"', 'getFieldValue', 'equals', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '47d9d000f3a84e59ac90a5ccd5f20646');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Short"', 'getFieldValue', 'equalsIgnoreCase', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '993451b8441c4b3982c4604218705019');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'mValue', 'getFieldValue', 'toString', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '0f64537836354aa0bb35744911dbc6cf');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Date"', 'getFieldValue', 'equals', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '1506bb670cdd412a82352df66727e9cd');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'DateUtil', 'getFieldValue', 'timeFormat', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', 'af5abcd9bafb407e8cd13ffc9402d00a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Timestamp"', 'getFieldValue', 'equals', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', 'e93c206a6bb2438da4ca4b0da0094e7c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'DateUtil', 'getFieldValue', 'timeFormat', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '5369d7fbd148485f99480582a180e20c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"HashMap"', 'getFieldValue', 'equals', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '0f88369fb2fa45e9af260f67d1d17c6b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject.fromObject(mValue,config)', 'getFieldValue', 'toString', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', 'b4cb030a371f45b3afcf1835311ac08e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject', 'getFieldValue', 'fromObject', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', 'a90d322be27e44cca07e2388c8582707');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"ArrayList"', 'getFieldValue', 'equals', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '697c0f97bc8e42ad82a5e2a2bdaa7a2f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONArray.fromObject(mValue,config)', 'getFieldValue', 'toString', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '289e194f0f5049f2b9b52792a434770e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONArray', 'getFieldValue', 'fromObject', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', 'fcd39f02d4b24a03a28cc7e8d029cd5c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm', 'getFieldValue', 'getReturnType', '[Class<?> clazz, String fieldName, Object data]', '', 'String', '', '281a58dd600642b8b21f6a55fbb4dda3');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'clazz', 'getPojoFileds', 'getDeclaredMethods', '[List<String> fields, Class<?> clazz]', '', 'void', '', '137a550ab9f248c8a5eda2f2d4ca841b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm', 'getPojoFileds', 'getName', '[List<String> fields, Class<?> clazz]', '', 'void', '', '258276eaa8fe453d9bcc15524e30c123');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'name', 'getPojoFileds', 'startsWith', '[List<String> fields, Class<?> clazz]', '', 'void', '', '63dd95b49f9e40f09f6b4a2393420141');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm.getReturnType()', 'getPojoFileds', 'getSimpleName', '[List<String> fields, Class<?> clazz]', '', 'void', '', '8e867db02e4c4fe3a1f92ce7b4b38304');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm', 'getPojoFileds', 'getReturnType', '[List<String> fields, Class<?> clazz]', '', 'void', '', 'dcc80b184687415084d58347391f817d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"String"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', '80d445c6925741698b91a8f8a7a62e0b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Integer"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', 'c05f475fcb614f269ee01dce18fc6b33');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Long"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', 'fbb5b6270e4d42df80e1e57b8a2f844b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Double"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', '5667be3d830e467eb2de79f821897795');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Float"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', '48bd7c296eab4952b8d92f5ae3542257');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Boolean"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', 'c0543c45c5be4abd8e1f457698fcd2e6');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Short"', 'getPojoFileds', 'equalsIgnoreCase', '[List<String> fields, Class<?> clazz]', '', 'void', '', '685d9f184d884d9ab2889a281ec920c5');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Date"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', '774a31e623a24215a26d4f621a3eed0f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Timestamp"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', '90eccf850c844075b91585126775d05b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"HashMap"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', 'a61caa2ff1f84dd2ae6849d80a0477cd');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"ArrayList"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', '6df53521f7dc45e488a293eedce88bf4');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'name.substring(3,4)', 'getPojoFileds', 'toLowerCase', '[List<String> fields, Class<?> clazz]', '', 'void', '', '0872d52c80e24540a4df97e16264915d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'name', 'getPojoFileds', 'substring', '[List<String> fields, Class<?> clazz]', '', 'void', '', '17f779d4236343fca441ee6427af7226');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'name', 'getPojoFileds', 'substring', '[List<String> fields, Class<?> clazz]', '', 'void', '', '5d2d5b6c6c524db6a29aff355073bc0c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm', 'getPojoFileds', 'getReturnType', '[List<String> fields, Class<?> clazz]', '', 'void', '', 'ffc21050725246708037dd67b2f9084f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fields', 'getPojoFileds', 'add', '[List<String> fields, Class<?> clazz]', '', 'void', '', 'baeb16d52260411d96ea489b95841da3');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'getFieldLucProperty', 'setFieldName', '[]', '', 'Map<String,FieldLucproperty>', '', 'aca6aa26a5d64878917fb4625d5ba62f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'getFieldLucProperty', 'setAnalyzed', '[]', '', 'Map<String,FieldLucproperty>', '', '058d5e76f9a14e5c8933b72dd5649960');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'getFieldLucProperty', 'setStore', '[]', '', 'Map<String,FieldLucproperty>', '', '084f750f7c5b48dd9e98d0a15bb77445');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'getFieldLucProperty', 'setIndex', '[]', '', 'Map<String,FieldLucproperty>', '', '2e7f4534efb448ae94b2494bf1a646ba');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldPropertyMap', 'getFieldLucProperty', 'put', '[]', '', 'Map<String,FieldLucproperty>', '', '68a948796aa54ca29df4a280be2df8cc');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'getFieldLucProperty', 'setFieldName', '[]', '', 'Map<String,FieldLucproperty>', '', '2a36f2d779484003aa524e5374c89ea7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'getFieldLucProperty', 'setIndex', '[]', '', 'Map<String,FieldLucproperty>', '', 'e84fcf75eafb4cbfa714cb35809887eb');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'getFieldLucProperty', 'setAnalyzed', '[]', '', 'Map<String,FieldLucproperty>', '', '656e9d97462649538d02a5e3a26d1fed');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'getFieldLucProperty', 'setStore', '[]', '', 'Map<String,FieldLucproperty>', '', '2bd53d3d177847a5881b50210c4c7cd1');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldPropertyMap', 'getFieldLucProperty', 'put', '[]', '', 'Map<String,FieldLucproperty>', '', 'd0a32fd6231942e5ba27e21f483d105b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldPropertyMap', 'getFieldLucProperty', 'containsKey', '[]', '', 'Map<String,FieldLucproperty>', '', '1b335fa3d15b4c5180d4aa5fbcc1d264');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldPropertyMap', 'getFieldLucProperty', 'get', '[]', '', 'Map<String,FieldLucproperty>', '', '24efcb2ded15489c9fbf95c7d84fa701');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'getFieldLucProperty', 'setStore', '[]', '', 'Map<String,FieldLucproperty>', '', '9ebd478c55e740bfaea41f5b7884d819');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'getFieldLucProperty', 'setFieldName', '[]', '', 'Map<String,FieldLucproperty>', '', '4d9cfb365f084c9f8a3e4e742d4ffef9');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'getFieldLucProperty', 'setIndex', '[]', '', 'Map<String,FieldLucproperty>', '', '531def404eff4ca68b96525f562aeda7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'getFieldLucProperty', 'setAnalyzed', '[]', '', 'Map<String,FieldLucproperty>', '', 'd609d77bbabc4171b5d25cf1fb41d622');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldLucproperty', 'getFieldLucProperty', 'setStore', '[]', '', 'Map<String,FieldLucproperty>', '', '3781b94d0e3247349864be627bd3d259');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldPropertyMap', 'getFieldLucProperty', 'put', '[]', '', 'Map<String,FieldLucproperty>', '', 'ca01af7f59914b1494385329b10a49e6');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'new SimpleDateFormat(format)', 'processObjectValue', 'format', '[String key, Object value, JsonConfig arg2]', '', 'Object', '', '3f8956f402224740a28302992c0edd6e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'new SimpleDateFormat(format)', 'processObjectValue', 'format', '[String key, Object value, JsonConfig arg2]', '', 'Object', '', '63130f5013964ea1bca4ba77af576631');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'value', 'processObjectValue', 'toString', '[String key, Object value, JsonConfig arg2]', '', 'Object', '', '32a9bde5ff914573bdb52f5004f981f8');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'configPath', 'init', 'contains', '[]', '', 'void', '', '7e1e65204031445ba3369d77c2f9d1d3');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'configPath', 'init', 'contains', '[]', '', 'void', '', '479dce77dfba44698f7cb5d64c12c42f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'cfFileParser', 'init', 'setFilePath', '[]', '', 'void', '', 'a69f2d8103e149ee839e4a2a43163b8e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'cfFileParser', 'init', 'parse', '[]', '', 'void', '', '1980585ed9c94aa0a5e6d297ca736dbb');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'itemList', 'init', 'addAll', '[]', '', 'void', '', 'cd04e64ff6354153ac9dddcf69730bf8');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'cfContextMap', 'init', 'keySet', '[]', '', 'void', '', 'da264a6d3e294a0eb531d3a1342e1db4');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'cfContextMap', 'init', 'keySet', '[]', '', 'void', '', '84b21415c01446e9a63da9109a475900');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'cfContextMap', 'init', 'get', '[]', '', 'void', '', 'c56a9d56ab204ed08f84ba87950c2ac3');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'factory', 'init', 'getIxSourceInstance', '[]', '', 'void', '', '9d9a3556a90a4eaa850ccadac2076384');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'init', 'getString', '[]', '', 'void', '', '56d1e3b45c244d44b7b9872ef28da675');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexSource', 'init', 'configure', '[]', '', 'void', '', '245d6d78ba49473a8d9727e3b479eec2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexSourceMap', 'init', 'put', '[]', '', 'void', '', '056ed7a51d62416aa5a59bf0236ad611');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'factory', 'init', 'getSearcherInstance', '[]', '', 'void', '', '3bc3e13fc14f48fba1f89e385dda02ef');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcher', 'init', 'configure', '[]', '', 'void', '', '7fbeed2cac1346d5b263cb22b7b839be');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcherMap', 'init', 'put', '[]', '', 'void', '', 'c5557239f1a64f39a6dee0aa7fcc3a1b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexSourceMap', 'writeIndex', 'keySet', '[]', '', 'void', '', 'b2586b07d1f646408281077153f8daf1');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexSourceMap.get(iSourceKey)', 'writeIndex', 'InitialDataOpen', '[]', '', 'void', '', '0f054cb51dc248c7a13c3abd7b58c4df');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexSourceMap', 'writeIndex', 'get', '[]', '', 'void', '', '3c9ab2cee26c42339464b58f39142cbd');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'itemList', 'writeIndex', 'contains', '[String item]', '', 'void', '', '5aeff399ea1d4b4199a235c0091c23c0');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexSourceMap.get(item)', 'writeIndex', 'InitialDataOpen', '[String item]', '', 'void', '', 'a1670b78d8c1476a8b68962bc8bc280c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexSourceMap', 'writeIndex', 'get', '[String item]', '', 'void', '', '6e94c9e7f13c414e971d3b9213b5d68f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexSourceMap', 'appendIndex', 'keySet', '[]', '', 'void', '', 'c4177bcd5f554e18a498dd04c5a5f535');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexSourceMap.get(iSourceKey)', 'appendIndex', 'IncreaseDataOpen', '[]', '', 'void', '', 'a96e347ab62943b6bbb3a62a05e10c75');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexSourceMap', 'appendIndex', 'get', '[]', '', 'void', '', 'ee576a9cadb54ebf89200a2246872839');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'itemList', 'appendIndex', 'contains', '[String item]', '', 'void', '', '50a0003dba0646fb8866cc0aa6659199');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexSourceMap.get(item)', 'appendIndex', 'IncreaseDataOpen', '[String item]', '', 'void', '', 'dbd41e9187644798b1c8c9c7459a27fe');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexSourceMap', 'appendIndex', 'get', '[String item]', '', 'void', '', 'a72eecddd707439a902e67ca9c76e60d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'itemList', 'search', 'contains', '[String item, String queryStr, Sort sort, int num]', '', 'List<T>', '', '74d0d709ade0425aad51b0144724832c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcherMap.get(item)', 'search', 'search', '[String item, String queryStr, Sort sort, int num]', '', 'List<T>', '', '4030c7826e08480a9b7d22f738ddb341');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcherMap', 'search', 'get', '[String item, String queryStr, Sort sort, int num]', '', 'List<T>', '', '5081c3dbe80247fc9c0242667f356d0d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'itemList', 'search', 'contains', '[String item, String[] queryStr, Sort sort, int num]', '', 'List<T>', '', '40d0bbb90e5a492a94198b0be9763b3d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcherMap.get(item)', 'search', 'search', '[String item, String[] queryStr, Sort sort, int num]', '', 'List<T>', '', 'a5fdce8e47824a64b99dc2eea5cd917a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcherMap', 'search', 'get', '[String item, String[] queryStr, Sort sort, int num]', '', 'List<T>', '', 'eb94b2e906564b0e9bc7234fb9896664');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'itemList', 'search', 'contains', '[String item, String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', 'f045e8ebdb4642bbb307993b5fa7f42f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcherMap.get(item)', 'search', 'search', '[String item, String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', 'ddd667715897404fb50073d8bfd2a429');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcherMap', 'search', 'get', '[String item, String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '0367a602e7264efda0d79f14504ecaf9');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'itemList', 'Exactsearch', 'contains', '[String item, Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', '7edd65e0962c464895ddbcd921c1437c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcherMap.get(item)', 'Exactsearch', 'Exactsearch', '[String item, Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', 'cae88bb9d53644b2b657098694fd0a04');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcherMap', 'Exactsearch', 'get', '[String item, Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', '8d7c14da586b474d86d7181583b0081b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'itemList', 'search', 'contains', '[String item, String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', 'da024d9729234bb5a8f45b7f1090a99a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcherMap.get(item)', 'search', 'search', '[String item, String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '308f2d7c70ca454f9b33f9484eb5acac');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcherMap', 'search', 'get', '[String item, String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '781fab3200bd452a885b34523d541529');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'prop', 'parse', 'load', '[String filePath]', '', 'Map<String,String>', '', 'ded699495ae742e6a61fb12bbe499e30');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'PropertyParser.class', 'parse', 'getResourceAsStream', '[String filePath]', '', 'Map<String,String>', '', '4f158f06e2f54cae9783bb545b1d5be6');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'prop', 'parse', 'keys', '[String filePath]', '', 'Map<String,String>', '', '222718349bd34a20aa00c3b1e4c8b8f7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'keys', 'parse', 'hasMoreElements', '[String filePath]', '', 'Map<String,String>', '', 'ae7d76172fd348d0970ce94c3a3d8e7c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'keys', 'parse', 'nextElement', '[String filePath]', '', 'Map<String,String>', '', '32cb46fd1aca4b3fb955a2034d3c8732');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'prop', 'parse', 'get', '[String filePath]', '', 'Map<String,String>', '', 'f6ef9306bdea4092861f5e9d77f1f47a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'configs', 'parse', 'put', '[String filePath]', '', 'Map<String,String>', '', 'c3d6dbc507604a0ab7ce794ce7ee37b7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'PropertyParser', 'main', 'parse', '[String[] args]', '', 'void', '', 'f95c7090749e4fe5be346f71e11bd8ce');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'map', 'main', 'keySet', '[String[] args]', '', 'void', '', 'eb4650d3385947a1afdb1ca4321dc689');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'System.out', 'main', 'println', '[String[] args]', '', 'void', '', '3ed66c9e974c45bfb49407bab8408f61');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'map', 'main', 'get', '[String[] args]', '', 'void', '', '51231a99f53248c0ace570c1e719a585');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'main', 'printStackTrace', '[String[] args]', '', 'void', '', '56a939909d0545a3a8aba06b911607a6');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'DirectoryReader', 'search', 'open', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', 'dc70bb74efbc44418bcad3aeb4691dd9');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'analyzedIndexKeys', 'search', 'toArray', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', 'cd4405223d15499d926bdf86c3f1a4f5');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'parser', 'search', 'parse', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', 'b3cbe5b2f7c641f7b7649d43ddef5509');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcher', 'search', 'search', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', '91188944c11543fda7b482eb80731bf5');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcher', 'search', 'doc', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', '3fe7d618e4624586842dc750d50e7480');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'doc', 'search', 'get', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', '21c6fb0c2e4942f391bf3b97905d6d26');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject', 'search', 'toBean', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', '4f0677f5b13f402490e6f77c8f6550fd');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject', 'search', 'fromObject', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', '4b3a37f577b04ca79405892dbb252701');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'results', 'search', 'add', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', '7671dd25691e4d4a977927ff122bb634');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'clazz', 'search', 'newInstance', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', 'f41f92e1d6dc4e198ef0044acb12d4d0');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'doc', 'search', 'get', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', 'e257c9352b1c461abf09c659cce279f7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldNameTypes', 'search', 'get', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', '8d35c8cebce24322bcdcde6e029477d7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'results', 'search', 'add', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', 'e83d1fed83614e9d88b671afa07e30cc');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'search', 'error', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', '23b8fabece21498ea06ae500a0344d5f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'search', 'getMessage', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', '2655fdc4ab2446c7bfd567b2fab2ce91');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'search', 'error', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', '6e5b6330eca643768bdb205f0dbfe6f6');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'search', 'getMessage', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', 'a1ea5821cbb3464d951786498202379d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'search', 'error', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', '7b122678eceb4beb8278260dc77b92d1');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'search', 'getMessage', '[String queryStr, Sort sort, int num]', '', 'List<T>', '', '5f82df6b530b4484ae619d41675a6007');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'DirectoryReader', 'search', 'open', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', 'cbe10ff82dc54a05b6d0672bef809f0c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'analyzedIndexKeys', 'search', 'toArray', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', '8a453d948dab449ab2616cfd6721a57b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'parser', 'search', 'parse', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', '037d7e054e9f49638d9721628240b7ce');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcher', 'search', 'search', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', '09552b28f38d4778a237e2adfacc0ab7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcher', 'search', 'doc', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', '1732be86b2124de28c7be62ea5cbe75c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'doc', 'search', 'get', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', 'e04782a27dd345bc8ff0f6bd0a18fd4b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject', 'search', 'toBean', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', 'c91ac8232178440c8d0dde4046e6094b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject', 'search', 'fromObject', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', '8111781c713741baac5354ab0e8cf5c2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'results', 'search', 'add', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', 'efe6c67d6c4f45d498e8b7e072d3ffe6');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'clazz', 'search', 'newInstance', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', '7288f3680f4943a38cc1b0bbb4c98972');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'doc', 'search', 'get', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', '40ccaad5225d4d438a3d6370cf075d1c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldNameTypes', 'search', 'get', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', '09608364f20146939046f68f0a04558c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'results', 'search', 'add', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', 'ac9fe4ba4407494db086bb91e4b0549e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'search', 'error', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', 'd183a0dfde9448eda748d0b4a397fa34');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'search', 'getMessage', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', '58c1deefa0994afa91fb87815868e45e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'search', 'error', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', '629ff816694e49b5aeb8e126acecc4c0');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'search', 'getMessage', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', '3bfe1cd33ae8426a9b2ee263e7744c76');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'search', 'error', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', '27286f8562ad47d6b9d8173782c7f048');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'search', 'getMessage', '[String[] queryStrs, Sort sort, int num]', '', 'List<T>', '', '3287917706ef4d238e9c5eb2490fd2f3');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'DirectoryReader', 'search', 'open', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '7f9452ded8c1424985746eb38a3f0df1');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'analyzedIndexKeys', 'search', 'toArray', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', 'c72ecec520014c07be09127261695b73');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'parser', 'search', 'parse', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '3414b0aaf00644e1af01c98dc8529d22');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcher', 'search', 'search', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '6efe7ec6c1274905b718dcf1d5ffbc43');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Math', 'search', 'min', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '0d1b3e3c57624aca84b517e64ba3fcc7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcher', 'search', 'doc', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '6f5a3f86f72a487db922b4949611cb53');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'doc', 'search', 'get', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', 'a30df14fe3c34f21a001b106f917467d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject', 'search', 'toBean', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '679fdd7f4d484b84b8a9e884569ab54f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject', 'search', 'fromObject', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '8c91a46c37794eb09583b708374bf2ec');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'results', 'search', 'add', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '4f1028f93f8a447caa490eca4e8c41e5');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'clazz', 'search', 'newInstance', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '08ab54806e254e73bc7693c958ecf3bf');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'doc', 'search', 'get', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '412cebfadd75498c8fa91b4d6e495bea');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldNameTypes', 'search', 'get', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '1435c9308fd940b39d40a93d303a981e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'results', 'search', 'add', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '6e6df6282be24b0eafa359b10c54910d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'search', 'error', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', 'be1a98f9feea42d3a9ae050ea45f913a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'search', 'getMessage', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', 'e3edcda1866941aebdbd8daf55dbb621');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'search', 'error', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '8bee2f793123401b9b9dfa6f38a9b316');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'search', 'getMessage', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '6c84359f830c44459e6782a913e7fc3f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'search', 'error', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '334016ba6cef40498c286c15901c4971');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'search', 'getMessage', '[String queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '9b66109bea5f4d4f8e7d913f22f07b33');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'DirectoryReader', 'search', 'open', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '7bfbc1cc94734a3eb72f7ca6303491aa');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'analyzedIndexKeys', 'search', 'toArray', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '347de1f93e60432b85147710aa79c694');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'parser', 'search', 'parse', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '224fd592eea040d1a71621effffa8bee');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Bquery', 'search', 'add', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '4fd951fdf5b143659c39f8bbf5296730');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcher', 'search', 'search', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '3631240c0d7d4718ab0928fc0fafe319');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Math', 'search', 'min', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', 'f92d342dcbe7496a9e19046085291095');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcher', 'search', 'doc', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', 'dcb610bdb40844e5b9138e1c75a4c882');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'doc', 'search', 'get', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '2740f4eac32c4db18a2f15effbc329f4');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject', 'search', 'toBean', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '890e1fd691304e839524827de9d05de7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject', 'search', 'fromObject', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '358db2bff45a4a2eb4586748a5cb064e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'results', 'search', 'add', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', 'bfd7839cf97f4f87b18f9ef5b50201fc');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'clazz', 'search', 'newInstance', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '2b9f28a120c44adeb1e5a2ef2a589fd1');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'doc', 'search', 'get', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '5edd2c098c8b49c6b0d8017da2482239');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldNameTypes', 'search', 'get', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', 'd3a89ac82124400ca85bf731ee439ac9');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'results', 'search', 'add', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '9eb580bbd1e447e88196250234336771');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'search', 'error', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', 'c2b7a33f3c184a5baa54a731f6d505cb');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'search', 'getMessage', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '5ec62c5787be4d428cb016d8f85c4f51');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'search', 'error', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', '159f63445f0b4dc28fefc94f79e15362');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'search', 'getMessage', '[String[] queryStr, Sort sort, int pageSize, int curPage]', '', 'List<T>', '', 'f3bbd29bf0704e489d73d5a0f5e86875');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'notAnalyzedIndexKeys', 'Exactsearch', 'containsAll', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', '7ac570a14cdc4f2589599e23ba606f51');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searchTermMap', 'Exactsearch', 'keySet', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', '62d37832cb65430b918a93b3bdbc7bb1');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'DirectoryReader', 'Exactsearch', 'open', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', '869f5190825a4becbeda85c26c8689c3');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searchTermMap', 'Exactsearch', 'keySet', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', '9e17219f89064e93b83788167190ef29');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searchTermMap', 'Exactsearch', 'get', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', 'a508ebfaf3064dcfbc64323d04bedc7a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcher', 'Exactsearch', 'search', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', 'ccc7fa1b608442dd95051c2ed194a723');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'searcher', 'Exactsearch', 'doc', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', '25fb8de95a034d4c9526ddd3f314eac6');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'doc', 'Exactsearch', 'get', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', '895b283523ba46f7ad7087f1206826b8');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject', 'Exactsearch', 'toBean', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', 'ec14e1ae3f794570b07425355a2fdd8b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject', 'Exactsearch', 'fromObject', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', 'a5e7d7bfb0b640179a4db0486e37a5a7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'results', 'Exactsearch', 'add', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', 'cd9d992acbaf47d2a94040f29557784d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'clazz', 'Exactsearch', 'newInstance', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', 'ab45c050c59a4bd3b78665f04d4ef737');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'doc', 'Exactsearch', 'get', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', '6665886e77ba4ccab54f58421f031042');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldNameTypes', 'Exactsearch', 'get', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', 'ab9883f7fffb4ac1b8be772610ae0ac7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'results', 'Exactsearch', 'add', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', '776e0cd726e5487782bbbaf3b457d31e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'Exactsearch', 'error', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', '2fc023062e72459eac3687d096d12d94');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'Exactsearch', 'getMessage', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', '3e9b6ce0f1234f02a4a0f4ed55c2ee20');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'Exactsearch', 'error', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', 'ed06c388d5624516aec7048e445899c4');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e', 'Exactsearch', 'getMessage', '[Map<String,List<String>> searchTermMap, Sort sort, int num]', '', 'List<T>', '', '719f81df2e71490283c35b94dbffcd14');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', 'ed09c6079c764e939599af2f210d68c3');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Class.forName(analyzerClass)', 'configure', 'newInstance', '[Context context]', '', 'void', '', 'ae756299591645fa9dd792ca962eee96');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Class', 'configure', 'forName', '[Context context]', '', 'void', '', 'c462c3519fbe46958757b11a7ca7e3eb');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', 'a829cf012a0b4bee94d97612d20e6e6e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Class', 'configure', 'forName', '[Context context]', '', 'void', '', '6cabb6f8d9b246b68e9f610ec270714d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'configure', 'error', '[Context context]', '', 'void', '', '859fde05450e45f2859c355d974311a2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e1', 'configure', 'getMessage', '[Context context]', '', 'void', '', 'dd71915f26e142d39cb182afc5f74fbc');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', '81320e6b6c934feaa6be044201f74030');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'analyzedIndexFields', 'configure', 'isEmpty', '[Context context]', '', 'void', '', '7b4fecc84e0b4443b40e321539659f38');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Arrays', 'configure', 'asList', '[Context context]', '', 'void', '', 'ca7bc3949a0943e8bab7879b27f19739');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'analyzedIndexFields', 'configure', 'split', '[Context context]', '', 'void', '', 'eff957aa0aa045f1b1010cb8acc1542f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'pojoFields', 'configure', 'containsAll', '[Context context]', '', 'void', '', '9ef6534c4e2e4130a6cd02edca6f0182');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'configure', 'error', '[Context context]', '', 'void', '', '30b5775246af4367abc5f49d451152c0');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'analyzedIndexKeys', 'configure', 'addAll', '[Context context]', '', 'void', '', 'bd059ad39a894669bc04cb3095983089');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', 'fb8959b7434649c684b88016b0203e3e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'notAnalyzedIndexFields', 'configure', 'isEmpty', '[Context context]', '', 'void', '', '71b7d9d3cb5a425a976443491ceb1341');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Arrays', 'configure', 'asList', '[Context context]', '', 'void', '', '8284d5d2b8cb420bbfab75046c5489a0');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'notAnalyzedIndexFields', 'configure', 'split', '[Context context]', '', 'void', '', '3ae2d0076be64491a2c236330438552e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'pojoFields', 'configure', 'containsAll', '[Context context]', '', 'void', '', 'f6f690ee4d334e8690cdcbb5b3b4563b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'configure', 'error', '[Context context]', '', 'void', '', '38161ec9e7ef42c99097ff55b4829322');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'notAnalyzedIndexKeys', 'configure', 'addAll', '[Context context]', '', 'void', '', '004bf5fc2af247fdb7f1c66c57f5f140');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', '475536a1a5bc4e3c95194b9013ea793f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'storeFields', 'configure', 'isEmpty', '[Context context]', '', 'void', '', 'bfc1fad07010485a8d6b73c23cc29a26');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Arrays', 'configure', 'asList', '[Context context]', '', 'void', '', '4d372a49aa804462b51c181eb8e677ac');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'storeFields', 'configure', 'split', '[Context context]', '', 'void', '', '7a2007c2b30f473d9edcf43965e63a92');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'pojoFields', 'configure', 'containsAll', '[Context context]', '', 'void', '', 'b4b632680691420985fa9bf053e4cd2d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'storeFieldList', 'configure', 'contains', '[Context context]', '', 'void', '', 'e5db3cde4c2440ff8f30019d1c2c15a5');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'configure', 'error', '[Context context]', '', 'void', '', 'e0c8d71b2d7f48e48ce42b7c8bb416a5');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'storeKeys', 'configure', 'addAll', '[Context context]', '', 'void', '', 'e2ab88f2f430492ba68215ccd49f2c50');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'storeKeys', 'configure', 'contains', '[Context context]', '', 'void', '', '607df58faee644ee96d0d75a2e7b207f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', '11ac8e7f57fd4b1abd27aac64f1e13e4');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'indexFilePath', 'configure', 'isEmpty', '[Context context]', '', 'void', '', 'e20d6842190c403c83d36a264954fe1f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'configure', 'error', '[Context context]', '', 'void', '', 'f94c165e23944f3185e2778b878483f7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'FSDirectory', 'configure', 'open', '[Context context]', '', 'void', '', '80b93637c721486c92132ceb59a835d3');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'configure', 'error', '[Context context]', '', 'void', '', '108d6106af994a8d8920dd9930e8918c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Log', 'configure', 'error', '[Context context]', '', 'void', '', '62c773c3ca6047ff93efb0b61737b7f6');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'this', 'configure', 'getClass', '[Context context]', '', 'void', '', '30b3580b4b7a476e9e21fb7be0726be1');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e2', 'configure', 'getMessage', '[Context context]', '', 'void', '', '80220970a84542d5841f815e59a40a2f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e2', 'configure', 'getMessage', '[Context context]', '', 'void', '', '2d50d35c0e7e4c4691894f1f403e4799');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Log', 'configure', 'error', '[Context context]', '', 'void', '', '4bed3e9ff6b042a6924d1bb3e412b17c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'this', 'configure', 'getClass', '[Context context]', '', 'void', '', '522e40754ef14df0bed3bcd937e66253');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e2', 'configure', 'getMessage', '[Context context]', '', 'void', '', 'ddc765f7b77d4fd2bc0ab45d91e83471');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e2', 'configure', 'getMessage', '[Context context]', '', 'void', '', 'bb3f319843eb425e9d60c90821543665');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Log', 'configure', 'error', '[Context context]', '', 'void', '', '55001e218de149a6b674d66d080088cd');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'this', 'configure', 'getClass', '[Context context]', '', 'void', '', '06b3d41c2fee42c3acc8ab269364e469');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e2', 'configure', 'getMessage', '[Context context]', '', 'void', '', 'c397ad6a812541f68b1e5f5fed35d767');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'e2', 'configure', 'getMessage', '[Context context]', '', 'void', '', 'b87355ae885243f2b692bd7bf2caedf2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'clazz', 'getPojoFileds', 'getDeclaredMethods', '[List<String> fields, Class<?> clazz]', '', 'void', '', '3bb3e609bd8e4cf783701325910c1566');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm', 'getPojoFileds', 'getName', '[List<String> fields, Class<?> clazz]', '', 'void', '', '8da09aab84064c78893e4e0a7b16db26');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'name', 'getPojoFileds', 'startsWith', '[List<String> fields, Class<?> clazz]', '', 'void', '', '6f6a9486d73d48539773938d3a827206');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm.getReturnType()', 'getPojoFileds', 'getSimpleName', '[List<String> fields, Class<?> clazz]', '', 'void', '', 'ec15ccf6cff5472d8a186b155cff624e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm', 'getPojoFileds', 'getReturnType', '[List<String> fields, Class<?> clazz]', '', 'void', '', 'cd37e90efe5b49449107773ec0421df9');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"String"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', '55e588dbf7e545de89da27fdba884078');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Integer"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', 'dccf883ce26f42ea9f238be2b68a18af');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Long"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', '3abfed95d75e4ef0aaf0ecf5ee130eb7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Double"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', '9b042261f9ff4ae9bbf0b5832d29d066');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Float"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', '52fc57c51a044b76bd2aecff64467102');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Boolean"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', '1423182d528144ed8ffc1381e5d44cc8');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Short"', 'getPojoFileds', 'equalsIgnoreCase', '[List<String> fields, Class<?> clazz]', '', 'void', '', 'af3fe981ee7343179b9c2f231495ef1a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Date"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', 'e30c1db44ede4c0dadba257e4aa1b4f5');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Timestamp"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', '646cbd6ed41d446b943dca730ad58cd2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"HashMap"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', '59196722f383414295281f039a3b9c62');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"ArrayList"', 'getPojoFileds', 'equals', '[List<String> fields, Class<?> clazz]', '', 'void', '', '27e04412235b4229b4ce1831d82013d7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'name.substring(3,4)', 'getPojoFileds', 'toLowerCase', '[List<String> fields, Class<?> clazz]', '', 'void', '', '906ff16593474ebb9f3825e350b5ebe4');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'name', 'getPojoFileds', 'substring', '[List<String> fields, Class<?> clazz]', '', 'void', '', 'f3a1c7883f074e61ae9e1dd952820d0d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'name', 'getPojoFileds', 'substring', '[List<String> fields, Class<?> clazz]', '', 'void', '', '52638b993a014996a098a49736ba237f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm', 'getPojoFileds', 'getReturnType', '[List<String> fields, Class<?> clazz]', '', 'void', '', '3e5272fe58b74a6d93066bab671f92da');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fields', 'getPojoFileds', 'add', '[List<String> fields, Class<?> clazz]', '', 'void', '', '8ac9d0e08e314bd39db491eb24ec5f57');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"String"', 'setFieldValue', 'equals', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '366f9c22f33a407f801dee3168b35482');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Integer"', 'setFieldValue', 'equals', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', 'e8a48b0533b5441db17e1cceac61aa2a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Integer', 'setFieldValue', 'parseInt', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '344df0b46ed246c2bdffa0d92607b72d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Long"', 'setFieldValue', 'equals', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '4b82f9e5389145e3a9f7697d36de8e88');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Long', 'setFieldValue', 'parseLong', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '510c98141cfd4ca1b4982b4d098d52c1');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Double"', 'setFieldValue', 'equals', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', 'fb41b80afeba44e8bf2dd227b8ebd66d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Double', 'setFieldValue', 'parseDouble', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '4e5bc482a4c74a5184b6614b1a0644d0');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Float"', 'setFieldValue', 'equals', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '61c444bdcc7d40ca8eca9cf21244addd');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Float', 'setFieldValue', 'parseFloat', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', 'deec60cec3d0486eae81d6c27cadef88');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Boolean"', 'setFieldValue', 'equals', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '91784ea72e9f4a2ba3a60f8b71e09e93');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Boolean', 'setFieldValue', 'parseBoolean', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '8107fe3e684a41438245b5e43d767c4c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Short"', 'setFieldValue', 'equalsIgnoreCase', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '5ee683b6aea14ca0ba1c9fc3920ba480');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Short', 'setFieldValue', 'parseShort', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '377b1c8bbfc74cbd933fe85770ecfda4');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Date"', 'setFieldValue', 'equals', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '34ce62110ba94f479f1adb879e1fa235');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'DateUtil', 'setFieldValue', 'parseTime', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '1ba3e5a778ff484196e2d9f2f6c9f4b1');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Timestamp"', 'setFieldValue', 'equals', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '2a7e2780f3894dd4895abe53d08bd98d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'DateUtil', 'setFieldValue', 'parseTime', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '7c40e61dd1724ef994d6db8d15a8b9e8');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"HashMap"', 'setFieldValue', 'equals', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '7eda9963ca034fd48616f61638c9949d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject', 'setFieldValue', 'toBean', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', 'd570aad425a94e09ae27afadd1db0db7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObject', 'setFieldValue', 'fromObject', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '25a1b3a4eecd404aa0833f0625284f7b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"ArrayList"', 'setFieldValue', 'equals', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '928d73ae302a4e4785a0f29c4cb502fa');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONArray', 'setFieldValue', 'toArray', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '34fcf65304ee4bec8d1d1b83febba307');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONArray', 'setFieldValue', 'fromObject', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '3f2869d8f4e14d87b9778bdde8e472e7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'clazz', 'setFieldValue', 'getMethod', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', 'd438216e18614a6f8f0e85ab5132b268');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldName.substring(0,1)', 'setFieldValue', 'toUpperCase', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '56a9b5110e254073a815e102987bb997');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldName', 'setFieldValue', 'substring', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', 'faaaad9cc5ed4b77bd8deba2d626b6d1');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldName', 'setFieldValue', 'substring', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', '34b96d8c7a944df79c3caf5760e99c33');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm', 'setFieldValue', 'invoke', '[Class<?> clazz, String fieldName, String fieldvalue, String fieldType, Object data]', '', 'void', '', 'ce080d101b3c4aa0be15b18a184fc0b2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'clazz', 'getFieldNameType', 'getDeclaredMethods', '[Class<?> clazz]', '', 'Map<String,String>', '', '09bd1285cfbc4198bf4bd939b334d5e4');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm', 'getFieldNameType', 'getName', '[Class<?> clazz]', '', 'Map<String,String>', '', 'ba1231ef8f2a4e4698a33172fdbc2a28');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'name', 'getFieldNameType', 'startsWith', '[Class<?> clazz]', '', 'Map<String,String>', '', '4bb2606b42e54174a9476064d243f3e5');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm.getReturnType()', 'getFieldNameType', 'getSimpleName', '[Class<?> clazz]', '', 'Map<String,String>', '', '106045300ff142a58df468d7585a2468');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm', 'getFieldNameType', 'getReturnType', '[Class<?> clazz]', '', 'Map<String,String>', '', 'a652e49ec7bb44f7a575e653b2af9c68');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'name.substring(3,4)', 'getFieldNameType', 'toLowerCase', '[Class<?> clazz]', '', 'Map<String,String>', '', 'f8f8a2a75dcb4552a237d2be1db6c6f2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'name', 'getFieldNameType', 'substring', '[Class<?> clazz]', '', 'Map<String,String>', '', '9f9d3335da774606a73a2728b680d960');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'name', 'getFieldNameType', 'substring', '[Class<?> clazz]', '', 'Map<String,String>', '', 'ed96eee874ff44e985719924166a5e50');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldNameTypeMap', 'getFieldNameType', 'put', '[Class<?> clazz]', '', 'Map<String,String>', '', '828586e5604949449e4c8fa1ed87f4f9');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', '13cf487d979a473fbbd22be36b30f2f0');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Class', 'configure', 'forName', '[Context context]', '', 'void', '', 'd38d8d937b184ca5a3a1c8abfac0e268');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', '43992e37159742a2bde14dfc113fd287');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', '6ad0adce96344151abf18e18a6ac8743');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'context', 'configure', 'getString', '[Context context]', '', 'void', '', 'cb958d8985d94e14afa96495a4dd8eb6');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'dataFilterStr', 'configure', 'split', '[Context context]', '', 'void', '', '92c9d1589af7455c8bec8c2a26b984e3');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldFilterMap', 'configure', 'put', '[Context context]', '', 'void', '', '98a3c6f93fec447d88df128e2f8efc67');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'index', 'configure', 'configure', '[Context context]', '', 'void', '', '170111e2be24436cbbcaa9afbb36f22a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldFilterMap', 'InitialDataOpen', 'isEmpty', '[]', '', 'void', '', '0dc333b3aa8c4eeb958f5a50f9ee20ee');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldFilterMap', 'InitialDataOpen', 'keySet', '[]', '', 'void', '', '595a359908b04c47aee822ed9e64356e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'filter', 'InitialDataOpen', 'add', '[]', '', 'void', '', '7ee4306d2a3d45edbc3179830866ced9');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldFilterMap', 'InitialDataOpen', 'get', '[]', '', 'void', '', 'e0335d15bdb44651aeccdf545ddaa41c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'asynHelper', 'InitialDataOpen', 'query', '[]', '', 'void', '', '1b88c6c40e684725b1d846d720edaf5e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'filter', 'InitialDataOpen', 'isEmpty', '[]', '', 'void', '', 'eabf1acd136b463b82ae5d0a2e75e84d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'datas', 'succeed', 'isEmpty', '[List<Object> datas]', '', 'void', '', '61a0eef9f43040b5bd20382be2d90a28');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'incFieldRW', 'succeed', 'writeValue', '[List<Object> datas]', '', 'void', '', '8752c3b4fd89444cafceeb30f222e90e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'datas', 'succeed', 'get', '[List<Object> datas]', '', 'void', '', '717bed6ff0f046f1ab1bf68bb5c11698');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'databaseIndex', 'succeed', 'write', '[List<Object> datas]', '', 'void', '', 'b8e61cc3feee4f38873e48b45d6ceabb');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'failure', 'error', '[ResultVO result]', '', 'void', '', 'ea8560aa10fb404a985ea8f031e7826a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'result', 'failure', 'getErrorMsg', '[ResultVO result]', '', 'void', '', '8da4181c482c40dca17000c536d217cc');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'filter', 'IncreaseDataOpen', 'add', '[]', '', 'void', '', 'a130f2b142c84320b2222de6b3b21dc2');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'incFieldRW', 'IncreaseDataOpen', 'readValue', '[]', '', 'void', '', 'eb11ef2c76b34724baa27c2fc95bf1da');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldFilterMap', 'IncreaseDataOpen', 'isEmpty', '[]', '', 'void', '', '2a828719c3aa43a0b1923fb79ad46f35');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldFilterMap', 'IncreaseDataOpen', 'keySet', '[]', '', 'void', '', 'ebbe81e9610749e3b46500cc4ea48f69');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'filter', 'IncreaseDataOpen', 'add', '[]', '', 'void', '', '1cbb67a9bf7548ebaa50a57512ca12ca');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldFilterMap', 'IncreaseDataOpen', 'get', '[]', '', 'void', '', '3e9895810e364c45a1f331d1feaba386');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'asynHelper', 'IncreaseDataOpen', 'query', '[]', '', 'void', '', '52c275ceaebf427db18e64792c5cbf8b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'datas', 'succeed', 'isEmpty', '[List<Object> datas]', '', 'void', '', '28fd378ea4fd4bee997295a9bdc31c3c');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'incFieldRW', 'succeed', 'writeValue', '[List<Object> datas]', '', 'void', '', 'ee8cf66d98c44f38851d2722e495b0ef');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'datas', 'succeed', 'get', '[List<Object> datas]', '', 'void', '', '3218546c5cd74bbabbc9cb717901f193');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'databaseIndex', 'succeed', 'append', '[List<Object> datas]', '', 'void', '', '9e40e496dfd34f25beb0f9d78c7cea6a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'logger', 'failure', 'error', '[ResultVO result]', '', 'void', '', '8b11528c23d945b6b3efe7148717f19a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'result', 'failure', 'getErrorMsg', '[ResultVO result]', '', 'void', '', 'f14b95bf7dbc4a598e84f0f2a9f6a4d7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'clazz', 'writeValue', 'getMethod', '[Object data]', '', 'void', '', 'd0d4ff8aa96747bdaadb4735a7d7cdef');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'incFieldName.substring(0,1)', 'writeValue', 'toUpperCase', '[Object data]', '', 'void', '', '5287daed58f34a3ab3dcb8271170f8fe');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'incFieldName', 'writeValue', 'substring', '[Object data]', '', 'void', '', '10f777c2da684dd2a1f6d55eab3ea64a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'incFieldName', 'writeValue', 'substring', '[Object data]', '', 'void', '', 'd355044bbe85426bbd2e5ac500e7653e');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm.getReturnType()', 'writeValue', 'getSimpleName', '[Object data]', '', 'void', '', '66ccda845b9c4ff88a8a393fea76f9fe');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm', 'writeValue', 'getReturnType', '[Object data]', '', 'void', '', 'fdb6574b4e08426ea549cb19d279c216');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'm', 'writeValue', 'invoke', '[Object data]', '', 'void', '', 'fd1e5d77ebff4d4eacc7efcb136a8772');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Integer"', 'writeValue', 'equals', '[Object data]', '', 'void', '', 'd268cd705d1e46ff902fc3a936860143');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Long"', 'writeValue', 'equals', '[Object data]', '', 'void', '', 'e0ff78c9c7b044968db49247106417fc');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Short"', 'writeValue', 'equalsIgnoreCase', '[Object data]', '', 'void', '', 'ac004318ca194924bf0ef75fd52d2561');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'mValue', 'writeValue', 'toString', '[Object data]', '', 'void', '', 'c9c1c8625e984af6a6532cf4d4899b01');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Date"', 'writeValue', 'equals', '[Object data]', '', 'void', '', '3f289dc46e4f4a0ca028a41161d8eb6d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'TimeFormat', 'writeValue', 'format', '[Object data]', '', 'void', '', '316103d19af94fae9f2b352d7aed11ea');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Timestamp"', 'writeValue', 'equals', '[Object data]', '', 'void', '', 'f1d94d0be4b54c74930c85fa84a96624');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'TimeFormat', 'writeValue', 'format', '[Object data]', '', 'void', '', 'b6d084d6e0d54e7dabd252228e1fddf0');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'map', 'writeValue', 'put', '[Object data]', '', 'void', '', '60ba99f6bc8847868e3d7b58ca631a40');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'map', 'writeValue', 'put', '[Object data]', '', 'void', '', 'e90c03a09e52435fadaee8771397c8ca');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObjUtil', 'writeValue', 'saveJson2File', '[Object data]', '', 'void', '', '7ee964612f6b47bd89d332166ccb432f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'incFieldLastStore', 'readValue', 'exists', '[]', '', 'Object', '', '96ad114b28b643739de09280da5d6aec');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'JSONObjUtil', 'readValue', 'getFileJSONContent', '[]', '', 'Object', '', '2d10eba512604c8b8212df1acb24181f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'jsonObeject', 'readValue', 'getString', '[]', '', 'Object', '', '50d34ab1442c404caaefd511cae3954b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'jsonObeject', 'readValue', 'getString', '[]', '', 'Object', '', '3f52ce6321a84c1482ac787a3b7eba37');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Integer"', 'readValue', 'equals', '[]', '', 'Object', '', '285beb2c6fa24ed6af9ac4c8f2b9e881');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Integer', 'readValue', 'parseInt', '[]', '', 'Object', '', '41379ebeba204b2e8b29a9adacc24125');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Long"', 'readValue', 'equals', '[]', '', 'Object', '', 'da577459f4a74cfe92a0356815d20017');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Long', 'readValue', 'parseLong', '[]', '', 'Object', '', '5b36bf5de3d94741ba47c8555878bb16');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Short"', 'readValue', 'equals', '[]', '', 'Object', '', 'e0d704194489413b97f5337a4648f0aa');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Short', 'readValue', 'parseShort', '[]', '', 'Object', '', '7d68b6d1faaf4881812edc071345ff46');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Date"', 'readValue', 'equals', '[]', '', 'Object', '', '3c06348d15c149a9931ad9edf87d5669');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'TimeFormat', 'readValue', 'parse', '[]', '', 'Object', '', '097a4324974546dd9a497def71b474bc');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', '"Timestamp"', 'readValue', 'equals', '[]', '', 'Object', '', 'fd22979baedf4be29730ab32740ac881');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'TimeFormat', 'readValue', 'parse', '[]', '', 'Object', '', '3733eb147dab4ed29ab8009b69783d14');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'new SimpleDateFormat(format)', 'processObjectValue', 'format', '[String key, Object value, JsonConfig arg2]', '', 'Object', '', '6a12aa8c1f7c41cfbcdadeef8cec878d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'new SimpleDateFormat(format)', 'processObjectValue', 'format', '[String key, Object value, JsonConfig arg2]', '', 'Object', '', 'ce81934f903d4ef8b6f61d030edf68f7');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'value', 'processObjectValue', 'toString', '[String key, Object value, JsonConfig arg2]', '', 'Object', '', '29391c94b5344088894b546f4c282aca');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'clazz', 'getFieldNameType', 'getDeclaredFields', '[Class<?> clazz]', '', 'Map<String,String>', '', '5e5d4f3082dd46c8b5cc17b45ce0c028');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fields[j]', 'getFieldNameType', 'getName', '[Class<?> clazz]', '', 'Map<String,String>', '', '95c0b3569e6f42969624f69f18cf004d');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fields[j].getType()', 'getFieldNameType', 'getName', '[Class<?> clazz]', '', 'Map<String,String>', '', '096ef21a5382418391c406b2ab8fda27');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fields[j]', 'getFieldNameType', 'getType', '[Class<?> clazz]', '', 'Map<String,String>', '', '1a82a7daacfe4c839d7ef7d906ee466b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fieldNameTypeMap', 'getFieldNameType', 'put', '[Class<?> clazz]', '', 'Map<String,String>', '', 'e9bc3f1678e74e79963be3aa5cc67193');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'Class', 'main', 'forName', '[String[] args]', '', 'void', '', '3daaa862f05f43d8bce61a30e14ce4d1');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fields', 'main', 'keySet', '[String[] args]', '', 'void', '', '12476edeb8f94453b686ebbaa854ca6f');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'System.out', 'main', 'println', '[String[] args]', '', 'void', '', 'e9b299b8f6a24a4eb7b56dc7de3eb693');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'fields', 'main', 'get', '[String[] args]', '', 'void', '', '9bb1b5a08a3e43d78dea6dbfbde0ec6a');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'date', 'parseTime', 'isEmpty', '[String date]', '', 'Date', '', '09a243900e554d39973163582774f70b');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'TimeFormat', 'parseTime', 'parse', '[String date]', '', 'Date', '', '309ca51bee8f46b49a5417d9313363bd');
INSERT INTO codegraphtest.methodinvocationinfo (projectName, invocateVariant, callMethodName, calledMethodName, callMethodParameters, calledMethodParameters, callMethodReturnType, calledMethodReturnType, id) VALUES ('MyLuence-master', 'TimeFormat', 'timeFormat', 'format', '[Date date]', '', 'String', '', '5cb061e5a1024095918e88bfd4703f7c');
create table tokeninmethod
(
    projectName text null,
    methodName  text null,
    tokens      text null,
    stem        text null,
    id          text null
)
    charset = utf8;


create table variableinfo
(
    projectName    text null,
    name           text null,
    datatype       text null,
    belongedMethod text null,
    icount         text null,
    id             text null
)
    charset = utf8;

INSERT INTO codegraphtest.variableinfo (projectName, name, datatype, belongedMethod, icount, id) VALUES ('MyLuence-master', 'context', 'com.wind.myLuence.Context', '', '0', 'a77138d834cf4faa800345c24480aa97');
INSERT INTO codegraphtest.variableinfo (projectName, name, datatype, belongedMethod, icount, id) VALUES ('MyLuence-master', 'context', 'com.wind.myLuence.Context', '', '0', 'eb55976f5d194bb69a1d67bad6f8b507');
INSERT INTO codegraphtest.variableinfo (projectName, name, datatype, belongedMethod, icount, id) VALUES ('MyLuence-master', 'factory', 'com.wind.myLuence.factory.MyLuenceFactory', '', '0', '5b4b59898e7045d6ba66f43bb0979c74');
INSERT INTO codegraphtest.variableinfo (projectName, name, datatype, belongedMethod, icount, id) VALUES ('MyLuence-master', 'context', 'com.wind.myLuence.Context', '', '0', '879f8bc6cc094c8c9378a7c543409981');
INSERT INTO codegraphtest.variableinfo (projectName, name, datatype, belongedMethod, icount, id) VALUES ('MyLuence-master', 'context', 'com.wind.myLuence.Context', '', '0', 'f6e163a20663440abd932f69162e091b');
INSERT INTO codegraphtest.variableinfo (projectName, name, datatype, belongedMethod, icount, id) VALUES ('MyLuence-master', 'index', 'com.wind.myLuence.Index', '', '0', '31a0968e9bd541bf830ca4d301b5caa7');
INSERT INTO codegraphtest.variableinfo (projectName, name, datatype, belongedMethod, icount, id) VALUES ('MyLuence-master', 'context', 'com.wind.myLuence.Context', '', '0', '4710759829dc4baf831249355cf495a5');
INSERT INTO codegraphtest.variableinfo (projectName, name, datatype, belongedMethod, icount, id) VALUES ('MyLuence-master', 'index', 'com.wind.myLuence.Index', '', '0', '6a7d3ffa6c3c41e9a72e961c6d92bc62');