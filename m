Received: from mail-m49236.qiye.163.com (mail-m49236.qiye.163.com [45.254.49.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7527EFFA;
	Tue, 10 Mar 2026 01:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773105262; cv=none; b=RwWw5BwrxwKD68IMUpY+3UXlq7HxF3OHQbL6oigOfaEDlj8j6i7kIdDko9o+5+wWeTH2nnBt4ZsD2An85rfmewYTBtpoCP7oDAE/ULKTYI+iDc2dO8ObFXOdAm9UTnKNY2k8UHIEW+BO1EYuzWRq6nYsENoubWbMD8X08XBHu98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773105262; c=relaxed/simple;
	bh=DNu5WSfbz6xbewZa4m+rP+whA0xY8ez5SWbUNTzyJmw=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jkt7RqBBiHpFqpl/8LPngL/hn9z7rXpoDB5Yf02IPNFbJUZxyNVQjGsK8XiC9O+8BxHXLQ3ROrVp+pL1NXWSOedUtY+cdey/ixPPELNiXNbZ171fbrFSG/7YWrr+eN9mcwnXx5YTHqXFOwkAKtQ4/C3YPWjfOwR0FuMnwAnTwXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=aVmkvmRM; arc=none smtp.client-ip=45.254.49.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="aVmkvmRM"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3653428f3;
	Tue, 10 Mar 2026 09:14:06 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, jszhang@kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, adrian.hunter@intel.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
To: nick.hawkins@hpe.com
References: <20260309211333.977919-1-nick.hawkins@hpe.com>
 <20260309211333.977919-3-nick.hawkins@hpe.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <aa1bc496-fac3-b5c5-c311-2757526bdf1f@rock-chips.com>
Date: Tue, 10 Mar 2026 09:14:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260309211333.977919-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cd54ef29009cckunmcc6acaba35294
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh1PH1YZGR5KSU5CHhkeQ0lWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=aVmkvmRMpu9xqb7pXLcjD7X3PrA562g3u6lv5zNcq29RZcPE6aG2mXaE+h86cIyYl8fwzyOtKOmT5561N3hmua7y7U7lZUQ/VwYJYRNDg20JOLR7z67RjfvhcmD6sq0ngU7fNJxxSbglfR/EmbNp3XAq1PfcXJJ8aS0g8EMxn5k=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=+9qgFBPGECk47civsmqho0TjbRTPe3N87svA2DUCeKg=;
	h=date:mime-version:subject:message-id:from;


在 2026/03/10 星期二 5:13, nick.hawkins@hpe.com 写道:
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
>    programs ATCTRL = 0x021f0005:
>      BIT(0)       auto-tuning circuit enable
>      BIT(2)       centre-phase auto-tuning
>      BIT(16)      tune-clock-stop enable
>      BITS[18:17]  pre-change delay = 3
>      BITS[20:19]  post-change delay = 3
>      BIT(25)      sample-window threshold enable
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
>    Mirrors upstream dwcmshc_set_uhs_signaling() but always sets
>    CARD_IS_EMMC regardless of timing mode, for the same reason.
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
>   drivers/mmc/host/sdhci-of-dwcmshc.c | 173 ++++++++++++++++++++++++++++
>   1 file changed, 173 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 2b75a36c096b..78f5480f4662 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -1245,6 +1245,156 @@ static int sg2042_init(struct device *dev, struct sdhci_host *host,
>   					     ARRAY_SIZE(clk_ids), clk_ids);
>   }
>   
> +/*
> + * HPE GSC-specific vendor configuration: disable command conflict check
> + * and program Auto-Tuning Control register.
> + *
> + * ATCTRL value 0x021f0005 field breakdown:
> + *   BIT(0)      - Auto-tuning circuit enabled
> + *   BIT(2)      - Center-phase auto-tuning
> + *   BIT(16)     - Tune clock stop enable
> + *   BITS[18:17] - Pre-change delay = 3
> + *   BITS[20:19] - Post-change delay = 3
> + *   BIT(25)     - Sample window threshold enable
> + */
> +static void dwcmshc_hpe_vendor_specific(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	u8 extra;
> +
> +	extra = sdhci_readb(host, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
> +	extra &= ~BIT(0);
> +	sdhci_writeb(host, extra, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
> +	sdhci_writel(host, 0x021f0005, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);

Although you break it down in the comment, but it's still hard to read
and hard to change in the feature if needed. Would you consider defining
some macros and then OR-ing these macros together here?

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

This entire function is 99% copied from dwcmshc_set_uhs_signaling,
please wrap it like:

static void dwcmshc_hpe_set_uhs_signaling()
{
	dwcmshc_set_uhs_signaling();
	/* HPE GSC: always set CARD_IS_EMMC for all timing modes */
	ctrl = sdhci_readw(host, priv->vendor_specific_area1 + 
DWCMSHC_EMMC_CONTROL);
	ctrl |= DWCMSHC_CARD_IS_EMMC;
	sdhci_writew(host, ctrl, priv->vendor_specific_area1 + 
DWCMSHC_EMMC_CONTROL);
	
}

> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u16 ctrl, ctrl_2;
> +
> +	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
> +
> +	/* HPE GSC: always set CARD_IS_EMMC for all timing modes */
> +	ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +	ctrl |= DWCMSHC_CARD_IS_EMMC;
> +	sdhci_writew(host, ctrl, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +
> +	if ((timing == MMC_TIMING_MMC_HS200) ||
> +	    (timing == MMC_TIMING_UHS_SDR104))
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
> +	else if (timing == MMC_TIMING_UHS_SDR12)
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
> +	else if ((timing == MMC_TIMING_UHS_SDR25) ||
> +		 (timing == MMC_TIMING_MMC_HS))
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
> +	else if (timing == MMC_TIMING_UHS_SDR50)
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> +	else if ((timing == MMC_TIMING_UHS_DDR50) ||
> +		 (timing == MMC_TIMING_MMC_DDR52))
> +		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
> +	else if (timing == MMC_TIMING_MMC_HS400)
> +		ctrl_2 |= DWCMSHC_CTRL_HS400;
> +
> +	if (priv->flags & FLAG_IO_FIXED_1V8)
> +		ctrl_2 |= SDHCI_CTRL_VDD_180;
> +	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
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
> +
> +	return 0;
> +}
> +
>   static void sdhci_eic7700_set_clock(struct sdhci_host *host, unsigned int clock)
>   {
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1834,6 +1984,25 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_eic7700_pdata = {
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
> @@ -1942,6 +2111,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
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
