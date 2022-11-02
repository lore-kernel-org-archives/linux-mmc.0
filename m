Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B10C4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Nov 2022 10:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiKBKhq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Nov 2022 06:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiKBKhN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2022 06:37:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776EF28E39
        for <linux-mmc@vger.kernel.org>; Wed,  2 Nov 2022 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667385415; x=1698921415;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3dbFdJPDNyBd8IJXS8ejoaT84uIFGJZvStH8eSnp2sk=;
  b=D6XQqNKxH9WZnKjPqWn4DJghJeMOs0iiU1zFtgq9T52yBHih8RPxt4bB
   IYP0Xf11jZcyDy0OG4EBGSUOBFcSG2ez2ZEp7olJ+SebspMB4SSuWd8+4
   yLvVItL1yrfYZYaBOy3ZordFoJ5M/oOcCmqlIZjrQeKRZLzvRWyxqLZue
   CKoolfDE19xz8E5rdhWdtWO3Kyv61hHQXWIjVL5Tnfa8q7Mr7+Pp9zqPg
   OLhWkIWpcyO2xQ8N8XroaWa60jBVEhcheBwQKoojfXabnV0nVn4bv3TiQ
   QaJGEcjjHbMIV8wqyVcgwqH/dIdppxQ0MKnoiy0vCRVvzkvG6qVR5Ykjf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395679865"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="395679865"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 03:36:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="809233598"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="809233598"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.47.170])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 03:36:52 -0700
Message-ID: <04db7720-c13c-2a32-c0ea-a8e72052807c@intel.com>
Date:   Wed, 2 Nov 2022 12:16:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: reset the tuning logic before
 execute tuning
Content-Language: en-US
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, sherry.sun@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
References: <1666947869-7904-1-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1666947869-7904-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 28/10/22 12:04, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> For standard tuning method on usdhc, the previous tuning result can
> impact current tuning result, let current tuning can't set the correct
> delay cell. And from the logic, this is also reasonable for manual
> tuning method. So reset the tuning logic before execute tuning.
> To avoid compile issue, this patch also move the esdhc_reset_tuning()
> upper.
> 
> Find this issue when support SDIO WiFi in band wakeup feature. After
> system resume back, will do re-tuning, but then meet data CRC error.
> 
> Do not meet this issue on SD/eMMC, because we already call
> esdhc_reset_tuning() when config the legency ios, and SD/eMMC need
> to re-init when system resume back, but SDIO device don't do re-init
> if it has MMC_PM_KEEP_POWER pm_flags.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 82 ++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index b073e79dcd99..4559599d897d 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1012,6 +1012,44 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
>  			SDHCI_HOST_CONTROL);
>  }
>  
> +static void esdhc_reset_tuning(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +	u32 ctrl;
> +	int ret;
> +
> +	/* Reset the tuning circuit */
> +	if (esdhc_is_usdhc(imx_data)) {
> +		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
> +			ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
> +			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> +			ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
> +			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
> +			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> +		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
> +			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
> +			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> +			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
> +			writel(ctrl, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
> +			/* Make sure ESDHC_MIX_CTRL_EXE_TUNE cleared */
> +			ret = readl_poll_timeout(host->ioaddr + SDHCI_AUTO_CMD_STATUS,
> +				ctrl, !(ctrl & ESDHC_MIX_CTRL_EXE_TUNE), 1, 50);
> +			if (ret == -ETIMEDOUT)
> +				dev_warn(mmc_dev(host->mmc),
> +				 "Warning! clear execute tuning bit failed\n");
> +			/*
> +			 * SDHCI_INT_DATA_AVAIL is W1C bit, set this bit will clear the
> +			 * usdhc IP internal logic flag execute_tuning_with_clr_buf, which
> +			 * will finally make sure the normal data transfer logic correct.
> +			 */
> +			ctrl = readl(host->ioaddr + SDHCI_INT_STATUS);
> +			ctrl |= SDHCI_INT_DATA_AVAIL;
> +			writel(ctrl, host->ioaddr + SDHCI_INT_STATUS);
> +		}
> +	}
> +}
> +
>  static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> @@ -1023,6 +1061,12 @@ static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	if (host->timing == MMC_TIMING_UHS_DDR50)
>  		return 0;
>  
> +	/*
> +	 * Reset tuning circuit logic. If not, the previous tuning result
> +	 * will impact current tuning, make current tuning can't set the
> +	 * correct delay cell.
> +	 */
> +	esdhc_reset_tuning(host);
>  	return sdhci_execute_tuning(mmc, opcode);
>  }
>  
> @@ -1196,44 +1240,6 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
>  		"warning! HS400 strobe DLL status REF/SLV not lock in 50us, STROBE DLL status is %x!\n", v);
>  }
>  
> -static void esdhc_reset_tuning(struct sdhci_host *host)
> -{
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> -	u32 ctrl;
> -	int ret;
> -
> -	/* Reset the tuning circuit */
> -	if (esdhc_is_usdhc(imx_data)) {
> -		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
> -			ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
> -			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> -			ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
> -			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
> -			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> -		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
> -			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
> -			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> -			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
> -			writel(ctrl, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
> -			/* Make sure ESDHC_MIX_CTRL_EXE_TUNE cleared */
> -			ret = readl_poll_timeout(host->ioaddr + SDHCI_AUTO_CMD_STATUS,
> -				ctrl, !(ctrl & ESDHC_MIX_CTRL_EXE_TUNE), 1, 50);
> -			if (ret == -ETIMEDOUT)
> -				dev_warn(mmc_dev(host->mmc),
> -				 "Warning! clear execute tuning bit failed\n");
> -			/*
> -			 * SDHCI_INT_DATA_AVAIL is W1C bit, set this bit will clear the
> -			 * usdhc IP internal logic flag execute_tuning_with_clr_buf, which
> -			 * will finally make sure the normal data transfer logic correct.
> -			 */
> -			ctrl = readl(host->ioaddr + SDHCI_INT_STATUS);
> -			ctrl |= SDHCI_INT_DATA_AVAIL;
> -			writel(ctrl, host->ioaddr + SDHCI_INT_STATUS);
> -		}
> -	}
> -}
> -
>  static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  {
>  	u32 m;

