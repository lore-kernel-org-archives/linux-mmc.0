From: Juergen Borleis <jbe@pengutronix.de>
Subject: Re: [RFC] i.MX25/35/SDHCI: switch off DMA usage
Date: Tue, 14 Apr 2015 11:42:00 +0200
Message-ID: <201504141142.00237.jbe@pengutronix.de>
References: <201503271152.04348.jbe@pengutronix.de> <20150327114400.GA20277@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49373 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbbDNJj2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2015 05:39:28 -0400
In-Reply-To: <20150327114400.GA20277@shlinux1.ap.freescale.net>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org

Hi,

On Friday 27 March 2015 12:44:03 Dong Aisheng wrote:
> On Fri, Mar 27, 2015 at 11:52:04AM +0100, Juergen Borleis wrote:
> > DMA and the required overhead on very small data blocks seems an
> > expensive operation. Due to erratum ENGCM07207 for i.MX25 and i.MX3=
5 SoCs
> > the support for multiblock transfers is disabled which results into=
 a
> > huge amount of single 512 byte sector transfers and interrupts. Thi=
s
> > slows down the transmission speed to below 500 kiB/s (even at 50 MH=
z SD
> > card clock). Using PIO instead of DMA to avoid ENGCM07207 happens a=
nd
> > re-enabling multiblock transfers again improve the transmission
> > capability up to about 2.5 MiB/s.
> >
> > I'm still not sure if ENGCM07207 is related to DMA only and can not
> > happen when PIO is used instead. Someone out there with experience
> > regarding this topic?
>
> The errata does not state it's related to DMA only.
> http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf
> I could double check with our IC guys to confirm it.

Gentle ping.

Regards,
Juergen

--=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| Juergen Borleis =A0 =A0 =A0 =A0 =A0 =A0 |
Industrial Linux Solutions               =A0 =A0 =A0| http://www.pengut=
ronix.de/  |
