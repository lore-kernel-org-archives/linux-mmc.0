Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB6196;
	Tue, 16 Jul 2024 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721113429; cv=none; b=ofalyPClkO0W7l2q2JvxpNH2tjxybtPGZobq6fPADeYG69LZPle6d2O6OCL7r4MpUHMJzObBQzu6WIED1ETSRoac0Rgji8Mzj7ipPFslg9bfQgYaks05o8AcM5qMuX3jbJhG2LkN1agIFXeDyOAVGLjImP3aW10mbSFgYPmHmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721113429; c=relaxed/simple;
	bh=kb4BLUFgOrXwORd9OqvI1kr/TaikVBCAK64a4eBA/ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3vPnGB6+ZQTQ6OPYSnkuK5M0wVYfNVCV/ygiLD1+o65inP/U0Xk/8KzKM8QYXtBqqT65EDU7rMwNEhtj+Ohuq28XeJmlhbAZZLrL3dbxIxjwfhR8esyVL5/t5bi1OWjzkm9jpv77MMZZqQ6ngpdymh3PE/OK480O6bMz3bC3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvkNDN9p; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvkNDN9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721113428; x=1752649428;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kb4BLUFgOrXwORd9OqvI1kr/TaikVBCAK64a4eBA/ws=;
  b=WvkNDN9pzqRrOJparANmigi661+e1OIuIf4AExuYHavjH2LuPUb+mCdG
   9tWoLo2nTrWAnX7saNnlkMcqMex703MRnG3UO0jw7ILcaIv+9+ovHl3FV
   YH0Cs6U76oodbKBNRPvR5BjteRnvGgiECxCI22BrSJ87xGeWK890AL0oA
   JNZLhvYK71tZftItKdC5g68NUXGxG6rtTAx7vnI+T8cC1km/tTN++EWoS
   WgDhW+u6e3r453hIm6Jzg0ew+il6eBN9B+lqJVQAOMC2fqDiKscJq3CwB
   JmCNjMdXhCDykAbUbLWiMurYwxaJRqy8O3Nrj1fj/6DHQkrqNnCPZyek2
   g==;
X-CSE-ConnectionGUID: NBGOfBwwTUaUqu+qEhs6UQ==
X-CSE-MsgGUID: MI+LQKNNTEK+CvnWL/aQDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="29206655"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="29206655"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 00:03:46 -0700
X-CSE-ConnectionGUID: 39z+WceyQWyviCcHjTEOYA==
X-CSE-MsgGUID: AcCfRfahTcuxTe1TZvmqpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49787694"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.49.253])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 00:03:40 -0700
Message-ID: <935aedd8-0a7a-4e3a-a89d-e1f134ab7fd0@intel.com>
Date: Tue, 16 Jul 2024 10:03:35 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI
 driver
To: Shan-Chun Hung <shanchun1218@gmail.com>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, pbrobinson@gmail.com, serghox@gmail.com,
 mcgrof@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
 forbidden405@outlook.com, tmaimon77@gmail.com, andy.shevchenko@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240716004527.20378-1-shanchun1218@gmail.com>
 <20240716004527.20378-3-shanchun1218@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240716004527.20378-3-shanchun1218@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/07/24 03:45, Shan-Chun Hung wrote:
> Add the SDHCI driver for the MA35D1 platform. It is based upon the
> SDHCI interface, but requires some extra initialization.
> 
> Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/Kconfig           |  12 ++
>  drivers/mmc/host/Makefile          |   1 +
>  drivers/mmc/host/sdhci-of-ma35d1.c | 314 +++++++++++++++++++++++++++++
>  3 files changed, 327 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index bb0d4fb0892a..aa6922ff4210 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -252,6 +252,18 @@ config MMC_SDHCI_OF_SPARX5
> 
>  	  If unsure, say N.
> 
> +config MMC_SDHCI_OF_MA35D1
> +	tristate "SDHCI OF support for the MA35D1 SDHCI controller"
> +	depends on ARCH_MA35 || COMPILE_TEST
> +	depends on MMC_SDHCI_PLTFM
> +	help
> +	  This selects the MA35D1 Secure Digital Host Controller Interface.
> +	  The controller supports SD/MMC/SDIO devices.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_CADENCE
>  	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
>  	depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index f53f86d200ac..3ccffebbe59b 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -88,6 +88,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
>  obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_SPARX5)	+= sdhci-of-sparx5.o
> +obj-$(CONFIG_MMC_SDHCI_OF_MA35D1)	+= sdhci-of-ma35d1.o
>  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
>  obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
>  obj-$(CONFIG_MMC_SDHCI_NPCM)		+= sdhci-npcm.o
> diff --git a/drivers/mmc/host/sdhci-of-ma35d1.c b/drivers/mmc/host/sdhci-of-ma35d1.c
> new file mode 100644
> index 000000000000..b84c2927bd4a
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-ma35d1.c
> @@ -0,0 +1,314 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Nuvoton Technology Corp.
> + *
> + * Author: Shan-Chun Hung <shanchun1218@gmail.com>
> + */
> +
> +#include <linux/align.h>
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/build_bug.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/math.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/minmax.h>
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/sizes.h>
> +#include <linux/types.h>
> +
> +#include "sdhci-pltfm.h"
> +#include "sdhci.h"
> +
> +#define MA35_SYS_MISCFCR0	0x070
> +#define MA35_SDHCI_MSHCCTL	0x508
> +#define MA35_SDHCI_MBIUCTL	0x510
> +
> +#define MA35_SDHCI_CMD_CONFLICT_CHK	BIT(0)
> +#define MA35_SDHCI_INCR_MSK		GENMASK(3, 0)
> +#define MA35_SDHCI_INCR16		BIT(3)
> +#define MA35_SDHCI_INCR8		BIT(2)
> +
> +struct ma35_priv {
> +	struct reset_control	*rst;
> +	struct pinctrl		*pinctrl;
> +	struct pinctrl_state	*pins_uhs;
> +	struct pinctrl_state	*pins_default;
> +};
> +
> +struct ma35_restore_data {
> +	u32	reg;
> +	u32	width;
> +};
> +
> +static const struct ma35_restore_data restore_data[] = {
> +	{ SDHCI_CLOCK_CONTROL,		sizeof(u32)},
> +	{ SDHCI_BLOCK_SIZE,		sizeof(u32)},
> +	{ SDHCI_INT_ENABLE,		sizeof(u32)},
> +	{ SDHCI_SIGNAL_ENABLE,		sizeof(u32)},
> +	{ SDHCI_AUTO_CMD_STATUS,	sizeof(u32)},
> +	{ SDHCI_HOST_CONTROL,		sizeof(u32)},
> +	{ SDHCI_TIMEOUT_CONTROL,	sizeof(u8) },
> +	{ MA35_SDHCI_MSHCCTL,		sizeof(u16)},
> +	{ MA35_SDHCI_MBIUCTL,		sizeof(u16)},
> +};
> +
> +/*
> + * If DMA addr spans 128MB boundary, we split the DMA transfer into two
> + * so that each DMA transfer doesn't exceed the boundary.
> + */
> +static void ma35_adma_write_desc(struct sdhci_host *host, void **desc, dma_addr_t addr, int len,
> +				 unsigned int cmd)
> +{
> +	int tmplen, offset;
> +
> +	if (likely(!len || (ALIGN(addr, SZ_128M) == ALIGN(addr + len - 1, SZ_128M)))) {
> +		sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +		return;
> +	}
> +
> +	offset = addr & (SZ_128M - 1);
> +	tmplen = SZ_128M - offset;
> +	sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
> +
> +	addr += tmplen;
> +	len -= tmplen;
> +	sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +}
> +
> +static void ma35_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u32 ctl;
> +
> +	/*
> +	 * If the clock frequency exceeds MMC_HIGH_52_MAX_DTR,
> +	 * disable command conflict check.
> +	 */
> +	ctl = sdhci_readw(host, MA35_SDHCI_MSHCCTL);
> +	if (clock > MMC_HIGH_52_MAX_DTR)
> +		ctl &= ~MA35_SDHCI_CMD_CONFLICT_CHK;
> +	else
> +		ctl |= MA35_SDHCI_CMD_CONFLICT_CHK;
> +	sdhci_writew(host, ctl, MA35_SDHCI_MSHCCTL);
> +
> +	sdhci_set_clock(host, clock);
> +}
> +
> +static int ma35_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct ma35_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	switch (ios->signal_voltage) {
> +	case MMC_SIGNAL_VOLTAGE_180:
> +		if (!IS_ERR(priv->pinctrl) && !IS_ERR(priv->pins_uhs))
> +			pinctrl_select_state(priv->pinctrl, priv->pins_uhs);
> +		break;
> +	case MMC_SIGNAL_VOLTAGE_330:
> +		if (!IS_ERR(priv->pinctrl) && !IS_ERR(priv->pins_default))
> +			pinctrl_select_state(priv->pinctrl, priv->pins_default);
> +		break;
> +	default:
> +		dev_err(mmc_dev(host->mmc), "Unsupported signal voltage!\n");
> +		return -EINVAL;
> +	}
> +
> +	return sdhci_start_signal_voltage_switch(mmc, ios);
> +}
> +
> +static void ma35_voltage_switch(struct sdhci_host *host)
> +{
> +	/* Wait for 5ms after set 1.8V signal enable bit */
> +	fsleep(5000);
> +}
> +
> +static int ma35_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct ma35_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	int idx;
> +	u32 regs[ARRAY_SIZE(restore_data)] = {};
> +
> +	/*
> +	 * Limitations require a reset of SD/eMMC before tuning and
> +	 * saving the registers before resetting, then restoring
> +	 * after the reset.
> +	 */
> +	for (idx = 0; idx < ARRAY_SIZE(restore_data); idx++) {
> +		if (restore_data[idx].width == sizeof(u32))
> +			regs[idx] = sdhci_readl(host, restore_data[idx].reg);
> +		else if (restore_data[idx].width == sizeof(u16))
> +			regs[idx] = sdhci_readw(host, restore_data[idx].reg);
> +		else if (restore_data[idx].width == sizeof(u8))
> +			regs[idx] = sdhci_readb(host, restore_data[idx].reg);
> +	}
> +
> +	reset_control_assert(priv->rst);
> +	reset_control_deassert(priv->rst);
> +
> +	for (idx = 0; idx < ARRAY_SIZE(restore_data); idx++) {
> +		if (restore_data[idx].width == sizeof(u32))
> +			sdhci_writel(host, regs[idx], restore_data[idx].reg);
> +		else if (restore_data[idx].width == sizeof(u16))
> +			sdhci_writew(host, regs[idx], restore_data[idx].reg);
> +		else if (restore_data[idx].width == sizeof(u8))
> +			sdhci_writeb(host, regs[idx], restore_data[idx].reg);
> +	}
> +
> +	return sdhci_execute_tuning(mmc, opcode);
> +}
> +
> +static const struct sdhci_ops sdhci_ma35_ops = {
> +	.set_clock		= ma35_set_clock,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
> +	.reset			= sdhci_reset,
> +	.adma_write_desc	= ma35_adma_write_desc,
> +	.voltage_switch		= ma35_voltage_switch,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_ma35_pdata = {
> +	.ops = &sdhci_ma35_ops,
> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN | SDHCI_QUIRK2_BROKEN_DDR50 |
> +		   SDHCI_QUIRK2_ACMD23_BROKEN,
> +};
> +
> +static int ma35_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_host *host;
> +	struct ma35_priv *priv;
> +	int err;
> +	u32 extra, ctl;
> +
> +	host = sdhci_pltfm_init(pdev, &sdhci_ma35_pdata, sizeof(struct ma35_priv));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	/* Extra adma table cnt for cross 128M boundary handling. */
> +	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(dev), SZ_128M);
> +	extra = min(extra, SDHCI_MAX_SEGS);
> +
> +	host->adma_table_cnt += extra;
> +	pltfm_host = sdhci_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	pltfm_host->clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(pltfm_host->clk)) {
> +		err = dev_err_probe(dev, PTR_ERR(pltfm_host->clk), "failed to get clk\n");
> +		goto err_sdhci;
> +	}
> +
> +	err = mmc_of_parse(host->mmc);
> +	if (err)
> +		goto err_sdhci;
> +
> +	priv->rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(priv->rst)) {
> +		err = dev_err_probe(dev, PTR_ERR(priv->rst), "failed to get reset control\n");
> +		goto err_sdhci;
> +	}
> +
> +	sdhci_get_of_property(pdev);
> +
> +	priv->pinctrl = devm_pinctrl_get(dev);
> +	if (!IS_ERR(priv->pinctrl)) {
> +		priv->pins_default = pinctrl_lookup_state(priv->pinctrl, "default");
> +		priv->pins_uhs = pinctrl_lookup_state(priv->pinctrl, "state_uhs");
> +		pinctrl_select_state(priv->pinctrl, priv->pins_default);
> +	}
> +
> +	if (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)) {
> +		struct regmap	*regmap;
> +		u32		reg;
> +
> +		regmap = syscon_regmap_lookup_by_phandle(dev_of_node(dev), "nuvoton,sys");
> +		if (!IS_ERR(regmap)) {
> +			/* Enable SDHCI voltage stable for 1.8V */
> +			regmap_read(regmap, MA35_SYS_MISCFCR0, &reg);
> +			reg |= BIT(17);
> +			regmap_write(regmap, MA35_SYS_MISCFCR0, reg);
> +		}
> +
> +		host->mmc_host_ops.start_signal_voltage_switch =
> +					ma35_start_signal_voltage_switch;
> +	}
> +
> +	host->mmc_host_ops.execute_tuning = ma35_execute_tuning;
> +
> +	err = sdhci_add_host(host);
> +	if (err)
> +		goto err_sdhci;
> +
> +	/*
> +	 * Split data into chunks of 16 or 8 bytes for transmission.
> +	 * Each chunk transfer is guaranteed to be uninterrupted on the bus.
> +	 * This likely corresponds to the AHB bus DMA burst size.
> +	 */
> +	ctl = sdhci_readw(host, MA35_SDHCI_MBIUCTL);
> +	ctl &= ~MA35_SDHCI_INCR_MSK;
> +	ctl |= MA35_SDHCI_INCR16 | MA35_SDHCI_INCR8;
> +	sdhci_writew(host, ctl, MA35_SDHCI_MBIUCTL);
> +
> +	return 0;
> +
> +err_sdhci:
> +	sdhci_pltfm_free(pdev);
> +	return err;
> +}
> +
> +static void ma35_disable_card_clk(struct sdhci_host *host)
> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	if (ctrl & SDHCI_CLOCK_CARD_EN) {
> +		ctrl &= ~SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +	}
> +}
> +
> +static void ma35_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +
> +	sdhci_remove_host(host, 0);
> +	ma35_disable_card_clk(host);
> +	sdhci_pltfm_free(pdev);
> +}
> +
> +static const struct of_device_id sdhci_ma35_dt_ids[] = {
> +	{ .compatible = "nuvoton,ma35d1-sdhci" },
> +	{}
> +};
> +
> +static struct platform_driver sdhci_ma35_driver = {
> +	.driver	= {
> +		.name	= "sdhci-ma35",
> +		.of_match_table = sdhci_ma35_dt_ids,
> +	},
> +	.probe	= ma35_probe,
> +	.remove_new = ma35_remove,
> +};
> +module_platform_driver(sdhci_ma35_driver);
> +
> +MODULE_DESCRIPTION("SDHCI platform driver for Nuvoton MA35");
> +MODULE_AUTHOR("Shan-Chun Hung <shanchun1218@gmail.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1
> 

