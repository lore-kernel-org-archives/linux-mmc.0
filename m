From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Wed, 21 Oct 2009 19:46:23 +0200
Message-ID: <4ADF48EF.8010606@googlemail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>	 <004701ca4ea5$aeacefe0$544ff780@am.dhcp.ti.com>	 <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com>	 <4ADB4604.2090704@googlemail.com>	 <13B9B4C6EF24D648824FF11BE8967162039B3184F0@dlee02.ent.ti.com>	 <4b73d43f0910181717i9623184mc2b8c7d6ca0fb435@mail.gmail.com>	 <4b73d43f0910181724q11d40851wb2aed801d7ae85f6@mail.gmail.com>	 <005101ca50e1$11ef2770$544ff780@am.dhcp.ti.com>	 <4ADCAD0F.9010107@googlemail.com>	 <00cb01ca51d7$3fafe130$544ff780@am.dhcp.ti.com> <4b73d43f0910201559w86ef320q60823077ef0172af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:44121 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207AbZJURrW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2009 13:47:22 -0400
In-Reply-To: <4b73d43f0910201559w86ef320q60823077ef0172af@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Rigby <jcrigby@gmail.com>
Cc: Madhusudhan <madhu.cr@ti.com>, linux-omap@vger.kernel.org, "Woodruff, Richard" <r-woodruff2@ti.com>, linux-mmc@vger.kernel.org, Steve Sakoman <sakoman@gmail.com>

John Rigby wrote:
> In enable_sdio_irq
> if enable
>   set ctpl
> else
>   clear ctpl

It would really help avoiding mails like this if you just would send 
your changes. We know that they are for an old kernel and just a dirty 
hack.

Dirk

> On Tue, Oct 20, 2009 at 4:47 PM, Madhusudhan <madhu.cr@ti.com> wrote:
>>
>>> -----Original Message-----
>>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>>> owner@vger.kernel.org] On Behalf Of Dirk Behme
>>> Sent: Monday, October 19, 2009 1:17 PM
>>> To: linux-omap@vger.kernel.org
>>> Cc: Madhusudhan; 'John Rigby'; 'Woodruff, Richard'; linux-
>>> mmc@vger.kernel.org; 'Steve Sakoman'
>>> Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
>>>
>>> Madhusudhan wrote:
>>>> Hi John,
>>>>
>>>> So does the SDIO card interrupt mode work fine now?
>>> (wrong attachment in previous mail :( sorry)
>>>
>>> If somebody likes to test, my updated patch v2 in attachment. Compile
>>> tested only, testing and comments are welcome.
>>>
>> Can you inline the v2 patch please? It helps review. I wonder in the version
>> that John tested was the CTPL bit set in "set_ios" or "enable_sdio_irq"?
>>
>> Regards,
>> Madhu
>>
>>> Cheers
>>>
>>> Dirk
>>>
>>>>   _____
>>>>
>>>> From: John Rigby [mailto:jcrigby@gmail.com]
>>>> Sent: Sunday, October 18, 2009 7:24 PM
>>>> To: Woodruff, Richard
>>>> Cc: Dirk Behme; Chikkature Rajashekar, Madhusudhan;
>>>> linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Steve Sakoman
>>>> Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
>>>>
>>>>
>>>>
>>>> Ok I was going to ask where you found that but I just rechecked the TRM
>>> and
>>>> there it is in plain site:
>>>>
>>>>
>>>>
>>>> When this bit is set to 1, the host controller automatically disables
>>> all
>>>> the input buffers except the buffer of mmci_dat[1] outside of a
>>> transaction
>>>> in order to detect asynchronous card interrupt on mmci_dat[1] line and
>>>> minimize the leakage current of the buffers.
>>>>
>>>>
>>>> In my defence, I did search the TRM for every occurance of dat1 but not
>>>> dat[1].  Oh well live and learn and forget and repeat.
>>>>
>>>> John
>>>>
>>>> On Sun, Oct 18, 2009 at 6:17 PM, John Rigby <jcrigby@gmail.com> wrote:
>>>>> Richard,
>>>>>
>>>>> MMCHS_CON.CPTL = 1  < Don't disable input buffer on DAT1 after
>>>>> completion to allow seeing SDIO interrupt>
>>>>>
>>>>> Sounds exactly like what we need.
>>>>>
>>>>> Thanks
>>>>> John
>>>>>
>>>>> On Sun, Oct 18, 2009 at 5:12 PM, Woodruff, Richard <r-woodruff2@ti.com>
>>>> wrote:
>>>>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>>>>> owner@vger.kernel.org] On Behalf Of Dirk Behme
>>>>>>> Sent: Sunday, October 18, 2009 11:45 AM
>>>>>>>> It would be funny if the TRM was wrong and the CIRQ bit is really
>>>>>>>> cleared by writing 1 to it.  I'll try that.
>>>>>> A while back I hunted down a few of the bits for this.  Maybe this
>>> will
>>>> help some.
>>>>>> SYSCONFIG.ENAWAKEUP = 1 < allow ocp wrapper to generate an interrupt
>>> to
>>>> prcm>
>>>>>> MMCHS_HCTL.IWE = 1 < route wake up to module ocp wrapper>
>>>>>> MMCHS_CON.CPTL = 1  < Don't disable input buffer on DAT1 after
>>> completion
>>>> to allow seeing SDIO interrupt>
>>>>>> MMCHS_HCTL.IWE
>>>>>> MMCHS_ISE.CIRQ_ENABLE <bit to write to enable interrupt at pin>
>>>>>> MMCHS_STAT<bit to write for clear of SDIO interrupt>
>>>>>> CCCCR - IRQ_ENABLE (think host stack will do this)
>>>>>>
>>>>>> Regards,
>>>>>> Richard W.
>>>>>>
>>>>
>>
>>
> 

