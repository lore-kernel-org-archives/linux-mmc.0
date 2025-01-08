Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD951FCF55
	for <linux-mmc@vger.kernel.org>; Wed,  8 Jan 2025 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344346; cv=none; b=EZTYnpsISuvNWibTJgqVtS6lO1WZFdMs201gjdhVw4G97nQ4nCCVhKSecxtbhJRWh56F9nQmLmat1sPq5NFx2FPVwxoCd2ch3kurHeWDAtwEOi6nPI8+d703JBVPLIdRIcEdi4+RCF/MnLh/A3pPQRtn3uf4De+EyKyeRz1STuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344346; c=relaxed/simple;
	bh=J8jO6jNeUcGko2FuKznI2n/fGGWiIjL3JA2Jba2Myjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wa//MWSECwwxPJWNhcTXlR4QmaKKFgrMedFoXjoiBs2HCc3Vb6kpPgwvW9K2fha5G+9hDezplGRzHNlj1XIFdxINtoahTQ8C+mcakpihPpZPMEZHQIaE60qEqlDKtLEzxbmwQ+vJj8d4QUBQ3YPhXxS8Epo1uuCOLlQ9sDbW3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7P23tRt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7P23tRt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736344344; x=1767880344;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J8jO6jNeUcGko2FuKznI2n/fGGWiIjL3JA2Jba2Myjs=;
  b=M7P23tRt6mJEWAHe9kYG+OZ+pnv/XPbI9dba7RSwKF5jflxONOpQNEDI
   IFwxOUirRQjSHBhNa130C5wwS/oqGjZhMAdzJqvrRSPpZu/ZIdonuR5T/
   L0u/4wT23+Pn5uErbuvJZ7GcFMAqpnjM4fP6ABtYhmgMvZTvBxrcHpbf+
   c5kVBzEhNInHotbBg5XmUtvPvev5PV47qtN3muuqLX0lOsP/6YZJ0fZJh
   xxARrj45f1hL+YHtrF9TTMHm46uSu1gzRMGnuG/6Eo7iflPGNekZ0B0P/
   bhEOYpRGRJS+1hRDueIOoF1JkJRIijKUfkx1D7miLp8/GMP6W8TnlZDUP
   Q==;
X-CSE-ConnectionGUID: 4eB57L6xQ5GuHjr5x5wZQw==
X-CSE-MsgGUID: h2wYjnoDSd+eZ58QHi25UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36453839"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="36453839"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 05:52:24 -0800
X-CSE-ConnectionGUID: i9TBb6MlT2ObL9r7l6oUEQ==
X-CSE-MsgGUID: bKkfujIvQQKG+7VTb9QfNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="103325076"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 05:52:21 -0800
Message-ID: <9e244402-7e1a-4799-a159-b940547b4085@intel.com>
Date: Wed, 8 Jan 2025 15:52:13 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mmc: sdhci-of_dwcmshc: Change to dwcmshc_phy_init for
 reusing codes
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org
References: <CGME20241216105129epcas1p4f1ffe80586e9f7d4e4b5f7653dfde883@epcas1p4.samsung.com>
 <20241216105127.2180403-1-jh80.chung@samsung.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241216105127.2180403-1-jh80.chung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/12/24 12:51, Jaehoon Chung wrote:
> dwcmshc_phy_1_8v_init and dwcmshc_phy_3_3v_init differ only by a few
> lines of code. This allow us to reuse code depending on voltage.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
> Changelog V2:
> - Add more conditions to clarify if it's MMC_SIGNAL_VOLTAGE_180
> - Order the local variable according to Adrian's comment
> - Use local variable to make more readable
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 75 +++++++----------------------
>  1 file changed, 18 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 7ea3da45db32..08a9b963fb1a 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -328,12 +328,18 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	sdhci_request(mmc, mrq);
>  }
>  
> -static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
> +static void dwcmshc_phy_init(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 rxsel = PHY_PAD_RXSEL_3V3;
>  	u32 val;
>  
> +	if (priv->flags & FLAG_IO_FIXED_1V8 ||
> +		(host->mmc->ios.timing & MMC_SIGNAL_VOLTAGE_180 &&
> +		 host->flags & SDHCI_SIGNALING_180))

Thanks for making the changes.  It looks like
"&& host->flags & SDHCI_SIGNALING_180" is not needed

> +		rxsel = PHY_PAD_RXSEL_1V8;
> +
>  	/* deassert phy reset & set tx drive strength */
>  	val = PHY_CNFG_RSTN_DEASSERT;
>  	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
> @@ -353,7 +359,7 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
>  	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
>  
>  	/* configure phy pads */
> -	val = PHY_PAD_RXSEL_1V8;
> +	val = rxsel;
>  	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> @@ -365,65 +371,24 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
>  	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
>  
> -	val = PHY_PAD_RXSEL_1V8;
> +	val = rxsel;
>  	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
>  	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
>  
>  	/* enable data strobe mode */
> -	sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL),
> -		     PHY_DLLDL_CNFG_R);
> -
> -	/* enable phy dll */
> -	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> -}
> -
> -static void dwcmshc_phy_3_3v_init(struct sdhci_host *host)
> -{
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	u32 val;
> -
> -	/* deassert phy reset & set tx drive strength */
> -	val = PHY_CNFG_RSTN_DEASSERT;
> -	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
> -	val |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN);
> -	sdhci_writel(host, val, PHY_CNFG_R);
> -
> -	/* disable delay line */
> -	sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
> -
> -	/* set delay line */
> -	sdhci_writeb(host, priv->delay_line, PHY_SDCLKDL_DC_R);
> -	sdhci_writeb(host, PHY_DLL_CNFG2_JUMPSTEP, PHY_DLL_CNFG2_R);
> -
> -	/* enable delay lane */
> -	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
> -	val &= ~(PHY_SDCLKDL_CNFG_UPDATE);
> -	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> +	if (priv->flags & FLAG_IO_FIXED_1V8 ||
> +		(host->mmc->ios.timing & MMC_SIGNAL_VOLTAGE_180 &&
> +		 host->flags & SDHCI_SIGNALING_180)) {

Probably neater to check rxsel e.g.

	if (rxcel == PHY_PAD_RXSEL_1V8) {

> +		u8 sel = FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL);
>  
> -	/* configure phy pads */
> -	val = PHY_PAD_RXSEL_3V3;
> -	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> -	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> -	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> -	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> -
> -	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> -	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> -
> -	val = PHY_PAD_RXSEL_3V3;
> -	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> -	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> +		sdhci_writeb(host, sel, PHY_DLLDL_CNFG_R);
> +	}
>  
>  	/* enable phy dll */
>  	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> +
>  }
>  
>  static void th1520_sdhci_set_phy(struct sdhci_host *host)
> @@ -433,11 +398,7 @@ static void th1520_sdhci_set_phy(struct sdhci_host *host)
>  	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
>  	u16 emmc_ctrl;
>  
> -	/* Before power on, set PHY configs */
> -	if (priv->flags & FLAG_IO_FIXED_1V8)
> -		dwcmshc_phy_1_8v_init(host);
> -	else
> -		dwcmshc_phy_3_3v_init(host);
> +	dwcmshc_phy_init(host);
>  
>  	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
>  		emmc_ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> @@ -1163,7 +1124,7 @@ static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
>  	.get_max_clock		= dwcmshc_get_max_clock,
>  	.reset			= th1520_sdhci_reset,
>  	.adma_write_desc	= dwcmshc_adma_write_desc,
> -	.voltage_switch		= dwcmshc_phy_1_8v_init,
> +	.voltage_switch		= dwcmshc_phy_init,
>  	.platform_execute_tuning = th1520_execute_tuning,
>  };
>  

