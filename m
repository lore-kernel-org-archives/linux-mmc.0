Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FCAC4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Dec 2022 14:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiL2ODU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Dec 2022 09:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiL2ODT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2022 09:03:19 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53153E0F1
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 06:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672322598; x=1703858598;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Nhdqj21r+UZ6XMS1z2hRzIkPAHCjpkvPwsiJb7p3bh0=;
  b=cYtR6sDSTj+UjMVVIxHGThJfDl8Ioj9ZQOWSPdk3YCtUd0ThlqR8KAU9
   MmHNkihZuGKI892JsoEwEe7uNnUtdGxmsNuJ/QB0zyI3wSkE3bqJ106A5
   EAnFvUGmmWyx/iXAenF7Cp6hgTvhwqJHAMCFfOyk3bDpEv0c4ez9p+jPG
   t+dZDOIP4FvPXNVHHqo4GzUqa6jwkuOd1HQhSPd10jgSqhMUP0DNHGDAo
   uTRj52iH/b6WtuH4lBEywD9sxafSV2a37YnWZUt/jXeGF2pCbuW28SFx4
   /CCTZC+/IJSG4Hq0rTd9XcFL+arbRU0sNzT0Mfpxj9H5SeP/5CgAr0gpF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="407309832"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="407309832"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 06:03:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="722070483"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="722070483"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.63.128])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 06:03:08 -0800
Message-ID: <40d51976-a670-aa7b-dd2b-7528e31c8f28@intel.com>
Date:   Thu, 29 Dec 2022 16:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] mmc: sdhci-esdhc-imx: simplify the auto tuning
 logic
Content-Language: en-US
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        kgroeneveld@lenbrook.com
References: <20221223025022.1893102-1-haibo.chen@nxp.com>
 <20221223025022.1893102-2-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221223025022.1893102-2-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/12/22 04:50, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Clear auto tuning bit when reset tuning, and enable auto tuning
> only after tuning done successfully for both standard tuning and
> manual tuning.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 89ef0c80ac37..bf8d6f60a9ee 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -429,9 +429,10 @@ static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
>  }
>  
>  /* Enable the auto tuning circuit to check the CMD line and BUS line */
> -static inline void usdhc_auto_tuning_mode_sel(struct sdhci_host *host)
> +static inline void usdhc_auto_tuning_mode_sel_and_en(struct sdhci_host *host)
>  {
>  	u32 buswidth, auto_tune_buswidth;
> +	u32 reg;
>  
>  	buswidth = USDHC_GET_BUSWIDTH(readl(host->ioaddr + SDHCI_HOST_CONTROL));
>  
> @@ -450,6 +451,10 @@ static inline void usdhc_auto_tuning_mode_sel(struct sdhci_host *host)
>  	esdhc_clrset_le(host, ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK,
>  			auto_tune_buswidth | ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN,
>  			ESDHC_VEND_SPEC2);
> +
> +	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
> +	reg |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
> +	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
>  }
>  
>  static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
> @@ -681,14 +686,11 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  			} else {
>  				v &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
>  				m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
> -				m &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
>  			}
>  
>  			if (val & SDHCI_CTRL_EXEC_TUNING) {
>  				v |= ESDHC_MIX_CTRL_EXE_TUNE;
>  				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
> -				m |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
> -				usdhc_auto_tuning_mode_sel(host);
>  			} else {
>  				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
>  			}
> @@ -1022,13 +1024,15 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>  
>  	/* Reset the tuning circuit */
>  	if (esdhc_is_usdhc(imx_data)) {
> +		ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
> +		ctrl &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
>  		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
> -			ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
>  			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
>  			ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
>  			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
>  			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
>  		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
> +			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
>  			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
>  			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
>  			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
> @@ -1054,6 +1058,7 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>  static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> +	int err;
>  
>  	/*
>  	 * i.MX uSDHC internally already uses a fixed optimized timing for
> @@ -1068,7 +1073,12 @@ static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	 * correct delay cell.
>  	 */
>  	esdhc_reset_tuning(host);
> -	return sdhci_execute_tuning(mmc, opcode);
> +	err = sdhci_execute_tuning(mmc, opcode);
> +	/* If tuning done, enable auto tuning */
> +	if (!err && !host->tuning_err)
> +		usdhc_auto_tuning_mode_sel_and_en(host);
> +
> +	return err;
>  }
>  
>  static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
> @@ -1102,11 +1112,8 @@ static void esdhc_post_tuning(struct sdhci_host *host)
>  {
>  	u32 reg;
>  
> -	usdhc_auto_tuning_mode_sel(host);
> -
>  	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
>  	reg &= ~ESDHC_MIX_CTRL_EXE_TUNE;
> -	reg |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
>  	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
>  }
>  

