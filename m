From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/6] mmc: tmio: split core functionality, DMA and MFD
 glue
Date: Sat, 12 Mar 2011 23:48:26 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103122347270.28741@axis700.grange>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
 <Pine.LNX.4.64.1103110844080.23675@axis700.grange>
 <AANLkTinQB2NB---0o65Uy-axApw9DwPZoMeMBc=qmvSC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <AANLkTinQB2NB---0o65Uy-axApw9DwPZoMeMBc=qmvSC@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Sun, 13 Mar 2011, Magnus Damm wrote:

> On Fri, Mar 11, 2011 at 4:51 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > TMIO MMC chips contain an SD / SDIO IP core from Panasonic, similar=
 to
> > the one, used in MN5774 and other MN57xx controllers. These IP core=
s are
> > included in many multifunction devices, in sh-mobile chips from Ren=
esas,
> > in the latter case they can also use DMA. Some sh-mobile implementa=
tions
> > also have some other specialities, that MFD-based solutions don't h=
ave.
> > This makes supporting all these features in a monolithic driver inc=
onveniet
> > and error-prone. This patch splits the driver into 3 parts: the cor=
e,
> > the MFD glue and the DMA support. In case of a modular build, two m=
odules
> > will be built: mmc_tmio_core and mmc_tmio.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
>=20
> Thanks for your work on this, I'm happy to see these patches because
> they make it easier for me to add multi-interrupt source to the SDHI
> portion - something that is needed for sh73a0.
>=20
> > =A0drivers/mmc/host/Kconfig =A0 =A0 =A0 =A0| =A0 =A04 +
> > =A0drivers/mmc/host/Makefile =A0 =A0 =A0 | =A0 =A03 +
> > =A0drivers/mmc/host/tmio_mmc.c =A0 =A0 | 1303 +--------------------=
------------------
> > =A0drivers/mmc/host/tmio_mmc.h =A0 =A0 | =A0152 +++++
> > =A0drivers/mmc/host/tmio_mmc_dma.c | =A0302 +++++++++
> > =A0drivers/mmc/host/tmio_mmc_pio.c | =A0923 +++++++++++++++++++++++=
++++
> > =A06 files changed, 1402 insertions(+), 1285 deletions(-)
> > =A0create mode 100644 drivers/mmc/host/tmio_mmc.h
> > =A0create mode 100644 drivers/mmc/host/tmio_mmc_dma.c
> > =A0create mode 100644 drivers/mmc/host/tmio_mmc_pio.c
>=20
> Something is wrong with this patch. The Makefile adds tmio_mmc_core.c
> but it's not part of the diffstat above. Perhaps you're posting an
> older version of the patch?

No, the Makefile is adding tmio_mmc_core.o:

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 30aa686..79c42dd 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -29,6 +29,9 @@ endif
 obj-$(CONFIG_MMC_S3C)          +=3D s3cmci.o
 obj-$(CONFIG_MMC_SDRICOH_CS)   +=3D sdricoh_cs.o
 obj-$(CONFIG_MMC_TMIO)         +=3D tmio_mmc.o
+obj-$(CONFIG_MMC_TMIO_CORE)    +=3D tmio_mmc_core.o
+tmio_mmc_core-y                        :=3D tmio_mmc_pio.o
+tmio_mmc_core-$(CONFIG_TMIO_MMC_DMA)   +=3D tmio_mmc_dma.o
 obj-$(CONFIG_MMC_CB710)        +=3D cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)    +=3D via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)         +=3D bfin_sdh.o

which is linked from two source files. Looks correct to me.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
