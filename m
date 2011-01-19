From: Simon Horman <horms@verge.net.au>
Subject: Re: SDHC Read Performance
Date: Wed, 19 Jan 2011 17:05:49 +0900
Message-ID: <20110119080542.GE1960@verge.net.au>
References: <20110119000909.GA9412@verge.net.au>
 <AANLkTinNtL0v2cnhz7Ci+a8TqQTcQXBMVW5EkX8qujy+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinNtL0v2cnhz7Ci+a8TqQTcQXBMVW5EkX8qujy+@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 19, 2011 at 12:14:40PM +0900, Magnus Damm wrote:
> Hi Simon,
>=20
> On Wed, Jan 19, 2011 at 9:09 AM, Simon Horman <horms@verge.net.au> wr=
ote:
> > Hi,
> >
> > I am currently interested in the read performance of the SDHI drive=
r. =C2=A0I
> > ran the following tests on a Mackerel board using Linus's latest tr=
ee
> > (6845a44a), which I believe has all of the outstanding patches from=
 Arnd
> > and Guennadi merged.
>=20
> Nice, thanks for testing this.
>=20
> > I have made the following crude performance measurements using
> > several different cards.
> >
> > dd if=3D/dev/mmcblk1 of=3D/dev/null bs=3D512 count=3D100000
> >
> > SD1.1: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07.0 MB/s
> > SD2.0: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07.0 MB/s
> > SDHC Class 2: =C2=A0 7.1 MB/s
> > SDHC Class 10: =C2=A07.2 MB/s
> >
> > Whereas I would expect something like:
> >
> > SD1.1 card: =C2=A0 =C2=A0 12 MB/s
> > SD2.0 card: =C2=A0 =C2=A0 24 MB/s
> > SDHC Class 2: =C2=A0 24 MB/s
> > SDHC Class 10: =C2=A0Faster?
>=20
> Please have a look at the clock frequency set by the SDHI MFD driver
> (hclk), together with the tmio-mmc settings in tmio_mmc_set_clock().
> For the clock to be bumped up properly some capability/feature flags
> may be needed:
>=20
> MMC_CAP_MMC_HIGHSPEED
> MMC_CAP_SD_HIGHSPEED
>=20
> Not sure if they are set properly. Probably not.

Actually this is one thing that I did check, sorry for not mentioning i=
t.
The clock does seem to be set correctly, to 50Mhz for the high-speed ca=
se,
which iirc is everything except SD1.1.

> > Possibly relevant portions of my .config are:
> >
> > CONFIG_MFD_SH_MOBILE_SDHI=3Dy
> > CONFIG_TMIO_MMC_DMA=3Dy
> > CONFIG_MMC_TMIO=3Dy
>=20
> These two are also relevant:
>=20
> CONFIG_SH_DMAE=3Dy
> CONFIG_DMA_ENGINE=3Dy
>=20
> DMA controller platform data is also needed, not sure the state of
> your board. You can check out the counters in /proc/interrupts to see
> if the DMA controller is active or not.

Thanks!

I have CONFIG_DMA_ENGINE but not CONFIG_SH_DMAE.
