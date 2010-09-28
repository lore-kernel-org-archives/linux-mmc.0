From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: [PATCH 6/6] mmc: sdhci-pltfm: add pltfm-driver for imx35/51
Date: Tue, 28 Sep 2010 21:57:01 +0100
Message-ID: <20100928205701.GK27885@trinity.fluff.org>
References: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de> <1285677406-3359-7-git-send-email-w.sang@pengutronix.de> <AANLkTikHMXV+Bkg=fQEhw-2WszT3PeKwWvswrE-7h1EM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:50960 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472Ab0I1U5F (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Sep 2010 16:57:05 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikHMXV+Bkg=fQEhw-2WszT3PeKwWvswrE-7h1EM@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, Philip Rakity <prakity@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Saeed Bishara <saeed@marvell.com>

On Tue, Sep 28, 2010 at 10:04:14AM -0400, zhangfei gao wrote:
> On Tue, Sep 28, 2010 at 8:36 AM, Wolfram Sang <w.sang@pengutronix.de>=
 wrote:
> > This driver adds basic support for the esdhc-core found on e.g.
> > imx35/51. It adds up to the pltfm-core.
> >
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > ---
> >
> > Changes since last version:
> >
> > * some "-imx" suffixes added
> > * some cosmetic improvements
> >
> > Thanks to Anton for those.
> >
> > =A0drivers/mmc/host/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 10 +++
> > =A0drivers/mmc/host/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> > =A0drivers/mmc/host/sdhci-esdhc-imx.c | =A0144 ++++++++++++++++++++=
++++++++++++++++
> > =A0drivers/mmc/host/sdhci-pltfm.c =A0 =A0 | =A0 =A03 +
> > =A0drivers/mmc/host/sdhci-pltfm.h =A0 =A0 | =A0 =A01 +
> > =A05 files changed, 159 insertions(+), 0 deletions(-)
> > =A0create mode 100644 drivers/mmc/host/sdhci-esdhc-imx.c
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 6f12d5d..815bf0f 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -143,6 +143,16 @@ config MMC_SDHCI_MV
> >
> > =A0 =A0 =A0 =A0 =A0If unsure, say N.
> >
> > +config MMC_SDHCI_ESDHC
> > + =A0 =A0 =A0 bool "SDHCI platform support for the Freescale eSDHC =
controller"
> > + =A0 =A0 =A0 depends on MMC_SDHCI_PLTFM
> > + =A0 =A0 =A0 select MMC_SDHCI_IO_ACCESSORS
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 This selects the Freescale eSDHC controller suppo=
rt on the platform
> > + =A0 =A0 =A0 =A0 bus, found on platforms like mx35/51.
> > +
> > + =A0 =A0 =A0 =A0 If unsure, say N.
> > +
> > =A0config MMC_SDHCI_S3C
> > =A0 =A0 =A0 =A0tristate "SDHCI support on Samsung S3C SoC"
> > =A0 =A0 =A0 =A0depends on MMC_SDHCI && PLAT_SAMSUNG
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index ef32c32..5294425 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -38,6 +38,7 @@ obj-$(CONFIG_MMC_USHC) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0+=3D ushc.o
> > =A0obj-$(CONFIG_MMC_SDHCI_PLTFM) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
+=3D sdhci-platform.o
> > =A0sdhci-platform-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 :=3D sdhci-pltfm.o
> > =A0sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX) =A0 =A0 +=3D sdhci-cn=
s3xxx.o
> > +sdhci-platform-$(CONFIG_MMC_SDHCI_ESDHC) =A0 =A0 =A0 +=3D sdhci-es=
dhc-imx.o
> >
> > =A0obj-$(CONFIG_MMC_SDHCI_OF) =A0 =A0 +=3D sdhci-of.o
> > =A0sdhci-of-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 :=3D sdhci-of-core.o
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/=
sdhci-esdhc-imx.c
> > new file mode 100644
> > index 0000000..c43d448
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -0,0 +1,144 @@
> > +/*
> > + * Freescale eSDHC controller driver for the platform bus.
> > + *
> > + * derived from the OF-version.
> > + *
> > + * Copyright (c) 2010 Pengutronix e.K.
> > + * =A0 Author: Wolfram Sang <w.sang@pengutronix.de>
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License as publish=
ed by
> > + * the Free Software Foundation; either version 2 of the License.
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/clk.h>
> > +#include <linux/mmc/host.h>
> > +#include <linux/mmc/sdhci-pltfm.h>
> > +#include "sdhci.h"
> > +#include "sdhci-pltfm.h"
> > +#include "sdhci-esdhc.h"
> > +
> > +static inline void esdhc_clrset_le(struct sdhci_host *host, u32 ma=
sk, u32 val, int reg)
> > +{
> > + =A0 =A0 =A0 void __iomem *base =3D host->ioaddr + (reg & ~0x3);
> > + =A0 =A0 =A0 u32 shift =3D (reg & 0x3) * 8;
> > +
> > + =A0 =A0 =A0 writel(((readl(base) & ~(mask << shift)) | (val << sh=
ift)), base);
> > +}
> > +
> > +static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
> > +{
> > + =A0 =A0 =A0 if (unlikely(reg =3D=3D SDHCI_HOST_VERSION))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg ^=3D 2;
> > +
> > + =A0 =A0 =A0 return readw(host->ioaddr + reg);
> > +}
> > +
> > +static void esdhc_writew_le(struct sdhci_host *host, u16 val, int =
reg)
> > +{
> > + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(ho=
st);
> > +
> > + =A0 =A0 =A0 switch (reg) {
> > + =A0 =A0 =A0 case SDHCI_TRANSFER_MODE:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Postpone this write, we must do =
it together with a
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* command write that is down below=
=2E
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pltfm_host->scratchpad =3D val;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 case SDHCI_COMMAND:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(val << 16 | pltfm_host->scratc=
hpad,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ioaddr + SDHCI_=
TRANSFER_MODE);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 case SDHCI_BLOCK_SIZE:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~SDHCI_MAKE_BLKSZ(0x7, 0);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 esdhc_clrset_le(host, 0xffff, val, reg);
> > +}
> > +
> > +static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int r=
eg)
> > +{
> > + =A0 =A0 =A0 u32 new_val;
> > +
> > + =A0 =A0 =A0 switch (reg) {
> > + =A0 =A0 =A0 case SDHCI_POWER_CONTROL:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* FSL put some DMA bits here
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If your board has a regulator, c=
ode should be here
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 case SDHCI_HOST_CONTROL:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FSL messed up here, so we can just=
 keep those two */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_val =3D val & (SDHCI_CTRL_LED | S=
DHCI_CTRL_4BITBUS);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* ensure the endianess */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_val |=3D ESDHC_HOST_CONTROL_LE;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DMA mode bits are shifted */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_val |=3D (val & SDHCI_CTRL_DMA_MA=
SK) << 5;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 esdhc_clrset_le(host, 0xffff, new_val=
, reg);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 esdhc_clrset_le(host, 0xff, val, reg);
> > +}
> > +
> > +static unsigned int esdhc_pltfm_get_max_clock(struct sdhci_host *h=
ost)
> > +{
> > + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(ho=
st);
> > +
> > + =A0 =A0 =A0 return clk_get_rate(pltfm_host->clk);
> > +}
> > +
> > +static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *h=
ost)
> > +{
> > + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(ho=
st);
> > +
> > + =A0 =A0 =A0 return clk_get_rate(pltfm_host->clk) / 256 / 16;
> > +}

the above always confuses me, how about a / (b * c) or similar?

> > +static int esdhc_pltfm_init(struct sdhci_host *host,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sdhci_pltfm_data *pdata, void =
*priv_pdata)
> > +{
> > + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(ho=
st);
> > + =A0 =A0 =A0 struct clk *clk;
> > +
> > + =A0 =A0 =A0 clk =3D clk_get(NULL, "sdhc");
>=20
> Here only could support one device, how about several device, for
> example sdhc.0, sdhc.1 sdhc.2, if using this method, they will get th=
e
> first clock.
> Then sdhc.1 sdhc.2 can not work.

No, clk_get() should be passed the device and a NULL for preference.

The main match should be made on the device, and the name is an optiona=
l
distinguisher for devices that have multiple clock sources.

> > --- a/drivers/mmc/host/sdhci-pltfm.c
> > +++ b/drivers/mmc/host/sdhci-pltfm.c
> > @@ -169,6 +169,9 @@ static const struct platform_device_id sdhci_pl=
tfm_ids[] =3D {
> > =A0#ifdef CONFIG_MMC_SDHCI_CNS3XXX
> > =A0 =A0 =A0 =A0{ "sdhci-cns3xxx", (kernel_ulong_t)&sdhci_cns3xxx_pd=
ata },
> > =A0#endif
> > +#ifdef CONFIG_MMC_SDHCI_ESDHC
> > + =A0 =A0 =A0 { "sdhci-esdhc-imx", (kernel_ulong_t)&sdhci_esdhc_imx=
_pdata },
> > +#endif
> > =A0 =A0 =A0 =A0{ },

I'd much prefer to see these outside of the sdhci-pltfm.c, this sort of
#ifdef went out of other drivers with the end of the caveman.

My preference would be to rework the sdhci-pltfm.c to be the 'core'
implementation called by each driver. I'll have a look at posting
some patches to see what can be done to sort this out.

--=20
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

