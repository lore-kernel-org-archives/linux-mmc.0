Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB7222587;
	Wed, 12 Nov 2025 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955232; cv=none; b=H02iQ+BOwBTWdrdbB/QGdQKjizb8FmJBLeKK8P0IHh6RJvOT9nHjIrNlkYIxbH9hpK6z6PAaSa1FS3Xv5iNHQTUDXnn4NBMrB7MVMIIYlb46Cx0ALEJNGmTS5fNva8s/C6y2ld4lmmLDtGyQ1hIKJRw3srimMD7++atvshyaV94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955232; c=relaxed/simple;
	bh=vPEO6ikNEl3G+Iubi37HdKqFst9U39SbweNp03IaAiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqO4KT+UEbJsB16WCRukm1vc8NY3UrnEOLIQh3YbDJAacskVwamSUMLtOkzopZS8KE1Wx7TcNtrNfB/4Z43RBpK0LX+dwaRZD84ubBgemvmiNGK97IvmsCXWeTaaKOY7Sfoqy0sdNk7A70fE6JO7h6nW2EccDOUtIdi05H/BgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGGX34S+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGGX34S+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AF3C16AAE;
	Wed, 12 Nov 2025 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762955231;
	bh=vPEO6ikNEl3G+Iubi37HdKqFst9U39SbweNp03IaAiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGGX34S+AN1fXpuAD93pNyKB/dnqJ7vh63XW22gkH9KktBCsRxYdgUfDxQt7ZQh5x
	 zPQT48qb4+GWwU8/kCUizf6NRWXW3eP0CVoEAMvKqzfqnyw4Uv8Bu8AwOXqedyfPCF
	 BfK40Os18/KrTVF3OXNVoSd63GFv0D9coueENszVv446ZYOxMEJNOhVxkj51laRr1f
	 YRhdUor3gIxfNZ0X3sRQdYbhQb7GgGFzfkZj2GXOMhmvDldc2zf03YvuZek0nUJi9V
	 IFEu3DldiDVeqLogvWXXbXQUp5smT9Y0YSFvghuRaPbCnxaGuRUkJLlhXTEvkNBDnx
	 s0u5qYoXbFVZA==
Date: Wed, 12 Nov 2025 21:29:18 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Albert Yang <yangzh0906@thundersoft.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ge Gordon <gordon.ge@bst.ai>,
	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org, soc@lists.linux.dev
Subject: Re: [PATCH 5/9] mmc: sdhci: add Black Sesame Technologies BST C1200
 controller driver
Message-ID: <aRSLruoEBfl2fJ8m@xhacker>
References: <20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com>
 <20250923-v4-patch-final-v1-5-2283ad7cbf88@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250923-v4-patch-final-v1-5-2283ad7cbf88@thundersoft.com>

On Tue, Sep 23, 2025 at 02:10:11PM +0800, Albert Yang wrote:
> Add SDHCI controller driver for Black Sesame Technologies C1200 SoC.
> 
> This driver supports the DWCMSHC SDHCI controller with BST-specific

If this is snps dwcmshc, I'm afraid there will be many code duplications
when you add set_uhs_signaling, cqe support etc. in the future.

There's also a common 128MB boundary "feature" with dwcmshc, OK, I see bst
variant uses a bounce buffer from sram, so no need to share the 128MB
boundary handling. But what about if BST solves the 32bit bus sdhci controller
limitation in new generation SoCs? Then you'll duplicate the 128MB
boundary handing too.

So I'm wondering why not add the bst support to exisiting dwcmshc
driver?

> enhancements including:
> - Custom clock management and tuning
> - Power management support
> - BST-specific register configurations
> - Support for eMMC and SD card interfaces
> - Hardware limitation workaround for 32-bit DMA addressing
> 
> The driver addresses specific hardware constraints where:
> - System memory uses 64-bit bus, eMMC controller uses 32-bit bus
> - eMMC controller cannot access memory through SMMU due to hardware bug
> - All system DRAM is configured outside 4GB boundary (ZONE_DMA32)
> - Uses SRAM-based bounce buffer within 32-bit address space
> 
> Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
> Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> ---
> Changes for v4:
> - Rename all functions from bst_* to sdhci_bst_* for better namespace consistency
> - Rename driver file from sdhci-of-bst-c1200.c to sdhci-of-bst.c
> - Rename dwcmshc_priv structure to sdhci_bst_priv for clarity
> - Update driver name from "sdhci-dwcmshc" to "sdhci-bst" throughout
> - Add comprehensive register bit mask definitions and named constants
> - Replace manual polling loops with read_poll_timeout() for clock stability
> - Add dedicated sdhci_bst_wait_int_clk() function for internal clock management
> - Completely rewrite power management with proper power-off handling
> - Enhance clock control with read-modify-write operations to avoid clobbering
> - Add MBIU burst mode configuration based on power state
> - Improve error handling and cleanup in probe/remove functions
> - Simplify bounce buffer allocation and remove redundant MMC parameter adjustments
> - Add SDHCI_QUIRK_BROKEN_ADMA quirk for hardware limitation
> - Replace ioread32/iowrite32 with readl/writel for consistency
> - Update copyright year and simplify license text
> - Improve tuning algorithm with clearer variable naming
> - Enhance register access patterns with proper bit field manipulation
> - Add power-off clock management to reduce idle power consumption
> - Add Acked-by: Arnd Bergmann
> 
> Changes for v3:
> - Simplify dwcmshc_priv structure by removing unused fields
> - Improve helper functions with better encapsulation
> - Use devm_platform_ioremap_resource() for resource management
> - Update Kconfig description and alphabetical ordering
> - Clarify documentation on hardware limitations and bounce buffer approach
> - Remove duplicate sdhci_writew SDHCI_CLOCK_CONTROL
> 
> Changes for v2:
> - Remove COMMON_CLK dependency from Kconfig (MMC_SDHCI_BST)
> - Add ARCH_BST || COMPILE_TEST dependency from Kconfig (MMC_SDHCI_BST)
> - Replace temporary ioremap with persistent mapping
> - Map CRM registers once during probe instead of per-access
> - Add proper cleanup in remove callback
> - Refactor bounce buffer allocation with simplified error handling
> - Remove unnecessary DMA configuration layers
> - Prune unused headers and legacy vendor debug code
> - Remove deprecated sdhci_bst_print_vendor() export
> - Convert internal functions to static scope
> - Standardize naming conventions (DRIVER_NAME, DEFAULT_MAX_FREQ)
> - Optimize clock configuration routines
> - Fix register access macros for EMMC_CTRL with proper offset calculation
> - Correct device tree compatibility string to "bst,c1200-dwcmshc-sdhci"
> - Add robust ioremap error checking
> - Improve bounce buffer allocation failure handling
> - Update MODULE_DESCRIPTION and AUTHOR fields
> - Add explanatory comments for hardware limitations
> - Remove redundant multi-host setup infrastructure
> - Fix build warnings from lkp (kernel test robot)
> ---
>  drivers/mmc/host/Kconfig        |  14 ++
>  drivers/mmc/host/Makefile       |   1 +
>  drivers/mmc/host/sdhci-of-bst.c | 544 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 559 insertions(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7232de1c068873d9bccec0b3b43ece939cb84894..75c37be559d23bff773bbe3f018b76c34ad710ca 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -429,6 +429,20 @@ config MMC_SDHCI_BCM_KONA
>  
>  	  If you have a controller with this interface, say Y or M here.
>  
> +config MMC_SDHCI_BST
> +	tristate "SDHCI support for Black Sesame Technologies BST C1200 controller"
> +	depends on ARCH_BST || COMPILE_TEST
> +	depends on MMC_SDHCI_PLTFM
> +	depends on OF
> +	help
> +	  This selects the Secure Digital Host Controller Interface (SDHCI)
> +	  for Black Sesame Technologies BST C1200 SoC. The controller is
> +	  based on Synopsys DesignWare Cores Mobile Storage Controller but
> +	  requires platform-specific workarounds for hardware limitations.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_F_SDH30
>  	tristate "SDHCI support for Fujitsu Semiconductor F_SDH30"
>  	depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 5057fea8afb696e210e465a6a2aafc68adad7854..ee412e6b84d6c91f80654e53d0a05b549d4b6171 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
>  obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_UHS2)	+= sdhci-uhs2.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
> +obj-$(CONFIG_MMC_SDHCI_BST)	        += sdhci-of-bst.o
>  sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
>  				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
>  obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
> diff --git a/drivers/mmc/host/sdhci-of-bst.c b/drivers/mmc/host/sdhci-of-bst.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b19b763f216a25f58d37c8e288a8aa791f1e20f7
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-bst.c
> @@ -0,0 +1,544 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * SDHCI driver for Black Sesame Technologies C1200 controller
> + *
> + * Copyright (c) 2025 Black Sesame Technologies
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/ioport.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/iopoll.h>
> +#include "sdhci.h"
> +#include "sdhci-pltfm.h"
> +
> +/* SDHCI standard register extensions */
> +#define SDHCI_CLOCK_PLL_EN		0x0008
> +#define SDHCI_TUNING_COUNT		0x20
> +#define SDHCI_VENDOR_PTR_R		0xE8
> +
> +/* Synopsys vendor specific registers */
> +#define SDHC_EMMC_CTRL_R_OFFSET		0x2C
> +#define MBIU_CTRL			0x510
> +
> +/* MBIU burst control bits */
> +#define BURST_INCR16_EN			BIT(3)
> +#define BURST_INCR8_EN			BIT(2)
> +#define BURST_INCR4_EN			BIT(1)
> +#define BURST_EN			(BURST_INCR16_EN | BURST_INCR8_EN | BURST_INCR4_EN)
> +#define MBIU_BURST_MASK			GENMASK(3, 0)
> +
> +/* CRM (Clock/Reset/Management) register offsets */
> +#define SDEMMC_CRM_BCLK_DIV_CTRL	0x08
> +#define SDEMMC_CRM_TIMER_DIV_CTRL	0x0C
> +#define SDEMMC_CRM_RX_CLK_CTRL		0x14
> +#define SDEMMC_CRM_VOL_CTRL		0x1C
> +#define REG_WR_PROTECT			0x88
> +#define DELAY_CHAIN_SEL			0x94
> +
> +/* CRM register values and bit definitions */
> +#define REG_WR_PROTECT_KEY		0x1234abcd
> +#define BST_VOL_STABLE_ON		BIT(7)
> +#define BST_TIMER_DIV_MASK		GENMASK(7, 0)
> +#define BST_TIMER_DIV_VAL		0x20
> +#define BST_TIMER_LOAD_BIT		BIT(8)
> +#define BST_BCLK_EN_BIT			BIT(10)
> +#define BST_RX_UPDATE_BIT		BIT(11)
> +#define BST_EMMC_CTRL_BIT2		BIT(2)
> +
> +/* Clock frequency limits */
> +#define BST_DEFAULT_MAX_FREQ		2000000UL
> +#define BST_DEFAULT_MIN_FREQ		400000UL
> +
> +/* Clock control bit definitions */
> +#define BST_CLOCK_DIV_MASK		GENMASK(7, 0)
> +#define BST_CLOCK_DIV_SHIFT		8
> +#define BST_BCLK_DIV_MASK		GENMASK(9, 0)
> +
> +/* Clock frequency thresholds */
> +#define BST_CLOCK_THRESHOLD_LOW		1500
> +
> +/* Clock stability polling parameters */
> +#define BST_CLK_STABLE_POLL_US		1000	/* Poll interval in microseconds */
> +#define BST_CLK_STABLE_TIMEOUT_US	20000	/* Timeout for internal clock stabilization (us) */
> +
> +struct sdhci_bst_priv {
> +	void __iomem *crm_reg_base;
> +};
> +
> +union sdhci_bst_rx_ctrl {
> +	struct {
> +		u32 rx_revert:1,
> +		    rx_clk_sel_sec:1,
> +		    rx_clk_div:4,
> +		    rx_clk_phase_inner:2,
> +		    rx_clk_sel_first:1,
> +		    rx_clk_phase_out:2,
> +		    rx_clk_en:1,
> +		    res0:20;
> +	};
> +	u32 reg;
> +};
> +
> +static u32 sdhci_bst_crm_read(struct sdhci_pltfm_host *pltfm_host, u32 offset)
> +{
> +	struct sdhci_bst_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	return readl(priv->crm_reg_base + offset);
> +}
> +
> +static void sdhci_bst_crm_write(struct sdhci_pltfm_host *pltfm_host, u32 offset, u32 value)
> +{
> +	struct sdhci_bst_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	writel(value, priv->crm_reg_base + offset);
> +}
> +
> +static int sdhci_bst_wait_int_clk(struct sdhci_host *host)
> +{
> +	u16 clk;
> +
> +	if (read_poll_timeout(sdhci_readw, clk, (clk & SDHCI_CLOCK_INT_STABLE),
> +			      BST_CLK_STABLE_POLL_US, BST_CLK_STABLE_TIMEOUT_US, false,
> +			      host, SDHCI_CLOCK_CONTROL))
> +		return -EBUSY;
> +	return 0;
> +}
> +
> +static unsigned int sdhci_bst_get_max_clock(struct sdhci_host *host)
> +{
> +	return BST_DEFAULT_MAX_FREQ;
> +}
> +
> +static unsigned int sdhci_bst_get_min_clock(struct sdhci_host *host)
> +{
> +	return BST_DEFAULT_MIN_FREQ;
> +}
> +
> +static void sdhci_bst_enable_clk(struct sdhci_host *host, unsigned int clk)
> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	unsigned int div;
> +	u32 val;
> +	union sdhci_bst_rx_ctrl rx_reg;
> +
> +	pltfm_host = sdhci_priv(host);
> +	if (clk == 0) {
> +		div = clk;
> +	} else if (clk > BST_DEFAULT_MAX_FREQ) {
> +		div = clk / 1000;
> +		div = BST_DEFAULT_MAX_FREQ / div;
> +	} else if (clk < BST_CLOCK_THRESHOLD_LOW) {
> +		div = clk;
> +	} else {
> +		div = BST_DEFAULT_MAX_FREQ * 100;
> +		div = div / clk;
> +		div /= 100;
> +	}
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk &= ~SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	clk &= ~SDHCI_CLOCK_PLL_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL);
> +	val &= ~BST_TIMER_LOAD_BIT;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL, val);
> +
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL);
> +	val &= ~BST_TIMER_DIV_MASK;
> +	val |= BST_TIMER_DIV_VAL;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL, val);
> +
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL);
> +	val |= BST_TIMER_LOAD_BIT;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL, val);
> +
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL);
> +	val &= ~BST_RX_UPDATE_BIT;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL, val);
> +
> +	rx_reg.reg = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL);
> +
> +	rx_reg.rx_revert = 0;
> +	rx_reg.rx_clk_sel_sec = 1;
> +	rx_reg.rx_clk_div = 4;
> +	rx_reg.rx_clk_phase_inner = 2;
> +	rx_reg.rx_clk_sel_first = 0;
> +	rx_reg.rx_clk_phase_out = 2;
> +
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL, rx_reg.reg);
> +
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL);
> +	val |= BST_RX_UPDATE_BIT;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL, val);
> +
> +	/* Disable clock first */
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL);
> +	val &= ~BST_BCLK_EN_BIT;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL, val);
> +
> +	/* Setup clock divider */
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL);
> +	val &= ~BST_BCLK_DIV_MASK;
> +	val |= div;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL, val);
> +
> +	/* Enable clock */
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL);
> +	val |= BST_BCLK_EN_BIT;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL, val);
> +
> +	/* RMW the clock divider bits to avoid clobbering other fields */
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk &= ~(BST_CLOCK_DIV_MASK << BST_CLOCK_DIV_SHIFT);
> +	clk |= (div & BST_CLOCK_DIV_MASK) << BST_CLOCK_DIV_SHIFT;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk |= SDHCI_CLOCK_PLL_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	clk |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	clk |= SDHCI_CLOCK_INT_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +}
> +
> +static void sdhci_bst_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	/* Turn off card/internal/PLL clocks when clock==0 to avoid idle power */
> +	u32 clk_reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +	if (!clock) {
> +		clk_reg &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN | SDHCI_CLOCK_PLL_EN);
> +		sdhci_writew(host, clk_reg, SDHCI_CLOCK_CONTROL);
> +		return;
> +	}
> +	sdhci_bst_enable_clk(host, clock);
> +}
> +
> +/**
> + * sdhci_bst_reset - Reset the SDHCI host controller
> + * @host: SDHCI host controller
> + * @mask: Reset mask
> + *
> + * Performs a reset of the SDHCI host controller with special handling for eMMC.
> + */
> +static void sdhci_bst_reset(struct sdhci_host *host, u8 mask)
> +{
> +	u16 vendor_ptr, emmc_ctrl_reg;
> +	u32 reg;
> +
> +	if (host->mmc->caps2 & MMC_CAP2_NO_SD) {
> +		vendor_ptr = sdhci_readw(host, SDHCI_VENDOR_PTR_R);
> +		emmc_ctrl_reg = vendor_ptr + SDHC_EMMC_CTRL_R_OFFSET;
> +
> +		reg = sdhci_readw(host, emmc_ctrl_reg);
> +		reg &= ~BST_EMMC_CTRL_BIT2;
> +		sdhci_writew(host, reg, emmc_ctrl_reg);
> +		sdhci_reset(host, mask);
> +		usleep_range(10, 20);
> +		reg = sdhci_readw(host, emmc_ctrl_reg);
> +		reg |= BST_EMMC_CTRL_BIT2;
> +		sdhci_writew(host, reg, emmc_ctrl_reg);
> +	} else {
> +		sdhci_reset(host, mask);
> +	}
> +}
> +
> +/**
> + * sdhci_bst_set_timeout - Set timeout value for commands
> + * @host: SDHCI host controller
> + * @cmd: MMC command
> + *
> + * Sets the timeout control register to maximum value (0xE).
> + */
> +static void sdhci_bst_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	sdhci_writeb(host, 0xE, SDHCI_TIMEOUT_CONTROL);
> +}
> +
> +/**
> + * sdhci_bst_set_power - Set power mode and voltage
> + * @host: SDHCI host controller
> + * @mode: Power mode to set
> + * @vdd: Voltage to set
> + *
> + * Sets power mode and voltage, also configures MBIU control register.
> + */
> +static void sdhci_bst_set_power(struct sdhci_host *host, unsigned char mode,
> +				unsigned short vdd)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	u32 reg;
> +	u32 val;
> +
> +	sdhci_set_power(host, mode, vdd);
> +
> +	if (mode == MMC_POWER_OFF) {
> +		/* Disable MBIU burst mode */
> +		reg = sdhci_readw(host, MBIU_CTRL);
> +		reg &= ~BURST_EN; /* Clear all burst enable bits */
> +		sdhci_writew(host, reg, MBIU_CTRL);
> +
> +		/* Disable CRM BCLK */
> +		val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL);
> +		val &= ~BST_BCLK_EN_BIT;
> +		sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL, val);
> +
> +		/* Disable RX clock */
> +		val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL);
> +		val &= ~BST_RX_UPDATE_BIT;
> +		sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL, val);
> +
> +		/* Turn off voltage stable power */
> +		val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_VOL_CTRL);
> +		val &= ~BST_VOL_STABLE_ON;
> +		sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_VOL_CTRL, val);
> +	} else {
> +		/* Configure burst mode only when powered on */
> +		reg = sdhci_readw(host, MBIU_CTRL);
> +		reg &= ~MBIU_BURST_MASK; /* Clear burst related bits */
> +		reg |= BURST_EN; /* Enable burst mode for better bandwidth */
> +		sdhci_writew(host, reg, MBIU_CTRL);
> +	}
> +}
> +
> +/**
> + * sdhci_bst_execute_tuning - Execute tuning procedure
> + * @host: SDHCI host controller
> + * @opcode: Opcode to use for tuning
> + *
> + * Performs tuning procedure by trying different values and selecting the best one.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int sdhci_bst_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	int ret = 0, error;
> +	int first_start = -1, first_end = -1, best = 0;
> +	int second_start = -1, second_end = -1, has_failure = 0;
> +	int i;
> +
> +	pltfm_host = sdhci_priv(host);
> +
> +	for (i = 0; i < SDHCI_TUNING_COUNT; i++) {
> +		/* Protected write */
> +		sdhci_bst_crm_write(pltfm_host, REG_WR_PROTECT, REG_WR_PROTECT_KEY);
> +		/* Write tuning value */
> +		sdhci_bst_crm_write(pltfm_host, DELAY_CHAIN_SEL, (1ul << i) - 1);
> +
> +		/* Wait for internal clock stable before tuning */
> +		if (sdhci_bst_wait_int_clk(host)) {
> +			dev_err(mmc_dev(host->mmc), "Internal clock never stabilised\n");
> +			return -EBUSY;
> +		}
> +
> +		ret = mmc_send_tuning(host->mmc, opcode, &error);
> +		if (ret != 0) {
> +			has_failure = 1;
> +		} else {
> +			if (has_failure == 0) {
> +				if (first_start == -1)
> +					first_start = i;
> +				first_end = i;
> +			} else {
> +				if (second_start == -1)
> +					second_start = i;
> +				second_end = i;
> +			}
> +		}
> +	}
> +
> +	/* Calculate best tuning value */
> +	if (first_end - first_start >= second_end - second_start)
> +		best = ((first_end - first_start) >> 1) + first_start;
> +	else
> +		best = ((second_end - second_start) >> 1) + second_start;
> +
> +	if (best < 0)
> +		best = 0;
> +
> +	sdhci_bst_crm_write(pltfm_host, DELAY_CHAIN_SEL, (1ul << best) - 1);
> +	/* Confirm internal clock stable after setting best tuning value */
> +	if (sdhci_bst_wait_int_clk(host)) {
> +		dev_err(mmc_dev(host->mmc), "Internal clock never stabilised\n");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * sdhci_bst_voltage_switch - Perform voltage switch
> + * @host: SDHCI host controller
> + *
> + * Enables voltage stable power.
> + */
> +static void sdhci_bst_voltage_switch(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +	/* Enable voltage stable power */
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_VOL_CTRL, BST_VOL_STABLE_ON);
> +}
> +
> +static const struct sdhci_ops sdhci_bst_ops = {
> +	.set_clock		= sdhci_bst_set_clock,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +	.get_min_clock		= sdhci_bst_get_min_clock,
> +	.get_max_clock		= sdhci_bst_get_max_clock,
> +	.reset			= sdhci_bst_reset,
> +	.set_power		= sdhci_bst_set_power,
> +	.set_timeout		= sdhci_bst_set_timeout,
> +	.platform_execute_tuning = sdhci_bst_execute_tuning,
> +	.voltage_switch		= sdhci_bst_voltage_switch,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_bst_pdata = {
> +	.ops = &sdhci_bst_ops,
> +	.quirks = SDHCI_QUIRK_BROKEN_ADMA |
> +		  SDHCI_QUIRK_DELAY_AFTER_POWER |
> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
> +	.quirks2 = SDHCI_QUIRK2_BROKEN_DDR50 |
> +		   SDHCI_QUIRK2_TUNING_WORK_AROUND |
> +		   SDHCI_QUIRK2_ACMD23_BROKEN,
> +};
> +
> +static int sdhci_bst_alloc_bounce_buffer(struct sdhci_host *host)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	unsigned int bounce_size;
> +	int ret;
> +
> +	/* Fixed SRAM bounce size to 32KB: verified config under 32-bit DMA addressing limit */
> +	bounce_size = SZ_32K;
> +
> +	ret = of_reserved_mem_device_init_by_idx(mmc_dev(mmc), mmc_dev(mmc)->of_node, 0);
> +	if (ret) {
> +		dev_err(mmc_dev(mmc), "Failed to initialize reserved memory\n");
> +		return ret;
> +	}
> +
> +	host->bounce_buffer = dma_alloc_coherent(mmc_dev(mmc), bounce_size,
> +						 &host->bounce_addr, GFP_KERNEL);
> +	if (!host->bounce_buffer)
> +		return -ENOMEM;
> +
> +	host->bounce_buffer_size = bounce_size;
> +
> +	return 0;
> +}
> +
> +static int sdhci_bst_probe(struct platform_device *pdev)
> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_host *host;
> +	struct sdhci_bst_priv *priv;
> +	int err;
> +
> +	host = sdhci_pltfm_init(pdev, &sdhci_bst_pdata, sizeof(struct sdhci_bst_priv));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host); /* Get platform private data */
> +
> +	err = mmc_of_parse(host->mmc);
> +	if (err)
> +		return err;
> +
> +	sdhci_get_of_property(pdev);
> +
> +	/* Get CRM registers from the second reg entry */
> +	priv->crm_reg_base = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(priv->crm_reg_base)) {
> +		err = PTR_ERR(priv->crm_reg_base);
> +		return err;
> +	}
> +
> +	/*
> +	 * Silicon constraints for BST C1200:
> +	 * - System RAM base is 0x800000000 (above 32-bit addressable range)
> +	 * - The eMMC controller DMA engine is limited to 32-bit addressing
> +	 * - SMMU cannot be used on this path due to hardware design flaws
> +	 * - These are fixed in silicon and cannot be changed in software
> +	 *
> +	 * Bus/controller mapping:
> +	 * - No registers are available to reprogram the address mapping
> +	 * - The 32-bit DMA limit is a hard constraint of the controller IP
> +	 *
> +	 * Given these constraints, an SRAM-based bounce buffer in the 32-bit
> +	 * address space is required to enable eMMC DMA on this platform.
> +	 */
> +	err = sdhci_bst_alloc_bounce_buffer(host);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to allocate bounce buffer: %d\n", err);
> +		return err;
> +	}
> +
> +	err = sdhci_add_host(host);
> +	if (err)
> +		goto err_free_bounce_buffer;
> +
> +	return 0;
> +
> +err_free_bounce_buffer:
> +	if (host->bounce_buffer) {
> +		dma_free_coherent(mmc_dev(host->mmc), host->bounce_buffer_size,
> +				  host->bounce_buffer, host->bounce_addr);
> +		host->bounce_buffer = NULL;
> +	}
> +	of_reserved_mem_device_release(mmc_dev(host->mmc));
> +
> +	return err;
> +}
> +
> +static void sdhci_bst_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +
> +	/* Free bounce buffer if allocated */
> +	if (host->bounce_buffer) {
> +		dma_free_coherent(mmc_dev(host->mmc), host->bounce_buffer_size,
> +				  host->bounce_buffer, host->bounce_addr);
> +		host->bounce_buffer = NULL;
> +	}
> +
> +	/* Release reserved memory */
> +	of_reserved_mem_device_release(mmc_dev(host->mmc));
> +
> +	/* Use platform helper for remove */
> +	sdhci_pltfm_remove(pdev);
> +}
> +
> +static const struct of_device_id sdhci_bst_ids[] = {
> +	{ .compatible = "bst,c1200-dwcmshc-sdhci" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_bst_ids);
> +
> +static struct platform_driver sdhci_bst_driver = {
> +	.driver = {
> +		.name = "sdhci-bst",
> +		.of_match_table = sdhci_bst_ids,
> +	},
> +	.probe = sdhci_bst_probe,
> +	.remove = sdhci_bst_remove,
> +};
> +module_platform_driver(sdhci_bst_driver);
> +
> +MODULE_DESCRIPTION("Black Sesame Technologies SDHCI driver (BST)");
> +MODULE_AUTHOR("Black Sesame Technologies Co., Ltd.");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.43.0
> 
