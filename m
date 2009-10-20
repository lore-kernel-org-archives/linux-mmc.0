From: John Rigby <jcrigby@gmail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Mon, 19 Oct 2009 19:13:07 -0600
Message-ID: <4b73d43f0910191813j6089f4a4q3a4768d99cc82e30@mail.gmail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>
	 <42153.192.168.10.89.1255715021.squirrel@dbdmail.itg.ti.com>
	 <4AD8C959.1000004@googlemail.com>
	 <004701ca4ea5$aeacefe0$544ff780@am.dhcp.ti.com>
	 <4b73d43f0910161426l7600f424w5b8345d16790dd21@mail.gmail.com>
	 <4ADB4604.2090704@googlemail.com>
	 <13B9B4C6EF24D648824FF11BE8967162039B3184F0@dlee02.ent.ti.com>
	 <4b73d43f0910181717i9623184mc2b8c7d6ca0fb435@mail.gmail.com>
	 <4b73d43f0910181724q11d40851wb2aed801d7ae85f6@mail.gmail.com>
	 <005101ca50e1$11ef2770$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:55136 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756330AbZJTBND convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Oct 2009 21:13:03 -0400
In-Reply-To: <005101ca50e1$11ef2770$544ff780@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Dirk Behme <dirk.behme@googlemail.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Steve Sakoman <sakoman@gmail.com>

All,

I have sdio working mostly.  With a flood ping of 1000 packets I have
2 dropped.  Before I was seeing 300+ packets dropped.

It is not perfect yet,  I am still polling in sdio_irq.c because
sometimes the card irq does get dropped.  I suspect that is why the
davinci driver had extra checks and calls in various places.

Also apologies for this redundant reply, the last one was rejected by
the vger because of embedded html.

John

On Mon, Oct 19, 2009 at 11:24 AM, Madhusudhan <madhu.cr@ti.com> wrote:
>
> Hi John,
>
>
>
> So does the SDIO card interrupt mode work fine now?
>
>
>
> Regards,
>
> Madhu
>
>
>
> ________________________________
>
> From: John Rigby [mailto:jcrigby@gmail.com]
> Sent: Sunday, October 18, 2009 7:24 PM
> To: Woodruff, Richard
> Cc: Dirk Behme; Chikkature Rajashekar, Madhusudhan; linux-mmc@vger.ke=
rnel.org; linux-omap@vger.kernel.org; Steve Sakoman
> Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
>
>
>
> Ok I was going to ask where you found that but I just rechecked the T=
RM and there it is in plain site:
>
> When this bit is set to 1, the host controller automatically disables=
 all the input buffers except the buffer of mmci_dat[1] outside of a tr=
ansaction in order to detect asynchronous card interrupt on mmci_dat[1]=
 line and minimize the leakage current of the buffers.
>
> In my defence, I did search the TRM for every occurance of dat1 but n=
ot dat[1].=A0 Oh well live and learn and forget and repeat.
>
> John
>
> On Sun, Oct 18, 2009 at 6:17 PM, John Rigby <jcrigby@gmail.com> wrote=
:
> > Richard,
> >
> > MMCHS_CON.CPTL =3D 1 =A0< Don't disable input buffer on DAT1 after
> > completion to allow seeing SDIO interrupt>
> >
> > Sounds exactly like what we need.
> >
> > Thanks
> > John
> >
> > On Sun, Oct 18, 2009 at 5:12 PM, Woodruff, Richard <r-woodruff2@ti.=
com> wrote:
> >>
> >>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >>> owner@vger.kernel.org] On Behalf Of Dirk Behme
> >>> Sent: Sunday, October 18, 2009 11:45 AM
> >>
> >>> > It would be funny if the TRM was wrong and the CIRQ bit is real=
ly
> >>> > cleared by writing 1 to it. =A0I'll try that.
> >>
> >> A while back I hunted down a few of the bits for this. =A0Maybe th=
is will help some.
> >>
> >> SYSCONFIG.ENAWAKEUP =3D 1 < allow ocp wrapper to generate an inter=
rupt to prcm>
> >> MMCHS_HCTL.IWE =3D 1 < route wake up to module ocp wrapper>
> >> MMCHS_CON.CPTL =3D 1 =A0< Don't disable input buffer on DAT1 after=
 completion to allow seeing SDIO interrupt>
> >> MMCHS_HCTL.IWE
> >> MMCHS_ISE.CIRQ_ENABLE <bit to write to enable interrupt at pin>
> >> MMCHS_STAT<bit to write for clear of SDIO interrupt>
> >> CCCCR - IRQ_ENABLE (think host stack will do this)
> >>
> >> Regards,
> >> Richard W.
> >>
> >
