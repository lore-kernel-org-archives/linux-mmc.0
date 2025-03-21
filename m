Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EE31EF39F;
	Fri, 21 Mar 2025 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742601518; cv=none; b=tsg4H8ASwXFOequfB1M1R+Xn/jAVlHK4ZdEbPVElNW6JCkqr29ZJZIPcO08RpKh7fiRmxyzv5iQWuAnoW5V9BRI4BI6M6Fy6QAKhLLiPXnmS0mxMa+yQVV1A1ubbvzGBF/lqG50GsxXlKgD6NT1+JqTtUq5bcRGXuJjCaVVWHyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742601518; c=relaxed/simple;
	bh=m6UkBiq2OBDMQY/NyxsU5FKMcCkOsNgG/0k+DWls0wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4+GgGM/NZKZ0qpUUbTI4uZPfn1no3uIte608wBgCHW88G1+apgPnM0FVLQtteOq0LEVZb47bGbKajVUMuY/qem4hZvWWTwcZ67dc4fHT+B8ftXw9sq51C00nRN3yMwHvEy9iAnJPY7dJCt8BnSKKe51JFRHZXFvJ6Sndgw4xx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 3CC7F343162;
	Fri, 21 Mar 2025 23:58:34 +0000 (UTC)
Date: Fri, 21 Mar 2025 23:58:30 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] mmc: sdhci-of-k1: add support for SpacemiT K1 SoC
Message-ID: <20250321235830-GYA13359@gentoo>
References: <20250213-20-k1-sdhci-v1-0-1f4362a980cd@gentoo.org>
 <20250213-20-k1-sdhci-v1-2-1f4362a980cd@gentoo.org>
 <b0583550-eb2c-4918-b9e7-7041d3fd2e9e@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0583550-eb2c-4918-b9e7-7041d3fd2e9e@riscstar.com>

Hi Alex:

On 11:51 Fri 21 Mar     , Alex Elder wrote:
> On 2/13/25 4:58 AM, Yixun Lan wrote:
> > The SDHCI controller found in SpacemiT K1 SoC features SD,
> > SDIO, eMMC support, such as:
> > 
> > - Compatible for 4-bit SDIO 3.0 UHS-I protocol, up to SDR104
> > - Compatible for 4-bit SD 3.0 UHS-I protocol, up to SDR104
> > - Compatible for 8bit eMMC5.1, up to HS400
> > 
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> 
> Why is this RFC? Have you tested it?
> 
I'd explicitly mark it as RFC before clock/reset driver merged,
in case there is anything changed break this driver, and also
 notify maintainer to only review the code but not merge it.

Yes, I've tested, it works

> I have a few minor comments but this seems reasonable to me.
> 
> > ---
> >   drivers/mmc/host/Kconfig       |  14 ++
> >   drivers/mmc/host/Makefile      |   1 +
> >   drivers/mmc/host/sdhci-of-k1.c | 320 +++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 335 insertions(+)
> 
> . . .
> 
> > +#define SDHC_PHY_DLLCFG			0x168
> > +#define  DLL_PREDLY_NUM			0x04
> > +#define  DLL_FULLDLY_RANGE		0x10
> > +#define  DLL_VREG_CTRL			0x40
> > +#define  DLL_ENABLE			0x80000000
> > +#define  DLL_REFRESH_SWEN_SHIFT		0x1C
> > +#define  DLL_REFRESH_SW_SHIFT		0x1D
> > +
> > +#define SDHC_PHY_DLLCFG1		0x16C
> > +#define  DLL_REG2_CTRL			0x0C
> > +#define  DLL_REG3_CTRL_MASK		0xFF
> 
> As Adrian said, please use GENMASK() (or BIT()) to define
> these masks, and FIELD_GET() or similar to manipulate them.
> I prefer lower-case hex digits too.
> 
ok, will fix in next version

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
> 
> I don't think the next few functions add any real value.
> 
> Just call sdhci_writel() and sdhci_readl() directly.  It
> might even take fewer characters (but above all, I think
> it's clearer without the function hiding what's done).
> 
on the opposite, I thought introducing a helper function make it more readable
1) give a function name as setbits(), clrbits(), we know clearly what's doing here
2) without helper, we either need to break the code into several lines -
read first, then write, or if put them into one line, then reg variable usually
come as macro which quite long and need to repeat twice which easily exceed max line number


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
> 
> This too, just open-code this function in the two places it's used.
> 
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
> 
> . . .
> 
> > +	udelay(5);
> > +
> > +	spacemit_sdhci_setbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
> > +}
> > +
> 
> I don't feel as strongly about this, but...
> 
> Here too, what the next function does is very typical and all
> of it could go in the probe function.  I do understand that it
> groups the clock-related code though.
> 
I would like to keep it as is if possible, or if other maintainer has objection?

the motivation here is breaking the logic into more small parts, then 
people review probe() can move more quickly, and if want to further audit
clock (maybe reset - plan to group them together), then can do it separately

> But aside from that, I think assigning pltfm_host->clock could
> be done in the probe function rather than hiding it in here.
> 
I'd consider all clock related, so reasonable to put them together

in another perspective, introducing spacemit_sdhci_host which only 
contain clk_core, clk_io sounds not necessary in current stage as they
are not used in later functions, but will eventually do when implement
suspend/resume functionality.

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
> 
> I think you should make the next structure be used as platform
> data for "spacemit,k1-sdhci", rather than just a global.  That
> way you could conceivably use the same driver with slightly
> different (or even the same) quirks for future hardware.
> 
I'm not sure if we should do it now, or postpone later in future
 when we really come to it (lazy implementation).

As I have no idea of how future hardware is, they may change to 
use another IP.

> 					-Alex
> 
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
> > +. . .

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
