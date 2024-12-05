Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35881DF745
	for <linux-mmc@vger.kernel.org>; Thu,  5 Dec 2024 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404627; cv=none; b=S/JbL4Q7PbZeluyee0V9Gg61f7CXXqzOlm15i7FAx7E+jXtugFKOm++ejy5dzUa57u/aI0+MZuDmn3bCA4+PD5SB6Wijy9Wn1/r8PRQUTyWqYJB6p9UVsTF1QHkyICpw+Umf5n/8X/nXyBvdrhN1sfr975gkNSahsw26ib60RdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404627; c=relaxed/simple;
	bh=rO7bFJ1YKRkoa48qZM0Zr6uA2Ubqy/NEK/icvlD5L0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9ugoHXc4w5Qmhm80qoq8y+ky7Jdg57roc4aG6CFB/eb81XAad9/NfGIm14mvA7Ab6X9prBXFAUaRaN6ndFmj2npPhk3dp8wnAw4DoaNCMkYSt8k4QKhEgYbu4VmZKorx8VDiKslff9p9cGuuCVv9hMrO+BjqKNDn4qNwQc3umw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GcFRQWIG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GcFRQWIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733404625; x=1764940625;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rO7bFJ1YKRkoa48qZM0Zr6uA2Ubqy/NEK/icvlD5L0s=;
  b=GcFRQWIGZurUQBS4+kk8Aa5fRQzucNrcLaThrNUnDV94c6RsofHhztle
   WI/QldOp2bwphqRTH7VPU6yG7baVvTAZMzpbBHvQ5BmTOI0kI4upWgRfo
   T65PLUajgvG5JqZG3K/zc7323YaUJSQLte4ZcSQZwi6lSbk1iO/syJ9hK
   TSyEacWJQoWBqa51wd/KLOYQ6lmKWxnMA5T+7LsIDCbDVQvZxe7Yi/iQA
   iKX3B7mrFIba28CdJ+dHzvuJOmi7RpQs8VMje7QbI3v72lSlqk1QCxdZr
   VY+hWLu6nnFHYcEWRrggFRgsjyp5QPhwTfg21ef0XUiXA3jWXG7V+lLQr
   A==;
X-CSE-ConnectionGUID: rcn70xcOR4eMMtGST8XspQ==
X-CSE-MsgGUID: GDhhG1PbTTSMHyZOYDOuUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44321136"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="44321136"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 05:17:05 -0800
X-CSE-ConnectionGUID: N96mNVkkQ7mgP6ZpkMMhsA==
X-CSE-MsgGUID: PZwfAt6jSKe6eoVPTEFBZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="94533712"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 05:17:04 -0800
Message-ID: <36d8b897-e8d0-4262-b60b-a5510e93c6ff@intel.com>
Date: Thu, 5 Dec 2024 15:16:56 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of_dwcmshc: Change to dwcmshc_phy_init for
 reusing codes
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org
References: <CGME20241204100508epcas1p2cc54ed287df5a361536b68971bca48f6@epcas1p2.samsung.com>
 <20241204100507.330025-1-jh80.chung@samsung.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241204100507.330025-1-jh80.chung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/24 12:05, Jaehoon Chung wrote:
> dwcmshc_phy_1_8v_init and dwcmshc_phy_3_3v_init differ only by a few
> lines of code. This allow us to reuse code depending on voltage.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 69 +++++------------------------
>  1 file changed, 12 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 7ea3da45db32..87bc32d13cc0 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -328,11 +328,15 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	sdhci_request(mmc, mrq);
>  }
>  
> -static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
> +static void dwcmshc_phy_init(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>  	u32 val;
> +	u32 rxsel = PHY_PAD_RXSEL_3V3;

Nicer to order local variables by descending line length when
possible i.e.

	u32 rxsel = PHY_PAD_RXSEL_3V3;
	u32 val;

> +
> +	if (host->flags & SDHCI_SIGNALING_180 || priv->flags & FLAG_IO_FIXED_1V8)

'host->flags & SDHCI_SIGNALING_180' only means 1.8V signaling
is supported, so this looks strange. Can you clarify this?

> +		rxsel = PHY_PAD_RXSEL_1V8;
>  
>  	/* deassert phy reset & set tx drive strength */
>  	val = PHY_CNFG_RSTN_DEASSERT;
> @@ -353,7 +357,7 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
>  	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
>  
>  	/* configure phy pads */
> -	val = PHY_PAD_RXSEL_1V8;
> +	val = rxsel;
>  	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> @@ -365,65 +369,20 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
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
> +	if (host->flags & SDHCI_SIGNALING_180 || priv->flags & FLAG_IO_FIXED_1V8)
> +		sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK,
> +					PHY_DLLDL_CNFG_SLV_INPSEL), PHY_DLLDL_CNFG_R);

Perhaps slightly more readable to use a variable e.g.

	/* enable data strobe mode */
	if (???) {
		u8 sel = FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL);

		sdhci_writeb(host, sel, PHY_DLLDL_CNFG_R);
	}

>  
>  	/* enable phy dll */
>  	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
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
> -
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
>  
> -	/* enable phy dll */
> -	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
>  }
>  
>  static void th1520_sdhci_set_phy(struct sdhci_host *host)
> @@ -433,11 +392,7 @@ static void th1520_sdhci_set_phy(struct sdhci_host *host)
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
> @@ -1163,7 +1118,7 @@ static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
>  	.get_max_clock		= dwcmshc_get_max_clock,
>  	.reset			= th1520_sdhci_reset,
>  	.adma_write_desc	= dwcmshc_adma_write_desc,
> -	.voltage_switch		= dwcmshc_phy_1_8v_init,
> +	.voltage_switch		= dwcmshc_phy_init,
>  	.platform_execute_tuning = th1520_execute_tuning,
>  };
>  

