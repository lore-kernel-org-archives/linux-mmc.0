Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EEEC4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Dec 2022 17:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiLVR5F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Dec 2022 12:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiLVR5E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2022 12:57:04 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F097928742;
        Thu, 22 Dec 2022 09:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671731822; x=1703267822;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QEwpG7YPkjygfaW66tLkHP88MR6Pq8dGRwAgelJ9rbY=;
  b=D7HLLMvjw/nxsmrH20c99fvBf7zgNPiATzct1zSlwdaJMSPahFDiEbaQ
   NPlvItwNzWS8IRaRRFL1/ySJdzNEOs0RDceKmV/eahdKpyPp33gVWaJUO
   Ssc+2EjR322OWqxsMFIHn8s/jjuxZ3pszh2tnexqyw2AWlsYIwh1D9ZEo
   YSr558i0Ke5WFOfxeaPxsxdmzNi/ADqq8gmyHlsWrpSAmoDxPj4lgLRel
   VsdefJcr7E0lgTokjTurSLSxQ043wpPlRXaF/SgAkJDzzIZhVW13HdEZt
   QGsBen4+HJI0U8CfHF4ukqyM14MVM7J/Kt59bv+99PAkiqBboCDGExWMg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="382433412"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="382433412"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 09:33:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="629588598"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="629588598"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.195])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 09:33:44 -0800
Message-ID: <c9e5e377-f3ce-87c2-0ff1-aae8da7045a0@intel.com>
Date:   Thu, 22 Dec 2022 19:33:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 5/8] mmc: sdhci-pxav2: add optional core clock
Content-Language: en-US
To:     Doug Brown <doug@schmorgal.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <20221202031330.94130-1-doug@schmorgal.com>
 <20221202031330.94130-6-doug@schmorgal.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221202031330.94130-6-doug@schmorgal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/12/22 05:13, Doug Brown wrote:
> Add ability to have an optional core clock just like the pxav3 driver.
> The PXA168 needs this because its SDHC controllers have separate core
> and io clocks that both need to be enabled. This also correctly matches
> the documented devicetree bindings for this driver.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
>  drivers/mmc/host/sdhci-pxav2.c | 40 ++++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index 509ba5dd4a4a..1f0c3028987a 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -41,6 +41,10 @@
>  #define MMC_CARD		0x1000
>  #define MMC_WIDTH		0x0100
>  
> +struct sdhci_pxav2_host {
> +	struct clk *clk_core;
> +};
> +
>  static void pxav2_reset(struct sdhci_host *host, u8 mask)
>  {
>  	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
> @@ -176,6 +180,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
> +	struct sdhci_pxav2_host *pxav2_host;
>  	struct device *dev = &pdev->dev;
>  	struct sdhci_host *host = NULL;
>  	const struct of_device_id *match;
> @@ -183,11 +188,12 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>  	int ret;
>  	struct clk *clk;
>  
> -	host = sdhci_pltfm_init(pdev, NULL, 0);
> +	host = sdhci_pltfm_init(pdev, NULL, sizeof(*pxav2_host));
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
>  
>  	pltfm_host = sdhci_priv(host);
> +	pxav2_host = sdhci_pltfm_priv(pltfm_host);
>  
>  	clk = devm_clk_get(dev, "io");
>  	if (IS_ERR(clk))
> @@ -204,6 +210,15 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>  		goto free;
>  	}
>  
> +	pxav2_host->clk_core = devm_clk_get(dev, "core");

This can use devm_clk_get_optional_enabled()

> +	if (!IS_ERR(pxav2_host->clk_core)) {
> +		ret = clk_prepare_enable(pxav2_host->clk_core);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to enable core clock\n");

	if (IS_ERR(pxav2_host->clk_core)) {
		dev_err_probe(&pdev->dev, PTR_ERR(pxav2_host->clk_core), "failed to enable core clock\n");

> +			goto disable_io_clk;
> +		}
> +	}
> +
>  	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
>  		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
>  		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
> @@ -240,17 +255,34 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>  
>  	ret = sdhci_add_host(host);
>  	if (ret)
> -		goto disable_clk;
> +		goto disable_core_clk;
>  
>  	return 0;
>  
> -disable_clk:
> +disable_core_clk:
> +	if (!IS_ERR(pxav2_host->clk_core))

With changes above this would need to be: IS_ERR_OR_NULL


> +		clk_disable_unprepare(pxav2_host->clk_core);
> +disable_io_clk:
>  	clk_disable_unprepare(clk);
>  free:
>  	sdhci_pltfm_free(pdev);
>  	return ret;
>  }
>  
> +static int sdhci_pxav2_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_pxav2_host *pxav2_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	int ret = sdhci_pltfm_unregister(pdev);
> +
> +	if (!IS_ERR(pxav2_host->clk_core))

With changes above this would need to be: IS_ERR_OR_NULL

> +		clk_disable_unprepare(pxav2_host->clk_core);
> +
> +	return ret;
> +}
> +
>  static struct platform_driver sdhci_pxav2_driver = {
>  	.driver		= {
>  		.name	= "sdhci-pxav2",
> @@ -259,7 +291,7 @@ static struct platform_driver sdhci_pxav2_driver = {
>  		.pm	= &sdhci_pltfm_pmops,
>  	},
>  	.probe		= sdhci_pxav2_probe,
> -	.remove		= sdhci_pltfm_unregister,
> +	.remove		= sdhci_pxav2_remove,
>  };
>  
>  module_platform_driver(sdhci_pxav2_driver);

