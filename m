Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADAAC4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Dec 2022 06:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiL2GoP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Dec 2022 01:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiL2GoO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2022 01:44:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2530CDFC6
        for <linux-mmc@vger.kernel.org>; Wed, 28 Dec 2022 22:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672296252; x=1703832252;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NSPLo87GXsgcOrJ+1xE7P/NCzS9yPwkds4WWyoVcLvk=;
  b=QOx++rXmsKskU+YTpqpxNPpiJiv/Y+51PLiB/7r+gYJMO6vsLlyCDybO
   JZSfVZvJvKx6/Bxbws+u+VTWQxMBxZ0Lu/tzAzLXN5DAVjrdjD121KsmX
   bBwOH0oovzNq80eDkH5qY35mqAapzk2jJVh75Ja4Q2BLC4Zx2rNoT6mV5
   0GvPwiSd1HxocfKi5AOAhecrUKkpGTxcR8JbjjA1oE+N6JcHeshLS+KP5
   kVPzLZNAf3YlY739qiO+o2gI46xcdOOAoqfZnhbYXah7TO4l20wPtFrlx
   ABvAtAdJy+6o3HogCC6L2iClK5w5aYcT10+wiOsTMI0cUtmjhzMsJAxMH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="318674474"
X-IronPort-AV: E=Sophos;i="5.96,283,1665471600"; 
   d="scan'208";a="318674474"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 22:44:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="742220869"
X-IronPort-AV: E=Sophos;i="5.96,283,1665471600"; 
   d="scan'208";a="742220869"
Received: from albuadri-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.63.128])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 22:44:08 -0800
Message-ID: <aa7b9a91-d237-dc30-5691-cd5443e290a9@intel.com>
Date:   Thu, 29 Dec 2022 08:44:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: correct the tuning start tap and
 step setting
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
References: <20221207112315.1812222-1-haibo.chen@nxp.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221207112315.1812222-1-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/12/22 13:23, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Current code logic may be impacted by the setting of ROM/Bootloader,
> so unmask these bits first, then setting these bits accordingly.
> 
> Fixes: 2b16cf326b70 ("mmc: sdhci-esdhc-imx: move tuning static configuration into hwinit function")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 89ef0c80ac37..9e73c34b6401 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -107,6 +107,7 @@
>  #define ESDHC_TUNING_START_TAP_DEFAULT	0x1
>  #define ESDHC_TUNING_START_TAP_MASK	0x7f
>  #define ESDHC_TUNING_CMD_CRC_CHECK_DISABLE	(1 << 7)
> +#define ESDHC_TUNING_STEP_DEFAULT	0x1
>  #define ESDHC_TUNING_STEP_MASK		0x00070000
>  #define ESDHC_TUNING_STEP_SHIFT		16
>  
> @@ -1368,7 +1369,7 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  	struct cqhci_host *cq_host = host->mmc->cqe_private;
> -	int tmp;
> +	u32 tmp;
>  
>  	if (esdhc_is_usdhc(imx_data)) {
>  		/*
> @@ -1423,17 +1424,24 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>  
>  		if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
>  			tmp = readl(host->ioaddr + ESDHC_TUNING_CTRL);
> -			tmp |= ESDHC_STD_TUNING_EN |
> -				ESDHC_TUNING_START_TAP_DEFAULT;
> -			if (imx_data->boarddata.tuning_start_tap) {
> -				tmp &= ~ESDHC_TUNING_START_TAP_MASK;
> +			tmp |= ESDHC_STD_TUNING_EN;
> +
> +			/*
> +			 * ROM code or bootloader may config the start tap
> +			 * and step, unmask them first.
> +			 */
> +			tmp &= ~(ESDHC_TUNING_START_TAP_MASK | ESDHC_TUNING_STEP_MASK);
> +			if (imx_data->boarddata.tuning_start_tap)
>  				tmp |= imx_data->boarddata.tuning_start_tap;
> -			}
> +			else
> +				tmp |= ESDHC_TUNING_START_TAP_DEFAULT;
>  
>  			if (imx_data->boarddata.tuning_step) {
> -				tmp &= ~ESDHC_TUNING_STEP_MASK;
>  				tmp |= imx_data->boarddata.tuning_step
>  					<< ESDHC_TUNING_STEP_SHIFT;
> +			} else {
> +				tmp |= ESDHC_TUNING_STEP_DEFAULT
> +					<< ESDHC_TUNING_STEP_SHIFT;
>  			}
>  
>  			/* Disable the CMD CRC check for tuning, if not, need to

