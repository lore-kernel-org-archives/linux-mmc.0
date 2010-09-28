From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 6/6] mmc: sdhci-pltfm: add pltfm-driver for imx35/51
Date: Tue, 28 Sep 2010 10:04:14 -0400
Message-ID: <AANLkTikHMXV+Bkg=fQEhw-2WszT3PeKwWvswrE-7h1EM@mail.gmail.com>
References: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de>
	<1285677406-3359-7-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59800 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755764Ab0I1OEP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 10:04:15 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so6011145iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2010 07:04:14 -0700 (PDT)
In-Reply-To: <1285677406-3359-7-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, Philip Rakity <prakity@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Saeed Bishara <saeed@marvell.com>

On Tue, Sep 28, 2010 at 8:36 AM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
> This driver adds basic support for the esdhc-core found on e.g.
> imx35/51. It adds up to the pltfm-core.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>
> Changes since last version:
>
> * some "-imx" suffixes added
> * some cosmetic improvements
>
> Thanks to Anton for those.
>
> =A0drivers/mmc/host/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 10 +++
> =A0drivers/mmc/host/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/mmc/host/sdhci-esdhc-imx.c | =A0144 ++++++++++++++++++++++=
++++++++++++++
> =A0drivers/mmc/host/sdhci-pltfm.c =A0 =A0 | =A0 =A03 +
> =A0drivers/mmc/host/sdhci-pltfm.h =A0 =A0 | =A0 =A01 +
> =A05 files changed, 159 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/mmc/host/sdhci-esdhc-imx.c
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 6f12d5d..815bf0f 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -143,6 +143,16 @@ config MMC_SDHCI_MV
>
> =A0 =A0 =A0 =A0 =A0If unsure, say N.
>
> +config MMC_SDHCI_ESDHC
> + =A0 =A0 =A0 bool "SDHCI platform support for the Freescale eSDHC co=
ntroller"
> + =A0 =A0 =A0 depends on MMC_SDHCI_PLTFM
> + =A0 =A0 =A0 select MMC_SDHCI_IO_ACCESSORS
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This selects the Freescale eSDHC controller support=
 on the platform
> + =A0 =A0 =A0 =A0 bus, found on platforms like mx35/51.
> +
> + =A0 =A0 =A0 =A0 If unsure, say N.
> +
> =A0config MMC_SDHCI_S3C
> =A0 =A0 =A0 =A0tristate "SDHCI support on Samsung S3C SoC"
> =A0 =A0 =A0 =A0depends on MMC_SDHCI && PLAT_SAMSUNG
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index ef32c32..5294425 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_MMC_USHC) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0+=3D ushc.o
> =A0obj-$(CONFIG_MMC_SDHCI_PLTFM) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=
=3D sdhci-platform.o
> =A0sdhci-platform-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 :=3D sdhci-pltfm.o
> =A0sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX) =A0 =A0 +=3D sdhci-cns3=
xxx.o
> +sdhci-platform-$(CONFIG_MMC_SDHCI_ESDHC) =A0 =A0 =A0 +=3D sdhci-esdh=
c-imx.o
>
> =A0obj-$(CONFIG_MMC_SDHCI_OF) =A0 =A0 +=3D sdhci-of.o
> =A0sdhci-of-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 :=3D sdhci-of-core.o
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sd=
hci-esdhc-imx.c
> new file mode 100644
> index 0000000..c43d448
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -0,0 +1,144 @@
> +/*
> + * Freescale eSDHC controller driver for the platform bus.
> + *
> + * derived from the OF-version.
> + *
> + * Copyright (c) 2010 Pengutronix e.K.
> + * =A0 Author: Wolfram Sang <w.sang@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/sdhci-pltfm.h>
> +#include "sdhci.h"
> +#include "sdhci-pltfm.h"
> +#include "sdhci-esdhc.h"
> +
> +static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask=
, u32 val, int reg)
> +{
> + =A0 =A0 =A0 void __iomem *base =3D host->ioaddr + (reg & ~0x3);
> + =A0 =A0 =A0 u32 shift =3D (reg & 0x3) * 8;
> +
> + =A0 =A0 =A0 writel(((readl(base) & ~(mask << shift)) | (val << shif=
t)), base);
> +}
> +
> +static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
> +{
> + =A0 =A0 =A0 if (unlikely(reg =3D=3D SDHCI_HOST_VERSION))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg ^=3D 2;
> +
> + =A0 =A0 =A0 return readw(host->ioaddr + reg);
> +}
> +
> +static void esdhc_writew_le(struct sdhci_host *host, u16 val, int re=
g)
> +{
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> +
> + =A0 =A0 =A0 switch (reg) {
> + =A0 =A0 =A0 case SDHCI_TRANSFER_MODE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Postpone this write, we must do it=
 together with a
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* command write that is down below.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pltfm_host->scratchpad =3D val;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 case SDHCI_COMMAND:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(val << 16 | pltfm_host->scratchp=
ad,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ioaddr + SDHCI_TR=
ANSFER_MODE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 case SDHCI_BLOCK_SIZE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~SDHCI_MAKE_BLKSZ(0x7, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 esdhc_clrset_le(host, 0xffff, val, reg);
> +}
> +
> +static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg=
)
> +{
> + =A0 =A0 =A0 u32 new_val;
> +
> + =A0 =A0 =A0 switch (reg) {
> + =A0 =A0 =A0 case SDHCI_POWER_CONTROL:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* FSL put some DMA bits here
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If your board has a regulator, cod=
e should be here
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 case SDHCI_HOST_CONTROL:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FSL messed up here, so we can just k=
eep those two */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_val =3D val & (SDHCI_CTRL_LED | SDH=
CI_CTRL_4BITBUS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* ensure the endianess */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_val |=3D ESDHC_HOST_CONTROL_LE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DMA mode bits are shifted */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_val |=3D (val & SDHCI_CTRL_DMA_MASK=
) << 5;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 esdhc_clrset_le(host, 0xffff, new_val, =
reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 esdhc_clrset_le(host, 0xff, val, reg);
> +}
> +
> +static unsigned int esdhc_pltfm_get_max_clock(struct sdhci_host *hos=
t)
> +{
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> +
> + =A0 =A0 =A0 return clk_get_rate(pltfm_host->clk);
> +}
> +
> +static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *hos=
t)
> +{
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> +
> + =A0 =A0 =A0 return clk_get_rate(pltfm_host->clk) / 256 / 16;
> +}
> +
> +static int esdhc_pltfm_init(struct sdhci_host *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sdhci_pltfm_data *pdata, void *p=
riv_pdata)
> +{
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> + =A0 =A0 =A0 struct clk *clk;
> +
> + =A0 =A0 =A0 clk =3D clk_get(NULL, "sdhc");

Here only could support one device, how about several device, for
example sdhc.0, sdhc.1 sdhc.2, if using this method, they will get the
first clock.
Then sdhc.1 sdhc.2 can not work.


> + =A0 =A0 =A0 if (IS_ERR(clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mmc_dev(host->mmc), "clk err\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 clk_enable(clk);
> + =A0 =A0 =A0 pltfm_host->clk =3D clk;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void esdhc_pltfm_exit(struct sdhci_host *host)
> +{
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host=
);
> +
> + =A0 =A0 =A0 clk_disable(pltfm_host->clk);
> + =A0 =A0 =A0 clk_put(pltfm_host->clk);
> +}
> +
> +static struct sdhci_ops sdhci_esdhc_ops =3D {
> + =A0 =A0 =A0 .read_w =3D esdhc_readw_le,
> + =A0 =A0 =A0 .write_w =3D esdhc_writew_le,
> + =A0 =A0 =A0 .write_b =3D esdhc_writeb_le,
> + =A0 =A0 =A0 .set_clock =3D esdhc_set_clock,
> + =A0 =A0 =A0 .get_max_clock =3D esdhc_pltfm_get_max_clock,
> + =A0 =A0 =A0 .get_min_clock =3D esdhc_pltfm_get_min_clock,
> +};
> +
> +struct sdhci_pltfm_data sdhci_esdhc_imx_pdata =3D {
> + =A0 =A0 =A0 .quirks =3D ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_MULTI=
BLOCK
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_BROKEN_AD=
MA,
> + =A0 =A0 =A0 /* ADMA has issues. Might be fixable */
> + =A0 =A0 =A0 /* NO_MULTIBLOCK might be MX35 only (Errata: ENGcm07207=
) */
> + =A0 =A0 =A0 .ops =3D &sdhci_esdhc_ops,
> + =A0 =A0 =A0 .init =3D esdhc_pltfm_init,
> + =A0 =A0 =A0 .exit =3D esdhc_pltfm_exit,
> +};
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-=
pltfm.c
> index 4076222..3e892a8 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -169,6 +169,9 @@ static const struct platform_device_id sdhci_pltf=
m_ids[] =3D {
> =A0#ifdef CONFIG_MMC_SDHCI_CNS3XXX
> =A0 =A0 =A0 =A0{ "sdhci-cns3xxx", (kernel_ulong_t)&sdhci_cns3xxx_pdat=
a },
> =A0#endif
> +#ifdef CONFIG_MMC_SDHCI_ESDHC
> + =A0 =A0 =A0 { "sdhci-esdhc-imx", (kernel_ulong_t)&sdhci_esdhc_imx_p=
data },
> +#endif
> =A0 =A0 =A0 =A0{ },
> =A0};
> =A0MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-=
pltfm.h
> index 9a6f8a9..efe8ea0 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -20,5 +20,6 @@ struct sdhci_pltfm_host {
> =A0};
>
> =A0extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
> +extern struct sdhci_pltfm_data sdhci_esdhc_imx_pdata;
>
> =A0#endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
> --
> 1.7.1
>
>
