From: Simon Horman <horms@verge.net.au>
Subject: Re: SDHC Read Performance
Date: Thu, 20 Jan 2011 12:30:21 +0900
Message-ID: <20110120033020.GA32120@verge.net.au>
References: <20110119000909.GA9412@verge.net.au>
 <AANLkTinNtL0v2cnhz7Ci+a8TqQTcQXBMVW5EkX8qujy+@mail.gmail.com>
 <20110119080542.GE1960@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110119080542.GE1960@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 19, 2011 at 05:05:49PM +0900, Simon Horman wrote:
> On Wed, Jan 19, 2011 at 12:14:40PM +0900, Magnus Damm wrote:
> > Hi Simon,
> >=20
> > On Wed, Jan 19, 2011 at 9:09 AM, Simon Horman <horms@verge.net.au> =
wrote:
> > > Hi,
> > >
> > > I am currently interested in the read performance of the SDHI dri=
ver. =C2=A0I
> > > ran the following tests on a Mackerel board using Linus's latest =
tree
> > > (6845a44a), which I believe has all of the outstanding patches fr=
om Arnd
> > > and Guennadi merged.
> >=20
> > Nice, thanks for testing this.
> >=20
> > > I have made the following crude performance measurements using
> > > several different cards.
> > >
> > > dd if=3D/dev/mmcblk1 of=3D/dev/null bs=3D512 count=3D100000
> > >
> > > SD1.1: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07.0 MB/s
> > > SD2.0: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07.0 MB/s
> > > SDHC Class 2: =C2=A0 7.1 MB/s
> > > SDHC Class 10: =C2=A07.2 MB/s
> > >
> > > Whereas I would expect something like:
> > >
> > > SD1.1 card: =C2=A0 =C2=A0 12 MB/s
> > > SD2.0 card: =C2=A0 =C2=A0 24 MB/s
> > > SDHC Class 2: =C2=A0 24 MB/s
> > > SDHC Class 10: =C2=A0Faster?
> >=20
> > Please have a look at the clock frequency set by the SDHI MFD drive=
r
> > (hclk), together with the tmio-mmc settings in tmio_mmc_set_clock()=
=2E
> > For the clock to be bumped up properly some capability/feature flag=
s
> > may be needed:
> >=20
> > MMC_CAP_MMC_HIGHSPEED
> > MMC_CAP_SD_HIGHSPEED
> >=20
> > Not sure if they are set properly. Probably not.
>=20
> Actually this is one thing that I did check, sorry for not mentioning=
 it.
> The clock does seem to be set correctly, to 50Mhz for the high-speed =
case,
> which iirc is everything except SD1.1.
>=20
> > > Possibly relevant portions of my .config are:
> > >
> > > CONFIG_MFD_SH_MOBILE_SDHI=3Dy
> > > CONFIG_TMIO_MMC_DMA=3Dy
> > > CONFIG_MMC_TMIO=3Dy
> >=20
> > These two are also relevant:
> >=20
> > CONFIG_SH_DMAE=3Dy
> > CONFIG_DMA_ENGINE=3Dy
> >=20
> > DMA controller platform data is also needed, not sure the state of
> > your board. You can check out the counters in /proc/interrupts to s=
ee
> > if the DMA controller is active or not.
> {
> Thanks!
>=20
> I have CONFIG_DMA_ENGINE but not CONFIG_SH_DMAE.

I ran my tests again with CONFIG_SH_DMAE (and CONFIG_DMA_ENGINE)
enabled and the results are substantially better. Although
the results are still below the theoretical speeds of the cards.

Read Speed - SHDI
SD1.1:		 9.9 MB/s
SD2.0:		17.2 MB/s
SDHC Class 2:	17.0 MB/s
SDHC Class 10:	17.2 MB/s
MMC4.0:		 8.6 MB/s   <-- Clocked down to 12Mhz due to driver limitation=
s

I also tested the Write Speed
SD1.1:		 2.4 MB/s   <-- Faster than expected
SD2.0:		 2.8 MB/s   <-- Faster than expected
SDHC Class 2:	 2.5 MB/s   <-- Faster than expected
SDHC Class 10:	 3.8 MB/s   <-- Slower than expected
MMC4.0:		 2.1 MB/s   <-- Clocked down to 12Mhz due to driver limitation=
s

=46or reference I obtained the following results on my laptop,
which according to dmesg has a SAMSUNG MMCRE28G VBM1 PQ.

Read
SD1.1:		10.0 MB/s
SD2.0:		19.2 MB/s
SDHC Class 2:	19.4 MB/s
SDHC Class10:	17.9 MB/s  <---- What!!!?
MMC4.0:		 8.2 MB/s

Write
SD1.1:		 2.7 MB/s
SD2.0:		 3.4 MB/s
SDHC Class 2:	 3.1 MB/s
SDHC Class10:	 3.8 MB/s  <---- What!!!?
MMC4.0:		 2.0 MB/s
