Return-Path: <SRS0=YSSR=4G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B95C34031
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 07:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82ED221D7D
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 07:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgBRHnd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:43:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:8157 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgBRHnd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Feb 2020 02:43:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 23:43:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,455,1574150400"; 
   d="scan'208";a="314977761"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga001.jf.intel.com with ESMTP; 17 Feb 2020 23:43:07 -0800
Subject: Re: [PATCH v3 09/14] mmc: sdhci-esdhc-imx: add flag
 ESDHC_FLAG_BROKEN_AUTO_CMD23
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, linus.walleij@linaro.org
References: <1581324597-31031-1-git-send-email-haibo.chen@nxp.com>
 <1581324597-31031-4-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1c64b127-6eb8-591d-7c46-d0659d0cf999@intel.com>
Date:   Tue, 18 Feb 2020 09:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581324597-31031-4-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/02/20 10:49 am, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Since L4.15, community involve the commit 105819c8a545 ("mmc: core: use mrq->sbc
> when sending CMD23 for RPMB"), let the usdhc to decide whether to use ACMD23 for
> RPMB. This CMD23 for RPMB need to set the bit 31 to its argument, if not, the
> RPMB write operation will return general fail.
> 
> According to the sdhci logic, SDMA mode will disable the ACMD23, and only in
> ADMA mode, it will chose to use ACMD23 if the host support. But according to
> debug, and confirm with IC, the imx6qpdl/imx6sx/imx6sl/imx7d do not support
> the ACMD23 feature completely. These SoCs only use the 16 bit block count of
> the register 0x4 (BLOCK_ATT) as the CMD23's argument in ACMD23 mode, which
> means it will ignore the upper 16 bit of the CMD23's argument. This will block
> the reliable write operation in RPMB, because RPMB reliable write need to set
> the bit31 of the CMD23's argument. This is the hardware limitation. So for
> imx6qpdl/imx6sx/imx6sl/imx7d, it need to broke the ACMD23 for eMMC, SD card do
> not has this limitation, because SD card do not support reliable write.
> 
> For imx6ul/imx6ull/imx6sll/imx7ulp/imx8, it support the ACMD23 completely, it
> change to use the 0x0 register (DS_ADDR) to put the CMD23's argument in ADMA mode.
> 
> This patch add a new flag ESDHC_FLAG_BROKEN_AUTO_CMD23, and add this flag to
> imx6q/imx6sx/imx6sl/imx7d, and due to the imx6sll share the same compatible string
> with imx6sx before, and imx6sll do not has this limitation, so add a new compatible
> string for imx6sll.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 34 ++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 1ec35cc45fc5..98b91b6ff2a9 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -166,6 +166,18 @@
>  #define ESDHC_FLAG_STATE_LOST_IN_LPMODE		BIT(14)
>  /* The IP lost clock rate in PM_RUNTIME */
>  #define ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME	BIT(15)
> +/*
> + * The IP do not support the ACMD23 feature completely when use ADMA mode.
> + * In ADMA mode, it only use the 16 bit block count of the register 0x4
> + * (BLOCK_ATT) as the CMD23's argument for ACMD23 mode, which means it will
> + * ignore the upper 16 bit of the CMD23's argument. This will block the reliable
> + * write operation in RPMB, because RPMB reliable write need to set the bit31
> + * of the CMD23's argument.
> + * imx6qpdl/imx6sx/imx6sl/imx7d has this limitation only for ADMA mode, SDMA
> + * do not has this limitation. so when these SoC use ADMA mode, it need to
> + * disable the ACMD23 feature.
> + */
> +#define ESDHC_FLAG_BROKEN_AUTO_CMD23	BIT(16)
>  
>  struct esdhc_soc_data {
>  	u32 flags;
> @@ -188,21 +200,30 @@ static const struct esdhc_soc_data esdhc_imx53_data = {
>  };
>  
>  static const struct esdhc_soc_data usdhc_imx6q_data = {
> -	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING,
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
> +			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
>  };
>  
>  static const struct esdhc_soc_data usdhc_imx6sl_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536
> -			| ESDHC_FLAG_HS200,
> +			| ESDHC_FLAG_HS200
> +			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
>  };
>  
> -static const struct esdhc_soc_data usdhc_imx6sx_data = {
> +static const struct esdhc_soc_data usdhc_imx6sll_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
>  };
>  
> +static const struct esdhc_soc_data usdhc_imx6sx_data = {
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> +			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
> +			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
> +};
> +
>  static const struct esdhc_soc_data usdhc_imx6ull_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> @@ -214,7 +235,8 @@ static const struct esdhc_soc_data usdhc_imx7d_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_HS400
> -			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
> +			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
> +			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
>  };
>  
>  static struct esdhc_soc_data usdhc_imx7ulp_data = {
> @@ -276,6 +298,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
>  	{ .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
>  	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
>  	{ .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
> +	{ .compatible = "fsl,imx6sll-usdhc", .data = &usdhc_imx6sll_data, },
>  	{ .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
>  	{ .compatible = "fsl,imx6ull-usdhc", .data = &usdhc_imx6ull_data, },
>  	{ .compatible = "fsl,imx7d-usdhc", .data = &usdhc_imx7d_data, },
> @@ -1560,6 +1583,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
>  		host->quirks2 |= SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400;
>  
> +	if (imx_data->socdata->flags & ESDHC_FLAG_BROKEN_AUTO_CMD23)
> +		host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;
> +
>  	if (imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
>  		host->mmc->caps2 |= MMC_CAP2_HS400_ES;
>  		host->mmc_host_ops.hs400_enhanced_strobe =
> 

