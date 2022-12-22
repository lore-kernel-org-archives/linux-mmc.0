Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3908C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Dec 2022 16:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLVQa4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Dec 2022 11:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLVQaz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2022 11:30:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF5B209A8;
        Thu, 22 Dec 2022 08:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671726653; x=1703262653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gaikJOwrkaTYxoPnt5Jgv3hjahARUac+2aDD8li1o5k=;
  b=TLmwuo8Txp7aXY142Mp5VBot4sTc3umgS4eD9sQ9qW25wvYWIE0493U0
   VjwMJ1COhGAaHPEJXstpHjG5Y0ByqfFRaVxzQilSCH1t71nZu8S9dRQ3o
   6Vj+jh0HMWcZG4qEw2SeHLgy66lOyIj6yPXHssSvgb9u6kXJFUhaPrHfw
   Mv19vkZ5DILhN9VNcCHKHyyQqkqqVkv54NtCsgtXdd57gDvkBiYZUlXrY
   +yGJM3VO7d5ouX+/AhS2arnH5qGxZYYDvkCEQIjrV98ftL3+5JpGr0zmD
   niFmeeflHkK/Tn1WguGm3MTXsCME6bJz64MSIh5GpYNzgbmoAR1MUOKvO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="406402245"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="406402245"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 08:30:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="653931969"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="653931969"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.195])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 08:30:51 -0800
Message-ID: <0136d5c6-7bb6-ce28-7db7-79d0f3bb2c4d@intel.com>
Date:   Thu, 22 Dec 2022 18:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/8] mmc: sdhci-pxav2: change clock name to match DT
 bindings
Content-Language: en-US
To:     Doug Brown <doug@schmorgal.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20221202031330.94130-1-doug@schmorgal.com>
 <20221202031330.94130-5-doug@schmorgal.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221202031330.94130-5-doug@schmorgal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/12/22 05:13, Doug Brown wrote:
> The devicetree bindings for this driver specify that the two allowed
> clock names are io and core. Change this driver to look for io, but
> allow any name if it fails for backwards compatibility. Follow the same
> pattern used in sdhci-pxav3.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
>  drivers/mmc/host/sdhci-pxav2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index 0a16098b963f..509ba5dd4a4a 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -189,7 +189,9 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>  
>  	pltfm_host = sdhci_priv(host);
>  
> -	clk = devm_clk_get(dev, "PXA-SDHCLK");
> +	clk = devm_clk_get(dev, "io");
> +	if (IS_ERR(clk))
> +		clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(clk)) {
>  		dev_err(dev, "failed to get io clock\n");
>  		ret = PTR_ERR(clk);

It is nicer to handle EPROBE_DEFER e.g.

	if (IS_ERR(clk) && PTR_ERR(clk) != -EPROBE_DEFER)
		clk = devm_clk_get(dev, NULL);
	if (IS_ERR(clk)) {
		ret = PTR_ERR(clk);
		dev_err_probe(dev, ret, "failed to get io clock\n");

