From: Zhang Haijun <B42677@freescale.com>
Subject: Re: [PATCH 2/4 V2] mmc: esdhc: workaround for dma err in the last
 system transaction
Date: Mon, 26 Aug 2013 09:50:15 +0800
Message-ID: <521AB457.3030009@freescale.com>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
 <99E897753B6F7048BD8CCDB4661D02E13DF52C@039-SN2MPN1-022.039d.mgd.msft.net>
 <521703AB.8030702@freescale.com>
 <1377272410.20722.46.camel@snotra.buserror.net>
 <521AA947.6080209@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0586539447192381688=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <521AA947.6080209@freescale.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Xie Xiaobo-R63061 <X.Xie@freescale.com>
List-Id: linux-mmc@vger.kernel.org

--===============0586539447192381688==
Content-Type: multipart/alternative;
	boundary="------------090104010705040003030102"

--------------090104010705040003030102
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 08/26/2013 09:03 AM, Zhang Haijun wrote:
> On 08/23/2013 11:40 PM, Scott Wood wrote:
>> On Fri, 2013-08-23 at 14:39 +0800, Zhang Haijun wrote:
>>> Hi, Anton and all
>>>
>>> Is there any advice on these two patches ?
>>>
>>> [PATCH 2/4 V2] mmc: esdhc: workaround for dma err in the last system
>>> transaction
>>> [PATCH 3/4 V3] mmc: esdhc: Correct host version of T4240-R1.0-R2.0.
>>>
>>>
>>> [PATCH 1/4 V4] powerpc/85xx: Add support for 85xx cpu type detection
>>> This patch is Act-by Scott.
>>> Patch 4/4 is split to four patches and Act-by Anton.
>>>
>>>
>>> Thanks all.
>>>
>>>
>>>
>> [snip]
>>>>> +	if (!(((SVR_SOC_VER(svr) == SVR_T4240) && (SVR_REV(svr) == 0x10))
>>>>> ||
>>>>> +		((SVR_SOC_VER(svr) == SVR_B4860) && (SVR_REV(svr) == 0x10))
>>>>> ||
>>>>> +		((SVR_SOC_VER(svr) == SVR_P1010) && (SVR_REV(svr) == 0x10))
>>>>> ||
>>>>> +		((SVR_SOC_VER(svr) == SVR_P3041) && (SVR_REV(svr) <= 0x20))
>>>>> ||
>>>>> +		((SVR_SOC_VER(svr) == SVR_P2041) && (SVR_REV(svr) <= 0x20))
>>>>> ||
>>>>> +		((SVR_SOC_VER(svr) == SVR_P5040) && SVR_REV(svr) == 0x20)))
>>>>> +		return;
>> You need to include variants here.  If P5040 is affected, then P5021 is
>> affected.  If P2041 is affected, then P2040 is affected, etc.
>>
>> -Scott
>>
>>
> Hi, Scott
>
> This workaround is for CR:ENGR00229586: A-005055, Configs Affected 
> onlylist these soc and its version.
> I was also wonder why only these boards?
>
> But Ican't add soc like P5021 as I think it should be. Maybe there are 
> some difference between them.
>
> -- 
> Thanks & Regards
>
> Haijun
Hi, Scott

I found there are update about this errata.

I'll update thispatch.

Thanks.

-- 
Thanks & Regards

Haijun


--------------090104010705040003030102
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 08/26/2013 09:03 AM, Zhang Haijun
      wrote:<br>
    </div>
    <blockquote cite="mid:521AA947.6080209@freescale.com" type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div class="moz-cite-prefix">On 08/23/2013 11:40 PM, Scott Wood
        wrote:<br>
      </div>
      <blockquote
        cite="mid:1377272410.20722.46.camel@snotra.buserror.net"
        type="cite">
        <pre wrap="">On Fri, 2013-08-23 at 14:39 +0800, Zhang Haijun wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">Hi, Anton and all

Is there any advice on these two patches ?

[PATCH 2/4 V2] mmc: esdhc: workaround for dma err in the last system 
transaction
[PATCH 3/4 V3] mmc: esdhc: Correct host version of T4240-R1.0-R2.0.


[PATCH 1/4 V4] powerpc/85xx: Add support for 85xx cpu type detection
This patch is Act-by Scott.
Patch 4/4 is split to four patches and Act-by Anton.


Thanks all.



</pre>
        </blockquote>
        <pre wrap="">[snip]
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="">+	if (!(((SVR_SOC_VER(svr) == SVR_T4240) &amp;&amp; (SVR_REV(svr) == 0x10))
||
+		((SVR_SOC_VER(svr) == SVR_B4860) &amp;&amp; (SVR_REV(svr) == 0x10))
||
+		((SVR_SOC_VER(svr) == SVR_P1010) &amp;&amp; (SVR_REV(svr) == 0x10))
||
+		((SVR_SOC_VER(svr) == SVR_P3041) &amp;&amp; (SVR_REV(svr) &lt;= 0x20))
||
+		((SVR_SOC_VER(svr) == SVR_P2041) &amp;&amp; (SVR_REV(svr) &lt;= 0x20))
||
+		((SVR_SOC_VER(svr) == SVR_P5040) &amp;&amp; SVR_REV(svr) == 0x20)))
+		return;
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="">You need to include variants here.  If P5040 is affected, then P5021 is
affected.  If P2041 is affected, then P2040 is affected, etc.

-Scott


</pre>
      </blockquote>
      <font size="-1">Hi, Scott<br>
        <br>
        <font size="-1"><font size="-1">This <font size="-1">worka<font
                size="-1">round is for </font></font></font></font></font><font
        size="-1"><font size="-1"><font size="-1"><font size="-1"><font
                size="-1">CR:ENGR00229586: A-005055<font size="-1">,
                  Config<font size="-1">s Affected only<font size="-1">
                      list th<font size="-1">e<font size="-1">se <font
                            size="-1">soc and its version</font>.<br>
                          <font size="-1">I was also wo<font size="-1">nder

                              <font size="-1">why only these boards<font
                                  size="-1">?<br>
                                  <br>
                                  <font size="-1"><font size="-1">But <font
                                        size="-1">I<font size="-1">
                                          can't add s<font size="-1">oc
                                          </font>like P5021 as <font
                                            size="-1">I think it should
                                            be. Maybe there are some <font
                                              size="-1">difference <font
                                                size="-1">between them.</font></font></font></font></font></font></font><br>
                                </font></font></font></font></font></font></font></font></font></font></font></font></font></font><br>
      <pre class="moz-signature" cols="72">-- 
Thanks &amp; Regards

Haijun</pre>
    </blockquote>
    <font size="-1"><font size="-1">Hi, <font size="-1">Scott<br>
          <br>
          <font size="-1">I found there are update about <font
              size="-1">this errata.<br>
              <br>
              <font size="-1">I'<font size="-1">ll update this<font
                    size="-1"> patch. <br>
                    <br>
                    Thanks<font size="-1">.</font></font></font></font><br>
            </font></font></font></font></font><br>
    <pre class="moz-signature" cols="72">-- 
Thanks &amp; Regards

Haijun</pre>
  </body>
</html>

--------------090104010705040003030102--

--===============0586539447192381688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
--===============0586539447192381688==--
