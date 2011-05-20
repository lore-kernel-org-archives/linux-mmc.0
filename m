From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [[v4] 2/5] MMC: Use CMD23 for multiblock transfers when we can.
Date: Fri, 20 May 2011 18:05:41 +0900
Message-ID: <4DD62EE5.8040604@samsung.com>
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
Received: from mailout2.samsung.com ([203.254.224.25]:15918 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934436Ab1ETJFr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2011 05:05:47 -0400
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LLH004OML98GCH0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 20 May 2011 18:05:45 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LLH0042SL9KJB@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 20 May 2011 18:05:44 +0900 (KST)
In-reply-to: <BANLkTi=mpibUJLJTCcf+i7=PgPBUFecgRw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org, arnd@arndb.de, Kyungmin Park <kyungmin.park@samsung.com>, "Gao, Yunpeng" <yunpeng.gao@intel.com>

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

I used two host-controller (sdhci and dw_mmc). you implemented them in sdhci.
I applied your patch then tested CMD23...but i didn't applied  auto-CMD23.
I known that auto-CMD23 supported at SD3.0..right?
My controller is supported SD2.0..

If you can consult me, too much helpful to me..

Regards,
Jaehoon Chung


