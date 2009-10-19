From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: MMC_CAP_SDIO_IRQ for omap 3430
Date: Mon, 19 Oct 2009 12:27:54 -0500
Message-ID: <005d01ca50e1$7de5db40$544ff780@am.dhcp.ti.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com> <4AD81DC2.4080607@googlemail.com> <42153.192.168.10.89.1255715021.squirrel@dbdmail.itg.ti.com> <4AD8C959.1000004@googlemail.com> <004701ca4ea5$aeacefe0$544ff780@am.dhcp.ti.com> <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com> <4ADB4604.2090704@googlemail.com> <13B9B4C6EF24D648824FF11BE8967162039B3184F0@dlee02.ent.ti.com> <4b73d43f0910181717i9623184mc2b8c7d6ca0fb435@mail.gmail.com> <4b73d43f0910181724q11d40851wb2aed801d7ae85f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53175 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752982AbZJSR1v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Oct 2009 13:27:51 -0400
In-Reply-To: <4b73d43f0910181724q11d40851wb2aed801d7ae85f6@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'John Rigby' <jcrigby@gmail.com>, "'Woodruff, Richard'" <r-woodruff2@ti.com>
Cc: 'Dirk Behme' <dirk.behme@googlemail.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, 'Steve Sakoman' <sakoman@gmail.com>



________________________________________
=46rom: John Rigby [mailto:jcrigby@gmail.com]=20
Sent: Sunday, October 18, 2009 7:24 PM
To: Woodruff, Richard
Cc: Dirk Behme; Chikkature Rajashekar, Madhusudhan;
linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Steve Sakoman
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430

Ok I was going to ask where you found that but I just rechecked the TRM=
 and
there it is in plain site:

When this bit is set to 1, the host controller automatically disables a=
ll
the input buffers except the buffer of mmci_dat[1] outside of a transac=
tion
in order to detect asynchronous card interrupt on mmci_dat[1] line and
minimize the leakage current of the buffers.

In my defence, I did search the TRM for every occurance of dat1 but not
dat[1].=A0 Oh well live and learn and forget and repeat.

John

So, Does the SDIO card interrupt mode work fine now?

Regards,
Madhu

On Sun, Oct 18, 2009 at 6:17 PM, John Rigby <jcrigby@gmail.com> wrote:
> Richard,
>
> MMCHS_CON.CPTL =3D 1 =A0< Don't disable input buffer on DAT1 after
> completion to allow seeing SDIO interrupt>
>
> Sounds exactly like what we need.
>
> Thanks
> John
>
> On Sun, Oct 18, 2009 at 5:12 PM, Woodruff, Richard <r-woodruff2@ti.co=
m>
wrote:
>>
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> owner@vger.kernel.org] On Behalf Of Dirk Behme
>>> Sent: Sunday, October 18, 2009 11:45 AM
>>
>>> > It would be funny if the TRM was wrong and the CIRQ bit is really
>>> > cleared by writing 1 to it. =A0I'll try that.
>>
>> A while back I hunted down a few of the bits for this. =A0Maybe this=
 will
help some.
>>
>> SYSCONFIG.ENAWAKEUP =3D 1 < allow ocp wrapper to generate an interru=
pt to
prcm>
>> MMCHS_HCTL.IWE =3D 1 < route wake up to module ocp wrapper>
>> MMCHS_CON.CPTL =3D 1 =A0< Don't disable input buffer on DAT1 after c=
ompletion
to allow seeing SDIO interrupt>
>> MMCHS_HCTL.IWE
>> MMCHS_ISE.CIRQ_ENABLE <bit to write to enable interrupt at pin>
>> MMCHS_STAT<bit to write for clear of SDIO interrupt>
>> CCCCR - IRQ_ENABLE (think host stack will do this)
>>
>> Regards,
>> Richard W.
>>
>

