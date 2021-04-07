Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C09FC433B4
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Apr 2021 11:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E9C61246
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Apr 2021 11:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbhDGLD3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Apr 2021 07:03:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:61574 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241815AbhDGLD2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Apr 2021 07:03:28 -0400
IronPort-SDR: BkbfwqJQiT33IGCreyCI3lWoHbYpn/w6JWqHLTWVV0+stxCLDKwLAfY8q8OnSRdjJjmcdo2YCj
 SAl3FCw0NceQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="278548276"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="278548276"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 04:03:19 -0700
IronPort-SDR: MUPx8tiQB10NIqhWzpWGMTW5QY3lSIU3HLFlYyF65q/XQAookVznosvg38tHDxlHuz9bpj2zvt
 hZzReUeRwXRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="458320452"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga001.jf.intel.com with ESMTP; 07 Apr 2021 04:03:16 -0700
Subject: Re: [PATCH] mmc: sdhci-tegra: Add required callbacks to set/clear
 CQE_EN bit
To:     Jon Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Kamal Mostafa <kamal@canonical.com>
References: <20210407094617.770495-1-jonathanh@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0964b587-5682-fee8-333e-8e2a23cdfe83@intel.com>
Date:   Wed, 7 Apr 2021 14:03:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210407094617.770495-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/04/21 12:46 pm, Jon Hunter wrote:
> From: Aniruddha Tvs Rao <anrao@nvidia.com>
> 
> CMD8 is not supported with Command Queue Enabled. Add required callback
> to clear CQE_EN and CQE_INTR fields in the host controller register
> before sending CMD8. Add corresponding callback in the CQHCI resume path
> to re-enable CQE_EN and CQE_INTR fields.
> 
> Reported-by: Kamal Mostafa <kamal@canonical.com>
> Tested-by: Kamal Mostafa <kamal@canonical.com>
> Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index c61f797a853f..387ce9cdbd7c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -119,6 +119,10 @@
>  /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
>  #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
>  
> +#define SDHCI_TEGRA_CQE_TRNS_MODE	(SDHCI_TRNS_MULTI | \
> +					 SDHCI_TRNS_BLK_CNT_EN | \
> +					 SDHCI_TRNS_DMA)
> +
>  struct sdhci_tegra_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
>  	u64 dma_mask;
> @@ -1156,6 +1160,7 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
>  static void tegra_cqhci_writel(struct cqhci_host *cq_host, u32 val, int reg)
>  {
>  	struct mmc_host *mmc = cq_host->mmc;
> +	struct sdhci_host *host = mmc_priv(mmc);
>  	u8 ctrl;
>  	ktime_t timeout;
>  	bool timed_out;
> @@ -1170,6 +1175,7 @@ static void tegra_cqhci_writel(struct cqhci_host *cq_host, u32 val, int reg)
>  	 */
>  	if (reg == CQHCI_CTL && !(val & CQHCI_HALT) &&
>  	    cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
> +		sdhci_writew(host, SDHCI_TEGRA_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
>  		sdhci_cqe_enable(mmc);
>  		writel(val, cq_host->mmio + reg);
>  		timeout = ktime_add_us(ktime_get(), 50);
> @@ -1205,6 +1211,7 @@ static void sdhci_tegra_update_dcmd_desc(struct mmc_host *mmc,
>  static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
>  {
>  	struct cqhci_host *cq_host = mmc->cqe_private;
> +	struct sdhci_host *host = mmc_priv(mmc);
>  	u32 val;
>  
>  	/*
> @@ -1218,6 +1225,7 @@ static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
>  		if (val & CQHCI_ENABLE)
>  			cqhci_writel(cq_host, (val & ~CQHCI_ENABLE),
>  				     CQHCI_CFG);
> +		sdhci_writew(host, SDHCI_TEGRA_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
>  		sdhci_cqe_enable(mmc);
>  		if (val & CQHCI_ENABLE)
>  			cqhci_writel(cq_host, val, CQHCI_CFG);
> @@ -1281,12 +1289,36 @@ static void tegra_sdhci_set_timeout(struct sdhci_host *host,
>  	__sdhci_set_timeout(host, cmd);
>  }
>  
> +static void sdhci_tegra_cqe_pre_enable(struct mmc_host *mmc)
> +{
> +	struct cqhci_host *cq_host = mmc->cqe_private;
> +	u32 reg;
> +
> +	reg = cqhci_readl(cq_host, CQHCI_CFG);
> +	reg |= CQHCI_ENABLE;
> +	cqhci_writel(cq_host, reg, CQHCI_CFG);
> +}
> +
> +static void sdhci_tegra_cqe_post_disable(struct mmc_host *mmc)
> +{
> +	struct cqhci_host *cq_host = mmc->cqe_private;
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u32 reg;
> +
> +	reg = cqhci_readl(cq_host, CQHCI_CFG);
> +	reg &= ~CQHCI_ENABLE;
> +	cqhci_writel(cq_host, reg, CQHCI_CFG);
> +	sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
> +}
> +
>  static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
>  	.write_l    = tegra_cqhci_writel,
>  	.enable	= sdhci_tegra_cqe_enable,
>  	.disable = sdhci_cqe_disable,
>  	.dumpregs = sdhci_tegra_dumpregs,
>  	.update_dcmd_desc = sdhci_tegra_update_dcmd_desc,
> +	.pre_enable = sdhci_tegra_cqe_pre_enable,
> +	.post_disable = sdhci_tegra_cqe_post_disable,
>  };
>  
>  static int tegra_sdhci_set_dma_mask(struct sdhci_host *host)
> 

