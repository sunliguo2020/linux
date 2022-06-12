#-*-encoding:utf-8-*-
'''
Created on 2016-5-9

@author: Administrator
'''
import cookielib
import urllib2
import urllib
import os
import time

#from bs4 import BeautifulSoup

class gongke(object):
    def __init__(self,uname,passwd):
        self.uname= uname
        self.passwd = passwd
        
        #cookie_file = "./cookie.txt"        
        self.cookie = cookielib.CookieJar()
        self.opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(self.cookie))
        urllib2.install_opener(self.opener)
        
        self.headers= { 'User-Agent': 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36' ,
                       'Referer': 'http://218.56.65.202:9081/PB_INTERFACE/pgCusd_login_test/pgLogin_cusd.jsp' ,
                       "Accept":'image/gif, image/jpeg, image/pjpeg, image/pjpeg, application/x-shockwave-flash, application/msword, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/xaml+xml, application/x-ms-xbap, application/x-ms-application, application/vnd.ms-xpsdocument, */*'}
        self.headers2= { 'User-Agent': 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36' ,
                       'Referer': 'http://218.56.65.202:9081/PB_INTERFACE/pgCusd_login_test/LZ_CUSD_ORDER.prCusd.prCustReportInit_Cusd.do' ,
                       "Accept":'*/*'}

        #self.login_url = "http://218.56.65.202:9081/PB_INTERFACE/pgCusd_login_test/PB_COMMON.prCTGSLogin.login.do"
        self.login_url="http://218.56.65.202:9081//PB_INTERFACE/pgCusd_login_test/PB_COMMON.prCTGSLogin.login.do"
        self.getPhone_url="http://218.56.65.202:9081/bwflow/scripts/basic/hiddensubmit.jsp"
        self.referer="http://218.56.65.202:9081/login.jsp"
        
        self.response = None
        self.content = None
        self.soup = None
        self.login()
        
    def login(self):
        data = {
                'EOSOperator/password':self.passwd,
                'EOSOperator/userID':self.uname 
                }
        #self.refer_result=self.opener.open(self.referer)
        post_data = urllib.urlencode(data)
        req = urllib2.Request(url=self.login_url,data=post_data,headers=self.headers)
        
        self.response=urllib2.urlopen(req)
        #self.cookie.save(ignore_discard=True, ignore_expires=True)
        #self.content=self.response.read()
      
    def get_phone(self,number,dir="D:/phone/"):
        """
                        参数1 ：手机号
                        参数2：保存路径
         
        """
        self.number=number
        self.dir =dir
        '''
        bizAction=SA_C_ORDER_MAKE.bizCustFaultReport.bizGetCustInfo
        &reportedOrgID=106
        &BUSI_NBR=5406399
        &id=3699110317866141
        &prodClass=PSTN
        &SA_J_USERINFO/CUST_LEVEL=09
        &SA_J_USERINFO/BRAND=PTD1
        &SA_J_USERINFO/COMBO=
        &SA_J_USERINFO/CITY_TYPE=6
        &SA_J_USERINFO/PROD=30
        &SA_J_USERINFO/VIP_LEVEL=09        
        '''
        '''
        bizAction=SA_C_ORDER_MAKE.bizCustFaultReport.bizGetCustInfo
        &reportedOrgID=106
        &BUSI_NBR=15615363322
        &id=3609020820255117
        &prodClass=BANDVIP
        &SA_J_USERINFO/CUST_LEVEL=09
        &SA_J_USERINFO/BRAND=BD00
        &SA_J_USERINFO/COMBO=
        &SA_J_USERINFO/CITY_TYPE=5
        &SA_J_USERINFO/PROD=BANDVIP
        &SA_J_USERINFO/VIP_LEVEL=09
        '''
        '''
        First post
        bizAction=SA_C_ORDER_MAKE.bizCustFaultReport.bizGetPrdtInfo
        &BUSI_NBR=15615363322
        &custType=1
        &reportedOrgID=106
        &prodClass=BANDVIP
        '''
        
        '''
        POST /bwflow/scripts/basic/hiddensubmit.jsp HTTP/1.1
        Host: 218.56.65.202:9081
        Accept: */*
        Referer: http://218.56.65.202:9081/PB_INTERFACE/pgCusd_login_test/LZ_CUSD_ORDER.prCusd.prCustReportInit_Cusd.do
        Cookie: JSESSIONID=0001cshIHG6bey9FXQMx_qXUrMI:IBPVFURND
        Content-Length: 124
        Content-Type: application/x-www-form-urlencoded
        bizAction=SA_C_ORDER_MAKE.bizCustFaultReport.bizGetPrdtInfo&BUSI_NBR=15615363344&custType=1&reportedOrgID=105&prodClass=PSTN
        '''
        '''
        bizAction=SA_C_ORDER_MAKE.bizCustFaultReport.bizGetPrdtInfo
        &BUSI_NBR=15615363344
        &custType=1
        &reportedOrgID=105
        &prodClass=PSTN
        '''
        data = {                
                "bizAction":"SA_C_ORDER_MAKE.bizCustFaultReport.bizGetPrdtInfo",
                "BUSI_NBR":self.number,
                "custType":1,
                "reportedOrgID":105,
                "prodClass":"PSTN"              
                }
        phoneCustInfo = {
        "bizAction":"SA_C_ORDER_MAKE.bizCustFaultReport.bizGetCustInfo",
        "reportedOrgID":"106",
        "BUSI_NBR":"15615363322",
        "id":"3609020820255117",
        "prodClass":"BANDVIP",
        "SA_J_USERINFO/CUST_LEVEL":"09",
        "SA_J_USERINFO/BRAND":"BD00",
        "SA_J_USERINFO/COMBO":"",
        "SA_J_USERINFO/CITY_TYPE":"5",
        "SA_J_USERINFO/PROD":"BANDVIP",
        "SA_J_USERINFO/VIP_LEVEL":"09"                    
         }
        TelCustInfo = {
        "bizAction":"SA_C_ORDER_MAKE.bizCustFaultReport.bizGetCustInfo",
        "reportedOrgID":106,
        "BUSI_NBR":5406399,
        "id":'3699110317866141',
        "prodClass":"PSTN",
        "SA_J_USERINFO/CUST_LEVEL":"09",
        "SA_J_USERINFO/BRAND":"PTD1",
        "SA_J_USERINFO/COMBO":"",
        "SA_J_USERINFO/CITY_TYPE":6,
        "SA_J_USERINFO/PROD":"30",
        "SA_J_USERINFO/VIP_LEVEL":"09"                         
        }
        #self.cookie.load('cookie.txt', ignore_discard=True, ignore_expires=True)
        post_data=urllib.urlencode(data)
        '''print "get number post_data",post_data
        print "get number cookie",self.cookie'''
        #print "post_data",post_data
        req = urllib2.Request(url=self.getPhone_url,data=post_data,headers={'User-Agent': 'Mozilla/5.0' })
        self.response=urllib2.urlopen(req)
        self.content=self.response.read()        
        #编码为utf-8
        count=self.content.decode('gb2312').encode('utf-8').replace("GB2312","UTF-8")  

        with  open(dir+self.number+".xml","w+") as f:
        #print myfile.encoding
            f.write(count)

    def get_kuandai(self,KuanDaiZhangHao,dir="D:/phone/"):
        
        '''返回一个字典，包含文件名，文件大小，文件最后修改时间'''
        
        """
        bizAction=SA_C_ORDER_MAKE.bizCustFaultReport.bizGetPrdtInfo
        &BUSI_NBR=053602195435
        &custType=1
        &reportedOrgID=106
        &prodClass=ADSL
        """
        '''
                        更详细的宽带信息
        bizAction=SA_C_ORDER_MAKE.bizCustFaultReport.bizGetCustInfo
        &reportedOrgID=106
        &BUSI_NBR=053602195435
        &id=1713102960974143
        &prodClass=ADSL
        &SA_J_USERINFO/CUST_LEVEL=09
        &SA_J_USERINFO/BRAND=JTBJ&SA_J_USERINFO/COMBO=
        &SA_J_USERINFO/CITY_TYPE=5&SA_J_USERINFO/PROD=40
        &SA_J_USERINFO/VIP_LEVEL=09
        '''
        self.kuanDaiZhangHao  = KuanDaiZhangHao
        
        self.saveFile = os.path.join(dir, self.kuanDaiZhangHao+".xml")
        
        self.kuandai_data = {
        "bizAction":"SA_C_ORDER_MAKE.bizCustFaultReport.bizGetPrdtInfo",
        "BUSI_NBR":self.kuanDaiZhangHao,
        "custType":1,
        "reportedOrgID":111,
        "prodClass":"ADSL"                 
        }
        
        self.kuandaiPost = urllib.urlencode(self.kuandai_data)
        req = urllib2.Request(url=self.getPhone_url,data=self.kuandaiPost,headers=self.headers)
        '''urllib2.HTTPError: HTTP Error 504: Gateway Time-out'''
        try:
            self.response=urllib2.urlopen(req)            
            self.content=self.response.read()
        except Exception,e :
            print "urllib2 error %s" % e
            self.content = ""
        
        #编码为utf-8,解码有时会有问题，保留原始数据
        #self.content=self.content.decode('ISO-8859-1','replace').encode('utf-8').replace("GB2312","UTF-8")  

        with  open(self.saveFile,"w+") as f:
        #print myfile.encoding
            f.write(self.content)
        if os.path.isfile(self.saveFile):
            filedict = {}
            filedict ['file_name'] = self.saveFile
            filedict['file_size'] = os.path.getsize(self.saveFile)
            filedict['mod_time'] = time.strftime("%Y-%m-%d %H:%M:%S",time.gmtime(os.path.getmtime(self.saveFile)+8*3600))
        
        return filedict
    def close(self):
        pass
        #self.opener.close()
        
if __name__ == "__main__":
    sk_renren=gongke('15615310077',"000000")
    #sk_renren.login()
    #getNumber= "15653613322"
    #print sk_renren.get_number("15653613322").decode('gb2312')
    #sk_renren.get_phone(getNumber)
    
    kuandaizhanghao = "053602976180"
    print sk_renren.get_kuandai(kuandaizhanghao,"./")
    sk_renren.close()