Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7661386C6;
	Thu, 27 Jun 2024 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481266; cv=none; b=dViUm6pOupwAvHm/s1ejoBlxZNY4iNedMsx+o2mVUrHz+94Y9NtybIi4T+4kIIptNK8upYDNygutn6LwOj19/hW62ls98B0ihVYjjX0bc+YXK5eZA3F4aCbTUHl2SC1OR8HXsao1o2NcnDNQCff4JCyXiSl2esxjT1Fhd4kg1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481266; c=relaxed/simple;
	bh=dDhAKfR/akDU3JQW5BxDgOOF0Gm8ZyHhb3OIbWgkxAI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cr+8WvoauJ2xZAjVOuvvEX72KA3KH1CS9o+lo8cWEl9PaWBlk+CEZTLKSMl+qIuNCpnLBRld2iWsIYoroqgBUJ3eIgRa98OE3KUXpB3GMYfm7sUQF36ffHyDgdyrVrCEjUWuNmJZUKqIuNSHxpB7vrEU2Em9MBlGIIGa3YnBs1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGHUYnmv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGHUYnmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719481264; x=1751017264;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=dDhAKfR/akDU3JQW5BxDgOOF0Gm8ZyHhb3OIbWgkxAI=;
  b=LGHUYnmvTAoijvNlDPWbeho8C/7YLkmYc3ltuhD82KRF3G/dFXqSvbvL
   u4mXKSQ/WEANpVnrv3QOupE5KBRgbHFuXJJNU13K0vY74C9H3/vigzU2j
   5Kt09MegCuA3npfiodexFuklvKCImCd00WDS8pxzPqbBQxz/2BP/+2s0O
   kX3cGEHKpS6+NLODZZJDCrzVBW+VdVkep3SoBYWQA8XLWPQ5xL9/xwOwU
   UktY9jwG+3UbPn7VckQv0FQpaVp8b2t98qt4cNitM/jdlPZ7MfbovaNNe
   eKpDii6u6hOPG9YGps7S3v/Kch30HDTtg0bEaXgd8xRqIkOzJ45onSNIC
   A==;
X-CSE-ConnectionGUID: B89b0KHFSTScDsPbO8KlHw==
X-CSE-MsgGUID: BJN1RsIaTS27gny5E2HKHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16724635"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="16724635"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 02:41:03 -0700
X-CSE-ConnectionGUID: gCr3jhHDTy+ivrk9PxV0jA==
X-CSE-MsgGUID: L71hqMBZT2mBRhuWsZs5gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="49288773"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.49.253])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 02:40:59 -0700
Message-ID: <216059e5-2160-4797-b431-b391ff69cd2c@intel.com>
Date: Thu, 27 Jun 2024 12:40:53 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI
 driver
To: Shan-Chun Hung <shanchun1218@gmail.com>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, pbrobinson@gmail.com, serghox@gmail.com,
 mcgrof@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
 forbidden405@outlook.com, tmaimon77@gmail.com, andy.shevchenko@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240626094900.581552-1-shanchun1218@gmail.com>
 <20240626094900.581552-3-shanchun1218@gmail.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240626094900.581552-3-shanchun1218@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/06/24 12:49, Shan-Chun Hung wrote:
> Add the SDHCI driver for the MA35D1 platform. It is based upon the
> SDHCI interface, but requires some extra initialization.
> 
> Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
> ---
>  drivers/mmc/host/Kconfig           |  14 ++
>  drivers/mmc/host/Makefile          |   1 +
>  drivers/mmc/host/sdhci-of-ma35d1.c | 291 +++++++++++++++++++++++++++++
>  3 files changed, 306 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index bb0d4fb0892a..31cd076e1c53 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -252,6 +252,20 @@ config MMC_SDHCI_OF_SPARX5
> 

Patch did not apply cleanly:

Applying: mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI driver
error: corrupt patch at line 14
Patch failed at 0001 mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI driver

> 	  If unsure, say N.
> 
> +config MMC_SDHCI_OF_MA35D1
> +	tristate "SDHCI OF support for the MA35D1 SDHCI controller"
> +	depends on ARCH_MA35

Does this dependency serve a purpose?  At least add COMPILE_TEST

	depends on ARCH_MA35 || COMPILE_TEST

> +	depends on MMC_SDHCI_PLTFM
> +	depends on COMMON_CLK
> +	depends on OF || COMPILE_TEST
> +	help
> +	  This selects the MA35D1 Secure Digital Host Controller Interface.
> +
> +	  If you have a controller with this interface, say Y or M here. You
> +	  also need to enable an appropriate bus interface.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_CADENCE
> 	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
> 	depends on MMC_SDHCI_PLTFM
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
> index 000000000000..e260aeb12d7f
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-ma35d1.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0
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
> +	struct regmap		*regmap;
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
> +static void ma35_adma_write_desc(struct sdhci_host *host, void **desc,
> +				  dma_addr_t addr, int len, unsigned int cmd)

Please take a look at checkpatch --strict output.  Fixing "Alignment" and
"spaces preferred around" CHECKs tends to make the code look better.

> +{
> +	int tmplen, offset;
> +
> +	if (likely(!len || (ALIGN(addr, SZ_128M) == ALIGN(addr+len-1, SZ_128M)))) {
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
> +	/* If the clock frequency exceeds MMC_HIGH_52_MAX_DTR,
> +	 * disable command conflict check.
> +	 */

Please use the following style for multi-line comments:

	/*
	 * If the clock frequency exceeds MMC_HIGH_52_MAX_DTR,
	 * disable command conflict check.
	 */

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
> +static int ma35_start_signal_voltage_switch(struct mmc_host *mmc,
> +					      struct mmc_ios *ios)
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
> +	u32 regs[ARRAY_SIZE(restore_data)] = { };
> +
> +	/* Limitations require a reset of SD/eMMC before tuning and
> +	 * saving the registers before resetting, then restoring
> +	 * after the reset.
> +	 */

Please use the following style for multi-line comments:

	/*
	 * Limitations require a reset of SD/eMMC before tuning and
	 * saving the registers before resetting, then restoring
	 * after the reset.
	 */

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
> +	.voltage_switch	= ma35_voltage_switch,

Last one does not line up

> +};
> +
> +static const struct sdhci_pltfm_data sdhci_ma35_pdata = {
> +	.ops = &sdhci_ma35_ops,
> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN | SDHCI_QUIRK2_BROKEN_DDR50 |
> +		   SDHCI_QUIRK2_ACMD23_BROKEN,
> +};
> +
> +static void ma35_sdhci_pltfm_free(void *data)
> +{
> +	sdhci_pltfm_free(data);
> +}
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
> +	err = devm_add_action_or_reset(dev, ma35_sdhci_pltfm_free, pdev);

This just looks like it is going to call sdhci_pltfm_free()
for a second time after it is called by sdhci_pltfm_remove()

> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to register sdhci_pltfm_free action\n");
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
> +	if (IS_ERR(pltfm_host->clk))
> +		return dev_err_probe(dev, IS_ERR(pltfm_host->clk), "failed to get clk\n");
> +
> +	err = mmc_of_parse(host->mmc);
> +	if (err)
> +		return err;
> +
> +	priv->rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(priv->rst))
> +		return dev_err_probe(dev, PTR_ERR(priv->rst), "failed to get reset control\n");
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
> +		u32 reg;
> +
> +		priv->regmap = syscon_regmap_lookup_by_phandle(dev_of_node(dev), "nuvoton,sys");
> +
> +		if (!IS_ERR(priv->regmap)) {
> +			/* Enable SDHCI voltage stable for 1.8V */
> +			regmap_read(priv->regmap, MA35_SYS_MISCFCR0, &reg);
> +			reg |= BIT(17);
> +			regmap_write(priv->regmap, MA35_SYS_MISCFCR0, reg);
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
> +		return err;
> +
> +	/* Enable INCR16 and INCR8 */

Comment would be more useful if it said what INCR16 and
INCR8 are

> +	ctl = sdhci_readw(host, MA35_SDHCI_MBIUCTL);
> +	ctl &= ~MA35_SDHCI_INCR_MSK;
> +	ctl |= MA35_SDHCI_INCR16|MA35_SDHCI_INCR8;
> +	sdhci_writew(host, ctl, MA35_SDHCI_MBIUCTL);
> +
> +	return 0;
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
> +	.remove_new = sdhci_pltfm_remove,
> +};
> +module_platform_driver(sdhci_ma35_driver);
> +
> +MODULE_DESCRIPTION("SDHCI platform driver for Nuvoton MA35");
> +MODULE_AUTHOR("Shan-Chun Hung <shanchun1218@google.com>");

"From:" is shanchun1218@gmail.com
"Signed-off-by" is shanchun1218@gmail.com

but here it is shanchun1218@google.com

Please be consistent

> +MODULE_LICENSE("GPL v2");

checkpatch says:

WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
#351: FILE: drivers/mmc/host/sdhci-of-ma35d1.c:291:
+MODULE_LICENSE("GPL v2");

> --
> 2.25.1

