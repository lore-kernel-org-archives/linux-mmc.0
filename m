Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D728C7EE29
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Jun 2023 05:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjFIFos (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Jun 2023 01:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFIFor (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2023 01:44:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1182926B9
        for <linux-mmc@vger.kernel.org>; Thu,  8 Jun 2023 22:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686289486; x=1717825486;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x2FUYSdN6Y63ATkUg2OnfBrFXj8JYi8enB1fWifzzt0=;
  b=Tm9gyRNjSgKkHCpJeBpbI0TAsosomByiteQUd3WT1u7rb1PUGY+H7Wau
   NYaqej+I1/Dmqw9HYHeXBobjkjsHcCTzW1acufBEZQsFB3vk4q67HC47U
   JmTRRCkNI3uhGi3PdKeW4KmGDClybrn6Oac5OufoA205J3ypNB6BjP1BG
   h9uVhagEbfDwX4cGaCygDE64SdSLPTyLKETFf+sfZk3eQa9D4ze8pM2LG
   AXOsftlcm1wvZBMfb6O25ju8yv0NqFwR9w7Xe+UTVvpz/tBeXv8bmZV/N
   CmqTHgaV3XGkU+tA1R1+P9KeFyM3HUFw/2alfENkGfq2ikIeSB+Wf80Av
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342195586"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="342195586"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 22:44:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="710243068"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="710243068"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.211.96])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 22:44:39 -0700
Message-ID: <f41d0260-ae0b-1862-c2b5-245b917714b4@intel.com>
Date:   Fri, 9 Jun 2023 08:44:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v2 09/12] mmc: sdhci-spear: fix deferred probing
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Viresh Kumar <vireshk@kernel.org>
References: <20230608194519.10665-1-s.shtylyov@omp.ru>
 <20230608194519.10665-10-s.shtylyov@omp.ru>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230608194519.10665-10-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/06/23 22:45, Sergey Shtylyov wrote:
> The driver overrides the error codes and IRQ0 returned by platform_get_irq()
> to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
> permanently instead of the deferred probing. Switch to propagating the error
> codes upstream.  IRQ0 is no longer returned by platform_get_irq(), so we now
> can safely ignore it...
> 
> Fixes: 682798a596a6 ("mmc: sdhci-spear: Handle return value of platform_get_irq")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in version 2:
> - slightly reformatted the patch description.
> 
>  drivers/mmc/host/sdhci-spear.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> index d463e2fd5b1a..c79035727b20 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -65,8 +65,8 @@ static int sdhci_probe(struct platform_device *pdev)
>  	host->hw_name = "sdhci";
>  	host->ops = &sdhci_pltfm_ops;
>  	host->irq = platform_get_irq(pdev, 0);
> -	if (host->irq <= 0) {
> -		ret = -EINVAL;
> +	if (host->irq < 0) {
> +		ret = host->irq;
>  		goto err_host;
>  	}
>  	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;

