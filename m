Return-Path: <SRS0=YSSR=4G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D708C34031
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 08:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FF720836
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 08:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgBRIBI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:01:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:36196 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgBRIBI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Feb 2020 03:01:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 00:01:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,455,1574150400"; 
   d="scan'208";a="314981652"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga001.jf.intel.com with ESMTP; 18 Feb 2020 00:01:05 -0800
Subject: Re: [PATCH v3 13/14] mmc: sdhci-esdhc-imx: clear DMA_SEL when disable
 DMA mode
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, linus.walleij@linaro.org
References: <1581324597-31031-1-git-send-email-haibo.chen@nxp.com>
 <1581324597-31031-8-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <923b58e7-8e75-e06c-0f37-b4827724ca45@intel.com>
Date:   Tue, 18 Feb 2020 10:00:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581324597-31031-8-git-send-email-haibo.chen@nxp.com>
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
> Currently, when use standard tuning, driver default disable DMA just before
> send tuning command. But on i.MX8 usdhc, this is not enough. Need also clear
> DMA_SEL. If not, once the DMA_SEL select AMDA2 before, even dma already disabled,
> when send tuning command, usdhc will still prefetch the ADMA script from wrong
> DMA address, then we will see IOMMU report some error which show lack of TLB
> mapping.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index dedc067cd0dd..44837e3014e8 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -639,10 +639,24 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  			 * For DMA access restore the levels to default value.
>  			 */
>  			m = readl(host->ioaddr + ESDHC_WTMK_LVL);
> -			if (val & SDHCI_TRNS_DMA)
> +			if (val & SDHCI_TRNS_DMA) {
>  				wml = ESDHC_WTMK_LVL_WML_VAL_DEF;
> -			else
> +			} else {
> +				u8 ctrl;
>  				wml = ESDHC_WTMK_LVL_WML_VAL_MAX;
> +
> +				/*
> +				 * Since already disable DMA mode, so also need
> +				 * to clear the DMASEL. Otherwise, for standard
> +				 * tuning, when send tuning command, usdhc will
> +				 * still prefetch the ADMA script from wrong
> +				 * DMA address, then we will see IOMMU report
> +				 * some error which show lack of TLB mapping.
> +				 */
> +				ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +				ctrl &= ~SDHCI_CTRL_DMA_MASK;
> +				sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +			}
>  			m &= ~(ESDHC_WTMK_LVL_RD_WML_MASK |
>  			       ESDHC_WTMK_LVL_WR_WML_MASK);
>  			m |= (wml << ESDHC_WTMK_LVL_RD_WML_SHIFT) |
> 

