From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 07/12] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
Date: Wed, 4 Jan 2017 09:26:36 +0200
Message-ID: <aedd36af-8bf6-815f-34ee-9a3166e4fe5b@intel.com>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
 <f48940626343ca9cf68b32b7324b243e76a11960.1481651244.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------D339B8C29FF30116D1A7AA43"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59152 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965126AbdADHcP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Jan 2017 02:32:15 -0500
In-Reply-To: <f48940626343ca9cf68b32b7324b243e76a11960.1481651244.git-series.gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Hanna Hawa <hannah@marvell.com>, Kostya Porotchkin <kostap@marvell.com>

This is a multi-part message in MIME format.
--------------D339B8C29FF30116D1A7AA43
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 13/12/16 19:48, Gregory CLEMENT wrote:
> From: Hu Ziji <huziji@marvell.com>
> 
> Add Xenon eMMC/SD/SDIO host controller core functionality.
> Add Xenon specific intialization process.
> Add Xenon specific mmc_host_ops APIs.
> Add Xenon specific register definitions.
> 
> Add CONFIG_MMC_SDHCI_XENON support in drivers/mmc/host/Kconfig.
> 
> Marvell Xenon SDHC conforms to SD Physical Layer Specification
> Version 3.01 and is designed according to the guidelines provided
> in the SD Host Controller Standard Specification Version 3.00.
> 
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  MAINTAINERS                    |   1 +-
>  drivers/mmc/host/Kconfig       |   9 +-
>  drivers/mmc/host/Makefile      |   3 +-
>  drivers/mmc/host/sdhci-xenon.c | 612 ++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci-xenon.h |  70 ++++-
>  5 files changed, 695 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-xenon.c
>  create mode 100644 drivers/mmc/host/sdhci-xenon.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 850a0afb0c8d..bb33286aeb48 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7608,6 +7608,7 @@ MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
>  M:	Ziji Hu <huziji@marvell.com>
>  L:	linux-mmc@vger.kernel.org
>  S:	Supported
> +F:	drivers/mmc/host/sdhci-xenon*
>  F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>  
>  MATROX FRAMEBUFFER DRIVER
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 5274f503a39a..85a53623526a 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -798,3 +798,12 @@ config MMC_SDHCI_BRCMSTB
>  	  Broadcom STB SoCs.
>  
>  	  If unsure, say Y.
> +
> +config MMC_SDHCI_XENON
> +	tristate "Marvell Xenon eMMC/SD/SDIO SDHCI driver"
> +	depends on MMC_SDHCI && MMC_SDHCI_PLTFM
> +	help
> +	  This selects Marvell Xenon eMMC/SD/SDIO SDHCI.
> +	  If you have a machine with integrated Marvell Xenon SDHC IP,
> +	  say Y or M here.
> +	  If unsure, say N.
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index e2bdaaf43184..75eaf743486c 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -80,3 +80,6 @@ obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
>  ifeq ($(CONFIG_CB710_DEBUG),y)
>  	CFLAGS-cb710-mmc	+= -DDEBUG
>  endif
> +
> +obj-$(CONFIG_MMC_SDHCI_XENON)	+= sdhci-xenon-driver.o
> +sdhci-xenon-driver-y		+= sdhci-xenon.o
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> new file mode 100644
> index 000000000000..c71439fbc308
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -0,0 +1,612 @@
> +/*
> + * Driver for Marvell Xenon SDHC as a platform device
> + *
> + * Copyright (C) 2016 Marvell, All Rights Reserved.
> + *
> + * Author:	Hu Ziji <huziji@marvell.com>
> + * Date:	2016-8-24
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * Inspired by Jisheng Zhang <jszhang@marvell.com>
> + * Special thanks to Video BG4 project team.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include "sdhci-pltfm.h"
> +#include "sdhci-xenon.h"
> +
> +static int enable_xenon_internal_clk(struct sdhci_host *host)
> +{
> +	u32 reg;
> +	u8 timeout;
> +
> +	reg = sdhci_readl(host, SDHCI_CLOCK_CONTROL);
> +	reg |= SDHCI_CLOCK_INT_EN;
> +	sdhci_writel(host, reg, SDHCI_CLOCK_CONTROL);
> +	/* Wait max 20 ms */
> +	timeout = 20;
> +	while (!((reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> +			& SDHCI_CLOCK_INT_STABLE)) {
> +		if (timeout == 0) {
> +			pr_err("%s: Internal clock never stabilised.\n",
> +			       mmc_hostname(host->mmc));
> +			return -ETIMEDOUT;
> +		}
> +		timeout--;
> +		mdelay(1);
> +	}
> +
> +	return 0;
> +}
> +
> +/* Set SDCLK-off-while-idle */
> +static void xenon_set_sdclk_off_idle(struct sdhci_host *host,
> +				     unsigned char sdhc_id, bool enable)
> +{
> +	u32 reg;
> +	u32 mask;
> +
> +	reg = sdhci_readl(host, SDHCI_SYS_OP_CTRL);
> +	/* Get the bit shift basing on the SDHC index */
> +	mask = (0x1 << (SDHCI_SDCLK_IDLEOFF_ENABLE_SHIFT + sdhc_id));
> +	if (enable)
> +		reg |= mask;
> +	else
> +		reg &= ~mask;
> +
> +	sdhci_writel(host, reg, SDHCI_SYS_OP_CTRL);
> +}
> +
> +/* Enable/Disable the Auto Clock Gating function */
> +static void xenon_set_acg(struct sdhci_host *host, bool enable)
> +{
> +	u32 reg;
> +
> +	reg = sdhci_readl(host, SDHCI_SYS_OP_CTRL);
> +	if (enable)
> +		reg &= ~SDHCI_AUTO_CLKGATE_DISABLE_MASK;
> +	else
> +		reg |= SDHCI_AUTO_CLKGATE_DISABLE_MASK;
> +	sdhci_writel(host, reg, SDHCI_SYS_OP_CTRL);
> +}
> +
> +/* Enable this SDHC */
> +static void xenon_enable_sdhc(struct sdhci_host *host,
> +			      unsigned char sdhc_id)
> +{
> +	u32 reg;
> +
> +	reg = sdhci_readl(host, SDHCI_SYS_OP_CTRL);
> +	reg |= (BIT(sdhc_id) << SDHCI_SLOT_ENABLE_SHIFT);
> +	sdhci_writel(host, reg, SDHCI_SYS_OP_CTRL);
> +
> +	/*
> +	 * Manually set the flag which all the card types require,
> +	 * including SD, eMMC, SDIO
> +	 */
> +	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> +}
> +
> +/* Disable this SDHC */
> +static void xenon_disable_sdhc(struct sdhci_host *host,
> +			       unsigned char sdhc_id)
> +{
> +	u32 reg;
> +
> +	reg = sdhci_readl(host, SDHCI_SYS_OP_CTRL);
> +	reg &= ~(BIT(sdhc_id) << SDHCI_SLOT_ENABLE_SHIFT);
> +	sdhci_writel(host, reg, SDHCI_SYS_OP_CTRL);
> +}
> +
> +/* Enable Parallel Transfer Mode */
> +static void xenon_enable_sdhc_parallel_tran(struct sdhci_host *host,
> +					    unsigned char sdhc_id)
> +{
> +	u32 reg;
> +
> +	reg = sdhci_readl(host, SDHCI_SYS_EXT_OP_CTRL);
> +	reg |= BIT(sdhc_id);
> +	sdhci_writel(host, reg, SDHCI_SYS_EXT_OP_CTRL);
> +}
> +
> +static void xenon_sdhc_tuning_setup(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 reg;
> +
> +	/* Disable the Re-Tuning Request functionality */
> +	reg = sdhci_readl(host, SDHCI_SLOT_RETUNING_REQ_CTRL);
> +	reg &= ~SDHCI_RETUNING_COMPATIBLE;
> +	sdhci_writel(host, reg, SDHCI_SLOT_RETUNING_REQ_CTRL);
> +
> +	/* Disable the Re-tuning Event Signal Enable */
> +	reg = sdhci_readl(host, SDHCI_SIGNAL_ENABLE);
> +	reg &= ~SDHCI_INT_RETUNE;
> +	sdhci_writel(host, reg, SDHCI_SIGNAL_ENABLE);
> +
> +	/* Force to use Tuning Mode 1 */
> +	host->tuning_mode = SDHCI_TUNING_MODE_1;
> +	/* Set re-tuning period */
> +	host->tuning_count = 1 << (priv->tuning_count - 1);

host->tuning_mode and host->tuning_count get overwritten in
sdhci_setup_host() called by sdhci_add_host()

> +}
> +
> +/*
> + * Operations inside struct sdhci_ops
> + */
> +/* Recover the Register Setting cleared during SOFTWARE_RESET_ALL */
> +static void sdhci_xenon_reset_exit(struct sdhci_host *host,
> +				   unsigned char sdhc_id, u8 mask)
> +{
> +	/* Only SOFTWARE RESET ALL will clear the register setting */
> +	if (!(mask & SDHCI_RESET_ALL))
> +		return;
> +
> +	/* Disable tuning request and auto-retuning again */
> +	xenon_sdhc_tuning_setup(host);
> +
> +	xenon_set_acg(host, true);
> +
> +	xenon_set_sdclk_off_idle(host, sdhc_id, false);
> +}
> +
> +static void sdhci_xenon_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	sdhci_reset(host, mask);
> +	sdhci_xenon_reset_exit(host, priv->sdhc_id, mask);
> +}
> +
> +/*
> + * Xenon defines different values for HS200 and HS400
> + * in Host_Control_2
> + */
> +static void xenon_set_uhs_signaling(struct sdhci_host *host,
> +				    unsigned int timing)
> +{
> +	u16 ctrl_2;
> +
> +	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	/* Select Bus Speed Mode for host */
> +	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
> +	if (timing == MMC_TIMING_MMC_HS200)
> +		ctrl_2 |= SDHCI_XENON_CTRL_HS200;
> +	else if (timing == MMC_TIMING_UHS_SDR104)
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
> +	else if (timing == MMC_TIMING_UHS_SDR12)
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
> +	else if (timing == MMC_TIMING_UHS_SDR25)
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
> +	else if (timing == MMC_TIMING_UHS_SDR50)
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> +	else if ((timing == MMC_TIMING_UHS_DDR50) ||
> +		 (timing == MMC_TIMING_MMC_DDR52))
> +		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
> +	else if (timing == MMC_TIMING_MMC_HS400)
> +		ctrl_2 |= SDHCI_XENON_CTRL_HS400;
> +	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +}
> +
> +static const struct sdhci_ops sdhci_xenon_ops = {
> +	.set_clock		= sdhci_set_clock,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.reset			= sdhci_xenon_reset,
> +	.set_uhs_signaling	= xenon_set_uhs_signaling,
> +	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_xenon_pdata = {
> +	.ops = &sdhci_xenon_ops,
> +	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> +		  SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER |
> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +};
> +
> +/*
> + * Xenon Specific Operations in mmc_host_ops
> + */
> +static void xenon_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	unsigned long flags;
> +	u32 reg;
> +
> +	/*
> +	 * HS400/HS200/eMMC HS doesn't have Preset Value register.
> +	 * However, sdhci_set_ios will read HS400/HS200 Preset register.
> +	 * Disable Preset Value register for HS400/HS200.
> +	 * eMMC HS with preset_enabled set will trigger a bug in
> +	 * get_preset_value().
> +	 */
> +	spin_lock_irqsave(&host->lock, flags);
> +	if ((ios->timing == MMC_TIMING_MMC_HS400) ||
> +	    (ios->timing == MMC_TIMING_MMC_HS200) ||
> +	    (ios->timing == MMC_TIMING_MMC_HS)) {
> +		host->preset_enabled = false;
> +		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> +
> +		reg = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		reg &= ~SDHCI_CTRL_PRESET_VAL_ENABLE;
> +		sdhci_writew(host, reg, SDHCI_HOST_CONTROL2);
> +	} else {
> +		host->quirks2 &= ~SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> +	}
> +	spin_unlock_irqrestore(&host->lock, flags);

At some point we will have to get rid of SDHCI_QUIRK2_PRESET_VALUE_BROKEN
and add a callback instead.

> +
> +	sdhci_set_ios(mmc, ios);
> +
> +	if (host->clock > SDHCI_DEFAULT_SDCLK_FREQ) {
> +		spin_lock_irqsave(&host->lock, flags);
> +		xenon_set_sdclk_off_idle(host, priv->sdhc_id, true);
> +		spin_unlock_irqrestore(&host->lock, flags);
> +	}
> +}
> +
> +static int xenon_emmc_signal_voltage_switch(struct mmc_host *mmc,
> +					    struct mmc_ios *ios)
> +{
> +	unsigned char voltage = ios->signal_voltage;
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	unsigned char voltage_code;
> +	u32 ctrl;
> +
> +	if ((voltage == MMC_SIGNAL_VOLTAGE_330) ||
> +	    (voltage == MMC_SIGNAL_VOLTAGE_180)) {
> +		if (voltage == MMC_SIGNAL_VOLTAGE_330)
> +			voltage_code = SDHCI_EMMC_VCCQ_3_3V;
> +		else if (voltage == MMC_SIGNAL_VOLTAGE_180)
> +			voltage_code = SDHCI_EMMC_VCCQ_1_8V;
> +
> +		/*
> +		 * This host is for eMMC, XENON self-defined
> +		 * eMMC control register should be accessed
> +		 * instead of Host Control 2
> +		 */
> +		ctrl = sdhci_readl(host, SDHCI_SLOT_EMMC_CTRL);
> +		ctrl &= ~SDHCI_EMMC_VCCQ_MASK;
> +		ctrl |= voltage_code;
> +		sdhci_writel(host, ctrl, SDHCI_SLOT_EMMC_CTRL);
> +
> +		/* There is no standard to determine this waiting period */
> +		usleep_range(1000, 2000);
> +
> +		/* Check whether io voltage switch is done */
> +		ctrl = sdhci_readl(host, SDHCI_SLOT_EMMC_CTRL);
> +		ctrl &= SDHCI_EMMC_VCCQ_MASK;
> +		/*
> +		 * This bit is set only when regulator feeds back
> +		 * the voltage switch results to Xenon SDHC.
> +		 * However, in actaul implementation, regulator might not
> +		 * provide this feedback.
> +		 * Thus we shall not rely on this bit to determine
> +		 * if switch failed.
> +		 * If the bit is not set, just throw a message.
> +		 * Besides, error code should not be returned.
> +		 */
> +		if (ctrl != voltage_code)
> +			dev_info(mmc_dev(mmc), "fail to detect eMMC signal voltage stable\n");
> +		return 0;
> +	}
> +
> +	dev_err(mmc_dev(mmc), "Unsupported signal voltage: %d\n", voltage);
> +	return -EINVAL;
> +}
> +
> +static int xenon_start_signal_voltage_switch(struct mmc_host *mmc,
> +					     struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	/*
> +	 * Before SD/SDIO set signal voltage, SD bus clock should be
> +	 * disabled. However, sdhci_set_clock will also disable the Internal
> +	 * clock in mmc_set_signal_voltage().
> +	 * If Internal clock is disabled, the 3.3V/1.8V bit can not be updated.
> +	 * Thus here manually enable internal clock.
> +	 *
> +	 * After switch completes, it is unnecessary to disable internal clock,
> +	 * since keeping internal clock active obeys SD spec.
> +	 */
> +	enable_xenon_internal_clk(host);

We could try the attached patch.

> +
> +	if (priv->init_card_type == MMC_TYPE_MMC)
> +		return xenon_emmc_signal_voltage_switch(mmc, ios);
> +
> +	return sdhci_start_signal_voltage_switch(mmc, ios);
> +}
> +
> +/*
> + * Update card type.
> + * priv->init_card_type will be used in PHY timing adjustment.
> + */
> +static void xenon_init_card(struct mmc_host *mmc, struct mmc_card *card)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	/* Update card type*/
> +	priv->init_card_type = card->type;
> +}
> +
> +static int xenon_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	if (host->timing == MMC_TIMING_UHS_DDR50)
> +		return 0;
> +
> +	return sdhci_execute_tuning(mmc, opcode);
> +}
> +
> +static void xenon_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 reg;
> +	u8 sdhc_id = priv->sdhc_id;
> +
> +	sdhci_enable_sdio_irq(mmc, enable);
> +
> +	if (enable) {
> +		/*
> +		 * Set SDIO Card Inserted indication
> +		 * to enable detecting SDIO async irq.
> +		 */
> +		reg = sdhci_readl(host, SDHCI_SYS_CFG_INFO);
> +		reg |= (1 << (sdhc_id + SDHCI_SLOT_TYPE_SDIO_SHIFT));
> +		sdhci_writel(host, reg, SDHCI_SYS_CFG_INFO);
> +	} else {
> +		/* Clear SDIO Card Inserted indication */
> +		reg = sdhci_readl(host, SDHCI_SYS_CFG_INFO);
> +		reg &= ~(1 << (sdhc_id + SDHCI_SLOT_TYPE_SDIO_SHIFT));
> +		sdhci_writel(host, reg, SDHCI_SYS_CFG_INFO);
> +	}
> +}
> +
> +static void xenon_replace_mmc_host_ops(struct sdhci_host *host)
> +{
> +	host->mmc_host_ops.set_ios = xenon_set_ios;
> +	host->mmc_host_ops.start_signal_voltage_switch =
> +			xenon_start_signal_voltage_switch;
> +	host->mmc_host_ops.init_card = xenon_init_card;
> +	host->mmc_host_ops.execute_tuning = xenon_execute_tuning;
> +	host->mmc_host_ops.enable_sdio_irq = xenon_enable_sdio_irq;
> +}
> +
> +/*
> + * Parse child node in Xenon DT.
> + * Search for the following item(s):
> + * - eMMC card type
> + */
> +static int xenon_child_node_of_parse(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct mmc_host *mmc = host->mmc;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	struct device_node *child;
> +	int nr_child;
> +
> +	priv->init_card_type = SDHCI_CARD_TYPE_UNKNOWN;
> +
> +	nr_child = of_get_child_count(np);
> +	if (!nr_child)
> +		return 0;
> +
> +	for_each_child_of_node(np, child) {
> +		if (of_device_is_compatible(child, "mmc-card"))	{
> +			priv->init_card_type = MMC_TYPE_MMC;
> +			mmc->caps |= MMC_CAP_NONREMOVABLE;
> +
> +			/*
> +			 * Force to clear BUS_TEST to
> +			 * skip bus_test_pre and bus_test_post
> +			 */
> +			mmc->caps &= ~MMC_CAP_BUS_WIDTH_TEST;
> +			mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ |
> +				      MMC_CAP2_PACKED_CMD |
> +				      MMC_CAP2_NO_SD |
> +				      MMC_CAP2_NO_SDIO;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int xenon_probe_dt(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct mmc_host *mmc = host->mmc;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	int err;
> +	u32 sdhc_id, nr_sdhc;
> +	u32 tuning_count;
> +
> +	/* Standard MMC property */
> +	err = mmc_of_parse(mmc);
> +	if (err)
> +		return err;
> +
> +	/* Standard SDHCI property */
> +	sdhci_get_of_property(pdev);
> +
> +	/*
> +	 * Xenon Specific property:
> +	 * init_card_type: check whether this SDHC is for eMMC
> +	 * sdhc-id: the index of current SDHC.
> +	 *	    Refer to SDHCI_SYS_CFG_INFO register
> +	 * tun-count: the interval between re-tuning
> +	 */
> +	/* Parse child node, including checking emmc type */
> +	err = xenon_child_node_of_parse(pdev);
> +	if (err)
> +		return err;
> +
> +	priv->sdhc_id = 0x0;
> +	if (!of_property_read_u32(np, "marvell,xenon-sdhc-id", &sdhc_id)) {
> +		nr_sdhc = sdhci_readl(host, SDHCI_SYS_CFG_INFO);
> +		nr_sdhc &= SDHCI_NR_SUPPORTED_SLOT_MASK;
> +		if (unlikely(sdhc_id > nr_sdhc)) {
> +			dev_err(mmc_dev(mmc), "SDHC Index %d exceeds Number of SDHCs %d\n",
> +				sdhc_id, nr_sdhc);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	tuning_count = SDHCI_DEF_TUNING_COUNT;
> +	if (!of_property_read_u32(np, "marvell,xenon-tun-count",
> +				  &tuning_count)) {
> +		if (unlikely(tuning_count >= SDHCI_TMR_RETUN_NO_PRESENT)) {
> +			dev_err(mmc_dev(mmc), "Wrong Re-tuning Count. Set default value %d\n",
> +				SDHCI_DEF_TUNING_COUNT);
> +			tuning_count = SDHCI_DEF_TUNING_COUNT;
> +		}
> +	}
> +	priv->tuning_count = tuning_count;
> +
> +	return err;
> +}
> +
> +static int xenon_sdhc_probe(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u8 sdhc_id = priv->sdhc_id;
> +
> +	/* Enable SDHC */
> +	xenon_enable_sdhc(host, sdhc_id);
> +
> +	/* Enable ACG */
> +	xenon_set_acg(host, true);
> +
> +	/* Enable Parallel Transfer Mode */
> +	xenon_enable_sdhc_parallel_tran(host, sdhc_id);
> +
> +	/* Set tuning functionality of this SDHC */
> +	xenon_sdhc_tuning_setup(host);
> +
> +	return 0;
> +}
> +
> +static void xenon_sdhc_remove(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u8 sdhc_id = priv->sdhc_id;
> +
> +	/* disable SDHC */
> +	xenon_disable_sdhc(host, sdhc_id);
> +}
> +
> +static int sdhci_xenon_probe(struct platform_device *pdev)
> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_host *host;
> +	struct sdhci_xenon_priv *priv;
> +	int err;
> +
> +	host = sdhci_pltfm_init(pdev, &sdhci_xenon_pdata,
> +				sizeof(struct sdhci_xenon_priv));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	xenon_set_acg(host, false);
> +
> +	/*
> +	 * Link Xenon specific mmc_host_ops function,
> +	 * to replace standard ones in sdhci_ops.
> +	 */
> +	xenon_replace_mmc_host_ops(host);
> +
> +	pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
> +	if (IS_ERR(pltfm_host->clk)) {
> +		err = PTR_ERR(pltfm_host->clk);
> +		dev_err(&pdev->dev, "Failed to setup input clk: %d\n", err);
> +		goto free_pltfm;
> +	}
> +	err = clk_prepare_enable(pltfm_host->clk);
> +	if (err)
> +		goto free_pltfm;
> +
> +	err = xenon_probe_dt(pdev);
> +	if (err)
> +		goto err_clk;
> +
> +	err = xenon_sdhc_probe(host);
> +	if (err)
> +		goto err_clk;
> +
> +	err = sdhci_add_host(host);
> +	if (err)
> +		goto remove_sdhc;
> +
> +	return 0;
> +
> +remove_sdhc:
> +	xenon_sdhc_remove(host);
> +err_clk:
> +	clk_disable_unprepare(pltfm_host->clk);
> +free_pltfm:
> +	sdhci_pltfm_free(pdev);
> +	return err;
> +}
> +
> +static int sdhci_xenon_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xFFFFFFFF);

This 'dead' check was originally for PCI I think.  Unless you know it makes
sense for your device, I would leave it out. i.e. just do
sdhci_remove_host(host, 0);

> +
> +	xenon_sdhc_remove(host);
> +
> +	sdhci_remove_host(host, dead);
> +
> +	clk_disable_unprepare(pltfm_host->clk);
> +
> +	sdhci_pltfm_free(pdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sdhci_xenon_dt_ids[] = {
> +	{ .compatible = "marvell,armada-7000-sdhci",},
> +	{ .compatible = "marvell,armada-3700-sdhci",},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
> +
> +static struct platform_driver sdhci_xenon_driver = {
> +	.driver	= {
> +		.name	= "xenon-sdhci",
> +		.of_match_table = sdhci_xenon_dt_ids,
> +		.pm = &sdhci_pltfm_pmops,
> +	},
> +	.probe	= sdhci_xenon_probe,
> +	.remove	= sdhci_xenon_remove,
> +};
> +
> +module_platform_driver(sdhci_xenon_driver);
> +
> +MODULE_DESCRIPTION("SDHCI platform driver for Marvell Xenon SDHC");
> +MODULE_AUTHOR("Hu Ziji <huziji@marvell.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> new file mode 100644
> index 000000000000..d50cd663a265
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-xenon.h
> @@ -0,0 +1,70 @@
> +/*
> + * Copyright (C) 2016 Marvell, All Rights Reserved.
> + *
> + * Author:	Hu Ziji <huziji@marvell.com>
> + * Date:	2016-8-24
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + */
> +#ifndef SDHCI_XENON_H_
> +#define SDHCI_XENON_H_
> +
> +

Double blank line

> +/* Register Offset of Xenon SDHC self-defined register */
> +#define SDHCI_SYS_CFG_INFO			0x0104

A lot of these defines look like they could be just in sdhci-xenon.c or
sdhci-xenon-phy.c.  It is also a little odd that they are prefixed by
"SDHCI" because they are not standard.  "XENON" would be better.

> +#define SDHCI_SLOT_TYPE_SDIO_SHIFT		24
> +#define SDHCI_NR_SUPPORTED_SLOT_MASK		0x7
> +
> +#define SDHCI_SYS_OP_CTRL			0x0108
> +#define SDHCI_AUTO_CLKGATE_DISABLE_MASK		BIT(20)
> +#define SDHCI_SDCLK_IDLEOFF_ENABLE_SHIFT	8
> +#define SDHCI_SLOT_ENABLE_SHIFT			0
> +
> +#define SDHCI_SYS_EXT_OP_CTRL			0x010C
> +
> +#define SDHCI_SLOT_EMMC_CTRL			0x0130
> +#define SDHCI_EMMC_VCCQ_MASK			0x3
> +#define SDHCI_EMMC_VCCQ_1_8V			0x1
> +#define SDHCI_EMMC_VCCQ_3_3V			0x3
> +
> +#define SDHCI_SLOT_RETUNING_REQ_CTRL		0x0144
> +/* retuning compatible */
> +#define SDHCI_RETUNING_COMPATIBLE		0x1
> +
> +/* Tuning Parameter */
> +#define SDHCI_TMR_RETUN_NO_PRESENT		0xF
> +#define SDHCI_DEF_TUNING_COUNT			0x9
> +
> +#define SDHCI_DEFAULT_SDCLK_FREQ		(400000)

Unnecessary ()

> +
> +/* Xenon specific Mode Select value */
> +#define SDHCI_XENON_CTRL_HS200			0x5
> +#define SDHCI_XENON_CTRL_HS400			0x6
> +
> +/* Indicate Card Type is not clear yet */
> +#define SDHCI_CARD_TYPE_UNKNOWN			0xF
> +
> +struct sdhci_xenon_priv {
> +	unsigned char	tuning_count;
> +	/* idx of SDHC */
> +	u8		sdhc_id;
> +
> +	/*
> +	 * eMMC/SD/SDIO require different PHY settings or
> +	 * voltage control. It's necessary for Xenon driver to
> +	 * recognize card type during, or even before initialization.
> +	 * However, mmc_host->card is not available yet at that time.
> +	 * This field records the card type during init.
> +	 * For eMMC, it is updated in dt parse. For SD/SDIO, it is
> +	 * updated in xenon_init_card().
> +	 *
> +	 * It is only valid during initialization after it is updated.
> +	 * Do not access this variable in normal transfers after
> +	 * initialization completes.
> +	 */
> +	unsigned int	init_card_type;
> +};
> +
> +#endif
> 


--------------D339B8C29FF30116D1A7AA43
Content-Type: text/x-patch;
 name="0001-mmc-sdhci-Leave-internal-clock-on-when-bus-power-is-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-mmc-sdhci-Leave-internal-clock-on-when-bus-power-is-.pa";
 filename*1="tch"

>From 9a23bf1292e33d3d91a1ee2d7f269c9079d9c1be Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 25 Nov 2016 16:25:05 +0200
Subject: [PATCH] mmc: sdhci: Leave internal clock on when bus power is on

According to the SDHCI specification, "Internal Clock Enable" is expected
to remain on while "SD Clock Enable" is off during voltage switching. Do
that by keeping the internal clock on if the bus power is on.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9a4fda81ff81..aeb001e7cc63 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1372,14 +1372,20 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-	u16 clk;
+	u16 clk = 0;
 
 	host->mmc->actual_clock = 0;
 
-	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
-
-	if (clock == 0)
+	if (clock == 0) {
+		if (host->mmc->ios.power_mode != MMC_POWER_OFF) {
+			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+			clk &= ~SDHCI_CLOCK_CARD_EN;
+		}
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 		return;
+	}
+
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	sdhci_enable_clk(host, clk);
-- 
1.9.1


--------------D339B8C29FF30116D1A7AA43--
