Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F9AC63797
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Jan 2023 06:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbjAQGzS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Jan 2023 01:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbjAQGzR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2023 01:55:17 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1742E22789;
        Mon, 16 Jan 2023 22:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673938517; x=1705474517;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E1uYgBwy7ys7iwpE4q42W3xbI5FgEWmS4DQH+Z4CUp8=;
  b=XuAfga7s4DumizhVfi0Rr/tRK/mM1OGDr9ycOggbfiuSjX+Iw+Y1R52f
   +ZmXpp5kJpccDd2m3ZAbXUEQoJq9ZiuebXMzewww89JpxKAUS8sFuHkjr
   mE7hVXXGW2Id0KXFABOPF16fkwNzXtvZxldRHTcATXjgj7Olayn1mwemz
   lqh42Xv1rD/60xTfeWyIQePtOwZF3YbnnUMdCFyncbg9E9diS5DtcN68N
   OBwMixAocI3tCW4e2JS3TGnlEhZJuUhTSsFZXTPqzTm7COzbvdibTcY7p
   0lvtfI8YGLMqcgF8z+BJNVsVyG1WCLlZJ9+UxKRN4lC1jOQBpdTLHQuNu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="308185876"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="308185876"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 22:55:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="988018740"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="988018740"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.223.65])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 22:55:13 -0800
Message-ID: <538a5839-3250-7a81-7221-19edcfefccb3@intel.com>
Date:   Tue, 17 Jan 2023 08:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v5 5/8] mmc: sdhci-pxav2: add optional core clock
Content-Language: en-US
To:     Doug Brown <doug@schmorgal.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
References: <20230116194401.20372-1-doug@schmorgal.com>
 <20230116194401.20372-6-doug@schmorgal.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230116194401.20372-6-doug@schmorgal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/01/23 21:43, Doug Brown wrote:
> Add ability to have an optional core clock just like the pxav3 driver.
> The PXA168 needs this because its SDHC controllers have separate core
> and io clocks that both need to be enabled. This also correctly matches
> the documented devicetree bindings for this driver.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> The Reported-by tags above refer to a missing assignment to ret in an
> earlier version of this patch. The kernel test robot caught it.
> 
>  drivers/mmc/host/sdhci-pxav2.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index f5c86e1ba734..3141901e1558 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -191,7 +191,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>  	const struct sdhci_pxa_variant *variant;
>  
>  	int ret;
> -	struct clk *clk;
> +	struct clk *clk, *clk_core;
>  
>  	host = sdhci_pltfm_init(pdev, NULL, 0);
>  	if (IS_ERR(host))
> @@ -214,6 +214,13 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>  		goto free;
>  	}
>  
> +	clk_core = devm_clk_get_optional_enabled(dev, "core");
> +	if (IS_ERR(clk_core)) {
> +		ret = PTR_ERR(clk_core);
> +		dev_err_probe(dev, ret, "failed to enable core clock\n");
> +		goto disable_clk;
> +	}
> +
>  	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
>  		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
>  		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;

