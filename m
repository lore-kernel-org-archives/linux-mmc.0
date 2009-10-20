From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Tue, 20 Oct 2009 06:47:38 +0200
Message-ID: <4ADD40EA.9020200@googlemail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>	 <42153.192.168.10.89.1255715021.squirrel@dbdmail.itg.ti.com>	 <4AD8C959.1000004@googlemail.com>	 <004701ca4ea5$aeacefe0$544ff780@am.dhcp.ti.com>	 <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com>	 <4ADB4604.2090704@googlemail.com>	 <13B9B4C6EF24D648824FF11BE8967162039B3184F0@dlee02.ent.ti.com>	 <4b73d43f0910181717i9623184mc2b8c7d6ca0fb435@mail.gmail.com>	 <4b73d43f0910181724q11d40851wb2aed801d7ae85f6@mail.gmail.com>	 <005101ca50e1$11ef2770$544ff780@am.dhcp.ti.com> <4b73d43f0910191439o30fd1de6odab8ccd5e5430760@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:46756 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbZJTEsk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Oct 2009 00:48:40 -0400
In-Reply-To: <4b73d43f0910191439o30fd1de6odab8ccd5e5430760@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Rigby <jcrigby@gmail.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Madhusudhan <madhu.cr@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, Steve Sakoman <sakoman@gmail.com>

John Rigby wrote:
> All,
> 
> Sorry for the delay, I have been without internet access until just now.
> 
> I added the cptl bit and I don't get continuous cirqs anymore.
> 
> Right now I have a hacked driver that still does timed polling in sdio_irq.c
> and also wakes up on cirq.  With this config the libertas works well.  A
> flood ping of 1000 packets loses 2.  Previously it was dropping about 30% of
> the packets from a flood ping.

Great!! :)

> Without the polling in sdio_irq.c I get timeouts in libertas driver so I
> suspect that we may need to add checks of the DAT1 line in other places like
> the davinci driver does.  As I said before, my kernel is a few months old so
> my issues may not be the same as current head of tree.

Do you like to send your changes anyway? Just for reference...

> Thanks to all who helped on this.

Now, the job will be to do this with recent kernel, make it stable and 
in the mid term get it applied.

Anybody likes to help with this?

Many thanks and best regards

Dirk

> On Mon, Oct 19, 2009 at 11:24 AM, Madhusudhan <madhu.cr@ti.com> wrote:
> 
>>  Hi John,
>>
>>
>>
>> So does the SDIO card interrupt mode work fine now?
>>
>>
>>
>> Regards,
>>
>> Madhu
>>
>>
>>   ------------------------------
>>
>> *From:* John Rigby [mailto:jcrigby@gmail.com]
>> *Sent:* Sunday, October 18, 2009 7:24 PM
>> *To:* Woodruff, Richard
>> *Cc:* Dirk Behme; Chikkature Rajashekar, Madhusudhan;
>> linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Steve Sakoman
>> *Subject:* Re: MMC_CAP_SDIO_IRQ for omap 3430
>>
>>
>>
>> Ok I was going to ask where you found that but I just rechecked the TRM and
>> there it is in plain site:
>>
>>  When this bit is set to 1, the host controller automatically disables all
>> the input buffers except the buffer of mmci_dat[1] outside of a transaction
>> in order to detect asynchronous card interrupt on mmci_dat[1] line and
>> minimize the leakage current of the buffers.
>>
>>
>> In my defence, I did search the TRM for every occurance of dat1 but not
>> dat[1].  Oh well live and learn and forget and repeat.
>>
>> John
>>
>> On Sun, Oct 18, 2009 at 6:17 PM, John Rigby <jcrigby@gmail.com> wrote:
>>> Richard,
>>>
>>> MMCHS_CON.CPTL = 1  < Don't disable input buffer on DAT1 after
>>> completion to allow seeing SDIO interrupt>
>>>
>>> Sounds exactly like what we need.
>>>
>>> Thanks
>>> John
>>>
>>> On Sun, Oct 18, 2009 at 5:12 PM, Woodruff, Richard <r-woodruff2@ti.com>
>> wrote:
>>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>>> owner@vger.kernel.org] On Behalf Of Dirk Behme
>>>>> Sent: Sunday, October 18, 2009 11:45 AM
>>>>>> It would be funny if the TRM was wrong and the CIRQ bit is really
>>>>>> cleared by writing 1 to it.  I'll try that.
>>>> A while back I hunted down a few of the bits for this.  Maybe this will
>> help some.
>>>> SYSCONFIG.ENAWAKEUP = 1 < allow ocp wrapper to generate an interrupt to
>> prcm>
>>>> MMCHS_HCTL.IWE = 1 < route wake up to module ocp wrapper>
>>>> MMCHS_CON.CPTL = 1  < Don't disable input buffer on DAT1 after
>> completion to allow seeing SDIO interrupt>
>>>> MMCHS_HCTL.IWE
>>>> MMCHS_ISE.CIRQ_ENABLE <bit to write to enable interrupt at pin>
>>>> MMCHS_STAT<bit to write for clear of SDIO interrupt>
>>>> CCCCR - IRQ_ENABLE (think host stack will do this)
>>>>
>>>> Regards,
>>>> Richard W.
>>>>
> 

