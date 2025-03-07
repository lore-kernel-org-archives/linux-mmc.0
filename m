Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC329408;
	Fri,  7 Mar 2025 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741310914; cv=none; b=rqVYNh5JeAFjOmBp9L40vB9DDMWL5Cg4/Pnaq12Tjmty0icJjmz6DSM1TIhFG6f3P8dIDsvqdfvHL1F4Lq/c6oI6HjEvJJl1zWT7JxCnFWx8Cg+5VCo/JxYegZvmqPZNII8gVvLkdVXuhKmEr+NyQJapF6yvs4CChmQQAQSfGv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741310914; c=relaxed/simple;
	bh=Uz0cGP+/MQVYKxtqepAdvA8TdCZXxX/W3pyJbnNtZ/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV5zy6hjpT47JgMtQMtZoJ3/mtwZa+sS1fyCpELDmCgyQlbDAHYFJqsYQGg1dOLMrWEfgNij7yGCKN4eEWyH15TV4WQFWO5UjgKFlirBy7bGLgDvXSMLoPYaLPUuF1zo20/A733jqzQOr7UOyqOC9WRFONX4Cp26EU11Fxg3XCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id D181D342FAD;
	Fri, 07 Mar 2025 01:28:31 +0000 (UTC)
Date: Fri, 7 Mar 2025 01:28:27 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] mmc: sdhci-of-k1: add support for SpacemiT K1 SoC
Message-ID: <20250307012827-GYA66425@gentoo>
References: <20250213-20-k1-sdhci-v1-0-1f4362a980cd@gentoo.org>
 <20250213-20-k1-sdhci-v1-2-1f4362a980cd@gentoo.org>
 <4643012e-b7c9-444d-b4f3-d743ae7d2943@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4643012e-b7c9-444d-b4f3-d743ae7d2943@intel.com>

Hi Adrian:

On 22:04 Wed 05 Mar     , Adrian Hunter wrote:
> On 13/02/25 12:58, Yixun Lan wrote:
> > The SDHCI controller found in SpacemiT K1 SoC features SD,
> > SDIO, eMMC support, such as:
> > 
> > - Compatible for 4-bit SDIO 3.0 UHS-I protocol, up to SDR104
> > - Compatible for 4-bit SD 3.0 UHS-I protocol, up to SDR104
> > - Compatible for 8bit eMMC5.1, up to HS400
> > 
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > ---
> >  drivers/mmc/host/Kconfig       |  14 ++
> >  drivers/mmc/host/Makefile      |   1 +
> >  drivers/mmc/host/sdhci-of-k1.c | 320 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 335 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 6824131b69b188cae58c8f48076715ca647ca28c..0ce78f22c33cfff916a2d4d680c79e9d19637e0e 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -250,6 +250,20 @@ config MMC_SDHCI_OF_DWCMSHC
> >  	  If you have a controller with this interface, say Y or M here.
> >  	  If unsure, say N.
> >  
> > +config MMC_SDHCI_OF_K1
> > +	tristate "SDHCI OF support for the SpacemiT K1 SoC"
> > +	depends on ARCH_SPACEMIT || COMPILE_TEST
> > +	depends on MMC_SDHCI_PLTFM
> > +	depends on OF
> > +	depends on COMMON_CLK
> > +	help
> > +	  This selects the Secure Digital Host Controller Interface (SDHCI)
> > +	  found in the SpacemiT K1 SoC.
> > +
> > +	  If you have a controller with this interface, say Y or M here.
> > +
> > +	  If unsure, say N.
> > +
> >  config MMC_SDHCI_OF_SPARX5
> >  	tristate "SDHCI OF support for the MCHP Sparx5 SoC"
> >  	depends on MMC_SDHCI_PLTFM
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 5147467ec825ffaef3a7bd812fad80545e52b180..75bafc7b162b9e1d4c6c050f5d28b9d7cb582447 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -88,6 +88,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
> > +obj-$(CONFIG_MMC_SDHCI_OF_K1)		+= sdhci-of-k1.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_SPARX5)	+= sdhci-of-sparx5.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_MA35D1)	+= sdhci-of-ma35d1.o
> >  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
> > diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..8202a893a46ef9f10675b031b31b72e81eaacd14
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-of-k1.c
> > @@ -0,0 +1,320 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023-2025 SpacemiT (Hangzhou) Technology Co. Ltd
> > + * Copyright (c) 2025 Yixun Lan <dlan@gentoo.org>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/init.h>
> > +#include <linux/mmc/card.h>
> > +#include <linux/mmc/host.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "sdhci.h"
> > +#include "sdhci-pltfm.h"
> > +
> > +#define SDHC_MMC_CTRL_REG		0x114
> > +#define  MISC_INT_EN			BIT(1)
> > +#define  MISC_INT			BIT(2)
> > +#define  ENHANCE_STROBE_EN		BIT(8)
> > +#define  MMC_HS400			BIT(9)
> > +#define  MMC_HS200			BIT(10)
> > +#define  MMC_CARD_MODE			BIT(12)
> > +
> > +#define SDHC_TX_CFG_REG			0x11C
> > +#define  TX_INT_CLK_SEL			BIT(30)
> > +#define  TX_MUX_SEL			BIT(31)
> > +
> > +#define SDHC_PHY_CTRL_REG		0x160
> > +#define  PHY_FUNC_EN			BIT(0)
> > +#define  PHY_PLL_LOCK			BIT(1)
> > +#define  HOST_LEGACY_MODE		BIT(31)
> > +
> > +#define SDHC_PHY_FUNC_REG		0x164
> > +#define  PHY_TEST_EN			BIT(7)
> > +#define  HS200_USE_RFIFO		BIT(15)
> > +
> > +#define SDHC_PHY_DLLCFG			0x168
> > +#define  DLL_PREDLY_NUM			0x04
> > +#define  DLL_FULLDLY_RANGE		0x10
> > +#define  DLL_VREG_CTRL			0x40
> > +#define  DLL_ENABLE			0x80000000
> 
> The 4 above look like they could be BIT()s
> 
ok
> > +#define  DLL_REFRESH_SWEN_SHIFT		0x1C
> > +#define  DLL_REFRESH_SW_SHIFT		0x1D
> 
> All *_SHIFT defines seem a little odd because they are not
> used and we generally try to use GENMASK and FIELD_GET and
> FIELD_PREP anyway.
> 
right

this due to I did a massive refactor of this driver, and
currently only part of functionality(emmc) has been implemented.

I will drop those unused defintions for now, and re-add later
when we come at it

> > +
> > +#define SDHC_PHY_DLLCFG1		0x16C
> > +#define  DLL_REG2_CTRL			0x0C
> > +#define  DLL_REG3_CTRL_MASK		0xFF
> > +#define  DLL_REG3_CTRL_SHIFT		0x10
> > +#define  DLL_REG2_CTRL_MASK		0xFF
> > +#define  DLL_REG2_CTRL_SHIFT		0x08
> > +#define  DLL_REG1_CTRL			0x92
> > +#define  DLL_REG1_CTRL_MASK		0xFF
> > +#define  DLL_REG1_CTRL_SHIFT		0x00
> > +
> > +#define SDHC_PHY_DLLSTS			0x170
> > +#define  DLL_LOCK_STATE			0x01
> > +
> > +#define SDHC_PHY_DLLSTS1		0x174
> > +#define  DLL_MASTER_DELAY_MASK		0xFF
> > +#define  DLL_MASTER_DELAY_SHIFT		0x10
> > +
> > +#define SDHC_PHY_PADCFG_REG		0x178
> > +#define  RX_BIAS_CTRL			BIT(5)
> > +#define  PHY_DRIVE_SEL_MASK		0x7
> > +#define  PHY_DRIVE_SEL_DEFAULT		0x4
> > +
> > +struct spacemit_sdhci_host {
> > +	struct clk *clk_core;
> > +	struct clk *clk_io;
> > +};
> > +
> > +static inline void spacemit_sdhci_setbits(struct sdhci_host *host, u32 val, int reg)
> > +{
> > +	sdhci_writel(host, sdhci_readl(host, reg) | val, reg);
> > +}
> > +
> > +static inline void spacemit_sdhci_clrbits(struct sdhci_host *host, u32 val, int reg)
> > +{
> > +	sdhci_writel(host, sdhci_readl(host, reg) & ~val, reg);
> > +}
> > +
> > +static inline void spacemit_sdhci_clrsetbits(struct sdhci_host *host, u32 clr, u32 set, int reg)
> > +{
> > +	u32 val = sdhci_readl(host, reg);
> > +
> > +	val = (val & ~clr) | set;
> > +	sdhci_writel(host, val, reg);
> > +}
> > +
> > +static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
> > +{
> > +	struct platform_device *pdev;
> > +
> > +	pdev = to_platform_device(mmc_dev(host->mmc));
> > +	sdhci_reset(host, mask);
> > +
> > +	if (mask != SDHCI_RESET_ALL)
> > +		return;
> > +
> > +	spacemit_sdhci_setbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
> > +
> > +	spacemit_sdhci_clrsetbits(host, PHY_DRIVE_SEL_MASK,
> > +				  RX_BIAS_CTRL | PHY_DRIVE_SEL_DEFAULT,
> > +				  SDHC_PHY_PADCFG_REG);
> > +
> > +	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC))
> > +		spacemit_sdhci_setbits(host, MMC_CARD_MODE, SDHC_MMC_CTRL_REG);
> > +}
> > +
> > +static void spacemit_sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
> > +{
> > +	if (timing == MMC_TIMING_MMC_HS200)
> > +		spacemit_sdhci_setbits(host, MMC_HS200, SDHC_MMC_CTRL_REG);
> > +
> > +	if (timing == MMC_TIMING_MMC_HS400)
> > +		spacemit_sdhci_setbits(host, MMC_HS400, SDHC_MMC_CTRL_REG);
> > +
> > +	sdhci_set_uhs_signaling(host, timing);
> > +
> > +	if (!(host->mmc->caps2 & MMC_CAP2_NO_SDIO))
> > +		spacemit_sdhci_setbits(host, SDHCI_CTRL_VDD_180, SDHCI_HOST_CONTROL2);
> > +}
> > +
> > +static void spacemit_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> > +{
> > +	struct mmc_host *mmc = host->mmc;
> > +
> > +	if (mmc->ios.timing <= MMC_TIMING_UHS_SDR50)
> > +		spacemit_sdhci_setbits(host, TX_INT_CLK_SEL, SDHC_TX_CFG_REG);
> > +	else
> > +		spacemit_sdhci_clrbits(host, TX_INT_CLK_SEL, SDHC_TX_CFG_REG);
> > +
> > +	sdhci_set_clock(host, clock);
> > +};
> > +
> > +static void spacemit_sdhci_phy_dll_init(struct sdhci_host *host)
> > +{
> > +	u32 state;
> > +	int ret;
> > +
> > +	spacemit_sdhci_setbits(host, DLL_PREDLY_NUM | DLL_FULLDLY_RANGE | DLL_VREG_CTRL,
> > +			       SDHC_PHY_DLLCFG);
> > +	spacemit_sdhci_clrsetbits(host, DLL_REG1_CTRL_MASK, DLL_REG1_CTRL,
> > +				  SDHC_PHY_DLLCFG1);
> > +	spacemit_sdhci_setbits(host, DLL_ENABLE, SDHC_PHY_DLLCFG);
> > +
> > +	ret = readl_poll_timeout(host->ioaddr + SDHC_PHY_DLLSTS, state,
> > +				 state & DLL_LOCK_STATE, 2, 100);
> > +	if (ret == -ETIMEDOUT)
> > +		dev_warn(mmc_dev(host->mmc), "fail to lock phy dll in 100us!\n");
> > +}
> > +
> > +static void spacemit_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +
> > +	if (!ios->enhanced_strobe) {
> > +		spacemit_sdhci_clrbits(host, ENHANCE_STROBE_EN, SDHC_MMC_CTRL_REG);
> > +		return;
> > +	}
> > +
> > +	spacemit_sdhci_setbits(host, ENHANCE_STROBE_EN, SDHC_MMC_CTRL_REG);
> > +	spacemit_sdhci_phy_dll_init(host);
> > +}
> > +
> > +static unsigned int spacemit_sdhci_clk_get_max_clock(struct sdhci_host *host)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +
> > +	return clk_get_rate(pltfm_host->clk);
> > +}
> > +
> > +static int spacemit_sdhci_pre_select_hs400(struct mmc_host *mmc)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +
> > +	spacemit_sdhci_setbits(host, MMC_HS400, SDHC_MMC_CTRL_REG);
> > +	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> > +
> > +	return 0;
> > +}
> > +
> > +static void spacemit_sdhci_post_select_hs400(struct mmc_host *mmc)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +
> > +	spacemit_sdhci_phy_dll_init(host);
> > +	host->mmc->caps &= ~MMC_CAP_WAIT_WHILE_BUSY;
> > +}
> > +
> > +static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +
> > +	spacemit_sdhci_clrbits(host, PHY_FUNC_EN | PHY_PLL_LOCK,
> > +			       SDHC_PHY_CTRL_REG);
> > +	spacemit_sdhci_clrbits(host, MMC_HS400 | MMC_HS200 | ENHANCE_STROBE_EN,
> > +			       SDHC_MMC_CTRL_REG);
> > +	spacemit_sdhci_clrbits(host, HS200_USE_RFIFO, SDHC_PHY_FUNC_REG);
> > +
> > +	udelay(5);
> > +
> > +	spacemit_sdhci_setbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
> > +}
> > +
> > +static inline int spacemit_sdhci_get_clocks(struct device *dev,
> > +					    struct sdhci_pltfm_host *pltfm_host)
> > +{
> > +	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
> > +
> > +	sdhst->clk_core = devm_clk_get_enabled(dev, "core");
> > +	if (IS_ERR(sdhst->clk_core))
> > +		return -EINVAL;
> > +
> > +	sdhst->clk_io = devm_clk_get_enabled(dev, "io");
> > +	if (IS_ERR(sdhst->clk_io))
> > +		return -EINVAL;
> > +
> > +	pltfm_host->clk = sdhst->clk_io;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct sdhci_ops spacemit_sdhci_ops = {
> > +	.get_max_clock		= spacemit_sdhci_clk_get_max_clock,
> > +	.reset			= spacemit_sdhci_reset,
> > +	.set_bus_width		= sdhci_set_bus_width,
> > +	.set_clock		= spacemit_sdhci_set_clock,
> > +	.set_uhs_signaling	= spacemit_sdhci_set_uhs_signaling,
> > +};
> > +
> > +static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata = {
> > +	.ops = &spacemit_sdhci_ops,
> > +	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> > +		  SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> > +		  SDHCI_QUIRK_32BIT_ADMA_SIZE |
> > +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> > +		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> > +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> > +	.quirks2 = SDHCI_QUIRK2_BROKEN_64_BIT_DMA |
> > +		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> > +};
> > +
> > +static const struct of_device_id spacemit_sdhci_of_match[] = {
> > +	{ .compatible = "spacemit,k1-sdhci" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, spacemit_sdhci_of_match);
> > +
> > +static int spacemit_sdhci_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct spacemit_sdhci_host *sdhst;
> > +	struct sdhci_pltfm_host *pltfm_host;
> > +	struct sdhci_host *host;
> > +	struct mmc_host_ops *mops;
> > +	int ret;
> > +
> > +	host = sdhci_pltfm_init(pdev, &spacemit_sdhci_k1_pdata, sizeof(*sdhst));
> > +	if (IS_ERR(host))
> > +		return PTR_ERR(host);
> > +
> > +	pltfm_host = sdhci_priv(host);
> > +
> > +	ret = mmc_of_parse(host->mmc);
> > +	if (ret)
> > +		goto err_pltfm;
> > +
> > +	sdhci_get_of_property(pdev);
> > +
> > +	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC)) {
> > +		mops = &host->mmc_host_ops;
> > +		mops->hs400_prepare_ddr	= spacemit_sdhci_pre_select_hs400;
> > +		mops->hs400_complete	= spacemit_sdhci_post_select_hs400;
> > +		mops->hs400_downgrade	= spacemit_sdhci_pre_hs400_to_hs200;
> > +		mops->hs400_enhanced_strobe = spacemit_sdhci_hs400_enhanced_strobe;
> > +	}
> > +
> > +	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
> > +
> > +	if (spacemit_sdhci_get_clocks(dev, pltfm_host))
> > +		goto err_pltfm;
> > +
> > +	ret = sdhci_add_host(host);
> > +	if (ret)
> > +		goto err_pltfm;
> > +
> > +	return 0;
> > +
> > +err_pltfm:
> > +	sdhci_pltfm_free(pdev);
> > +	return ret;
> > +}
> > +
> > +static void spacemit_sdhci_remove(struct platform_device *pdev)
> > +{
> > +	struct sdhci_host *host = platform_get_drvdata(pdev);
> > +
> > +	sdhci_remove_host(host, 1);
> > +	sdhci_pltfm_free(pdev);
> > +}
> > +
> > +static struct platform_driver spacemit_sdhci_driver = {
> > +	.driver		= {
> > +		.name	= "sdhci-spacemit",
> > +		.of_match_table = of_match_ptr(spacemit_sdhci_of_match),
> 
> No .pm?
I'd reluctant to push features that I can't test, so let's postpone it
> 
> > +	},
> > +	.probe		= spacemit_sdhci_probe,
> > +	.remove		= spacemit_sdhci_remove,
> 
> Could just use sdhci_pltfm_remove()
> 
sure, thanks
> > +};
> > +module_platform_driver(spacemit_sdhci_driver);
> > +
> > +MODULE_DESCRIPTION("SpacemiT SDHCI platform driver");
> > +MODULE_LICENSE("GPL");
> > 
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
