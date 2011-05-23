From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [[v4] 2/5] MMC: Use CMD23 for multiblock transfers when we can.
Date: Mon, 23 May 2011 21:40:22 +0900
Message-ID: <4DDA55B6.3040708@samsung.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
 <1303870235-29041-1-git-send-email-andreiw@motorola.com>
 <1303870235-29041-2-git-send-email-andreiw@motorola.com>
 <1303870235-29041-3-git-send-email-andreiw@motorola.com>
 <4DD48273.4060402@samsung.com>
 <BANLkTi=yJuEtN-SSokhp5CE_mCz9D9D5SA@mail.gmail.com>
 <4DD5F045.90001@samsung.com>
 <BANLkTik72KgftDWz6aNn=zGDqj1uMpwnYw@mail.gmail.com>
 <BANLkTi=mpibUJLJTCcf+i7=PgPBUFecgRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:23252 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab1EWMk0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2011 08:40:26 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LLN00ESGF76V2F0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 23 May 2011 21:40:24 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LLN00230F7B0O@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 23 May 2011 21:40:23 +0900 (KST)
In-reply-to: <BANLkTi=mpibUJLJTCcf+i7=PgPBUFecgRw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org, arnd@arndb.de, Kyungmin Park <kyungmin.park@samsung.com>, "Gao, Yunpeng" <yunpeng.gao@intel.com>

Hi A..

I tested your patch..(using CMD23)
my environment is the below.
eMMC card : Sandisk SEM8G (eMMC 4.3+)
buswidth : 4bit (SDR)
AP : C110
benchmark : IOzone

I want to know how do you think about this result?
(i can't see your results)

* open-ended 
	      KB  reclen   write rewrite    read    reread
           10240       4    9128    9859    18072    18131
           10240       8    9510   10025    18107    18031
           10240      16    9445   10104    18143    18084
           10240      32    9583   10076    17912    18097
           10240      64    2957    3025    12320    12317
           10240     128    9500    9850    18082    18085
           10240     256    9506    8712    17952    17905
           10240     512    9445    9905    17981    17851
           10240    1024    8894    9724    18079    18196
           10240    2048    9401    9810    18181    18040
           10240    4096    8657    9358    18172    17980
           10240    8192    8779    7730    18067    17943

* pre-defined (CMD23)

              KB  reclen   write rewrite    read    reread
           10240       4    8799    8061    18069    18212
           10240       8    8850    8465    17938    18084
           10240      16    8077    9171    18131    18249
           10240      32    8810    8209    18019    17999
           10240      64    8744    8214    18096    18204
           10240     128    7940   10041    18036    18043
           10240     256    8466    7557    18101    18186
           10240     512    7372    8486    18272    18010
           10240    1024    5565    9922    18155    18196
           10240    2048    9383    9686    18116    18049
           10240    4096    9282    8792    18073    18154
           10240    8192    3770   10136    18083    18155

Regards,
Jaehoon Chung


Andrei Warkentin wrote:
> On Fri, May 20, 2011 at 1:49 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
>> On Thu, May 19, 2011 at 11:38 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> Hi Andrei,
>>>
>>> Andrei Warkentin wrote:
>>>> On Wed, May 18, 2011 at 9:37 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>>> Hi Andrei
>>>>>
>>>>> Andrei Warkentin wrote:
>>>>>> CMD23-prefixed instead of open-ended multiblock transfers
>>>>>> have a performance advantage on some MMC cards.
>>>>>>
>>>>> you mentioned about "some MMC cards".
>>>>> Conversely, that means the some card didn't have a performance advantage?
>>>>>
>>>>> Did you find the performance advantage?
>>>>> if you found the advantage and you can tell me,
>>>>> i want to know what do you have the some MMC cards..
>>>>>
>>>> I've tested this on a Sandisk eMMC where I saw as good as
>>>> a 50% improvement on writes (30% real-life use cases). This was a
>>>> SEM32G 4.3+ part.
>>> Can you tell me your environment? buswidth, AP information, benchmark etc..
>>> And if you have the performance result's data, can you share them?
>>>
>> This was on an SDHCI controller (hence the patch...) on a Tegra
>> 2-based system. I was measuring
>> throughput on reads and writes (obviously without block cache,
>> filesystem, etc) to an eMMC card, 8 bits.
>>
>> Tested both with my tool (https://github.com/andreiw/superalign) and
>> an sqllite-based test.
>>
>> I'm attaching the data I have.
>>
>> A
>>
> 
> Additionally, CMD23 use is a requirement for SDXC cards (Arindam can
> comment on that), as well as for MMC reliable writes and eMMC 4.5-spec
> features (Yunpeng Gao can comment on that).
> 
> These patches allow CMD23 use. They do involve a some changes to host
> controller because of interaction with CMD12, as well as Auto-CMD12
> and Auto-CMD23 features. I can definitely consult you if you need help
> implementing CMD23 support for whatever controller you develop for.
> 
> A
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

