From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 3/3] SDHCI: 8-bit data transfer width support
Date: Mon, 28 Jun 2010 11:56:26 -0700
Message-ID: <AANLkTilBSjjmninq8VNxgFe2I41-b9guo5VKuiZWnAwU@mail.gmail.com>
References: <20100612054502.GA25686@july>
	<20100628113948.7778048d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:2572 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab0F1S43 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Jun 2010 14:56:29 -0400
Received: from kpbe18.cbf.corp.google.com (kpbe18.cbf.corp.google.com [172.25.105.82])
	by smtp-out.google.com with ESMTP id o5SIuSuC021910
	for <linux-mmc@vger.kernel.org>; Mon, 28 Jun 2010 11:56:28 -0700
Received: from vws5 (vws5.prod.google.com [10.241.21.133])
	by kpbe18.cbf.corp.google.com with ESMTP id o5SIuRnp032734
	for <linux-mmc@vger.kernel.org>; Mon, 28 Jun 2010 11:56:27 -0700
Received: by vws5 with SMTP id 5so408122vws.5
        for <linux-mmc@vger.kernel.org>; Mon, 28 Jun 2010 11:56:27 -0700 (PDT)
In-Reply-To: <20100628113948.7778048d.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@secretlab.ca>

These patches are not coming from the tegra/for-next branch, they are
coming from Grant's devicetree-next branch.  Grant, why are these
patches in your tree, and why is tegra/for-next in your tree?  It's
going to cause conflicts when we rebase our for-next branch.  Please
remove tegra and this sdhci patch from your tree.

As for the mmc patch, it seems to have been over-squashed to contain
the changes to the common code and the tegra sdhci driver.  Now that
tegra is in for-next, we'll be cleaning up and sending subsystem
drivers for review.  Expect a patch within a week or two.

On Mon, Jun 28, 2010 at 11:39 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Sat, 12 Jun 2010 14:45:02 +0900
> Kyungmin Park <kyungmin.park@samsung.com> wrote:
>
>> From: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> Some host constroller such as s5pc110 has WIDE8 support feature.
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> =A0drivers/mmc/host/sdhci.c | =A0 =A05 +++++
>> =A0drivers/mmc/host/sdhci.h | =A0 =A01 +
>> =A02 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 142419c..6cf018a 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1159,6 +1159,11 @@ static void sdhci_set_ios(struct mmc_host *mm=
c, struct mmc_ios *ios)
>>
>> =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL);
>>
>> + =A0 =A0 if (ios->bus_width =3D=3D MMC_BUS_WIDTH_8)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_8BITBUS;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_8BITBUS;
>> +
>> =A0 =A0 =A0 if (ios->bus_width =3D=3D MMC_BUS_WIDTH_4)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_4BITBUS;
>> =A0 =A0 =A0 else
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index c846813..eb5efe0 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -72,6 +72,7 @@
>> =A0#define =A0 SDHCI_CTRL_ADMA1 =A0 0x08
>> =A0#define =A0 SDHCI_CTRL_ADMA32 =A00x10
>> =A0#define =A0 SDHCI_CTRL_ADMA64 =A00x18
>> +#define =A0SDHCI_CTRL_8BITBUS =A00x20
>>
>> =A0#define SDHCI_POWER_CONTROL =A00x29
>> =A0#define =A0SDHCI_POWER_ON =A0 =A0 =A0 =A0 =A0 =A0 =A00x01
>
> This change (or something similar) also seems to have been lumped int=
o
> the unchangelogged, unreviewed "mmc: sdhci: Initial Tegra sdhci drive=
r"
> patch. =A0So again, I'll drop your patch and if "mmc: sdhci: Initial
> Tegra sdhci driver" doesn't get merged, your patch will be lost.
>
> I wonder what else it does. =A0Here it is:
>
> commit feed6702dc4bb130869171cbd8167637ea13c33c
> Author: =A0 =A0 Colin Cross <ccross@android.com>
> AuthorDate: Wed Mar 10 20:42:35 2010 -0800
> Commit: =A0 =A0 Grant Likely <grant.likely@secretlab.ca>
> CommitDate: Fri Jun 25 09:47:58 2010 -0600
>
> =A0 =A0mmc: sdhci: Initial Tegra sdhci driver
>
> =A0 =A0Signed-off-by: Colin Cross <ccross@android.com>
> =A0 =A0[Olof: Fixed up merge conflicts]
> =A0 =A0Signed-off-by: Olof Johansson <olof@lixom.net>
> =A0 =A0Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> diff --git a/arch/arm/mach-tegra/include/mach/sdhci.h b/arch/arm/mach=
-tegra/include/mach/sdhci.h
> new file mode 100644
> index 0000000..34e2686
> --- /dev/null
> +++ b/arch/arm/mach-tegra/include/mach/sdhci.h
> @@ -0,0 +1,33 @@
> +/*
> + * include/asm-arm/arch-tegra/sdhci.h
> + *
> + * Copyright (C) 2009 Palm, Inc.
> + * Author: Yvonne Yip <y@palm.com>
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +#ifndef __ASM_ARM_ARCH_TEGRA_SDHCI_H
> +#define __ASM_ARM_ARCH_TEGRA_SDHCI_H
> +
> +#include <linux/mmc/host.h>
> +
> +struct tegra_sdhci_platform_data {
> + =A0 =A0 =A0 const char *clk_id;
> + =A0 =A0 =A0 int force_hs;
> + =A0 =A0 =A0 int cd_gpio;
> + =A0 =A0 =A0 int wp_gpio;
> + =A0 =A0 =A0 int power_gpio;
> +
> + =A0 =A0 =A0 void (*board_probe)(int id, struct mmc_host *);
> + =A0 =A0 =A0 void (*board_remove)(int id, struct mmc_host *);
> +};
> +
> +#endif
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index b9dee28..85c473e 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -229,11 +229,13 @@ static int sdio_enable_hs(struct mmc_card *card=
)
> =A0 =A0 =A0 =A0int ret;
> =A0 =A0 =A0 =A0u8 speed;
>
> - =A0 =A0 =A0 if (!(card->host->caps & MMC_CAP_SD_HIGHSPEED))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 if (!(card->host->caps & MMC_CAP_FORCE_HS)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(card->host->caps & MMC_CAP_SD_HIG=
HSPEED))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> - =A0 =A0 =A0 if (!card->cccr.high_speed)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!card->cccr.high_speed)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0ret =3D mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_SPEED, =
0, &speed);
> =A0 =A0 =A0 =A0if (ret)
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index f06d06e..357c294 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -382,6 +382,12 @@ config MMC_TMIO
> =A0 =A0 =A0 =A0 =A0This provides support for the SD/MMC cell found in=
 TC6393XB,
> =A0 =A0 =A0 =A0 =A0T7L66XB and also HTC ASIC3
>
> +config MMC_SDHCI_TEGRA
> + =A0 =A0 =A0 tristate "Tegra SD/MMC Controller Support"
> + =A0 =A0 =A0 depends on ARCH_TEGRA && MMC_SDHCI
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This selects the Tegra SD/MMC controller.
> +
> =A0config MMC_CB710
> =A0 =A0 =A0 =A0tristate "ENE CB710 MMC/SD Interface support"
> =A0 =A0 =A0 =A0depends on PCI
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index e30c2ee..fb04448 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_MMC_SDHCI_PCI) =A0 +=3D sdhci-pci.o
> =A0obj-$(CONFIG_MMC_SDHCI_PLTFM) =A0+=3D sdhci-pltfm.o
> =A0obj-$(CONFIG_MMC_SDHCI_S3C) =A0 =A0+=3D sdhci-s3c.o
> =A0obj-$(CONFIG_MMC_SDHCI_SPEAR) =A0+=3D sdhci-spear.o
> +obj-$(CONFIG_MMC_SDHCI_TEGRA) =A0+=3D sdhci-tegra.o
> =A0obj-$(CONFIG_MMC_WBSD) =A0 =A0 =A0 =A0 +=3D wbsd.o
> =A0obj-$(CONFIG_MMC_AU1X) =A0 =A0 =A0 =A0 +=3D au1xmmc.o
> =A0obj-$(CONFIG_MMC_OMAP) =A0 =A0 =A0 =A0 +=3D omap.o
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-=
tegra.c
> new file mode 100644
> index 0000000..5e2a1f1
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -0,0 +1,217 @@
> +/*
> + * drivers/mmc/host/sdhci-tegra.c
> + *
> + * Copyright (C) 2009 Palm, Inc.
> + * Author: Yvonne Yip <y@palm.com>
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/gpio.h>
> +
> +#include <mach/sdhci.h>
> +
> +#include "sdhci.h"
> +
> +#define DRIVER_NAME =A0 =A0"sdhci-tegra"
> +
> +struct tegra_sdhci_host {
> + =A0 =A0 =A0 struct sdhci_host *sdhci;
> + =A0 =A0 =A0 struct clk *clk;
> +};
> +
> +static irqreturn_t carddetect_irq(int irq, void *data)
> +{
> + =A0 =A0 =A0 struct sdhci_host *sdhost =3D (struct sdhci_host *)data=
;
> +
> + =A0 =A0 =A0 sdhci_card_detect_callback(sdhost);
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +};
> +
> +static int tegra_sdhci_enable_dma(struct sdhci_host *host)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned =
int clock)
> +{
> + =A0 =A0 =A0 struct tegra_sdhci_host *tegra_host =3D sdhci_priv(host=
);
> + =A0 =A0 =A0 host->max_clk =3D clk_get_rate(tegra_host->clk);
> +}
> +
> +static struct sdhci_ops tegra_sdhci_ops =3D {
> + =A0 =A0 =A0 .enable_dma =3D tegra_sdhci_enable_dma,
> + =A0 =A0 =A0 .set_clock =A0=3D tegra_sdhci_set_clock,
> +};
> +
> +static int __devinit tegra_sdhci_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 int rc;
> + =A0 =A0 =A0 struct tegra_sdhci_platform_data *plat;
> + =A0 =A0 =A0 struct sdhci_host *sdhci;
> + =A0 =A0 =A0 struct tegra_sdhci_host *host;
> + =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 void __iomem *ioaddr;
> +
> + =A0 =A0 =A0 plat =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 if (plat =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> + =A0 =A0 =A0 if (res =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 irq =3D res->start;
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (res =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 ioaddr =3D ioremap(res->start, res->end - res->start);
> +
> + =A0 =A0 =A0 sdhci =3D sdhci_alloc_host(&pdev->dev, sizeof(struct te=
gra_sdhci_host));
> + =A0 =A0 =A0 if (IS_ERR(sdhci)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D PTR_ERR(sdhci);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unmap;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 host =3D sdhci_priv(sdhci);
> + =A0 =A0 =A0 host->sdhci =3D sdhci;
> +
> + =A0 =A0 =A0 host->clk =3D clk_get(&pdev->dev, plat->clk_id);
> + =A0 =A0 =A0 if (IS_ERR(host->clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D PTR_ERR(host->clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_host;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 rc =3D clk_enable(host->clk);
> + =A0 =A0 =A0 if (rc !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_clkput;
> +
> + =A0 =A0 =A0 sdhci->hw_name =3D "tegra";
> + =A0 =A0 =A0 sdhci->ops =3D &tegra_sdhci_ops;
> + =A0 =A0 =A0 sdhci->irq =3D irq;
> + =A0 =A0 =A0 sdhci->ioaddr =3D ioaddr;
> + =A0 =A0 =A0 sdhci->version =3D SDHCI_SPEC_200;
> + =A0 =A0 =A0 sdhci->quirks =3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_SINGLE_POWE=
R_WRITE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_ENABLE_INTE=
RRUPT_AT_BLOCK_GAP |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_BROKEN_WRIT=
E_PROTECT |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_BROKEN_CTRL=
_HISPD |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_8_BIT_DATA =
|
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_NO_VERSION_=
REG |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_BROKEN_ADMA=
_ZEROLEN_DESC |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_NO_SDIO_IRQ=
;
> +
> + =A0 =A0 =A0 if (plat->force_hs !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci->quirks |=3D SDHCI_QUIRK_FORCE_HI=
GH_SPEED_MODE;
> +
> + =A0 =A0 =A0 rc =3D sdhci_add_host(sdhci);
> + =A0 =A0 =A0 if (rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk_disable;
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, host);
> +
> + =A0 =A0 =A0 if (plat->cd_gpio) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D request_irq(gpio_to_irq(plat->cd=
_gpio), carddetect_irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_TRIGGER_FALLING | =
IRQF_TRIGGER_RISING,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(sdhci->mmc=
), sdhci);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_remove_host;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (plat->board_probe)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 plat->board_probe(pdev->id, sdhci->mmc)=
;
> +
> + =A0 =A0 =A0 printk(KERN_INFO "sdhci%d: initialized irq %d ioaddr %p=
\n", pdev->id,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci->irq, sdhci->ioad=
dr);
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_remove_host:
> + =A0 =A0 =A0 sdhci_remove_host(sdhci, 1);
> +err_clk_disable:
> + =A0 =A0 =A0 clk_disable(host->clk);
> +err_clkput:
> + =A0 =A0 =A0 clk_put(host->clk);
> +err_free_host:
> + =A0 =A0 =A0 if (sdhci)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_free_host(sdhci);
> +err_unmap:
> + =A0 =A0 =A0 iounmap(sdhci->ioaddr);
> +
> + =A0 =A0 =A0 return rc;
> +}
> +
> +static int tegra_sdhci_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct tegra_sdhci_host *host =3D platform_get_drvdata(=
pdev);
> + =A0 =A0 =A0 if (host) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct tegra_sdhci_platform_data *plat;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 plat =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (plat && plat->board_probe)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 plat->board_probe(pdev-=
>id, host->sdhci->mmc);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_remove_host(host->sdhci, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_free_host(host->sdhci);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int tegra_sdhci_suspend(struct platform_device *pdev, pm_mess=
age_t state)
> +{
> + =A0 =A0 =A0 return -1;
> +}
> +
> +static int tegra_sdhci_resume(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 return -1;
> +}
> +#else
> +#define tegra_sdhci_suspend =A0 =A0NULL
> +#define tegra_sdhci_resume =A0 =A0 NULL
> +#endif
> +
> +static struct platform_driver tegra_sdhci_driver =3D {
> + =A0 =A0 =A0 .probe =3D tegra_sdhci_probe,
> + =A0 =A0 =A0 .remove =3D tegra_sdhci_remove,
> + =A0 =A0 =A0 .suspend =3D tegra_sdhci_suspend,
> + =A0 =A0 =A0 .resume =3D tegra_sdhci_resume,
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D DRIVER_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init tegra_sdhci_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&tegra_sdhci_driver);
> +}
> +
> +static void __exit tegra_sdhci_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&tegra_sdhci_driver);
> +}
> +
> +module_init(tegra_sdhci_init);
> +module_exit(tegra_sdhci_exit);
> +
> +MODULE_DESCRIPTION("Tegra SDHCI controller driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c6d1bd8..4af24d6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1024,6 +1024,7 @@ static void sdhci_set_clock(struct sdhci_host *=
host, unsigned int clock)
> =A0 =A0 =A0 =A0sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>
> =A0out:
> +
> =A0 =A0 =A0 =A0host->clock =3D clock;
> =A0}
>
> @@ -1159,15 +1160,18 @@ static void sdhci_set_ios(struct mmc_host *mm=
c, struct mmc_ios *ios)
>
> =A0 =A0 =A0 =A0ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL);
>
> - =A0 =A0 =A0 if (ios->bus_width =3D=3D MMC_BUS_WIDTH_4)
> + =A0 =A0 =A0 ctrl &=3D ~(SDHCI_CTRL_8BITBUS|SDHCI_CTRL_4BITBUS);
> + =A0 =A0 =A0 if (ios->bus_width =3D=3D MMC_BUS_WIDTH_8)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_8BITBUS;
> + =A0 =A0 =A0 else if (ios->bus_width =3D=3D MMC_BUS_WIDTH_4)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl |=3D SDHCI_CTRL_4BITBUS;
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_4BITBUS;
>
> - =A0 =A0 =A0 if (ios->timing =3D=3D MMC_TIMING_SD_HS)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_HISPD;
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_HISPD;
> + =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_BROKEN_CTRL_HISPD)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ios->timing =3D=3D MMC_TIMING_SD_HS=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_HI=
SPD;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_H=
ISPD;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>
> @@ -1194,16 +1198,22 @@ static int sdhci_get_ro(struct mmc_host *mmc)
>
> =A0 =A0 =A0 =A0spin_lock_irqsave(&host->lock, flags);
>
> - =A0 =A0 =A0 if (host->flags & SDHCI_DEVICE_DEAD)
> + =A0 =A0 =A0 if (host->flags & SDHCI_DEVICE_DEAD) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0present =3D 0;
> - =A0 =A0 =A0 else
> + =A0 =A0 =A0 } else if (!(host->quirks & SDHCI_QUIRK_BROKEN_WRITE_PR=
OTECT)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0present =3D sdhci_readl(host, SDHCI_PR=
ESENT_STATE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 present =3D !(present & SDHCI_WRITE_PRO=
TECT);
> + =A0 =A0 =A0 } else if (host->ops->get_ro) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 present =3D host->ops->get_ro(host);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 present =3D 0;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, flags);
>
> =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return !!(present & SDHCI_WRITE_PROTEC=
T);
> - =A0 =A0 =A0 return !(present & SDHCI_WRITE_PROTECT);
> + =A0 =A0 =A0 return present;
> =A0}
>
> =A0static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable=
)
> @@ -1222,6 +1232,16 @@ static void sdhci_enable_sdio_irq(struct mmc_h=
ost *mmc, int enable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_unmask_irqs(host, SDHCI_INT_CARD=
_INT);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_mask_irqs(host, SDHCI_INT_CARD_I=
NT);
> +
> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_ENABLE_INTERRUPT_AT_BLOC=
K_GAP) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 gap_ctrl =3D readb(host->ioaddr + SD=
HCI_BLOCK_GAP_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gap_ctrl |=3D 0x8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gap_ctrl &=3D ~0x8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(gap_ctrl, host->ioaddr + SDHCI_B=
LOCK_GAP_CONTROL);
> + =A0 =A0 =A0 }
> +
> =A0out:
> =A0 =A0 =A0 =A0mmiowb();
>
> @@ -1235,19 +1255,10 @@ static const struct mmc_host_ops sdhci_ops =3D=
 {
> =A0 =A0 =A0 =A0.enable_sdio_irq =3D sdhci_enable_sdio_irq,
> =A0};
>
> -/*******************************************************************=
**********\
> - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 *
> - * Tasklets =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0*
> - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 *
> -\*******************************************************************=
**********/
> -
> -static void sdhci_tasklet_card(unsigned long param)
> +void sdhci_card_detect_callback(struct sdhci_host *host)
> =A0{
> - =A0 =A0 =A0 struct sdhci_host *host;
> =A0 =A0 =A0 =A0unsigned long flags;
>
> - =A0 =A0 =A0 host =3D (struct sdhci_host*)param;
> -
> =A0 =A0 =A0 =A0spin_lock_irqsave(&host->lock, flags);
>
> =A0 =A0 =A0 =A0if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_C=
ARD_PRESENT)) {
> @@ -1269,6 +1280,22 @@ static void sdhci_tasklet_card(unsigned long p=
aram)
>
> =A0 =A0 =A0 =A0mmc_detect_change(host->mmc, msecs_to_jiffies(200));
> =A0}
> +EXPORT_SYMBOL_GPL(sdhci_card_detect_callback);
> +
> +/*******************************************************************=
**********\
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 *
> + * Tasklets =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0*
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 *
> +\*******************************************************************=
**********/
> +
> +static void sdhci_tasklet_card(unsigned long param)
> +{
> + =A0 =A0 =A0 struct sdhci_host *host;
> +
> + =A0 =A0 =A0 host =3D (struct sdhci_host *)param;
> +
> + =A0 =A0 =A0 sdhci_card_detect_callback(host);
> +}
>
> =A0static void sdhci_tasklet_finish(unsigned long param)
> =A0{
> @@ -1380,7 +1407,8 @@ static void sdhci_cmd_irq(struct sdhci_host *ho=
st, u32 intmask)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->cmd->error =3D -EILSEQ;
>
> =A0 =A0 =A0 =A0if (host->cmd->error) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tasklet_schedule(&host->finish_tasklet)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (intmask & SDHCI_INT_RESPONSE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tasklet_schedule(&host-=
>finish_tasklet);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> @@ -1678,9 +1706,12 @@ int sdhci_add_host(struct sdhci_host *host)
>
> =A0 =A0 =A0 =A0sdhci_reset(host, SDHCI_RESET_ALL);
>
> - =A0 =A0 =A0 host->version =3D sdhci_readw(host, SDHCI_HOST_VERSION)=
;
> - =A0 =A0 =A0 host->version =3D (host->version & SDHCI_SPEC_VER_MASK)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >> SDHC=
I_SPEC_VER_SHIFT;
> + =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_NO_VERSION_REG)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->version =3D sdhci_readw(host, SDH=
CI_HOST_VERSION);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->version =3D (host->version & SDHC=
I_SPEC_VER_MASK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 >> SDHCI_SPEC_VER_SHIFT;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (host->version > SDHCI_SPEC_200) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: Unknown controlle=
r version (%d). "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"You may experience pr=
oblems.\n", mmc_hostname(mmc),
> @@ -1791,13 +1822,24 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->f_min =3D host->max_clk / 256;
> =A0 =A0 =A0 =A0mmc->f_max =3D host->max_clk;
> - =A0 =A0 =A0 mmc->caps =3D MMC_CAP_SDIO_IRQ;
> + =A0 =A0 =A0 mmc->caps =3D 0;
>
> - =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_8_BIT_DATA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_8_BIT_DATA;
> + =A0 =A0 =A0 else if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA)=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>
> - =A0 =A0 =A0 if (caps & SDHCI_CAN_DO_HISPD)
> +
> + =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_NO_SDIO_IRQ))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SDIO_IRQ;
> +
> + =A0 =A0 =A0 if (caps & SDHCI_CAN_DO_HISPD) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_SD_HIGHSPEED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_FORCE_HIGH_SPEED_MODE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_FORCE_HS;
>
> =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_NEEDS_POLL;
> @@ -1841,10 +1883,14 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 * of bytes. When doing hardware scatter/gather, each =
entry cannot
> =A0 =A0 =A0 =A0 * be larger than 64 KiB though.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (host->flags & SDHCI_USE_ADMA)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_seg_size =3D 65536;
> - =A0 =A0 =A0 else
> + =A0 =A0 =A0 if (host->flags & SDHCI_USE_ADMA) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_BROKEN_A=
DMA_ZEROLEN_DESC)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_seg_size =3D 0=
xffff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_seg_size =3D 6=
5536;
> + =A0 =A0 =A0 } else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_seg_size =3D mmc->max_req_siz=
e;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Maximum block size. This varies from controller to =
controller and
> @@ -1868,7 +1914,7 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 * Maximum block count.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0mmc->max_blk_count =3D (host->quirks & SDHCI_QUIRK_NO_=
MULTIBLOCK) ? 1 : 65535;
> -
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Init tasklets.
> =A0 =A0 =A0 =A0 */
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c846813..2c8a83a 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -66,6 +66,7 @@
> =A0#define SDHCI_HOST_CONTROL =A0 =A0 0x28
> =A0#define =A0SDHCI_CTRL_LED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x01
> =A0#define =A0SDHCI_CTRL_4BITBUS =A0 =A00x02
> +#define =A0SDHCI_CTRL_8BITBUS =A0 =A00x20
> =A0#define =A0SDHCI_CTRL_HISPD =A0 =A0 =A00x04
> =A0#define =A0SDHCI_CTRL_DMA_MASK =A0 0x18
> =A0#define =A0 SDHCI_CTRL_SDMA =A0 =A0 =A00x00
> @@ -184,7 +185,7 @@ struct sdhci_host {
> =A0 =A0 =A0 =A0/* Data set by hardware interface driver */
> =A0 =A0 =A0 =A0const char =A0 =A0 =A0 =A0 =A0 =A0 =A0*hw_name; =A0 =A0=
 =A0 /* Hardware bus name */
>
> - =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0=
 =A0 /* Deviations from spec. */
> + =A0 =A0 =A0 u64 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 quirks; =A0=
 =A0 =A0 =A0 /* Deviations from spec. */
>
> =A0/* Controller doesn't honor resets unless we touch the clock regis=
ter */
> =A0#define SDHCI_QUIRK_CLOCK_BEFORE_RESET =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1<<0)
> @@ -240,6 +241,22 @@ struct sdhci_host {
> =A0#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(1<<25)
> =A0/* Controller cannot support End Attribute in NOP ADMA descriptor =
*/
> =A0#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(1<<26)
> +/* Controller write protect bit is broken. Assume no write protectio=
n */
> +#define SDHCI_QUIRK_BROKEN_WRITE_PROTECT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1<<27)
> +/* Controller needs INTERRUPT_AT_BLOCK_GAP enabled to detect card in=
terrupts */
> +#define SDHCI_QUIRK_ENABLE_INTERRUPT_AT_BLOCK_GAP =A0 =A0 =A0(1<<28)
> +/* Controller should not program HIGH_SPEED_EN after switching to hi=
gh speed */
> +#define SDHCI_QUIRK_BROKEN_CTRL_HISPD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1<<29)
> +/* Controller supports 8-bit data width */
> +#define SDHCI_QUIRK_8_BIT_DATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (1<<30)
> +/* Controller has no version register */
> +#define SDHCI_QUIRK_NO_VERSION_REG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1<<31)
> +/* Controller treats ADMA descriptors with length 0000h incorrectly =
*/
> +#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC =A0 =A0 =A0 =A0 =A0 (1L=
L<<32)
> +/* Controller should not use SDIO IRQ */
> +#define SDHCI_QUIRK_NO_SDIO_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0(1LL<<33)
> +/* Controller should only use high-speed mode */
> +#define SDHCI_QUIRK_FORCE_HIGH_SPEED_MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(1LL<<34)
>
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq; =A0 =A0=
 =A0 =A0 =A0 =A0/* Device IRQ */
> =A0 =A0 =A0 =A0void __iomem * =A0 =A0 =A0 =A0 =A0ioaddr; =A0 =A0 =A0 =
=A0 /* Mapped address */
> @@ -309,6 +326,7 @@ struct sdhci_ops {
> =A0 =A0 =A0 =A0void =A0 =A0(*set_clock)(struct sdhci_host *host, unsi=
gned int clock);
>
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 (*enable_dma)(struct sdhci=
_host *host);
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*get_ro)(struct sdhci_host=
 *host);
> =A0 =A0 =A0 =A0unsigned int =A0 =A0(*get_max_clock)(struct sdhci_host=
 *host);
> =A0 =A0 =A0 =A0unsigned int =A0 =A0(*get_min_clock)(struct sdhci_host=
 *host);
> =A0 =A0 =A0 =A0unsigned int =A0 =A0(*get_timeout_clock)(struct sdhci_=
host *host);
> @@ -401,6 +419,7 @@ static inline u8 sdhci_readb(struct sdhci_host *h=
ost, int reg)
> =A0extern struct sdhci_host *sdhci_alloc_host(struct device *dev,
> =A0 =A0 =A0 =A0size_t priv_size);
> =A0extern void sdhci_free_host(struct sdhci_host *host);
> +extern void sdhci_card_detect_callback(struct sdhci_host *host);
>
> =A0static inline void *sdhci_priv(struct sdhci_host *host)
> =A0{
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f65913c..9ab146a 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -155,6 +155,7 @@ struct mmc_host {
> =A0#define MMC_CAP_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7) =A0=
 =A0 =A0 =A0/* Can the host be disabled */
> =A0#define MMC_CAP_NONREMOVABLE =A0 (1 << 8) =A0 =A0 =A0 =A0/* Nonrem=
ovable e.g. eMMC */
> =A0#define MMC_CAP_WAIT_WHILE_BUSY =A0 =A0 =A0 =A0(1 << 9) =A0 =A0 =A0=
 =A0/* Waits while card is busy */
> +#define MMC_CAP_FORCE_HS =A0 =A0 =A0 (1 << 10) =A0 =A0 =A0 /* Must e=
nable highspeed mode */
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
>
>
>
