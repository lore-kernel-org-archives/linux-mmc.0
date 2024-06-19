Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E1440879;
	Wed, 19 Jun 2024 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792327; cv=none; b=pK6wlmOTnml02izZsOqBQhbzk0ib2pzZvjgCzFIF7JlTE2ajjmYtS1xWoIguTmw2vuv7YRWuhWrp3uZfkOOJiHHvnCPLzQ89r2ItalwIr0Wk0C/x3UfVWAiG6NiXZmH6/lZ2HUuwFoxKbQL1DpR8Eu7WGq59HWZQTkEdcJz6FVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792327; c=relaxed/simple;
	bh=GhFE3Momdbk4T8shCcQktZLLAveGMCP6YHGkb1LMa4s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=My6JfGavMQzZMg/N8SdytqFluTWN3Az8jlG1fsmpP2pXnG6/fEFniojhJhN2SXwArAJB0ylbLt+pBAiOCvenbn8lR9mpuJOgHmQEFiGqGAeNpkzZAIVhKWwnBbjIi8YGbnBB4ObB59LfFN1zDQH8tt95ehU/kaU6g4xdZneIJVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xwVh942G; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xwVh942G"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718792316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IPjgb0xrFYAjFXXPpyaSCN7JFe4yAAVdL6xBIaITI0=;
	b=xwVh942GKaFR1d98m96BJsLD+MJGD0fkJ2tygebnebqmPI7OsyNaV5bMKP4HBhQxITZtWw
	Ufa4a8K+gsb+9okCRLCQ293YnO/hE9XeEuKOmKkI/J6DDKtlgVCjI+6mVDgpnabWb33SXP
	lYqK2Vv9/kx+dD+J+ODlFeYfyqUEFFZvb6Ca10wK+G8MsISEe8odtLh0qbwtgsKZwOxnXt
	gT1piTE7Cw2RW/iKEPv8CJ/Iq91t6sHW5LYwWN7dK70Zrb0QLuzZaXXOozhy3XX1MqxwUJ
	B7XqY2mbw4Nkmq3wPTG1tdH0n/4vAjQ1uVVSa/9x7GBODtEODFjGoeJpuRgF0A==
Date: Wed, 19 Jun 2024 12:18:32 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Shan-Chun Hung <shanchun1218@gmail.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, adrian.hunter@intel.com, p.zabel@pengutronix.de,
 pbrobinson@gmail.com, serghox@gmail.com, mcgrof@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, forbidden405@outlook.com,
 tmaimon77@gmail.com, andy.shevchenko@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com
Subject: Re: [PATCH 2/2] mmc: sdhci-of-ma35d1: Add Novoton MA35D1 SDHCI driver
In-Reply-To: <20240619054641.277062-3-shanchun1218@gmail.com>
References: <20240619054641.277062-1-shanchun1218@gmail.com>
 <20240619054641.277062-3-shanchun1218@gmail.com>
Message-ID: <c8bb0dd63128ff3cf3535213d45ce73e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Shan-Chun,

On 2024-06-19 07:46, Shan-Chun Hung wrote:
> This adds the SDHCI driver for the MA35 series SoC. It is based upon 
> the
> SDHCI interface, but requires some extra initialization.
> 
> Signed-off-by: schung <schung@nuvoton.com>

There's a typo in the patch subject: s/Novoton/Nuvoton/

Also, it would be better to use imperative mode in the patch 
description,
i.e. "Add the SDHCI driver..." instead of "This adds the SDHCI..."

> ---
>  drivers/mmc/host/Kconfig           |  13 ++
>  drivers/mmc/host/Makefile          |   1 +
>  drivers/mmc/host/sdhci-of-ma35d1.c | 297 +++++++++++++++++++++++++++++
>  3 files changed, 311 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index bb0d4fb0892a..e993901ebedd 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -252,6 +252,19 @@ config MMC_SDHCI_OF_SPARX5
> 
> 	  If unsure, say N.
> 
> +config MMC_SDHCI_OF_MA35D1
> +	tristate "SDHCI OF support for the MA35D1 SDHCI controller"
> +	depends on ARCH_A35 || COMPILE_TEST
> +	depends on MMC_SDHCI_PLTFM
> +	depends on OF && COMMON_CLK
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
> diff --git a/drivers/mmc/host/sdhci-of-ma35d1.c
> b/drivers/mmc/host/sdhci-of-ma35d1.c
> new file mode 100644
> index 000000000000..7714a5ab463d
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-ma35d1.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Nuvoton Technology Corp.
> + *
> + * Author: Shan-Chun Hung <shanchun1218@gmail.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include "sdhci-pltfm.h"
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
> +#define BOUNDARY_OK(addr, len) \
> +	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
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
> +	{ SDHCI_CLOCK_CONTROL,		32},
> +	{ SDHCI_BLOCK_SIZE,		32},
> +	{ SDHCI_INT_ENABLE,		32},
> +	{ SDHCI_SIGNAL_ENABLE,		32},
> +	{ SDHCI_AUTO_CMD_STATUS,	32},
> +	{ SDHCI_HOST_CONTROL,		32},
> +	{ SDHCI_TIMEOUT_CONTROL,	 8},
> +	{ MA35_SDHCI_MSHCCTL,		32},
> +	{ MA35_SDHCI_MBIUCTL,		32},
> +};
> +
> +/*
> + * If DMA addr spans 128MB boundary, we split the DMA transfer into 
> two
> + * so that each DMA transfer doesn't exceed the boundary.
> + */
> +static void ma35_adma_write_desc(struct sdhci_host *host, void **desc,
> +				  dma_addr_t addr, int len, unsigned int cmd)
> +{
> +	int tmplen, offset;
> +
> +	if (likely(!len || BOUNDARY_OK(addr, len))) {
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
> +static void ma35_set_clock(struct sdhci_host *host, unsigned int 
> clock)
> +{
> +	u32 ctl;
> +
> +	/* If the clock frequency exceeds MMC_HIGH_52_MAX_DTR,
> +	 *	disable command conflict check.
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
> +	usleep_range(5000, 5500);
> +}
> +
> +static int ma35_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct ma35_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	/* Limitations require a reset SD/eMMC before tuning. */
> +	if (!IS_ERR(priv->rst)) {
> +		int idx;
> +		u32 *val;
> +
> +		val = kmalloc(ARRAY_SIZE(restore_data), GFP_KERNEL);
> +		for (idx = 0; idx < ARRAY_SIZE(restore_data); idx++) {
> +			if (restore_data[idx].width == 32)
> +				val[idx] = sdhci_readl(host, restore_data[idx].reg);
> +			else if (restore_data[idx].width == 8)
> +				val[idx] = sdhci_readb(host, restore_data[idx].reg);
> +		}
> +
> +		reset_control_assert(priv->rst);
> +		reset_control_deassert(priv->rst);
> +
> +		for (idx = 0; idx < ARRAY_SIZE(restore_data); idx++) {
> +			if (restore_data[idx].width == 32)
> +				sdhci_writel(host, val[idx], restore_data[idx].reg);
> +			else if (restore_data[idx].width == 8)
> +				sdhci_writeb(host, val[idx], restore_data[idx].reg);
> +		}
> +
> +		kfree(val);
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
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_ma35_pdata = {
> +	.ops = &sdhci_ma35_ops,
> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN | 
> SDHCI_QUIRK2_BROKEN_DDR50 |
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
> +	host = sdhci_pltfm_init(pdev, &sdhci_ma35_pdata,
> +				sizeof(struct ma35_priv));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	/*
> +	 * extra adma table cnt for cross 128M boundary handling.
> +	 */
> +	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_128M);
> +	if (extra > SDHCI_MAX_SEGS)
> +		extra = SDHCI_MAX_SEGS;
> +	host->adma_table_cnt += extra;
> +	pltfm_host = sdhci_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	if (dev->of_node) {
> +		pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
> +		if (IS_ERR(pltfm_host->clk)) {
> +			err = PTR_ERR(pltfm_host->clk);
> +			dev_err(&pdev->dev, "failed to get clk: %d\n", err);
> +			goto free_pltfm;
> +		}
> +		err = clk_prepare_enable(pltfm_host->clk);
> +		if (err)
> +			goto free_pltfm;
> +	}
> +
> +	err = mmc_of_parse(host->mmc);
> +	if (err)
> +		goto err_clk;
> +
> +	priv->rst = devm_reset_control_get(&pdev->dev, NULL);
> +
> +	sdhci_get_of_property(pdev);
> +
> +	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (!IS_ERR(priv->pinctrl)) {
> +		priv->pins_default = pinctrl_lookup_state(priv->pinctrl, "default");
> +		priv->pins_uhs = pinctrl_lookup_state(priv->pinctrl, "state_uhs");
> +		pinctrl_select_state(priv->pinctrl, priv->pins_default);
> +	}
> +
> +	if (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)) {
> +		u32 reg;
> +
> +		priv->regmap = syscon_regmap_lookup_by_phandle(
> +				pdev->dev.of_node, "nuvoton,sys");
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
> +		goto err_clk;
> +
> +	/* Enable INCR16 and INCR8 */
> +	ctl = sdhci_readw(host, MA35_SDHCI_MBIUCTL);
> +	ctl &= ~MA35_SDHCI_INCR_MSK;
> +	ctl |= MA35_SDHCI_INCR16|MA35_SDHCI_INCR8;
> +	sdhci_writew(host, ctl, MA35_SDHCI_MBIUCTL);
> +
> +	return 0;
> +
> +err_clk:
> +	clk_disable_unprepare(pltfm_host->clk);
> +
> +free_pltfm:
> +	sdhci_pltfm_free(pdev);
> +	return err;
> +}
> +
> +static int ma35_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +	sdhci_remove_host(host, 0);
> +	clk_disable_unprepare(pltfm_host->clk);
> +	sdhci_pltfm_free(pdev);
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
> +	.remove = ma35_remove,
> +};
> +module_platform_driver(sdhci_ma35_driver);
> +
> +MODULE_DESCRIPTION("SDHCI platform driver for Nuvoton ma35d1");
> +MODULE_AUTHOR("shanchun1218@google.com");
> +MODULE_LICENSE("GPL v2");
> --
> 2.25.1
