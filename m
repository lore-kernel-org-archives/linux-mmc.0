Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8094FC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 13:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA1260F41
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 13:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhJNNOk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Oct 2021 09:14:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:47571 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhJNNOg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Oct 2021 09:14:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227955794"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="227955794"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 06:12:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="571327891"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga002.fm.intel.com with ESMTP; 14 Oct 2021 06:12:28 -0700
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: clear the buffer_read_ready to
 reset standard tuning circuit
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
References: <1634206268-5416-1-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <541668c6-ea4f-afa3-8ef4-9727c46bb2c6@intel.com>
Date:   Thu, 14 Oct 2021 16:12:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1634206268-5416-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/10/2021 13:11, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> To reset standard tuning circuit completely, after clear ESDHC_MIX_CTRL_EXE_TUNE,
> also need to clear bit buffer_read_ready, this operation will finally clear the
> USDHC IP internal logic flag execute_tuning_with_clr_buf, make sure the following
> normal data transfer will not be impacted by standard tuning logic used before.
> 
> Find this issue when do quick SD card insert/remove stress test. During standard
> tuning prodedure, if remove SD card, USDHC standard tuning logic can't clear the
> internal flag execute_tuning_with_clr_buf. Next time when insert SD card, all
> data related commands can't get any data related interrupts, include data transfer
> complete interrupt, data timeout interrupt, data CRC interrupt, data end bit interrupt.
> Always trigger software timeout issue. Even reset the USDHC through bits in register
> SYS_CTRL (0x2C, bit28 reset tuning, bit26 reset data, bit 25 reset command, bit 24
> reset all) can't recover this. From the user's point of view, USDHC stuck, SD can't
> be recognized any more.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Apart from the request for a fixes tag:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index f18d169bc8ff..e658f0174242 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1187,6 +1187,7 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  	u32 ctrl;
> +	int ret;
>  
>  	/* Reset the tuning circuit */
>  	if (esdhc_is_usdhc(imx_data)) {
> @@ -1199,7 +1200,22 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>  		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
>  			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
>  			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> +			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
>  			writel(ctrl, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
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
>  		}
>  	}
>  }
> 

