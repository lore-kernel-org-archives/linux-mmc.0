Return-Path: <SRS0=joLi=AM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9286EC433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 11:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D06206CB
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 11:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgGALBq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:01:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:17426 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbgGALBp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 1 Jul 2020 07:01:45 -0400
IronPort-SDR: GfBKPlHOM63CIGXtwTn9p36XGW4lP1PiM2aJ310Jz/Y8hENAoupQ7hDx4vCl3TcpESPC4d5O/x
 PWBKu5RxXGqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="145607567"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="145607567"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 04:01:45 -0700
IronPort-SDR: gkZe8wdawuRPdrdFuPZnu7EkUYm+Czuq2Ppv35e+MgawgmZQHC82BrcYgMrotDww8qoAj94Kxt
 ATnFn4YRVWRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="303810069"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jul 2020 04:01:43 -0700
Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: dump internal IC debug status
 during error
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
References: <1592985830-13038-1-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e9a19c46-aca6-b0f4-3a79-4da47e37cbdc@intel.com>
Date:   Wed, 1 Jul 2020 14:01:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1592985830-13038-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/06/20 11:03 am, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> USDHC of i.MX has internal IC debug register, which record the IC
> logical status. So dump these logical status in error condition,
> this can help analyzing issue.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 39 ++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 1d7f84b23a22..a76b4513fbec 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -38,6 +38,16 @@
>  #define  ESDHC_VENDOR_SPEC_SDIO_QUIRK	(1 << 1)
>  #define  ESDHC_VENDOR_SPEC_VSELECT	(1 << 1)
>  #define  ESDHC_VENDOR_SPEC_FRC_SDCLK_ON	(1 << 8)
> +#define ESDHC_DEBUG_SEL_AND_STATUS_REG		0xc2
> +#define ESDHC_DEBUG_SEL_REG			0xc3
> +#define ESDHC_DEBUG_SEL_MASK			0xf
> +#define ESDHC_DEBUG_SEL_CMD_STATE		1
> +#define ESDHC_DEBUG_SEL_DATA_STATE		2
> +#define ESDHC_DEBUG_SEL_TRANS_STATE		3
> +#define ESDHC_DEBUG_SEL_DMA_STATE		4
> +#define ESDHC_DEBUG_SEL_ADMA_STATE		5
> +#define ESDHC_DEBUG_SEL_FIFO_STATE		6
> +#define ESDHC_DEBUG_SEL_ASYNC_FIFO_STATE	7
>  #define ESDHC_WTMK_LVL			0x44
>  #define  ESDHC_WTMK_DEFAULT_VAL		0x10401040
>  #define  ESDHC_WTMK_LVL_RD_WML_MASK	0x000000FF
> @@ -348,6 +358,34 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
>  	writel(((readl(base) & ~(mask << shift)) | (val << shift)), base);
>  }
>  
> +#define DRIVER_NAME "sdhci-esdhc-imx"
> +#define ESDHC_IMX_DUMP(f, x...) \
> +	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
> +static void esdhc_dump_debug_regs(struct sdhci_host *host)
> +{
> +	int i;
> +	char *debug_status[7] = {
> +				 "cmd debug status",
> +				 "data debug status",
> +				 "trans debug status",
> +				 "dma debug status",
> +				 "adma debug status",
> +				 "fifo debug status",
> +				 "async fifo debug status"
> +	};
> +
> +	ESDHC_IMX_DUMP("========= ESDHC IMX DEBUG STATUS DUMP =========\n");
> +	for (i = 0; i < 7; i++) {
> +		esdhc_clrset_le(host, ESDHC_DEBUG_SEL_MASK,
> +			ESDHC_DEBUG_SEL_CMD_STATE + i, ESDHC_DEBUG_SEL_REG);
> +		ESDHC_IMX_DUMP("%s:  0x%04x\n", debug_status[i],
> +			readw(host->ioaddr + ESDHC_DEBUG_SEL_AND_STATUS_REG));
> +	}
> +
> +	esdhc_clrset_le(host, ESDHC_DEBUG_SEL_MASK, 0, ESDHC_DEBUG_SEL_REG);
> +
> +}
> +
>  static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
>  {
>  	u32 present_state;
> @@ -1237,6 +1275,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
>  	.set_uhs_signaling = esdhc_set_uhs_signaling,
>  	.reset = esdhc_reset,
>  	.irq = esdhc_cqhci_irq,
> +	.dump_vendor_regs = esdhc_dump_debug_regs,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
> 

