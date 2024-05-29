Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D34167DB1;
	Wed, 29 May 2024 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716979398; cv=none; b=jpGpDtHXdwEWVvh0GuoO6riQ8Wg7G1uNO46MMGHJ1TQm+RqGZg9CxT84aTpctHBJA8G+WANKLXavK90QXIkUvpm18p/bi5uJmQgPVC0SnCKFbvyaFDiWtPH51cj2saO/gx7jnYh+hIZOURxhl8YVEy1HSl1dxqmAEfGN7MWdhgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716979398; c=relaxed/simple;
	bh=/18Rr1BuD4kWhKQVl6DdLejQGgVZ9ZM88JF7ph1wrqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AMnkeZQ9Ku2RW9QExojglaDfsAnS+PC8Ew4x+ai3Oa0QmZ0r08kvJTN7XU2qETv3RR0drwwe2VV8BwDScCts0lne/zJL6wEtLu8P8bF6XaWsSQwZs20sHoRsYiPmBfl95ZdZGlAy7b3L9vExxgKp+coqIa5fQS0KCl0G6NjhA5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ieQ23uPE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ieQ23uPE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716979396; x=1748515396;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=/18Rr1BuD4kWhKQVl6DdLejQGgVZ9ZM88JF7ph1wrqE=;
  b=ieQ23uPE0qRF/dZkIHmjVwkeDebmBiXbwceOGLjcvh26yvnC2lnR2Vq2
   i2/5ysEgJ2y+HxkP4BnK+KLoUdt5ZAVh2vUKxd+bSZ2wghMqUt7gH0JHg
   nrM2sp54jNQ4zvT7WN6wG9DeFi3R6FSGSl2iuy6ryMZ/NuBrK00sOGD+K
   Xg2rrH+Vn/rosMpDfDEfh+Dqoml7jZ7mTMEVnfftkfabKsojvhO9MmpoZ
   R4cXMMtZJupX0yXPF4OElljzVJG46yD8M9Cf8gDHkOqCiAVODpg6z7Yp3
   ubyVHgMTVjSIMLDQxmfKL9qolKeqlzj2zPonG/enakW0KE4/rRhAvZXM0
   Q==;
X-CSE-ConnectionGUID: Rrc9TxFbREGFjYKefsdxwQ==
X-CSE-MsgGUID: QDaEdL/EQMKR5z3OZjCCow==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13146495"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13146495"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 03:43:15 -0700
X-CSE-ConnectionGUID: Wg6MD3WqT1WO2b6g+XjBoA==
X-CSE-MsgGUID: +OEB9qtaTcWKvSDjEzU1/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="40294235"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.248.18])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 03:43:12 -0700
Message-ID: <1c468f9b-587d-4f61-a129-7fc105476863@intel.com>
Date: Wed, 29 May 2024 12:25:53 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] mmc: sdhci-brcmstb: Add BCM2712 support
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Kamal Dasu <kamal.dasu@broadcom.com>,
 Al Cooper <alcooperx@gmail.com>, Stefan Wahren <wahrenst@gmx.net>,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <cover.1716899600.git.andrea.porta@suse.com>
 <4e8fc54e87447bae7db58636a1c87e5d8baeb012.1716899600.git.andrea.porta@suse.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <4e8fc54e87447bae7db58636a1c87e5d8baeb012.1716899600.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/05/24 16:32, Andrea della Porta wrote:
> Broadcom BCM2712 SoC has an SDHCI card controller using the SDIO CFG
> register block present on other STB chips. Add support for BCM2712
> SD capabilities of this chipset.
> The silicon is SD Express capable but this driver port does not currently
> include that feature yet.
> Based on downstream driver by raspberry foundation maintained kernel.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

One minor comment below, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


Also, unrelated to this patch, the driver has this code which looks
like it would have an issue if there were 2 devices of the same
type but only 1 had supports-cqe, because the ops would be shared
they would both try to use sdhci_brcmstb_cqhci_irq().

	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
		priv->flags |= BRCMSTB_PRIV_FLAGS_HAS_CQE;
		match_priv->ops->irq = sdhci_brcmstb_cqhci_irq;
	}

> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 60 ++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 9053526fa212..0d9c42d41376 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -30,6 +30,21 @@
>  
>  #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
>  
> +#define SDIO_CFG_CQ_CAPABILITY			0x4c
> +#define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
> +
> +#define SDIO_CFG_CTRL				0x0
> +#define SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
> +#define SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
> +
> +#define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
> +#define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
> +#define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
> +
> +#define MMC_CAP_HSE_MASK	(MMC_CAP2_HSX00_1_2V | MMC_CAP2_HSX00_1_8V)
> +/* Select all SD UHS type I SDR speed above 50MB/s */
> +#define MMC_CAP_UHS_I_SDR_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
> +
>  struct sdhci_brcmstb_priv {
>  	void __iomem *cfg_regs;
>  	unsigned int flags;
> @@ -38,6 +53,7 @@ struct sdhci_brcmstb_priv {
>  };
>  
>  struct brcmstb_match_priv {
> +	void (*cfginit)(struct sdhci_host *host);
>  	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
>  	struct sdhci_ops *ops;
>  	const unsigned int flags;
> @@ -168,6 +184,33 @@ static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
>  	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>  }
>  
> +static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *brcmstb_priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 reg, base_clk_mhz;

drivers/mmc/host/sdhci-brcmstb.c: In function ‘sdhci_brcmstb_cfginit_2712’:
drivers/mmc/host/sdhci-brcmstb.c:191:18: error: unused variable ‘base_clk_mhz’ [-Werror=unused-variable]
  191 |         u32 reg, base_clk_mhz;
      |                  ^~~~~~~~~~~~


> +
> +	/*
> +	 * If we support a speed that requires tuning,
> +	 * then select the delay line PHY as the clock source.
> +	 */
> +	if ((host->mmc->caps & MMC_CAP_UHS_I_SDR_MASK) || (host->mmc->caps2 & MMC_CAP_HSE_MASK)) {
> +		reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
> +		reg &= ~SDIO_CFG_MAX_50MHZ_MODE_ENABLE;
> +		reg |= SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE;
> +		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
> +	}
> +
> +	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
> +	    (host->mmc->caps & MMC_CAP_NEEDS_POLL)) {
> +		/* Force presence */
> +		reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
> +		reg &= ~SDIO_CFG_CTRL_SDCD_N_TEST_LEV;
> +		reg |= SDIO_CFG_CTRL_SDCD_N_TEST_EN;
> +		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
> +	}
> +}
> +
>  static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
>  {
>  	sdhci_dumpregs(mmc_priv(mmc));
> @@ -200,6 +243,14 @@ static struct sdhci_ops sdhci_brcmstb_ops = {
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>  
> +static struct sdhci_ops sdhci_brcmstb_ops_2712 = {
> +	.set_clock = sdhci_set_clock,
> +	.set_power = sdhci_set_power_and_bus_voltage,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_reset,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +};
> +
>  static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
>  	.set_clock = sdhci_brcmstb_set_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> @@ -214,6 +265,11 @@ static struct sdhci_ops sdhci_brcmstb_ops_74165b0 = {
>  	.set_uhs_signaling = sdhci_brcmstb_set_uhs_signaling,
>  };
>  
> +static const struct brcmstb_match_priv match_priv_2712 = {
> +	.cfginit = sdhci_brcmstb_cfginit_2712,
> +	.ops = &sdhci_brcmstb_ops_2712,
> +};
> +
>  static struct brcmstb_match_priv match_priv_7425 = {
>  	.flags = BRCMSTB_MATCH_FLAGS_NO_64BIT |
>  	BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
> @@ -238,6 +294,7 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
>  };
>  
>  static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
> +	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
>  	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
>  	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
>  	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
> @@ -370,6 +427,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	    (host->mmc->caps2 & MMC_CAP2_HS400_ES))
>  		host->mmc_host_ops.hs400_enhanced_strobe = match_priv->hs400es;
>  
> +	if (match_priv->cfginit)
> +		match_priv->cfginit(host);
> +
>  	/*
>  	 * Supply the existing CAPS, but clear the UHS modes. This
>  	 * will allow these modes to be specified by device tree

