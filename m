Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA031E85D
	for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303946; cv=none; b=gHqcF2+ZYQ0zU37kVB4puEQZSLkgHYztf8LsdqvDCsQkbX8ZGrPQ+0RwVQsu5UGNRS4M8JTpkvY8cgcqZiuTKnGxgTCztJbZTmV2yK4WX/DSJCjctnsDspiUKOanfJd7TpJjaRfft5xPzSrHInOCl2UjUVxrtylRussprUcxD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303946; c=relaxed/simple;
	bh=vnRu6vWD78N60rmDnoZwLuo68Xv+9s+jaEJcvby4VB0=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jCvdxT0jcvaOxswmDRwhx+eHEDssoa6E26mTs06zM4+mX0KDNOM2sXolXW2huPlHh5ng610SW4qMImdvu9TC1TalcW0vTaRzL2mHj4NXrDX1uXw3hbxE9rHOOY/dAJZ/NDMuNdLJD06JBQ86GVJ4dqPoz8mz/sQzT9WMeMBBrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X3zjgDwu; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X3zjgDwu"
Cc: shawn.lin@linux.dev, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773303933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39BcTAaJ+jylhom4CUL/jgYMjjcnba9v/HZTLJ0EBVU=;
	b=X3zjgDwu4uVUF2g6i1ttoHCszzzHOunMstKax0qJ4jNzZozGEsFVSn5Wc1Vv4qrVIUP4iU
	1sUWgb6of90zrtx5pliiwkxo89ZJgycFo+F5OmJwqlVabXrcdAYjA+pEnOtywn3rjRd+ds
	6kIUlgWpm7QegLCHyM8crXopiwPy85o=
Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
To: nick.hawkins@hpe.com, ulf.hansson@linaro.org, adrian.hunter@intel.com,
 jszhang@kernel.org
References: <20260311181112.1700667-1-nick.hawkins@hpe.com>
 <20260311181112.1700667-3-nick.hawkins@hpe.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shawn Lin <shawn.lin@linux.dev>
Message-ID: <c4271da0-87c9-d7c2-db46-e7ed7f5e4fdf@linux.dev>
Date: Thu, 12 Mar 2026 16:25:22 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260311181112.1700667-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/03/12 星期四 2:11, nick.hawkins@hpe.com 写道:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add support for the eMMC controller integrated in the HPE GSC (ARM64
> Cortex-A53) BMC SoC under the new 'hpe,gsc-dwcmshc' compatible
> string.
> 
> The HPE GSC eMMC controller is based on the DesignWare Cores MSHC IP
> but requires several platform-specific adjustments:
> 
> Clock mux (dwcmshc_hpe_set_clock):
>    The GSC SoC wires SDHCI_CLOCK_CONTROL.freq_sel directly to a clock
>    mux rather than a divider.  Forcing freq_sel = 1 when the requested
>    clock is 200 MHz (HS200) selects the correct high-speed clock source.
>    Using the generic sdhci_set_clock() would otherwise leave the mux on
>    the wrong source after tuning.
> 
> Auto-tuning / vendor config (dwcmshc_hpe_vendor_specific):
>    Disables the command-conflict check (DWCMSHC_HOST_CTRL3 BIT(0)) and
>    programs the ATCTRL register using existing AT_CTRL_* macros:
>      AT_CTRL_AT_EN           auto-tuning circuit enable
>      AT_CTRL_SWIN_TH_EN      sampling window threshold enable
>      AT_CTRL_TUNE_CLK_STOP_EN tune-clock-stop enable
>      PRE_CHANGE_DLY  = 3     pre-change delay
>      POST_CHANGE_DLY = 3     post-change delay
>      SWIN_TH_VAL    = 2      sampling window threshold
>    This combination is required for reliable HS200 signal integrity on
>    the GSC PCB trace topology.
> 
> Reset (dwcmshc_hpe_reset):
>    Calls sdhci_reset(), re-applies the vendor config above, and then
>    sets DWCMSHC_CARD_IS_EMMC unconditionally.  The GSC controller
>    clears this bit on every reset; leaving it clear causes card-detect
>    mis-identification on an eMMC-only slot.
> 
> UHS signaling (dwcmshc_hpe_set_uhs_signaling):
>    Wraps dwcmshc_set_uhs_signaling() and unconditionally sets
>    CARD_IS_EMMC for all timing modes, not just HS400.
> 
> Init (dwcmshc_hpe_gsc_init):
>    Obtains the SoC register block via the 'hpe,gxp-sysreg' syscon
>    phandle and sets SCGSyncDis (BIT(18)) in MSHCCS (offset 0x110)
>    to allow the HS200 RX delay lines to settle while the card clock
>    is stopped during auto-tuning.  Enables SDHCI v4 mode.
> 
> Quirks:
>    SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN:  base clock not advertised in
>      capabilities; must be obtained from the DTS 'clocks' property.
>    SDHCI_QUIRK2_PRESET_VALUE_BROKEN:  preset-value registers are not
>      populated in the GSC ROM.
> 
> All HPE-specific code is isolated to the new hpe_gsc_init / hpe_ops /
> hpe_gsc_pdata symbols.  No existing platform (Rockchip, T-Head, sg2042,
> etc.) is affected.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>   drivers/mmc/host/sdhci-of-dwcmshc.c | 149 ++++++++++++++++++++++++++++
>   1 file changed, 149 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 2b75a36c096b..46662071cc61 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -1245,6 +1245,132 @@ static int sg2042_init(struct device *dev, struct sdhci_host *host,
>   					     ARRAY_SIZE(clk_ids), clk_ids);
>   }
>   
> +/* HPE GSC-specific vendor configuration: disable command conflict check
> + * and program Auto-Tuning Control register.
> + */
> +static void dwcmshc_hpe_vendor_specific(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 atctrl;
> +	u8 extra;
> +
> +	extra = sdhci_readb(host, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
> +	extra &= ~BIT(0);
> +	sdhci_writeb(host, extra, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
> +
> +	atctrl = AT_CTRL_AT_EN | AT_CTRL_SWIN_TH_EN | AT_CTRL_TUNE_CLK_STOP_EN |
> +		FIELD_PREP(AT_CTRL_PRE_CHANGE_DLY_MASK, 3) |
> +		FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK, AT_CTRL_POST_CHANGE_DLY) |
> +		FIELD_PREP(AT_CTRL_SWIN_TH_VAL_MASK, 2);
> +	sdhci_writel(host, atctrl, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +}
> +
> +static void dwcmshc_hpe_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	u16 ctrl;
> +
> +	dwcmshc_reset(host, mask);
> +
> +	dwcmshc_hpe_vendor_specific(host);
> +
> +	/* HPE GSC eMMC always needs CARD_IS_EMMC set after reset */
> +	ctrl = sdhci_readw(host, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +	ctrl |= DWCMSHC_CARD_IS_EMMC;
> +	sdhci_writew(host, ctrl, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +}
> +
> +static void dwcmshc_hpe_set_uhs_signaling(struct sdhci_host *host,
> +					  unsigned int timing)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u16 ctrl;
> +
> +	dwcmshc_set_uhs_signaling(host, timing);
> +
> +	/* HPE GSC: always set CARD_IS_EMMC for all timing modes */
> +	ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +	ctrl |= DWCMSHC_CARD_IS_EMMC;
> +	sdhci_writew(host, ctrl, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +}
> +
> +/*
> + * HPE GSC eMMC controller clock setup.
> + *
> + * The GSC SoC wires the freq_sel field of SDHCI_CLOCK_CONTROL directly to a
> + * clock mux rather than a divider. Force freq_sel = 1 when running at
> + * 200 MHz (HS200) so the mux selects the correct clock source.
> + */
> +static void dwcmshc_hpe_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u16 clk;
> +
> +	host->mmc->actual_clock = 0;
> +
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +	if (clock == 0)
> +		return;
> +
> +	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> +
> +	if (host->mmc->actual_clock == 200000000)
> +		clk |= (1 << SDHCI_DIVIDER_SHIFT);
> +
> +	sdhci_enable_clk(host, clk);
> +}
> +
> +/*
> + * HPE GSC eMMC controller init.
> + *
> + * The GSC SoC requires configuring MSHCCS.  Bit 18 (SCGSyncDis) disables clock
> + * synchronisation for phase-select values going to the HS200 RX delay lines,
> + * allowing the card clock to be stopped while the delay selection settles and
> + * the phase shift is applied.  This must be used together with the ATCTRL
> + * settings programmed in dwcmshc_hpe_vendor_specific():
> + *   AT_CTRL_R.TUNE_CLK_STOP_EN  = 0x1
> + *   AT_CTRL_R.POST_CHANGE_DLY   = 0x3
> + *   AT_CTRL_R.PRE_CHANGE_DLY    = 0x3
> + *
> + * The DTS node provides a syscon phandle ('hpe,gxp-sysreg') to access
> + * this register at offset 0x110 within the SoC control block.
> + */
> +#define HPE_GSC_MSHCCS_OFFSET		0x110
> +#define HPE_GSC_MSHCCS_SCGSYNCDIS	BIT(18)
> +

I guess you should move these macros to the beginning of this c file.

> +static int dwcmshc_hpe_gsc_init(struct device *dev, struct sdhci_host *host,
> +				struct dwcmshc_priv *dwc_priv)
> +{
> +	struct regmap *soc_ctrl;
> +	int ret;
> +
> +	/* Disable cmd conflict check and configure auto-tuning */
> +	dwcmshc_hpe_vendor_specific(host);
> +
> +	/* Look up the GXP sysreg syscon for MSHCCS access */
> +	soc_ctrl = syscon_regmap_lookup_by_phandle(dev->of_node, "hpe,gxp-sysreg");
> +	if (IS_ERR(soc_ctrl)) {
> +		dev_err(dev, "failed to get hpe,gxp-sysreg syscon\n");
> +		return PTR_ERR(soc_ctrl);
> +	}
> +
> +	/* Set SCGSyncDis (bit 18) to disable sync on HS200 RX delay lines */
> +	ret = regmap_update_bits(soc_ctrl, HPE_GSC_MSHCCS_OFFSET,
> +				HPE_GSC_MSHCCS_SCGSYNCDIS,
> +				HPE_GSC_MSHCCS_SCGSYNCDIS);
> +	if (ret) {
> +		dev_err(dev, "failed to set SCGSyncDis in MSHCCS\n");
> +		return ret;
> +	}
> +
> +	sdhci_enable_v4_mode(host);

Sorry, I overlooked this part when in v2. But we enable it in
dwcmshc_probe() based on the capabilities, isn't it? Unless your
hardware didn't set SDHCI_CAN_64BIT_V4 but actually it does support
it? Then it perhaps should be a quirk, although we in general would like
to avoid more quirks... It depends on Adrian.

Btw, unlated to your patch, but th1520 did it the same way... Hmm

> +
> +	return 0;
> +}
> +
>   static void sdhci_eic7700_set_clock(struct sdhci_host *host, unsigned int clock)
>   {
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1834,6 +1960,25 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_eic7700_pdata = {
>   	.init = eic7700_init,
>   };
>   
> +static const struct sdhci_ops sdhci_dwcmshc_hpe_ops = {
> +	.set_clock		= dwcmshc_hpe_set_clock,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.set_uhs_signaling	= dwcmshc_hpe_set_uhs_signaling,
> +	.get_max_clock		= dwcmshc_get_max_clock,
> +	.reset			= dwcmshc_hpe_reset,
> +	.adma_write_desc	= dwcmshc_adma_write_desc,
> +	.irq			= dwcmshc_cqe_irq_handler,
> +};
> +
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_hpe_gsc_pdata = {
> +	.pdata = {
> +		.ops = &sdhci_dwcmshc_hpe_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	},
> +	.init = dwcmshc_hpe_gsc_init,
> +};
> +
>   static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
>   	.enable		= dwcmshc_sdhci_cqe_enable,
>   	.disable	= sdhci_cqe_disable,
> @@ -1942,6 +2087,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>   		.compatible = "eswin,eic7700-dwcmshc",
>   		.data = &sdhci_dwcmshc_eic7700_pdata,
>   	},
> +	{
> +		.compatible = "hpe,gsc-dwcmshc",
> +		.data = &sdhci_dwcmshc_hpe_gsc_pdata,
> +	},
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
> 
