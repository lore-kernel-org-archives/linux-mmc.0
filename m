From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 6/7] mmc: sdhci-omap: Add OMAP SDHCI driver
Date: Tue, 15 Aug 2017 11:22:07 +0300
Message-ID: <a45cf402-26c9-d9d0-1ca0-cbeeddad388c@intel.com>
References: <20170807160142.12134-1-kishon@ti.com>
 <20170807160142.12134-7-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170807160142.12134-7-kishon-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 07/08/17 19:01, Kishon Vijay Abraham I wrote:
> Create a new sdhci-omap driver to configure the eMMC/SD/SDIO controller
> in TI's OMAP SoCs making use of the SDHCI core library. For OMAP specific
> configurations, populate sdhci_ops with OMAP specific callbacks and use
> SDHCI quirks.
> Enable only high speed mode for both SD and eMMC here and add other
> UHS mode support later.

I only have a couple of comments below.

> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mmc/host/Kconfig      |  12 +
>  drivers/mmc/host/Makefile     |   1 +
>  drivers/mmc/host/sdhci-omap.c | 593 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 606 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-omap.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 5755b69f2f72..9aa7e5ce43ba 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -871,3 +871,15 @@ config MMC_SDHCI_XENON
>  	  This selects Marvell Xenon eMMC/SD/SDIO SDHCI.
>  	  If you have a controller with this interface, say Y or M here.
>  	  If unsure, say N.
> +
> +config MMC_SDHCI_OMAP
> +	tristate "TI SDHCI Controller Support"
> +	depends on MMC_SDHCI_PLTFM
> +	help
> +	  This selects the Secure Digital Host Controller Interface (SDHCI)
> +	  support present in TI's DRA7 SOCs. The controller supports
> +	  SD/MMC/SDIO devices.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 4d4547116311..30fb8b0fd0e1 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -82,6 +82,7 @@ obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
>  obj-$(CONFIG_MMC_SDHCI_ST)		+= sdhci-st.o
>  obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+= sdhci-pic32.o
>  obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
> +obj-$(CONFIG_MMC_SDHCI_OMAP)		+= sdhci-omap.o
>  
>  ifeq ($(CONFIG_CB710_DEBUG),y)
>  	CFLAGS-cb710-mmc	+= -DDEBUG
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> new file mode 100644
> index 000000000000..c067c428a0cd
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -0,0 +1,593 @@
> +/*
> + * SDHCI Controller driver for TI's OMAP SoCs
> + *
> + * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com
> + *
> + * Authors: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/mmc/slot-gpio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include "sdhci-pltfm.h"
> +
> +#define SDHCI_OMAP_CON		0x12c
> +#define CON_DW8			BIT(5)
> +#define CON_DMA_MASTER		BIT(20)
> +#define CON_INIT		BIT(1)
> +#define CON_OD			BIT(0)
> +
> +#define SDHCI_OMAP_CMD		0x20c
> +
> +#define SDHCI_OMAP_HCTL		0x228
> +#define HCTL_SDBP		BIT(8)
> +#define HCTL_SDVS_SHIFT		9
> +#define HCTL_SDVS_MASK		(0x7 << HCTL_SDVS_SHIFT)
> +#define HCTL_SDVS_33		(0x7 << HCTL_SDVS_SHIFT)
> +#define HCTL_SDVS_30		(0x6 << HCTL_SDVS_SHIFT)
> +#define HCTL_SDVS_18		(0x5 << HCTL_SDVS_SHIFT)
> +
> +#define SDHCI_OMAP_SYSCTL	0x22c
> +#define SYSCTL_CEN		BIT(2)
> +#define SYSCTL_CLKD_SHIFT	6
> +#define SYSCTL_CLKD_MASK	0x3ff
> +
> +#define SDHCI_OMAP_STAT		0x230
> +
> +#define SDHCI_OMAP_IE		0x234
> +#define INT_CC_EN		BIT(0)
> +
> +#define SDHCI_OMAP_AC12		0x23c
> +#define AC12_V1V8_SIGEN		BIT(19)
> +
> +#define SDHCI_OMAP_CAPA		0x240
> +#define CAPA_VS33		BIT(24)
> +#define CAPA_VS30		BIT(25)
> +#define CAPA_VS18		BIT(26)
> +
> +#define MMC_TIMEOUT		1		/* 1 msec */

This name "MMC_TIMEOUT" is too generic.  SDHCI_OMAP_TIMEOUT would be better.

> +
> +#define SYSCTL_CLKD_MAX		0x3FF
> +
> +#define IOV_1V8			1800000		/* 180000 uV */
> +#define IOV_3V0			3000000		/* 300000 uV */
> +#define IOV_3V3			3300000		/* 330000 uV */
> +
> +struct sdhci_omap_data {
> +	u32 offset;
> +};
> +
> +struct sdhci_omap_host {
> +	void __iomem		*base;
> +	struct device		*dev;
> +	struct	regulator	*pbias;
> +	bool			pbias_enabled;
> +	struct sdhci_host	*host;
> +	unsigned int		flags;
> +
> +#define SDHCI_OMAP_SUPPORTS_DUAL_VOLT	BIT(0)
> +#define SDHCI_OMAP_NO_1_8_V		BIT(1)
> +
> +	u8			power_mode;
> +	bool			io_3_3v_support;
> +};
> +
> +static inline u32 sdhci_omap_readl(struct sdhci_omap_host *host,
> +				   unsigned int offset)
> +{
> +	return readl(host->base + offset);
> +}
> +
> +static inline void sdhci_omap_writel(struct sdhci_omap_host *host,
> +				     unsigned int offset, u32 data)
> +{
> +	writel(data, host->base + offset);
> +}
> +
> +static int sdhci_omap_set_pbias(struct sdhci_omap_host *omap_host,
> +				bool power_on, unsigned int iov)
> +{
> +	int ret;
> +	struct device *dev = omap_host->dev;
> +
> +	if (IS_ERR(omap_host->pbias))
> +		return 0;
> +
> +	if (power_on) {
> +		ret = regulator_set_voltage(omap_host->pbias, iov, iov);
> +		if (ret) {
> +			dev_err(dev, "pbias set voltage failed\n");
> +			return ret;
> +		}
> +
> +		if (omap_host->pbias_enabled)
> +			return 0;
> +
> +		ret = regulator_enable(omap_host->pbias);
> +		if (ret) {
> +			dev_err(dev, "pbias reg enable fail\n");
> +			return ret;
> +		}
> +
> +		omap_host->pbias_enabled = true;
> +	} else {
> +		if (!omap_host->pbias_enabled)
> +			return 0;
> +
> +		ret = regulator_disable(omap_host->pbias);
> +		if (ret) {
> +			dev_err(dev, "pbias reg disable fail\n");
> +			return ret;
> +		}
> +		omap_host->pbias_enabled = false;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sdhci_omap_enable_iov(struct sdhci_omap_host *omap_host,
> +				 unsigned int iov)
> +{
> +	int ret;
> +	struct sdhci_host *host = omap_host->host;
> +	struct mmc_host *mmc = host->mmc;
> +
> +	ret = sdhci_omap_set_pbias(omap_host, false, 0);
> +	if (ret)
> +		return ret;
> +
> +	if (!IS_ERR(mmc->supply.vqmmc)) {
> +		ret = regulator_set_voltage(mmc->supply.vqmmc, iov, iov);
> +		if (ret) {
> +			dev_err(mmc_dev(mmc), "vqmmc set voltage failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = sdhci_omap_set_pbias(omap_host, true, iov);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void sdhci_omap_conf_bus_power(struct sdhci_omap_host *omap_host,
> +				      unsigned char signal_voltage)
> +{
> +	u32 reg;
> +	ktime_t timeout;
> +
> +	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_HCTL);
> +	reg &= ~HCTL_SDVS_MASK;
> +
> +	if (signal_voltage == MMC_SIGNAL_VOLTAGE_180)
> +		reg |= HCTL_SDVS_18;
> +	else if (omap_host->io_3_3v_support)
> +		reg |= HCTL_SDVS_33;
> +	else
> +		reg |= HCTL_SDVS_30;
> +
> +	sdhci_omap_writel(omap_host, SDHCI_OMAP_HCTL, reg);
> +
> +	reg |= HCTL_SDBP;
> +	sdhci_omap_writel(omap_host, SDHCI_OMAP_HCTL, reg);
> +
> +	/* wait 1ms */
> +	timeout = ktime_add_ms(ktime_get(), MMC_TIMEOUT);
> +	while (!(sdhci_omap_readl(omap_host, SDHCI_OMAP_HCTL) & HCTL_SDBP)) {
> +		if (WARN_ON(ktime_after(ktime_get(), timeout)))
> +			return;
> +		usleep_range(5, 10);
> +	}
> +}
> +
> +static int sdhci_omap_start_signal_voltage_switch(struct mmc_host *mmc,
> +						  struct mmc_ios *ios)
> +{
> +	u32 reg;
> +	int ret;
> +	unsigned int iov;
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_omap_host *omap_host;
> +	struct device *dev;
> +
> +	pltfm_host = sdhci_priv(host);
> +	omap_host = sdhci_pltfm_priv(pltfm_host);
> +	dev = omap_host->dev;
> +
> +	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> +		reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CAPA);
> +		if (!(reg & (CAPA_VS33 | CAPA_VS30)))
> +			return -EOPNOTSUPP;
> +
> +		sdhci_omap_conf_bus_power(omap_host, ios->signal_voltage);
> +
> +		reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_AC12);
> +		reg &= ~AC12_V1V8_SIGEN;
> +		sdhci_omap_writel(omap_host, SDHCI_OMAP_AC12, reg);
> +
> +		if (omap_host->io_3_3v_support)
> +			iov = IOV_3V3;
> +		else
> +			iov = IOV_3V0;
> +	} else if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> +		reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CAPA);
> +		if (!(reg & CAPA_VS18))
> +			return -EOPNOTSUPP;
> +
> +		sdhci_omap_conf_bus_power(omap_host, ios->signal_voltage);
> +
> +		reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_AC12);
> +		reg |= AC12_V1V8_SIGEN;
> +		sdhci_omap_writel(omap_host, SDHCI_OMAP_AC12, reg);
> +
> +		iov = IOV_1V8;
> +	} else {
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = sdhci_omap_enable_iov(omap_host, iov);
> +	if (ret) {
> +		dev_err(dev, "failed to switch IO voltage to %dmV\n", iov);
> +		return ret;
> +	}
> +
> +	dev_dbg(dev, "IO voltage switched to %dmV\n", iov);
> +	return 0;
> +}
> +
> +static void sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
> +{
> +	u32 reg;
> +
> +	/* voltage capabilities might be set by boot loader, clear it */
> +	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CAPA);
> +	reg &= ~(CAPA_VS18 | CAPA_VS30 | CAPA_VS33);
> +
> +	if (omap_host->flags & SDHCI_OMAP_SUPPORTS_DUAL_VOLT) {
> +		if (omap_host->io_3_3v_support)
> +			reg |= (CAPA_VS33 | CAPA_VS18);
> +		else
> +			reg |= (CAPA_VS30 | CAPA_VS18);
> +	} else if (omap_host->flags & SDHCI_OMAP_NO_1_8_V) {
> +		if (omap_host->io_3_3v_support)
> +			reg |= CAPA_VS33;
> +		else
> +			reg |= CAPA_VS30;
> +	} else {
> +		reg |= CAPA_VS18;
> +	}
> +
> +	sdhci_omap_writel(omap_host, SDHCI_OMAP_CAPA, reg);
> +}
> +
> +static void sdhci_omap_set_bus_mode(struct sdhci_host *host, unsigned int mode)
> +{
> +	u32 reg;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
> +	if (mode == MMC_BUSMODE_OPENDRAIN)
> +		reg |= CON_OD;
> +	else
> +		reg &= ~CON_OD;
> +	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, reg);
> +}
> +
> +static void sdhci_omap_set_bus_width(struct sdhci_host *host, int width)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +	u32 reg;
> +
> +	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
> +	if (width == MMC_BUS_WIDTH_8)
> +		reg |= CON_DW8;
> +	else
> +		reg &= ~CON_DW8;
> +	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, reg);
> +
> +	sdhci_set_bus_width(host, width);
> +}
> +
> +static void sdhci_omap_init_74_clocks(struct sdhci_host *host, u8 power_mode)
> +{
> +	u32 reg;
> +	ktime_t timeout;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	if (omap_host->power_mode == power_mode)
> +		return;
> +
> +	if (power_mode != MMC_POWER_ON)
> +		return;
> +
> +	disable_irq(host->irq);
> +
> +	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
> +	reg |= CON_INIT;
> +	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, reg);
> +	sdhci_omap_writel(omap_host, SDHCI_OMAP_CMD, 0x0);
> +
> +	/* wait 1ms */
> +	timeout = ktime_add_ms(ktime_get(), MMC_TIMEOUT);
> +	while (!(sdhci_omap_readl(omap_host, SDHCI_OMAP_STAT) & INT_CC_EN)) {
> +		if (WARN_ON(ktime_after(ktime_get(), timeout)))
> +			return;
> +		usleep_range(5, 10);
> +	}
> +
> +	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
> +	reg &= ~CON_INIT;
> +	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, reg);
> +	sdhci_omap_writel(omap_host, SDHCI_OMAP_STAT, INT_CC_EN);
> +
> +	enable_irq(host->irq);
> +
> +	omap_host->power_mode = power_mode;
> +}
> +
> +static u16 sdhci_omap_calc_divisor(struct sdhci_pltfm_host *host,
> +				   unsigned int clock)
> +{
> +	u16 dsor;
> +
> +	dsor = DIV_ROUND_UP(clk_get_rate(host->clk), clock);
> +	if (dsor > SYSCTL_CLKD_MAX)
> +		dsor = SYSCTL_CLKD_MAX;
> +
> +	return dsor;
> +}
> +
> +static void sdhci_omap_start_clock(struct sdhci_omap_host *omap_host)
> +{
> +	u32 reg;
> +
> +	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_SYSCTL);
> +	reg |= SYSCTL_CEN;
> +	sdhci_omap_writel(omap_host, SDHCI_OMAP_SYSCTL, reg);
> +}
> +
> +static void sdhci_omap_stop_clock(struct sdhci_omap_host *omap_host)
> +{
> +	u32 reg;
> +
> +	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_SYSCTL);
> +	reg &= ~SYSCTL_CEN;
> +	sdhci_omap_writel(omap_host, SDHCI_OMAP_SYSCTL, reg);
> +}
> +
> +static void sdhci_omap_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +	unsigned long clkdiv;
> +
> +	if (!clock)
> +		return;
> +
> +	sdhci_omap_stop_clock(omap_host);
> +
> +	clkdiv = sdhci_omap_calc_divisor(pltfm_host, clock);
> +	clkdiv = (clkdiv & SYSCTL_CLKD_MASK) << SYSCTL_CLKD_SHIFT;
> +	sdhci_enable_clk(host, clkdiv);
> +
> +	sdhci_omap_start_clock(omap_host);
> +}
> +
> +static int sdhci_omap_enable_dma(struct sdhci_host *host)
> +{
> +	u32 reg;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
> +	reg |= CON_DMA_MASTER;
> +	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, reg);
> +
> +	return 0;
> +}
> +
> +unsigned int sdhci_omap_get_min_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +	return clk_get_rate(pltfm_host->clk) / SYSCTL_CLKD_MAX;
> +}
> +
> +static struct sdhci_ops sdhci_omap_ops = {
> +	.set_clock = sdhci_omap_set_clock,
> +	.enable_dma = sdhci_omap_enable_dma,
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.get_min_clock = sdhci_omap_get_min_clock,
> +	.set_bus_width = sdhci_omap_set_bus_width,
> +	.platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
> +	.reset = sdhci_reset,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +	.set_bus_mode = sdhci_omap_set_bus_mode,
> +};
> +
> +void sdhci_omap_get_of_property(struct sdhci_omap_host *omap_host)
> +{
> +	struct device *dev = omap_host->dev;
> +	struct sdhci_host *host = omap_host->host;
> +	struct mmc_host *mmc = host->mmc;
> +
> +	if (device_property_read_bool(dev, "ti,dual-volt"))
> +		omap_host->flags |= SDHCI_OMAP_SUPPORTS_DUAL_VOLT;
> +
> +	if (device_property_read_bool(dev, "no-1-8-v"))
> +		omap_host->flags |= SDHCI_OMAP_NO_1_8_V;
> +
> +	if (device_property_read_bool(dev, "ti,non-removable"))
> +		mmc->caps |= MMC_CAP_NONREMOVABLE;
> +}
> +
> +static const struct sdhci_pltfm_data sdhci_omap_pdata = {
> +	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> +		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_NO_HISPD_BIT |
> +		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
> +	.quirks2 = SDHCI_QUIRK2_NO_1_8_V |
> +		   SDHCI_QUIRK2_ACMD23_BROKEN |
> +		   SDHCI_QUIRK2_NO_CRC_STRIPPING |
> +		   SDHCI_QUIRK2_FORCE_ADMA |
> +		   SDHCI_QUIRK2_BROKEN_POWER_CONTROL,
> +	.ops = &sdhci_omap_ops,
> +};
> +
> +static const struct sdhci_omap_data dra7_data = {
> +	.offset = 0x200,
> +};
> +
> +static const struct of_device_id omap_sdhci_match[] = {
> +	{ .compatible = "ti,dra7-sdhci", .data = &dra7_data },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, omap_sdhci_match);
> +
> +static int sdhci_omap_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	u32 offset;
> +	struct device *dev = &pdev->dev;
> +	struct sdhci_host *host;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_omap_host *omap_host;
> +	struct mmc_host *mmc;
> +	const struct of_device_id *match;
> +	struct sdhci_omap_data *data;
> +
> +	match = of_match_device(omap_sdhci_match, dev);
> +	if (!match)
> +		return -EINVAL;
> +
> +	data = (struct sdhci_omap_data *)match->data;
> +	if (!data) {
> +		dev_err(dev, "no sdhci omap data\n");
> +		return -EINVAL;
> +	}
> +
> +	offset = data->offset;
> +
> +	host = sdhci_pltfm_init(pdev, &sdhci_omap_pdata,
> +				sizeof(*omap_host));
> +	if (IS_ERR(host)) {
> +		dev_err(dev, "Failed sdhci_pltfm_init\n");
> +		return PTR_ERR(host);
> +	}
> +
> +	pltfm_host = sdhci_priv(host);
> +	omap_host = sdhci_pltfm_priv(pltfm_host);
> +	omap_host->host = host;
> +	omap_host->base = host->ioaddr;
> +	omap_host->dev = dev;
> +	sdhci_omap_get_of_property(omap_host);
> +
> +	host->ioaddr += offset;
> +
> +	mmc = host->mmc;
> +	ret = mmc_of_parse(mmc);
> +	if (ret)
> +		goto err_of_parse;
> +
> +	pltfm_host->clk = devm_clk_get(dev, "fck");
> +	if (IS_ERR(pltfm_host->clk)) {
> +		ret = PTR_ERR(pltfm_host->clk);
> +		goto err_of_parse;
> +	}
> +
> +	ret = clk_set_rate(pltfm_host->clk, mmc->f_max);
> +	if (ret) {
> +		dev_err(dev, "failed to set clock to %d\n", mmc->f_max);
> +		goto err_of_parse;
> +	}
> +
> +	omap_host->pbias = devm_regulator_get_optional(dev, "pbias");
> +	if (IS_ERR(omap_host->pbias)) {
> +		ret = PTR_ERR(omap_host->pbias);
> +		if (ret != -ENODEV) {
> +			dev_err(dev, "CONFIG_REGULATOR_PBIAS not enabled??\n");
> +			return ret;
> +		}
> +		dev_dbg(dev, "unable to get pbias regulator %ld\n",
> +			PTR_ERR(omap_host->pbias));
> +	} else {
> +		if (regulator_is_supported_voltage(omap_host->pbias, IOV_3V3,
> +						   IOV_3V3))
> +			omap_host->io_3_3v_support = true;
> +		dev_vdbg(dev, "Max PBIAS support Voltage: %dmv\n",
> +			 omap_host->io_3_3v_support ? IOV_3V3 : IOV_3V0);
> +	}
> +	omap_host->pbias_enabled = false;
> +
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);

What are you trying to do with runtime pm?  There don't seem to be any pm
callbacks, so does this do anything?

> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed\n");
> +		goto err_get_sync;
> +	}
> +
> +	sdhci_omap_set_capabilities(omap_host);
> +
> +	host->mmc_host_ops.get_ro = mmc_gpio_get_ro;
> +	host->mmc_host_ops.start_signal_voltage_switch =
> +					sdhci_omap_start_signal_voltage_switch;
> +
> +	ret = sdhci_add_host(host);
> +	if (ret)
> +		goto err_get_sync;
> +
> +	return 0;
> +
> +err_get_sync:
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +
> +err_of_parse:
> +	sdhci_pltfm_free(pdev);
> +	return ret;
> +}
> +
> +static int sdhci_omap_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +
> +	sdhci_remove_host(host, true);
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	sdhci_pltfm_free(pdev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sdhci_omap_driver = {
> +	.probe = sdhci_omap_probe,
> +	.remove = sdhci_omap_remove,
> +	.driver = {
> +		   .name = "sdhci-omap",
> +		   .of_match_table = of_match_ptr(omap_sdhci_match),
> +		  },
> +};
> +
> +module_platform_driver(sdhci_omap_driver);
> +
> +MODULE_DESCRIPTION("SDHCI driver for OMAP SoCs");
> +MODULE_AUTHOR("Texas Instruments Inc.");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("OMAP SDHCI Driver");
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
