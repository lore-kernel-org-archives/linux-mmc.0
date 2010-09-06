From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 8/9] esdhc-4 esdhc: fsl esdhc driver based on platform
 sdhci api
Date: Mon, 6 Sep 2010 12:47:29 +0200
Message-ID: <20100906104729.GB2617@pengutronix.de>
References: <1283334533-12793-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33578 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab0IFKre (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2010 06:47:34 -0400
Content-Disposition: inline
In-Reply-To: <1283334533-12793-1-git-send-email-r65037@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <r65037@freescale.com>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 01, 2010 at 05:48:53PM +0800, Richard Zhu wrote:
> Based on SDHCI platform API, PIO and simple internal DMA
> are enabled.
>=20
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  drivers/mmc/host/Kconfig     |   12 +
>  drivers/mmc/host/Makefile    |    1 +
>  drivers/mmc/host/sdhci-fsl.c |  481 ++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 494 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-fsl.c
>=20
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 283190b..2b67e11 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -167,6 +167,18 @@ config MMC_SDHCI_S3C_DMA
> =20
>  	  YMMV.
> =20
> +config MMC_SDHCI_FSL
> +	tristate "Freescale i.MX platform eSDHCI support"
> +	depends on ARCH_MX5 && MMC_SDHCI
> +	select MMC_SDHCI_IO_ACCESSORS
> +	help
> +	  This selects the Freescale i.MX Enhanced Secure Card Host
> +	  Controller Interface.
> +	  If you have a i.MX platform with a Multimedia Card slot,
> +	  say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_OMAP
>  	tristate "TI OMAP Multimedia Card Interface support"
>  	depends on ARCH_OMAP
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 840bcb5..649656c 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_MMC_MXC)		+=3D mxcmmc.o
>  obj-$(CONFIG_MMC_SDHCI)		+=3D sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+=3D sdhci-pci.o
>  obj-$(CONFIG_MMC_SDHCI_S3C)	+=3D sdhci-s3c.o
> +obj-$(CONFIG_MMC_SDHCI_FSL)	+=3D sdhci-fsl.o
>  obj-$(CONFIG_MMC_SDHCI_SPEAR)	+=3D sdhci-spear.o
>  obj-$(CONFIG_MMC_WBSD)		+=3D wbsd.o
>  obj-$(CONFIG_MMC_AU1X)		+=3D au1xmmc.o
> diff --git a/drivers/mmc/host/sdhci-fsl.c b/drivers/mmc/host/sdhci-fsl.c
> new file mode 100644
> index 0000000..fa57ec4
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-fsl.c
> @@ -0,0 +1,481 @@
> +/*
> + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + */
> +
> +/*
> + * sdhci-fsl.c Support for SDHCI platform devices
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +/* Supports:
> + * SDHCI fsl devices
> + *
> + * Inspired by sdhci-pci.c, by Pierre Ossman
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/highmem.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/mmc/host.h>
> +
> +#include <mach/mmc.h>
> +
> +#include "sdhci.h"
> +
> +#define DRIVER_NAME "imx-sdhci"
> +
> +enum {
> +	/* Vendor specified registors */
> +	FSL_SDHCI_WML 		=3D 0x44,
> +	FSL_SDHCI_WML_16_WORDS 	=3D 0x08100810,
> +	FSL_SDHCI_WML_32_WORDS 	=3D 0x08200820,
> +	FSL_SDHCI_WML_64_WORDS 	=3D 0x08400840,
> +	FSL_SDHCI_WML_128_WORDS 	=3D 0x08800880,
> +
> +	/* Non-standard clock control registor */
> +	FSL_SDHCI_CLOCK_MASK 	=3D 0xFFFF,
> +	FSL_SDHCI_CLOCK_SD_EN 	=3D 0x00000008,
> +	FSL_SDHCI_CLOCK_HLK_EN 	=3D 0x00000002,
> +
> +	/* Non-standard host control registor */
> +	FSL_SDHCI_CTRL_8BITBUS 	=3D 0x00000004,
> +};
> +
> +/***********************************************************************=
******\
> + *                                                                      =
     *
> + * SDHCI core callbacks                                                 =
     *
> + *                                                                      =
     *
> +\***********************************************************************=
******/
> +
> +struct sdhci_fsl_host {
> +	struct sdhci_host 		*host;
> +	struct platform_device 		*pdev; /*! Platform dev */
> +	struct imxmmc_platform_data 	*pdata; /*! private data */
> +	struct clk 			*clk_input; /*! Clock */
> +	struct regulator 		*regulator_mmc;	/*! Regulator */
> +};
> +
> +static u32 sdhci_fsl_readl(struct sdhci_host *host, int reg)
> +{
> +	return readl(host->ioaddr + reg);
> +}
> +
> +static u16 sdhci_fsl_readw(struct sdhci_host *host, int reg)
> +{
> +	u32 val;
> +	u16 rc;
> +
> +	if (reg % 4 =3D=3D 3) {
> +		printk(KERN_ERR "Invalid reg address!\n");
> +		return 0;
> +	}
> +
> +	val =3D readl(host->ioaddr + (reg / 4) * 4);
> +	rc =3D (val >> (reg % 4) * 8) & 0xFFFF;
> +
> +	return rc;
> +}
> +
> +static u8 sdhci_fsl_readb(struct sdhci_host *host, int reg)
> +{
> +	u32 val;
> +	u8 rc;
> +
> +	val =3D readl(host->ioaddr + (reg / 4) * 4);
> +	rc =3D (val >> (reg % 4) * 8) & 0xFF;
> +
> +	return rc;
> +}
> +
> +static void sdhci_fsl_writel(struct sdhci_host *host, u32 val, int reg)
> +{
> +	writel(val, host->ioaddr + reg);
> +}
> +
> +static void sdhci_fsl_writew(struct sdhci_host *host, u16 val, int reg)
> +{
> +	u32 io_val;
> +
> +	if (reg % 4 =3D=3D 3) {
> +		printk(KERN_ERR "Invalid reg address!\n");
> +		return;
> +	}
> +
> +	io_val =3D readl(host->ioaddr + (reg / 4) * 4);
> +	io_val &=3D ~(0xFFFF << ((reg % 4) * 8));
> +	io_val |=3D val << ((reg % 4) * 8);
> +
> +	writel(io_val, host->ioaddr + (reg / 4) * 4);
> +}
> +
> +static void sdhci_fsl_writeb(struct sdhci_host *host, u8 val, int reg)
> +{
> +	u32 io_val;
> +
> +	io_val =3D readl(host->ioaddr + (reg / 4) * 4);
> +	io_val &=3D ~(0xFF << ((reg % 4) * 8));
> +	io_val |=3D val << ((reg % 4) * 8);
> +
> +	writel(io_val, host->ioaddr + (reg / 4) * 4);
> +}
> +
> +static unsigned int sdhci_fsl_get_max_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_fsl_host *fsl_host =3D sdhci_priv(host);
> +
> +	return fsl_host->pdata->max_clk;
> +}
> +
> +static unsigned int sdhci_fsl_get_min_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_fsl_host *fsl_host =3D sdhci_priv(host);
> +
> +	return fsl_host->pdata->min_clk;
> +}
> +
> +static unsigned int sdhci_fsl_get_timeout_clock(struct sdhci_host *host)
> +{
> +	return sdhci_fsl_get_max_clock(host) / 1000000;
> +}
> +
> +static unsigned int sdhci_fsl_get_ro(struct sdhci_host *host)
> +{
> +	struct sdhci_fsl_host *fsl_host =3D sdhci_priv(host);
> +
> +	return fsl_host->pdata->wp_status(host->mmc->parent);
> +}

Is there really no way to route the WP-GPIO to the SD_WP pin of the
controller (sigh)? Still, I'd think we can be more abstract by using the
gpiolib and just pass the gpio number in the platform-data?

> +
> +static void sdhci_fsl_set_clock(struct sdhci_host *host, unsigned int cl=
ock)
> +{
> +	/*This variable holds the value of clock divider, prescaler */
> +	int div =3D 0, prescaler =3D 1;
> +	int clk_rate =3D 0;
> +	u32 clk;
> +	unsigned long timeout;
> +	struct sdhci_fsl_host *fsl_host =3D sdhci_priv(host);
> +
> +	if (clock =3D=3D 0) {
> +		host->clock =3D 0;
> +		clk =3D readl(host->ioaddr + SDHCI_CLOCK_CONTROL);
> +		writel(clk & (~FSL_SDHCI_CLOCK_HLK_EN),
> +				host->ioaddr + SDHCI_CLOCK_CONTROL);
> +		return;
> +	}
> +
> +	clk_rate =3D clk_get_rate(fsl_host->clk_input);
> +	clk =3D readl(host->ioaddr + SDHCI_CLOCK_CONTROL) & ~FSL_SDHCI_CLOCK_MA=
SK;
> +	/* precaler can't be set to zero in CLK_CTL reg */
> +	clk |=3D (prescaler << 8);
> +	writel(clk, host->ioaddr + SDHCI_CLOCK_CONTROL);
> +
> +	if (clock =3D=3D sdhci_fsl_get_min_clock(host))
> +		prescaler =3D 0x10;
> +
> +	while (prescaler <=3D 0x80) {
> +		for (div =3D 0; div <=3D 0xF; div++) {
> +			int x;
> +			if (prescaler !=3D 0)
> +				x =3D (clk_rate / (div + 1)) / (prescaler * 2);
> +			else
> +				x =3D clk_rate / (div + 1);
> +
> +			dev_dbg(&fsl_host->pdev->dev, "x=3D%d, clock=3D%d %d\n",
> +					x, clock, div);
> +			if (x <=3D clock)
> +				break;
> +		}
> +		if (div < 0x10)
> +			break;
> +
> +		prescaler <<=3D 1;
> +	}
> +	dev_dbg(&fsl_host->pdev->dev, "prescaler =3D 0x%x, divider =3D 0x%x\n",
> +			prescaler, div);
> +	clk |=3D (prescaler << 8) | (div << 4);
> +
> +	/* Configure the clock control register */
> +	clk |=3D readl(host->ioaddr + SDHCI_CLOCK_CONTROL)
> +		& (~FSL_SDHCI_CLOCK_MASK);
> +	clk |=3D FSL_SDHCI_CLOCK_HLK_EN;
> +	writel(clk, host->ioaddr + SDHCI_CLOCK_CONTROL);
> +
> +	/* Wait max 10 ms */
> +	timeout =3D 5000;
> +	while (timeout > 0) {
> +		timeout--;
> +		udelay(20);
> +	}
> +	writel(clk | FSL_SDHCI_CLOCK_SD_EN, host->ioaddr + SDHCI_CLOCK_CONTROL);
> +
> +	host->clock =3D (clk_rate / (div + 1)) / (prescaler * 2);
> +}

Do you know if there is an improvement over the set_clock-routine in
sdhic-of-esdhc.c?

> +
> +static void sdhci_fsl_set_power(struct sdhci_host *host, unsigned int po=
wer)
> +{
> +	struct sdhci_fsl_host *fsl_host =3D sdhci_priv(host);
> +	int voltage =3D 0;
> +
> +	/* There is no sdhci standard PWR CTL REG in fsl esdhci */
> +	if (host->pwr =3D=3D power)
> +		return;
> +
> +	if (fsl_host->regulator_mmc) {
> +		if (power =3D=3D (unsigned short)-1) {
> +			regulator_disable(fsl_host->regulator_mmc);
> +			dev_dbg(&fsl_host->pdev->dev, "mmc power off\n");
> +		} else {
> +			if (power =3D=3D 7)
> +				voltage =3D 1800000;
> +			else if (power >=3D 8)
> +				voltage =3D 2000000 + (power - 8) * 100000;
> +			regulator_set_voltage(fsl_host->regulator_mmc,
> +					      voltage, voltage);
> +
> +			if (regulator_enable(fsl_host->regulator_mmc) =3D=3D 0) {
> +				dev_dbg(&fsl_host->pdev->dev, "mmc power on\n");
> +				msleep(1);
> +			}
> +		}
> +	}
> +
> +	host->pwr =3D power;
> +}

The host-structure has a regulator, too. We should use that. Note that
my boards don't have such a regulator, so I can't test here.

> +
> +static void sdhci_fsl_set_bus(struct sdhci_host *host, unsigned int bus_=
width)
> +{
> +	u32 ctrl;
> +
> +	ctrl =3D readl(host->ioaddr + SDHCI_HOST_CONTROL);
> +
> +	if (bus_width =3D=3D MMC_BUS_WIDTH_4) {
> +		ctrl &=3D ~FSL_SDHCI_CTRL_8BITBUS;
> +		ctrl |=3D SDHCI_CTRL_4BITBUS;
> +	} else if (bus_width =3D=3D MMC_BUS_WIDTH_8) {
> +		ctrl &=3D ~SDHCI_CTRL_4BITBUS;
> +		ctrl |=3D FSL_SDHCI_CTRL_8BITBUS;
> +	} else if (bus_width =3D=3D MMC_BUS_WIDTH_1) {
> +		ctrl &=3D ~SDHCI_CTRL_4BITBUS;
> +		ctrl &=3D ~FSL_SDHCI_CTRL_8BITBUS;
> +	}

I'd be careful with the 8Bit-mode for now. We need some to deal with it
correctly in sdhci.c first.

> +
> +	writel(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
> +}
> +
> +static u16 sdhci_fsl_make_blksz(u16 blk_sz)
> +{
> +	return  blk_sz &=3D 0x1FFF;
> +}
> +
> +static int esdhci_fsl_enable_dma(struct sdhci_host *host)
> +{
> +	u32 ctrl;
> +
> +	ctrl =3D readl(host->ioaddr + SDHCI_HOST_CONTROL);
> +	ctrl &=3D ~(SDHCI_CTRL_DMA_MASK << 5);
> +	if ((host->flags & SDHCI_REQ_USE_DMA) &&
> +		(host->flags & SDHCI_USE_ADMA))
> +		ctrl |=3D (SDHCI_CTRL_ADMA32 << 8);
> +	else if (host->flags & SDHCI_REQ_USE_DMA)
> +		ctrl |=3D (SDHCI_CTRL_SDMA << 8);
> +
> +	writel(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
> +
> +	if (host->flags & SDHCI_REQ_USE_DMA)
> +		writel(FSL_SDHCI_WML_64_WORDS,
> +				host->ioaddr + FSL_SDHCI_WML);
> +	else
> +		writel(FSL_SDHCI_WML_128_WORDS,
> +				host->ioaddr + FSL_SDHCI_WML);
> +	return 0;
> +}
> +
> +static const struct sdhci_ops sdhci_fsl_ops =3D {
> +	.read_l 		=3D sdhci_fsl_readl,
> +	.read_w 		=3D sdhci_fsl_readw,
> +	.read_b 		=3D sdhci_fsl_readb,
> +	.write_l 		=3D sdhci_fsl_writel,
> +	.write_w 		=3D sdhci_fsl_writew,
> +	.write_b 		=3D sdhci_fsl_writeb,
> +	.set_clock 		=3D sdhci_fsl_set_clock,
> +	.set_power 		=3D sdhci_fsl_set_power,
> +	.set_bus 		=3D sdhci_fsl_set_bus,
> +	.enable_dma 		=3D esdhci_fsl_enable_dma,
> +	.get_max_clock 		=3D sdhci_fsl_get_max_clock,
> +	.get_min_clock 		=3D sdhci_fsl_get_min_clock,
> +	.get_timeout_clock 	=3D sdhci_fsl_get_timeout_clock,
> +	.get_ro 		=3D sdhci_fsl_get_ro,
> +	.make_blksz 		=3D sdhci_fsl_make_blksz,
> +};
> +
> +/***********************************************************************=
******\
> + *                                                                      =
     *
> + * Device probing/removal                                               =
     *
> + *                                                                      =
     *
> +\***********************************************************************=
******/
> +
> +static int __devinit sdhci_fsl_probe(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host;
> +	struct resource *iomem;
> +	struct sdhci_fsl_host *fsl_host;
> +	int ret;
> +	struct imxmmc_platform_data *pdata =3D pdev->dev.platform_data;
> +
> +	BUG_ON(pdev =3D=3D NULL);
> +
> +	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!iomem) {
> +		ret =3D -ENOMEM;
> +		goto err;
> +	}
> +
> +	host =3D sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_fsl_host));
> +
> +	if (IS_ERR(host)) {
> +		ret =3D PTR_ERR(host);
> +		goto err;
> +	}
> +
> +	fsl_host =3D sdhci_priv(host);
> +
> +	fsl_host->host =3D host;
> +	fsl_host->pdev =3D pdev;
> +	fsl_host->pdata =3D pdata;
> +
> +	/* Get clk supply for eSDHC */
> +	fsl_host->clk_input =3D clk_get(&pdev->dev, "esdhc_clk");
> +	if (IS_ERR(fsl_host->clk_input)) {
> +		ret =3D PTR_ERR(fsl_host->clk_input);
> +		printk(KERN_ERR "IMX MMC can't get clock.\n");
> +		goto err_request_clk;
> +	}
> +	clk_enable(fsl_host->clk_input);
> +
> +	dev_dbg(&pdev->dev, "SDHC:%d clock:%lu\n",
> +			pdev->id, clk_get_rate(fsl_host->clk_input));
> +
> +	host->hw_name =3D "sdhci-fsl";
> +	host->ops =3D &sdhci_fsl_ops;
> +	host->irq =3D platform_get_irq(pdev, 0);
> +
> +	host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA

Why did you add all the DMA-stuff and mark it as broken then?
Is there a problem with the engine?

> +		| SDHCI_QUIRK_32BIT_DMA_ADDR
> +		| SDHCI_QUIRK_32BIT_ADMA_SIZE
> +		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
> +		| SDHCI_QUIRK_NO_BUSY_IRQ
> +		| SDHCI_QUIRK_BROKEN_CARD_DETECTION
> +		| SDHCI_QUIRK_NONSTANDARD_CLOCK
> +		| SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET
> +		| SDHCI_QUIRK_32BIT_CMD_TRANS_COMBINATION
> +		| SDHCI_QUIRK_NONSTANDARD_HOST_CTL;
> +	if (!request_mem_region(iomem->start, resource_size(iomem),
> +		mmc_hostname(host->mmc))) {
> +		dev_err(&pdev->dev, "cannot request region\n");
> +		ret =3D -EBUSY;
> +		goto err_request_mem;
> +	}
> +
> +	host->ioaddr =3D ioremap(iomem->start, resource_size(iomem));
> +	if (!host->ioaddr) {
> +		dev_err(&pdev->dev, "failed to remap registers\n");
> +		ret =3D -ENOMEM;
> +		goto err_remap;
> +	}
> +
> +	ret =3D sdhci_add_host(host);
> +	if (ret)
> +		goto err_add_host;
> +
> +	platform_set_drvdata(pdev, host);
> +
> +	return 0;
> +
> +err_add_host:
> +	iounmap(host->ioaddr);
> +err_remap:
> +	release_mem_region(iomem->start, resource_size(iomem));
> +err_request_mem:
> +	if (fsl_host->clk_input) {
> +		clk_disable(fsl_host->clk_input);
> +		clk_put(fsl_host->clk_input);
> +	}
> +err_request_clk:
> +	if (fsl_host->regulator_mmc) {
> +		regulator_disable(fsl_host->regulator_mmc);
> +		regulator_put(fsl_host->regulator_mmc);
> +	}
> +	sdhci_free_host(host);
> +err:
> +	printk(KERN_ERR"Probing of sdhci-pltfm failed: %d\n", ret);
> +	return ret;
> +}
> +
> +static int __devexit sdhci_fsl_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> +	struct resource *iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, =
0);
> +	int dead;
> +	u32 scratch;
> +
> +	dead =3D 0;
> +	scratch =3D readl(host->ioaddr + SDHCI_INT_STATUS);
> +	if (scratch =3D=3D (u32)-1)
> +		dead =3D 1;
> +
> +	sdhci_remove_host(host, dead);
> +	iounmap(host->ioaddr);
> +	release_mem_region(iomem->start, resource_size(iomem));
> +	sdhci_free_host(host);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sdhci_fsl_driver =3D {
> +	.driver =3D {
> +		.name =3D DRIVER_NAME,
> +		.owner	=3D THIS_MODULE,
> +	},
> +	.probe		=3D sdhci_fsl_probe,
> +	.remove		=3D __devexit_p(sdhci_fsl_remove),
> +};
> +
> +/***********************************************************************=
******\
> + *                                                                      =
     *
> + * Driver init/exit                                                     =
     *
> + *                                                                      =
     *
> +\***********************************************************************=
******/
> +
> +static int __init sdhci_fsl_init(void)
> +{
> +	return platform_driver_register(&sdhci_fsl_driver);
> +}
> +
> +static void __exit sdhci_fsl_exit(void)
> +{
> +	platform_driver_unregister(&sdhci_fsl_driver);
> +}
> +
> +module_init(sdhci_fsl_init);
> +module_exit(sdhci_fsl_exit);
> +
> +MODULE_DESCRIPTION("IMX Secure Digital Host Controller Interface driver"=
);
> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:sdhci-fsl");
> --=20
> 1.7.0
>=20
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyExsEACgkQD27XaX1/VRt0AACbBSnkih2CAPUOhyeNeJc5BDyl
9b8An1NxHiXnlFKdzAzgGVG7U/ctEX26
=4eSZ
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
