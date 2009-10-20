From: John Rigby <jcrigby@gmail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Tue, 20 Oct 2009 12:45:51 -0600
Message-ID: <4b73d43f0910201145q388837adr2b790e3dc1ef5e52@mail.gmail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>
	 <004701ca4ea5$aeacefe0$544ff780@am.dhcp.ti.com>
	 <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com>
	 <4ADB4604.2090704@googlemail.com>
	 <13B9B4C6EF24D648824FF11BE8967162039B3184F0@dlee02.ent.ti.com>
	 <4b73d43f0910181717i9623184mc2b8c7d6ca0fb435@mail.gmail.com>
	 <4b73d43f0910181724q11d40851wb2aed801d7ae85f6@mail.gmail.com>
	 <005101ca50e1$11ef2770$544ff780@am.dhcp.ti.com>
	 <4b73d43f0910191439o30fd1de6odab8ccd5e5430760@mail.gmail.com>
	 <4ADD40EA.9020200@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f199.google.com ([209.85.216.199]:47241 "EHLO
	mail-px0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbZJTSxO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Oct 2009 14:53:14 -0400
In-Reply-To: <4ADD40EA.9020200@googlemail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Madhusudhan <madhu.cr@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, Steve Sakoman <sakoman@gmail.com>

It is still a work in progress because I have hacked the sdio_irq
thread to poll all the time.  I won't get a chance to do a proper fix
for a couple of days at least.

The main part of the fix was just turning on the cptl in the same
place you turn on the cirq bit.

Send me a reminder If you get no offers of testing help from anyone
else and I'll try to use my beagle board and wifi card with a modern
kernel.

John

On Mon, Oct 19, 2009 at 10:47 PM, Dirk Behme <dirk.behme@googlemail.com=
> wrote:
> John Rigby wrote:
>>
>> All,
>>
>> Sorry for the delay, I have been without internet access until just =
now.
>>
>> I added the cptl bit and I don't get continuous cirqs anymore.
>>
>> Right now I have a hacked driver that still does timed polling in
>> sdio_irq.c
>> and also wakes up on cirq. =A0With this config the libertas works we=
ll. =A0A
>> flood ping of 1000 packets loses 2. =A0Previously it was dropping ab=
out 30%
>> of
>> the packets from a flood ping.
>
> Great!! :)
>
>> Without the polling in sdio_irq.c I get timeouts in libertas driver =
so I
>> suspect that we may need to add checks of the DAT1 line in other pla=
ces
>> like
>> the davinci driver does. =A0As I said before, my kernel is a few mon=
ths old
>> so
>> my issues may not be the same as current head of tree.
>
> Do you like to send your changes anyway? Just for reference...
>
>> Thanks to all who helped on this.
>
> Now, the job will be to do this with recent kernel, make it stable an=
d in
> the mid term get it applied.
>
> Anybody likes to help with this?
>
> Many thanks and best regards
>
> Dirk
>
>> On Mon, Oct 19, 2009 at 11:24 AM, Madhusudhan <madhu.cr@ti.com> wrot=
e:
>>
>>> =A0Hi John,
>>>
>>>
>>>
>>> So does the SDIO card interrupt mode work fine now?
>>>
>>>
>>>
>>> Regards,
>>>
>>> Madhu
>>>
>>>
>>> =A0------------------------------
>>>
>>> *From:* John Rigby [mailto:jcrigby@gmail.com]
>>> *Sent:* Sunday, October 18, 2009 7:24 PM
>>> *To:* Woodruff, Richard
>>> *Cc:* Dirk Behme; Chikkature Rajashekar, Madhusudhan;
>>> linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Steve Sakoma=
n
>>> *Subject:* Re: MMC_CAP_SDIO_IRQ for omap 3430
>>>
>>>
>>>
>>> Ok I was going to ask where you found that but I just rechecked the=
 TRM
>>> and
>>> there it is in plain site:
>>>
>>> =A0When this bit is set to 1, the host controller automatically dis=
ables
>>> all
>>> the input buffers except the buffer of mmci_dat[1] outside of a
>>> transaction
>>> in order to detect asynchronous card interrupt on mmci_dat[1] line =
and
>>> minimize the leakage current of the buffers.
>>>
>>>
>>> In my defence, I did search the TRM for every occurance of dat1 but=
 not
>>> dat[1]. =A0Oh well live and learn and forget and repeat.
>>>
>>> John
>>>
>>> On Sun, Oct 18, 2009 at 6:17 PM, John Rigby <jcrigby@gmail.com> wro=
te:
>>>>
>>>> Richard,
>>>>
>>>> MMCHS_CON.CPTL =3D 1 =A0< Don't disable input buffer on DAT1 after
>>>> completion to allow seeing SDIO interrupt>
>>>>
>>>> Sounds exactly like what we need.
>>>>
>>>> Thanks
>>>> John
>>>>
>>>> On Sun, Oct 18, 2009 at 5:12 PM, Woodruff, Richard <r-woodruff2@ti=
=2Ecom>
>>>
>>> wrote:
>>>>>>
>>>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>>>> owner@vger.kernel.org] On Behalf Of Dirk Behme
>>>>>> Sent: Sunday, October 18, 2009 11:45 AM
>>>>>>>
>>>>>>> It would be funny if the TRM was wrong and the CIRQ bit is real=
ly
>>>>>>> cleared by writing 1 to it. =A0I'll try that.
>>>>>
>>>>> A while back I hunted down a few of the bits for this. =A0Maybe t=
his will
>>>
>>> help some.
>>>>>
>>>>> SYSCONFIG.ENAWAKEUP =3D 1 < allow ocp wrapper to generate an inte=
rrupt to
>>>
>>> prcm>
>>>>>
>>>>> MMCHS_HCTL.IWE =3D 1 < route wake up to module ocp wrapper>
>>>>> MMCHS_CON.CPTL =3D 1 =A0< Don't disable input buffer on DAT1 afte=
r
>>>
>>> completion to allow seeing SDIO interrupt>
>>>>>
>>>>> MMCHS_HCTL.IWE
>>>>> MMCHS_ISE.CIRQ_ENABLE <bit to write to enable interrupt at pin>
>>>>> MMCHS_STAT<bit to write for clear of SDIO interrupt>
>>>>> CCCCR - IRQ_ENABLE (think host stack will do this)
>>>>>
>>>>> Regards,
>>>>> Richard W.
>>>>>
>>
>
>
