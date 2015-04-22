From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [RFC] i.MX25/35/SDHCI: switch off DMA usage
Date: Wed, 22 Apr 2015 15:33:00 +0800
Message-ID: <20150422073258.GB25437@shlinux1.ap.freescale.net>
References: <201503271152.04348.jbe@pengutronix.de>
 <20150327114400.GA20277@shlinux1.ap.freescale.net>
 <201504141142.00237.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201504141142.00237.jbe@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Borleis <jbe@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, eric@eukrea.com
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 14, 2015 at 11:42:00AM +0200, Juergen Borleis wrote:
> Hi,
>=20
> On Friday 27 March 2015 12:44:03 Dong Aisheng wrote:
> > On Fri, Mar 27, 2015 at 11:52:04AM +0100, Juergen Borleis wrote:
> > > DMA and the required overhead on very small data blocks seems an
> > > expensive operation. Due to erratum ENGCM07207 for i.MX25 and i.M=
X35 SoCs
> > > the support for multiblock transfers is disabled which results in=
to a
> > > huge amount of single 512 byte sector transfers and interrupts. T=
his
> > > slows down the transmission speed to below 500 kiB/s (even at 50 =
MHz SD
> > > card clock). Using PIO instead of DMA to avoid ENGCM07207 happens=
 and
> > > re-enabling multiblock transfers again improve the transmission
> > > capability up to about 2.5 MiB/s.
> > >
> > > I'm still not sure if ENGCM07207 is related to DMA only and can n=
ot
> > > happen when PIO is used instead. Someone out there with experienc=
e
> > > regarding this topic?
> >
> > The errata does not state it's related to DMA only.
> > http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf
> > I could double check with our IC guys to confirm it.
>=20
> Gentle ping.
>=20

Hi Juergen,

Got the info from our IC guy.
PIO mode is not related to AHB access, so AHB hang is not exist.
But, he supposes the incorrect state machine of IP after sending CMD12 =
should
also exist on PIO mode. We may still needs reset the controller after s=
ending
CMD12.(Reset before sending CMD12 should also work)

BTW the errata already indicates a workaround for AHB hang:
"To abort data transfers on the AHB, software can reset the eSDHC by
writing 1 to SYSCTL[24] (RSTA)."

So the issue could be avoided by reset controller.

And the current SDHCI driver already does reset if any error(cmd or dat=
a)
happens, and current MMC core seems only sending stop command when meet=
s error.
(not sending stop during normal transfer).
So it looks to me the issue may already be workarounded and can not
be reproduced.

I'm not sure if anyone really meets the issue.

By googling the original post of this patch, it seems the patch
owner also did not reproduce this issue.
See:
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/0298=
18.html

I would suggest someone who has the MX35/MX25 boards, to run the test a=
gain by
manually triggering a data error.(e.g: shorting data line to ground dur=
ing
transfer). Then to see if the controller can still work well.

If can not reproduce, then we can remove this errata and back to DMA mo=
de.

Regards
Dong Aisheng

> Regards,
> Juergen
>=20
> --=20
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| Juergen Borleis =A0 =A0 =A0 =A0 =A0 =A0 |
> Industrial Linux Solutions               =A0 =A0 =A0| http://www.peng=
utronix.de/  |
