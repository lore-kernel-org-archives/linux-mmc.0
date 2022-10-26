Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DFFC38A2D
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Oct 2022 06:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiJZGHU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Oct 2022 02:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJZGHT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2022 02:07:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500DD792C2
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 23:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666764438; x=1698300438;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fSvbQ/LTaoHXibh2SbylLDlfvYZCefpnx+B77fZvxV4=;
  b=e1UxsrggGnkPhJy8H0UP+nM0XoFIpLeCkGgMOpzMnY1DWVIpoyd+kUAq
   NSlz3kEyJwmonTrtBcRSt7HpupXaut3Vx55Sq4hER3O62vJMpJayjSlZ5
   ZBxRvg/lF5d+Om86H3eposvUee7odAP3NUEtGkdlv5GjgUcO+6gD++GDD
   hMYHg5QDyQhMFKipehkvlQVI2hsmcW1Ti45LrpsBBVJ7QJEnoed+FLbtO
   ShLFyXj2tyTL4IEi5sd7ZBg0PffafB/DCOg3D4gZIqbUnAEdxeANnfkQa
   gYq1uI1S3uhZtgr/T21eS+kF/KwPDltSw26lHbH+L81rsqs3P6rTsb8HH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="372078345"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="372078345"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 23:07:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="721132810"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="721132810"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.53.127])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 23:07:15 -0700
Message-ID: <2b523371-7eeb-25f2-8879-76bbf028f4bb@intel.com>
Date:   Wed, 26 Oct 2022 09:07:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Override
 SDHCI_RETUNING_TIMER_COUNT_MASK on ZynqMP
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20221025191500.149167-1-marex@denx.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221025191500.149167-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/10/22 22:15, Marek Vasut wrote:
> On Xilinx ZynqMP, the reg_capabilities (SDIO) Register
> 
> https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabilities.html#
> Absolute Address  0x00FF160040 (SD0)
> Reset Value       0x280737EC6481
> 
> really reads 0x200737EC6481 . The interesting part is the
> top 32 bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The
> missing 0x800 is SDHCI_RETUNING_TIMER_COUNT_MASK=0, which
> makes the SDHCI core disable retuning timer.
> 
> Fix this up here by explicitly setting tuning_count to 8
> as it should be, otherwise an eMMC might fail in various
> thermal conditions
> 
> Note that the diff is best shown with -w option, this makes it
> visible what happened with !sdhci_arasan->has_cqe conditional,
> which is placed between sdhci_setup_host() and __sdhci_add_host()
> calls. Since sdhci_add_host() is also a sequence of these two
> calls and host->tuning_count must be overriden before calling

overriden -> overridden

> __sdhci_add_host(), call the two calls separately and do all
> the adjustments between them in either case.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> To: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 57 ++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 3997cad1f793d..465498f2a7c0f 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1521,37 +1521,56 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
>  	return 0;
>  }
>  
> -static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
> +static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan,
> +				 struct device *dev)
>  {
>  	struct sdhci_host *host = sdhci_arasan->host;
>  	struct cqhci_host *cq_host;
>  	bool dma64;
>  	int ret;
>  
> -	if (!sdhci_arasan->has_cqe)
> -		return sdhci_add_host(host);
> -
>  	ret = sdhci_setup_host(host);
>  	if (ret)
>  		return ret;
>  
> -	cq_host = devm_kzalloc(host->mmc->parent,
> -			       sizeof(*cq_host), GFP_KERNEL);
> -	if (!cq_host) {
> -		ret = -ENOMEM;
> -		goto cleanup;
> -	}
> +	/*
> +	 * On Xilinx ZynqMP, the reg_capabilities (SDIO) Register
> +	 *
> +	 * https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabilities.html#
> +	 * Absolute Address  0x00FF160040 (SD0)
> +	 * Reset Value	     0x280737EC6481
> +	 *
> +	 * really reads 0x200737EC6481 . The interesting part is the
> +	 * top 32 bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The
> +	 * missing 0x800 is SDHCI_RETUNING_TIMER_COUNT_MASK=0, which
> +	 * makes the SDHCI core disable retuning timer.

Are you aware that caps can be changed in DT via "sdhci-caps" and
"sdhci-caps-mask" ?

> +	 *
> +	 * Fix this up here by explicitly setting tuning_count to 8
> +	 * as it should be, otherwise an eMMC might fail in various
> +	 * thermal conditions.
> +	 */
> +	if (of_device_is_compatible(dev->of_node, "xlnx,zynqmp-8.9a"))
> +		host->tuning_count = 1 << (8 - 1);
> +
> +	if (sdhci_arasan->has_cqe) {
> +		cq_host = devm_kzalloc(host->mmc->parent,
> +				       sizeof(*cq_host), GFP_KERNEL);
> +		if (!cq_host) {
> +			ret = -ENOMEM;
> +			goto cleanup;
> +		}
>  
> -	cq_host->mmio = host->ioaddr + SDHCI_ARASAN_CQE_BASE_ADDR;
> -	cq_host->ops = &sdhci_arasan_cqhci_ops;
> +		cq_host->mmio = host->ioaddr + SDHCI_ARASAN_CQE_BASE_ADDR;
> +		cq_host->ops = &sdhci_arasan_cqhci_ops;
>  
> -	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> -	if (dma64)
> -		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +		dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> +		if (dma64)
> +			cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
>  
> -	ret = cqhci_init(cq_host, host->mmc, dma64);
> -	if (ret)
> -		goto cleanup;
> +		ret = cqhci_init(cq_host, host->mmc, dma64);
> +		if (ret)
> +			goto cleanup;
> +	}
>  
>  	ret = __sdhci_add_host(host);
>  	if (ret)
> @@ -1711,7 +1730,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  			host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
>  	}
>  
> -	ret = sdhci_arasan_add_host(sdhci_arasan);
> +	ret = sdhci_arasan_add_host(sdhci_arasan, &pdev->dev);
>  	if (ret)
>  		goto err_add_host;
>  

