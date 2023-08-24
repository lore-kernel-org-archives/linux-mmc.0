Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC17C7113B
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Aug 2023 09:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjHXJNt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Aug 2023 05:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbjHXJNS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Aug 2023 05:13:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CF9198E
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 02:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692868396; x=1724404396;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VqfSPH++moyJRJwCAeDyqn0XCyJcu72TryGAaJn/Pns=;
  b=dZBIsF/MLyMCYh2ycTiNPwCMJy7KA3B0uFLxV6e8WlF7FJqy2hHa4/Vh
   E3nVh++cBKkwDabA0PkACDIYZyQhLo0V3hmIaqAFZvt0fDXjWq06z1qrr
   DV84ohOJMzyj3qCKRZkKCRKNYq3xmMZbFSDrW+nJgGuxgYirSh83eaEU0
   uTeRC/ZQhJPTAxNAoW+78sB1FJx4o2BFpcatyjzgbNrDr4/2GMLKVPd1T
   O6ueWue7QLE8mGFdYxrdTrvM1rP7aDgR5VjWlFAIkMeho/GOv6NmkEq3E
   B0RO2rBsrpcesb5kZKqIUhLtvWt00H37Vk5o87wzrZEXgvWwJuMxcXdLq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="378143082"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="378143082"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 02:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="860632888"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="860632888"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.187])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 02:13:13 -0700
Message-ID: <b7ffe3db-aafe-9d88-7c4a-b8d6dc77ef8f@intel.com>
Date:   Thu, 24 Aug 2023 12:13:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH V3] mmc: sdhci-of-dwcmshc: Use helper function
 devm_clk_get_enabled()
Content-Language: en-US
To:     Yi Yang <yiyang13@huawei.com>
Cc:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        Liming Sun <limings@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
References: <20230824084629.135361-1-yiyang13@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230824084629.135361-1-yiyang13@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/08/23 11:46, Yi Yang wrote:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for
> prepared and enabled clocks"), devm_clk_get() and clk_prepare_enable()
> can now be replaced by devm_clk_get_enabled() when the driver enables
> (and possibly prepares) the clocks for the whole lifetime of the device.
> Moreover, it is no longer necessary to unprepare and disable the clocks
> explicitly.
> 
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
> v3: Fix err check logic
> v2: Remove clk_disable_unprepare in dwcmshc_remove()
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 31c1892f4ecd..7e1cf78d9695 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -495,19 +495,19 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	priv = sdhci_pltfm_priv(pltfm_host);
>  
>  	if (dev->of_node) {
> -		pltfm_host->clk = devm_clk_get(dev, "core");
> +		pltfm_host->clk = devm_clk_get_enabled(dev, "core");
>  		if (IS_ERR(pltfm_host->clk)) {
>  			err = PTR_ERR(pltfm_host->clk);
> -			dev_err(dev, "failed to get core clk: %d\n", err);
> +			dev_err(dev, "failed to get or enable core clk: %d\n", err);
>  			goto free_pltfm;
>  		}
> -		err = clk_prepare_enable(pltfm_host->clk);
> -		if (err)
> -			goto free_pltfm;
>  
> -		priv->bus_clk = devm_clk_get(dev, "bus");
> -		if (!IS_ERR(priv->bus_clk))
> -			clk_prepare_enable(priv->bus_clk);
> +		priv->bus_clk = devm_clk_get_enabled(dev, "bus");

This should probably be devm_clk_get_enabled_optional()
Maybe someone who knows the hardware can confirm?

> +		if (IS_ERR(priv->bus_clk)) {
> +			err = PTR_ERR(priv->bus_clk);
> +			dev_err(dev, "failed to get or enable bus clk: %d\n", err);
> +			goto free_pltfm;
> +		}
>  	}
>  
>  	err = mmc_of_parse(host->mmc);
> @@ -564,8 +564,6 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  err_setup_host:
>  	sdhci_cleanup_host(host);
>  err_clk:
> -	clk_disable_unprepare(pltfm_host->clk);
> -	clk_disable_unprepare(priv->bus_clk);
>  	if (rk_priv)
>  		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>  					   rk_priv->rockchip_clks);
> @@ -583,8 +581,6 @@ static void dwcmshc_remove(struct platform_device *pdev)
>  
>  	sdhci_remove_host(host, 0);
>  
> -	clk_disable_unprepare(pltfm_host->clk);
> -	clk_disable_unprepare(priv->bus_clk);
>  	if (rk_priv)
>  		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>  					   rk_priv->rockchip_clks);

