Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101E5C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Dec 2022 14:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiL2ODc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Dec 2022 09:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiL2ODb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2022 09:03:31 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45013E0DF
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 06:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672322610; x=1703858610;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/qRqRnMerAIrO6RTOvxFbbrC4keTZQgBbkwR4m7C7CI=;
  b=Ro+llvUExql4jz2qWLEBCV0zzo0+AeQse+pEggbxiV2RB4HN4vPrJT5d
   nyZ6FweQmO9602l0LJqdEQSVPDYcT7mcs2k67gzQJ0ISMcxGRsDc7uZ28
   7WvgvQ8X5K9UH/LDwxDCa7G0afvDiprM8B6bkeEy5PrmHnCB9PYUyy3bi
   WVgqns//4LwJYnEKzisIcPYJTBzLLrkoas2Zrp6n7uj9+PLBZV3zDRWfa
   Ydn216MKltSXrNUmTyfAanhqb183JvwJJ4e4LZdPPF9GID1DZboOsXEbX
   kab97uPvxFDU3CDh4CVHQ188q8GPuV+42Ydth8js3ygp826tiKkgBvcGD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="407309935"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="407309935"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 06:03:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="722070711"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="722070711"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.63.128])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 06:03:27 -0800
Message-ID: <86062950-cde4-c078-90f4-8f8f09452013@intel.com>
Date:   Thu, 29 Dec 2022 16:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/2] mmc: sdhci-esdhc-imx: only enable DAT[0] and CMD
 line auto tuning for SDIO device
Content-Language: en-US
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        kgroeneveld@lenbrook.com
References: <20221223025022.1893102-1-haibo.chen@nxp.com>
 <20221223025022.1893102-3-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221223025022.1893102-3-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/12/22 04:50, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> USDHC IP has one limitation: the tuning circuit can't handle the async
> sdio device interrupt correctly. When sdio device use 4 data lines,
> async sdio interrupt will use the shared DAT[1], if enable auto tuning
> circuit to check these 4 data lines, include the DAT[1], this circuit
> will detect this interrupt, take this as data on DAT[1], and adjust the
> delay cell wrongly, finally will cause the DATA/CMD CRC error.
> So for SDIO device, only enable DAT[0] and CMD line for auto tuning.
> To distinguish the card type during card init, involve init_card().
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 41 ++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index bf8d6f60a9ee..8f5ee5964396 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -337,6 +337,16 @@ struct pltfm_imx_data {
>  	struct clk *clk_ahb;
>  	struct clk *clk_per;
>  	unsigned int actual_clock;
> +
> +	/*
> +	 * USDHC has one limition, require the SDIO device a different
> +	 * register setting. Driver has to recognize card type during
> +	 * the card init, but at this stage, mmc_host->card is not
> +	 * available. So involve this field to save the card type
> +	 * during card init through usdhc_init_card().
> +	 */
> +	unsigned int init_card_type;
> +
>  	enum {
>  		NO_CMD_PENDING,      /* no multiblock command pending */
>  		MULTIBLK_IN_PROCESS, /* exact multiblock cmd in process */
> @@ -431,6 +441,8 @@ static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
>  /* Enable the auto tuning circuit to check the CMD line and BUS line */
>  static inline void usdhc_auto_tuning_mode_sel_and_en(struct sdhci_host *host)
>  {
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  	u32 buswidth, auto_tune_buswidth;
>  	u32 reg;
>  
> @@ -448,6 +460,20 @@ static inline void usdhc_auto_tuning_mode_sel_and_en(struct sdhci_host *host)
>  		break;
>  	}
>  
> +	/*
> +	 * For USDHC, auto tuning circuit can not handle the async sdio
> +	 * device interrupt correctly. When sdio device use 4 data lines,
> +	 * async sdio interrupt will use the shared DAT[1], if enable auto
> +	 * tuning circuit check these 4 data lines, include the DAT[1],
> +	 * this circuit will detect this interrupt, take this as a data on
> +	 * DAT[1], and adjust the delay cell wrongly.
> +	 * This is the hardware design limitation, to avoid this, for sdio
> +	 * device, config the auto tuning circuit only check DAT[0] and CMD
> +	 * line.
> +	 */
> +	if (imx_data->init_card_type == MMC_TYPE_SDIO)
> +		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_1BIT_EN;
> +
>  	esdhc_clrset_le(host, ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK,
>  			auto_tune_buswidth | ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN,
>  			ESDHC_VEND_SPEC2);
> @@ -1055,6 +1081,15 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>  	}
>  }
>  
> +static void usdhc_init_card(struct mmc_host *mmc, struct mmc_card *card)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +
> +	imx_data->init_card_type = card->type;
> +}
> +
>  static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> @@ -1673,6 +1708,12 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  		 * to replace the standard one in sdhci_ops.
>  		 */
>  		host->mmc_host_ops.execute_tuning = usdhc_execute_tuning;
> +
> +		/*
> +		 * Link usdhc specific mmc_host_ops init card function,
> +		 * to distinguish the card type.
> +		 */
> +		host->mmc_host_ops.init_card = usdhc_init_card;
>  	}
>  
>  	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);

