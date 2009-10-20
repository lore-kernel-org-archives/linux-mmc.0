From: John Rigby <jcrigby@gmail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Tue, 20 Oct 2009 16:59:10 -0600
Message-ID: <4b73d43f0910201559w86ef320q60823077ef0172af@mail.gmail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>
	 <004701ca4ea5$aeacefe0$544ff780@am.dhcp.ti.com>
	 <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com>
	 <4ADB4604.2090704@googlemail.com>
	 <13B9B4C6EF24D648824FF11BE8967162039B3184F0@dlee02.ent.ti.com>
	 <4b73d43f0910181717i9623184mc2b8c7d6ca0fb435@mail.gmail.com>
	 <4b73d43f0910181724q11d40851wb2aed801d7ae85f6@mail.gmail.com>
	 <005101ca50e1$11ef2770$544ff780@am.dhcp.ti.com>
	 <4ADCAD0F.9010107@googlemail.com>
	 <00cb01ca51d7$3fafe130$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <00cb01ca51d7$3fafe130$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: Dirk Behme <dirk.behme@googlemail.com>, linux-omap@vger.kernel.org, "Woodruff, Richard" <r-woodruff2@ti.com>, linux-mmc@vger.kernel.org, Steve Sakoman <sakoman@gmail.com>
List-Id: linux-mmc@vger.kernel.org

In enable_sdio_irq
if enable
  set ctpl
else
  clear ctpl

Again my version is halt baked.  I was just happy that enabling ctpl
prevents the infinitie cirq issue.

On Tue, Oct 20, 2009 at 4:47 PM, Madhusudhan <madhu.cr@ti.com> wrote:
>
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Dirk Behme
>> Sent: Monday, October 19, 2009 1:17 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Madhusudhan; 'John Rigby'; 'Woodruff, Richard'; linux-
>> mmc@vger.kernel.org; 'Steve Sakoman'
>> Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
>>
>> Madhusudhan wrote:
>> > Hi John,
>> >
>> > So does the SDIO card interrupt mode work fine now?
>>
>> (wrong attachment in previous mail :( sorry)
>>
>> If somebody likes to test, my updated patch v2 in attachment. Compil=
e
>> tested only, testing and comments are welcome.
>>
>
> Can you inline the v2 patch please? It helps review. I wonder in the =
version
> that John tested was the CTPL bit set in "set_ios" or "enable_sdio_ir=
q"?
>
> Regards,
> Madhu
>
>> Cheers
>>
>> Dirk
>>
>> > =A0 _____
>> >
>> > From: John Rigby [mailto:jcrigby@gmail.com]
>> > Sent: Sunday, October 18, 2009 7:24 PM
>> > To: Woodruff, Richard
>> > Cc: Dirk Behme; Chikkature Rajashekar, Madhusudhan;
>> > linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Steve Sakom=
an
>> > Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
>> >
>> >
>> >
>> > Ok I was going to ask where you found that but I just rechecked th=
e TRM
>> and
>> > there it is in plain site:
>> >
>> >
>> >
>> > When this bit is set to 1, the host controller automatically disab=
les
>> all
>> > the input buffers except the buffer of mmci_dat[1] outside of a
>> transaction
>> > in order to detect asynchronous card interrupt on mmci_dat[1] line=
 and
>> > minimize the leakage current of the buffers.
>> >
>> >
>> > In my defence, I did search the TRM for every occurance of dat1 bu=
t not
>> > dat[1]. =A0Oh well live and learn and forget and repeat.
>> >
>> > John
>> >
>> > On Sun, Oct 18, 2009 at 6:17 PM, John Rigby <jcrigby@gmail.com> wr=
ote:
>> >> Richard,
>> >>
>> >> MMCHS_CON.CPTL =3D 1 =A0< Don't disable input buffer on DAT1 afte=
r
>> >> completion to allow seeing SDIO interrupt>
>> >>
>> >> Sounds exactly like what we need.
>> >>
>> >> Thanks
>> >> John
>> >>
>> >> On Sun, Oct 18, 2009 at 5:12 PM, Woodruff, Richard <r-woodruff2@t=
i.com>
>> > wrote:
>> >>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> >>>> owner@vger.kernel.org] On Behalf Of Dirk Behme
>> >>>> Sent: Sunday, October 18, 2009 11:45 AM
>> >>>>> It would be funny if the TRM was wrong and the CIRQ bit is rea=
lly
>> >>>>> cleared by writing 1 to it. =A0I'll try that.
>> >>> A while back I hunted down a few of the bits for this. =A0Maybe =
this
>> will
>> > help some.
>> >>> SYSCONFIG.ENAWAKEUP =3D 1 < allow ocp wrapper to generate an int=
errupt
>> to
>> > prcm>
>> >>> MMCHS_HCTL.IWE =3D 1 < route wake up to module ocp wrapper>
>> >>> MMCHS_CON.CPTL =3D 1 =A0< Don't disable input buffer on DAT1 aft=
er
>> completion
>> > to allow seeing SDIO interrupt>
>> >>> MMCHS_HCTL.IWE
>> >>> MMCHS_ISE.CIRQ_ENABLE <bit to write to enable interrupt at pin>
>> >>> MMCHS_STAT<bit to write for clear of SDIO interrupt>
>> >>> CCCCR - IRQ_ENABLE (think host stack will do this)
>> >>>
>> >>> Regards,
>> >>> Richard W.
>> >>>
>> >
>> >
>>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
