Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AC5EE49A5
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Aug 2023 05:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjHUFfD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Aug 2023 01:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjHUFfC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Aug 2023 01:35:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EF5A3
        for <linux-mmc@vger.kernel.org>; Sun, 20 Aug 2023 22:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692596101; x=1724132101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zsI234N1nr6yB9FcJM+x44FLcBBuBtrdv2YxbJMdXiM=;
  b=F/VKFYyp5nMzXPeTLwvtfZTH5XQQsWYNFElFWk280VcvM3CBOxL7yqFd
   9gax2tZ3NywIt9lLKT065HxBMQ3QnACYvpMzBJMzTXhH1GrbAiKfRu9DP
   l2IgKlC+IpcieUzogI/S+HdNDrLuUn1oJ3OOviTk4YlTF5xIB/8YzHvXj
   85EF7lAwfuxchhOf3x3ZWCr95HPFD8XMjTiKvUCXd7O6VCijj8fXBnTdG
   RKUXOuXYQoG+RlPLOGDUmg94V2qhKBAanJuLax9iE2ZEinaOmiAFKM6zk
   Xe5w4IkxZjM/VAoanjy1ifK6mB381h0To4iYftEtz/MtC7ZLmHofvppT2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="373470484"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="373470484"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2023 22:35:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="685533744"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="685533744"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.54.30])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2023 22:34:58 -0700
Message-ID: <36fe9b5f-2601-417a-c865-ca39ca99d620@intel.com>
Date:   Mon, 21 Aug 2023 08:34:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH -next] mmc: sdhci-of-dwcmshc: Use helper function
 devm_clk_get_enabled()
To:     Yi Yang <yiyang13@huawei.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org
References: <20230819061659.74716-1-yiyang13@huawei.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230819061659.74716-1-yiyang13@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/08/23 09:16, Yi Yang wrote:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for
> prepared and enabled clocks"), devm_clk_get() and clk_prepare_enable()
> can now be replaced by devm_clk_get_enabled() when the driver enables
> (and possibly prepares) the clocks for the whole lifetime of the device.
> Moreover, it is no longer necessary to unprepare and disable the clocks
> explicitly.
> 
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 31c1892f4ecd..144ca5bc427c 100644
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
> +		if (!IS_ERR(priv->bus_clk)) {
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

Also need to take them away from dwcmshc_remove()

>  	if (rk_priv)
>  		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>  					   rk_priv->rockchip_clks);

