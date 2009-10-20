From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Tue, 20 Oct 2009 11:55:49 -0700
Message-ID: <5e088bd90910201155p63996ea3i821beb09a7b7ba15@mail.gmail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>
	 <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com>
	 <4ADB4604.2090704@googlemail.com>
	 <13B9B4C6EF24D648824FF11BE8967162039B3184F0@dlee02.ent.ti.com>
	 <4b73d43f0910181717i9623184mc2b8c7d6ca0fb435@mail.gmail.com>
	 <4b73d43f0910181724q11d40851wb2aed801d7ae85f6@mail.gmail.com>
	 <005101ca50e1$11ef2770$544ff780@am.dhcp.ti.com>
	 <4b73d43f0910191439o30fd1de6odab8ccd5e5430760@mail.gmail.com>
	 <4ADD40EA.9020200@googlemail.com>
	 <4b73d43f0910201145q388837adr2b790e3dc1ef5e52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4b73d43f0910201145q388837adr2b790e3dc1ef5e52@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: John Rigby <jcrigby@gmail.com>
Cc: Dirk Behme <dirk.behme@googlemail.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Madhusudhan <madhu.cr@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Oct 20, 2009 at 11:45 AM, John Rigby <jcrigby@gmail.com> wrote:
> It is still a work in progress because I have hacked the sdio_irq
> thread to poll all the time. =A0I won't get a chance to do a proper f=
ix
> for a couple of days at least.
>
> The main part of the fix was just turning on the cptl in the same
> place you turn on the cirq bit.
>
> Send me a reminder If you get no offers of testing help from anyone
> else and I'll try to use my beagle board and wifi card with a modern
> kernel.

I'm happy to test on Overo.

Steve

> John
>
> On Mon, Oct 19, 2009 at 10:47 PM, Dirk Behme <dirk.behme@googlemail.c=
om> wrote:
>> John Rigby wrote:
>>>
>>> All,
>>>
>>> Sorry for the delay, I have been without internet access until just=
 now.
>>>
>>> I added the cptl bit and I don't get continuous cirqs anymore.
>>>
>>> Right now I have a hacked driver that still does timed polling in
>>> sdio_irq.c
>>> and also wakes up on cirq. =A0With this config the libertas works w=
ell. =A0A
>>> flood ping of 1000 packets loses 2. =A0Previously it was dropping a=
bout 30%
>>> of
>>> the packets from a flood ping.
>>
>> Great!! :)
>>
>>> Without the polling in sdio_irq.c I get timeouts in libertas driver=
 so I
>>> suspect that we may need to add checks of the DAT1 line in other pl=
aces
>>> like
>>> the davinci driver does. =A0As I said before, my kernel is a few mo=
nths old
>>> so
>>> my issues may not be the same as current head of tree.
>>
>> Do you like to send your changes anyway? Just for reference...
>>
>>> Thanks to all who helped on this.
>>
>> Now, the job will be to do this with recent kernel, make it stable a=
nd in
>> the mid term get it applied.
>>
>> Anybody likes to help with this?
>>
>> Many thanks and best regards
>>
>> Dirk
>>
>>> On Mon, Oct 19, 2009 at 11:24 AM, Madhusudhan <madhu.cr@ti.com> wro=
te:
>>>
>>>> =A0Hi John,
>>>>
>>>>
>>>>
>>>> So does the SDIO card interrupt mode work fine now?
>>>>
>>>>
>>>>
>>>> Regards,
>>>>
>>>> Madhu
>>>>
>>>>
>>>> =A0------------------------------
>>>>
>>>> *From:* John Rigby [mailto:jcrigby@gmail.com]
>>>> *Sent:* Sunday, October 18, 2009 7:24 PM
>>>> *To:* Woodruff, Richard
>>>> *Cc:* Dirk Behme; Chikkature Rajashekar, Madhusudhan;
>>>> linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Steve Sakom=
an
>>>> *Subject:* Re: MMC_CAP_SDIO_IRQ for omap 3430
>>>>
>>>>
>>>>
>>>> Ok I was going to ask where you found that but I just rechecked th=
e TRM
>>>> and
>>>> there it is in plain site:
>>>>
>>>> =A0When this bit is set to 1, the host controller automatically di=
sables
>>>> all
>>>> the input buffers except the buffer of mmci_dat[1] outside of a
>>>> transaction
>>>> in order to detect asynchronous card interrupt on mmci_dat[1] line=
 and
>>>> minimize the leakage current of the buffers.
>>>>
>>>>
>>>> In my defence, I did search the TRM for every occurance of dat1 bu=
t not
>>>> dat[1]. =A0Oh well live and learn and forget and repeat.
>>>>
>>>> John
>>>>
>>>> On Sun, Oct 18, 2009 at 6:17 PM, John Rigby <jcrigby@gmail.com> wr=
ote:
>>>>>
>>>>> Richard,
>>>>>
>>>>> MMCHS_CON.CPTL =3D 1 =A0< Don't disable input buffer on DAT1 afte=
r
>>>>> completion to allow seeing SDIO interrupt>
>>>>>
>>>>> Sounds exactly like what we need.
>>>>>
>>>>> Thanks
>>>>> John
>>>>>
>>>>> On Sun, Oct 18, 2009 at 5:12 PM, Woodruff, Richard <r-woodruff2@t=
i.com>
>>>>
>>>> wrote:
>>>>>>>
>>>>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>>>>> owner@vger.kernel.org] On Behalf Of Dirk Behme
>>>>>>> Sent: Sunday, October 18, 2009 11:45 AM
>>>>>>>>
>>>>>>>> It would be funny if the TRM was wrong and the CIRQ bit is rea=
lly
>>>>>>>> cleared by writing 1 to it. =A0I'll try that.
>>>>>>
>>>>>> A while back I hunted down a few of the bits for this. =A0Maybe =
this will
>>>>
>>>> help some.
>>>>>>
>>>>>> SYSCONFIG.ENAWAKEUP =3D 1 < allow ocp wrapper to generate an int=
errupt to
>>>>
>>>> prcm>
>>>>>>
>>>>>> MMCHS_HCTL.IWE =3D 1 < route wake up to module ocp wrapper>
>>>>>> MMCHS_CON.CPTL =3D 1 =A0< Don't disable input buffer on DAT1 aft=
er
>>>>
>>>> completion to allow seeing SDIO interrupt>
>>>>>>
>>>>>> MMCHS_HCTL.IWE
>>>>>> MMCHS_ISE.CIRQ_ENABLE <bit to write to enable interrupt at pin>
>>>>>> MMCHS_STAT<bit to write for clear of SDIO interrupt>
>>>>>> CCCCR - IRQ_ENABLE (think host stack will do this)
>>>>>>
>>>>>> Regards,
>>>>>> Richard W.
>>>>>>
>>>
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
