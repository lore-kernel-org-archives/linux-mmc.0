Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11FA21A424;
	Tue,  6 May 2025 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746571052; cv=none; b=gP9x48/kOKSsHHSe3EXwh0nqz2RuH2JMKufUjboawV7pcGM8Q2MMXDYSd1tTcA5T/UdKPFTAQ1VaGlsEC7+L48NROKhDOkTrqYf1m0+COF1eCbALHnQQDBzuvBa1757RmcFKumQKfsOO0u+RN+vPnCFnD2LUjgi4a9oIN0KEXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746571052; c=relaxed/simple;
	bh=o3nZGdSsIIdCvX9JflP+FvU8JAUpYXnOQHaemBSsMjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rvu16qAlqVp/C7uyzhx0crtztunhwOd2QdE3HyztNiHcSgRZrxRXsuhhuSoL3nrB7uc9QwOsryDyiQVFWcBXkz9mPAtdYtBz+S6n44jgg7lfpmrOdD6/yzW1d+FMIv12z+iZP5PkQNw0Ru4erstwpPPZ6y6OJFZQHR0oquEZWUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+9ehBWG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+9ehBWG"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476ab588f32so98939271cf.2;
        Tue, 06 May 2025 15:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746571049; x=1747175849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YcnWnslX8rItrz+YOuuroqv5GRuVu7eWI4rYUAZg620=;
        b=Q+9ehBWGJaJu/kSPYDojZSmdL1s8CNDICpZSdfj+dB3rZXUdM5DPrIDbjDbOSaLKl/
         rJPrPJccYJNv0XSfY9M0MhVbxWrC+z1Fyl+WOUuUB55caZ3ykA3QM9RD+u5vGWB6alGK
         UK+odgcxtU24vRsiBT6V7sk18TLLAvGm7Wk6C9pF9dO/p9fHqeV/tEXMqmLHktQ9p4TO
         cuApHHzhv/Y7pH2bTC9keQWMpYxo91E1KeaD0CTjcPpbxvl35kOizTZjg/aYRcZa3125
         sqXkhhg4MKocSLKTWQKIhIFqumnyJELgqDLdX5kym7GFAfuI0+Bx6R65qNZFhh3FbfAX
         t8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746571049; x=1747175849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcnWnslX8rItrz+YOuuroqv5GRuVu7eWI4rYUAZg620=;
        b=p+CRP9ma2MJpWMmHLuf5CmerCT8wA1gXAmIUx6G6BrAlt7FD7JDPm26Re0Z2gI5ot4
         d2kAJR8ienlz3MzVtG+njg+K40zw+oID5cLb4xr/WbZGXK4S7BX9Sez77yF1NlxxB0Em
         QBz67p/WE7Y757tAJdOaADZWdUa+1txJO2wI5smOvRS9djP5lwD4vT68LLJh+Alz5oYS
         oTaTyiPk7DZbDW1d/uHzOVQx0Ug6/+mCDyceZ1sX2PmBhEutoJB60XeKnC2F6wTpVPtx
         0fwoL7fpIC3ph1GaaIQHeqvgrnPND1YvoYqLR5/divFF8UZjNY74DfsjTOJTCObxiEug
         rT9A==
X-Forwarded-Encrypted: i=1; AJvYcCVAc25UeG/sK6FWA+xGnL32crGUL2Y6DF3pZ4Gm1+GpYlHeKy5zxlPQR1eL3uluNyTmJ36WW6Hb1wZB@vger.kernel.org, AJvYcCVEo9mbtE09Eg+19tpn4Lm/9uVLmMyt4I0o41sXOUYUmY2LN9/CeDA8Cbibl4wjrJzJXoEJ6JlTO497jXBY@vger.kernel.org, AJvYcCXtgJGsYfBUAuxgGXMloUIEs0vrpwoE6PNtODIOIdXbt1+I5F1ggYEh+kxjqgxyp4KeNr8xLtY/y9fR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx3CDfFU9INSkfzt0UNCKPqYquWr4CAcV4IV3jd8xrOzFpRIsx
	3yLX2AjfHXc3ZzU/ir/+qbrfh56yq82xs+QyGRjQ9Vpu5XxSRkhaeTyTrg==
X-Gm-Gg: ASbGncvQ/YcqcBjHisGMpsW/7WSSyWJQPGhlKgSdVL6PtlFZkbhsyjzMM6JfGV1mYtO
	9oIRGBHoCXLp5j+JRURd82J5Etrvfb2xSiRtpFkjutbkdmtHFufUn4MdcdtZJKxpOepNHoiEjO9
	tH7EjD3vrjxT0lSzkttV8LYybYHi9WETRsbytv9L65yqCLEa8CBa0tKZ8I4Mk317sHGh7ri47hQ
	tjj3h8li0JESk8FqZiRYDUKxL+wsZOsewnSeJY0IDbKxE5V/ROy5bcnf5IoIto+bApmfzvXrwr4
	N/ldlh4qVthjYRvh
X-Google-Smtp-Source: AGHT+IFD+86jwQVHn10xN0dUtSZW51fxUiySWLnJW6kMe8y8IaqiVPzRdI+ex4x6o/WEcq9mqdjc6A==
X-Received: by 2002:a05:622a:1445:b0:476:8db0:8cae with SMTP id d75a77b69052e-4922565666dmr11043431cf.10.1746571049349;
        Tue, 06 May 2025 15:37:29 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-49220f81e03sm3600961cf.10.2025.05.06.15.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 15:37:28 -0700 (PDT)
Date: Wed, 7 May 2025 06:37:05 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Yixun Lan <dlan@gentoo.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Alex Elder <elder@riscstar.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-k1: add support for SpacemiT K1 SoC
Message-ID: <gfrdvfencetztdmkxmeo5q5vdnp3yxmggnuewfprjyxsldzhv2@eur5wtlltqtm>
References: <20250501-20-k1-sdhci-v2-0-3e7005fae29b@gentoo.org>
 <20250501-20-k1-sdhci-v2-2-3e7005fae29b@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501-20-k1-sdhci-v2-2-3e7005fae29b@gentoo.org>

On Thu, May 01, 2025 at 04:50:22PM +0800, Yixun Lan wrote:
> The SDHCI controller found in SpacemiT K1 SoC features SD,
> SDIO, eMMC support, such as:
> 
> - Compatible for 4-bit SDIO 3.0 UHS-I protocol, up to SDR104
> - Compatible for 4-bit SD 3.0 UHS-I protocol, up to SDR104
> - Compatible for 8bit eMMC5.1, up to HS400
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  drivers/mmc/host/Kconfig       |  14 ++
>  drivers/mmc/host/Makefile      |   1 +
>  drivers/mmc/host/sdhci-of-k1.c | 306 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 321 insertions(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 6824131b69b188cae58c8f48076715ca647ca28c..0ce78f22c33cfff916a2d4d680c79e9d19637e0e 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -250,6 +250,20 @@ config MMC_SDHCI_OF_DWCMSHC
>  	  If you have a controller with this interface, say Y or M here.
>  	  If unsure, say N.
>  
> +config MMC_SDHCI_OF_K1
> +	tristate "SDHCI OF support for the SpacemiT K1 SoC"
> +	depends on ARCH_SPACEMIT || COMPILE_TEST
> +	depends on MMC_SDHCI_PLTFM
> +	depends on OF
> +	depends on COMMON_CLK
> +	help
> +	  This selects the Secure Digital Host Controller Interface (SDHCI)
> +	  found in the SpacemiT K1 SoC.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_OF_SPARX5
>  	tristate "SDHCI OF support for the MCHP Sparx5 SoC"
>  	depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 5147467ec825ffaef3a7bd812fad80545e52b180..75bafc7b162b9e1d4c6c050f5d28b9d7cb582447 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -88,6 +88,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
>  obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
> +obj-$(CONFIG_MMC_SDHCI_OF_K1)		+= sdhci-of-k1.o
>  obj-$(CONFIG_MMC_SDHCI_OF_SPARX5)	+= sdhci-of-sparx5.o
>  obj-$(CONFIG_MMC_SDHCI_OF_MA35D1)	+= sdhci-of-ma35d1.o
>  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..8988053eeb33a476fa484d145579db6214b2d0b7
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -0,0 +1,306 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-2025 SpacemiT (Hangzhou) Technology Co. Ltd
> + * Copyright (c) 2025 Yixun Lan <dlan@gentoo.org>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <linux/init.h>
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "sdhci.h"
> +#include "sdhci-pltfm.h"
> +
> +#define SDHC_MMC_CTRL_REG		0x114
> +#define  MISC_INT_EN			BIT(1)
> +#define  MISC_INT			BIT(2)
> +#define  ENHANCE_STROBE_EN		BIT(8)
> +#define  MMC_HS400			BIT(9)
> +#define  MMC_HS200			BIT(10)
> +#define  MMC_CARD_MODE			BIT(12)
> +
> +#define SDHC_TX_CFG_REG			0x11C
> +#define  TX_INT_CLK_SEL			BIT(30)
> +#define  TX_MUX_SEL			BIT(31)
> +
> +#define SDHC_PHY_CTRL_REG		0x160
> +#define  PHY_FUNC_EN			BIT(0)
> +#define  PHY_PLL_LOCK			BIT(1)
> +#define  HOST_LEGACY_MODE		BIT(31)
> +
> +#define SDHC_PHY_FUNC_REG		0x164
> +#define  PHY_TEST_EN			BIT(7)
> +#define  HS200_USE_RFIFO		BIT(15)
> +
> +#define SDHC_PHY_DLLCFG			0x168
> +#define  DLL_PREDLY_NUM			GENMASK(3, 2)
> +#define  DLL_FULLDLY_RANGE		GENMASK(5, 4)
> +#define  DLL_VREG_CTRL			GENMASK(7, 6)
> +#define  DLL_ENABLE			BIT(31)
> +
> +#define SDHC_PHY_DLLCFG1		0x16C
> +#define  DLL_REG1_CTRL			GENMASK(7, 0)
> +#define  DLL_REG2_CTRL			GENMASK(15, 8)
> +#define  DLL_REG3_CTRL			GENMASK(23, 16)
> +#define  DLL_REG4_CTRL			GENMASK(31, 24)
> +
> +#define SDHC_PHY_DLLSTS			0x170
> +#define  DLL_LOCK_STATE			BIT(0)
> +
> +#define SDHC_PHY_PADCFG_REG		0x178
> +#define  PHY_DRIVE_SEL			GENMASK(2, 0)
> +#define  RX_BIAS_CTRL			BIT(5)
> +
> +struct spacemit_sdhci_host {
> +	struct clk *clk_core;
> +	struct clk *clk_io;
> +};
> +
> +static inline void spacemit_sdhci_setbits(struct sdhci_host *host, u32 val, int reg)
> +{
> +	sdhci_writel(host, sdhci_readl(host, reg) | val, reg);
> +}
> +
> +static inline void spacemit_sdhci_clrbits(struct sdhci_host *host, u32 val, int reg)
> +{
> +	sdhci_writel(host, sdhci_readl(host, reg) & ~val, reg);
> +}
> +

> +static inline void spacemit_sdhci_clrsetbits(struct sdhci_host *host, u32 clr, u32 set, int reg)

updatebits?

> +{
> +	u32 val = sdhci_readl(host, reg);
> +
> +	val = (val & ~clr) | set;
> +	sdhci_writel(host, val, reg);
> +}
> +
> +static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct platform_device *pdev;
> +
> +	pdev = to_platform_device(mmc_dev(host->mmc));
> +	sdhci_reset(host, mask);
> +
> +	if (mask != SDHCI_RESET_ALL)
> +		return;
> +
> +	spacemit_sdhci_setbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
> +
> +	spacemit_sdhci_clrsetbits(host, PHY_DRIVE_SEL,
> +				  RX_BIAS_CTRL | FIELD_PREP(PHY_DRIVE_SEL, 4),
> +				  SDHC_PHY_PADCFG_REG);
> +
> +	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC))
> +		spacemit_sdhci_setbits(host, MMC_CARD_MODE, SDHC_MMC_CTRL_REG);
> +}
> +
> +static void spacemit_sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
> +{
> +	if (timing == MMC_TIMING_MMC_HS200)
> +		spacemit_sdhci_setbits(host, MMC_HS200, SDHC_MMC_CTRL_REG);
> +
> +	if (timing == MMC_TIMING_MMC_HS400)
> +		spacemit_sdhci_setbits(host, MMC_HS400, SDHC_MMC_CTRL_REG);
> +
> +	sdhci_set_uhs_signaling(host, timing);
> +
> +	if (!(host->mmc->caps2 & MMC_CAP2_NO_SDIO))
> +		spacemit_sdhci_setbits(host, SDHCI_CTRL_VDD_180, SDHCI_HOST_CONTROL2);
> +}
> +
> +static void spacemit_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +
> +	if (mmc->ios.timing <= MMC_TIMING_UHS_SDR50)
> +		spacemit_sdhci_setbits(host, TX_INT_CLK_SEL, SDHC_TX_CFG_REG);
> +	else
> +		spacemit_sdhci_clrbits(host, TX_INT_CLK_SEL, SDHC_TX_CFG_REG);
> +
> +	sdhci_set_clock(host, clock);
> +};
> +
> +static void spacemit_sdhci_phy_dll_init(struct sdhci_host *host)
> +{
> +	u32 state;
> +	int ret;
> +
> +	spacemit_sdhci_clrsetbits(host, DLL_PREDLY_NUM | DLL_FULLDLY_RANGE | DLL_VREG_CTRL,
> +				  FIELD_PREP(DLL_PREDLY_NUM, 1) |
> +				  FIELD_PREP(DLL_FULLDLY_RANGE, 1) |
> +				  FIELD_PREP(DLL_VREG_CTRL, 1),
> +				  SDHC_PHY_DLLCFG);
> +
> +	spacemit_sdhci_clrsetbits(host, DLL_REG1_CTRL,
> +				  FIELD_PREP(DLL_REG1_CTRL, 0x92),
> +				  SDHC_PHY_DLLCFG1);
> +
> +	spacemit_sdhci_setbits(host, DLL_ENABLE, SDHC_PHY_DLLCFG);
> +
> +	ret = readl_poll_timeout(host->ioaddr + SDHC_PHY_DLLSTS, state,
> +				 state & DLL_LOCK_STATE, 2, 100);
> +	if (ret == -ETIMEDOUT)
> +		dev_warn(mmc_dev(host->mmc), "fail to lock phy dll in 100us!\n");
> +}
> +
> +static void spacemit_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	if (!ios->enhanced_strobe) {
> +		spacemit_sdhci_clrbits(host, ENHANCE_STROBE_EN, SDHC_MMC_CTRL_REG);
> +		return;
> +	}
> +
> +	spacemit_sdhci_setbits(host, ENHANCE_STROBE_EN, SDHC_MMC_CTRL_REG);
> +	spacemit_sdhci_phy_dll_init(host);
> +}
> +
> +static unsigned int spacemit_sdhci_clk_get_max_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +	return clk_get_rate(pltfm_host->clk);
> +}
> +
> +static int spacemit_sdhci_pre_select_hs400(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	spacemit_sdhci_setbits(host, MMC_HS400, SDHC_MMC_CTRL_REG);
> +	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> +
> +	return 0;
> +}
> +
> +static void spacemit_sdhci_post_select_hs400(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	spacemit_sdhci_phy_dll_init(host);
> +	host->mmc->caps &= ~MMC_CAP_WAIT_WHILE_BUSY;
> +}
> +
> +static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	spacemit_sdhci_clrbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
> +	spacemit_sdhci_clrbits(host, MMC_HS400 | MMC_HS200 | ENHANCE_STROBE_EN, SDHC_MMC_CTRL_REG);
> +	spacemit_sdhci_clrbits(host, HS200_USE_RFIFO, SDHC_PHY_FUNC_REG);
> +
> +	udelay(5);
> +
> +	spacemit_sdhci_setbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
> +}
> +
> +static inline int spacemit_sdhci_get_clocks(struct device *dev,
> +					    struct sdhci_pltfm_host *pltfm_host)
> +{
> +	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
> +
> +	sdhst->clk_core = devm_clk_get_enabled(dev, "core");
> +	if (IS_ERR(sdhst->clk_core))
> +		return -EINVAL;
> +
> +	sdhst->clk_io = devm_clk_get_enabled(dev, "io");
> +	if (IS_ERR(sdhst->clk_io))
> +		return -EINVAL;
> +
> +	pltfm_host->clk = sdhst->clk_io;
> +
> +	return 0;
> +}
> +
> +static const struct sdhci_ops spacemit_sdhci_ops = {
> +	.get_max_clock		= spacemit_sdhci_clk_get_max_clock,
> +	.reset			= spacemit_sdhci_reset,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.set_clock		= spacemit_sdhci_set_clock,
> +	.set_uhs_signaling	= spacemit_sdhci_set_uhs_signaling,
> +};
> +
> +static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata = {
> +	.ops = &spacemit_sdhci_ops,
> +	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +		  SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> +		  SDHCI_QUIRK_32BIT_ADMA_SIZE |
> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +	.quirks2 = SDHCI_QUIRK2_BROKEN_64_BIT_DMA |
> +		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +};
> +
> +static const struct of_device_id spacemit_sdhci_of_match[] = {
> +	{ .compatible = "spacemit,k1-sdhci" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, spacemit_sdhci_of_match);
> +
> +static int spacemit_sdhci_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct spacemit_sdhci_host *sdhst;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_host *host;
> +	struct mmc_host_ops *mops;
> +	int ret;
> +
> +	host = sdhci_pltfm_init(pdev, &spacemit_sdhci_k1_pdata, sizeof(*sdhst));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +
> +	ret = mmc_of_parse(host->mmc);
> +	if (ret)
> +		goto err_pltfm;
> +
> +	sdhci_get_of_property(pdev);
> +
> +	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC)) {
> +		mops = &host->mmc_host_ops;
> +		mops->hs400_prepare_ddr	= spacemit_sdhci_pre_select_hs400;
> +		mops->hs400_complete	= spacemit_sdhci_post_select_hs400;
> +		mops->hs400_downgrade	= spacemit_sdhci_pre_hs400_to_hs200;
> +		mops->hs400_enhanced_strobe = spacemit_sdhci_hs400_enhanced_strobe;
> +	}
> +
> +	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
> +
> +	if (spacemit_sdhci_get_clocks(dev, pltfm_host))
> +		goto err_pltfm;
> +
> +	ret = sdhci_add_host(host);
> +	if (ret)
> +		goto err_pltfm;
> +
> +	return 0;
> +
> +err_pltfm:
> +	sdhci_pltfm_free(pdev);
> +	return ret;
> +}
> +
> +static struct platform_driver spacemit_sdhci_driver = {
> +	.driver		= {
> +		.name	= "sdhci-spacemit",

> +		.of_match_table = of_match_ptr(spacemit_sdhci_of_match),

I think the of_match_ptr is not needed.

> +	},
> +	.probe		= spacemit_sdhci_probe,
> +	.remove		= sdhci_pltfm_remove,
> +};
> +module_platform_driver(spacemit_sdhci_driver);
> +
> +MODULE_DESCRIPTION("SpacemiT SDHCI platform driver");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.49.0
> 
