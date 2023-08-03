Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A063EB64DD
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Aug 2023 05:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjHCFhy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Aug 2023 01:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHCFhx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Aug 2023 01:37:53 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6182C1FED
        for <linux-mmc@vger.kernel.org>; Wed,  2 Aug 2023 22:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691041072; x=1722577072;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xrm3HcJjg6NKppzyJbQGrv19QW840EECrC3Dt/kpY7s=;
  b=mLQp7dGzCI7Vpzz8FJXtRS2raMJ4dkuyasuzTboBsXewS4wDvU2tr2bb
   Xly2n9tua4Bv0/kjukor6yDb3MvSWyIz1ytL/whbQ/acgHMDLj8zrUpWY
   MZjX4rPARdwKG5zzMuTe6DFQKzgC9NeiAKqIVht4vX9xjAmKBJPul2mmK
   PqgurF+W7huY1lBK8Bx3AZWw0zfkdTqgoF4ETCuTgJ+1/X9ZRnpfYWmSs
   gfmpAvFwQb4Vx8hFl5RzmP+RVpGrAIbk/Vl4OnFDJC+U/Qz+RzbUQ1Ek0
   nOg4Ar5PC7iRRRDuUKmR2akZj5a1rQNXQyJlec+BUmB+Ne/vIHVemZZOY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368674818"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="368674818"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 22:37:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="853112661"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="853112661"
Received: from mehlinma-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.36.218])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 22:37:50 -0700
Message-ID: <31e64790-12dc-8537-e099-5e5d633b8e54@intel.com>
Date:   Thu, 3 Aug 2023 08:37:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH -next] mmc: sdhci-st: Use
 devm_platform_ioremap_resource_byname()
To:     Li Zetao <lizetao1@huawei.com>, patrice.chotard@foss.st.com,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org
References: <20230802094028.976612-1-lizetao1@huawei.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230802094028.976612-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/08/23 12:40, Li Zetao wrote:
> Convert platform_get_resource_byname() + devm_ioremap_resource() to a
> single call to devm_platform_ioremap_resource_byname(), as this is
> exactly what this function does.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-st.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index 6415916fbd91..97f350953c4b 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -348,7 +348,6 @@ static int sdhci_st_probe(struct platform_device *pdev)
>  	struct clk *clk, *icnclk;
>  	int ret = 0;
>  	u16 host_version;
> -	struct resource *res;
>  	struct reset_control *rstc;
>  
>  	clk =  devm_clk_get(&pdev->dev, "mmc");
> @@ -397,9 +396,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Configure the FlashSS Top registers for setting eMMC TX/RX delay */
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -					   "top-mmc-delay");
> -	pdata->top_ioaddr = devm_ioremap_resource(&pdev->dev, res);
> +	pdata->top_ioaddr = devm_platform_ioremap_resource_byname(pdev, "top-mmc-delay");
>  	if (IS_ERR(pdata->top_ioaddr))
>  		pdata->top_ioaddr = NULL;
>  

