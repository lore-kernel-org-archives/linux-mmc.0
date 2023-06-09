Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289CFC7EE29
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Jun 2023 05:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjFIFn7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Jun 2023 01:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbjFIFnz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2023 01:43:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98D12715
        for <linux-mmc@vger.kernel.org>; Thu,  8 Jun 2023 22:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686289434; x=1717825434;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=TJpgpuUl4sn3lMCOAi4Tu1N7vqA6RE6AjrgWsEiXCe8=;
  b=BiTEyjnu6Ml8FAjWTIWi7kKF7XwAxT+RNSHOfVFovjDVEnsorI4fHi1K
   86vlh0xEJMLu8EqdGAQc+9y3FQPaGtFCl8wjWVOIZFQ+lZb+ICKHYPInb
   RJe8/R0WYa1kCfbwdPzjxjrNBnAWYiK5Gkyxeh7947d2ahwG2kAYULV+I
   VoIYvdIlb+DqYMvcpmOkM6maCFyylFN40jDcCapltj6YkGouH1TvK5K6s
   Oi/k2pmShnUwZ+F3oYaXHw8WPmBGGqiFFc+tBJhWaJOpoDYwgBUVW8hGW
   slp92dlU9dhJ6GPpcsP0r0JhJAsEiD7QxcCl7jKfHOOQ7TSoPAZqQEXSw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342195446"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="342195446"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 22:43:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="710242630"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="710242630"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.211.96])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 22:43:48 -0700
Message-ID: <e4418d99-a439-a0cd-b8aa-f36465d9b396@intel.com>
Date:   Fri, 9 Jun 2023 08:43:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v2 08/12] mmc: sdhci-acpi: fix deferred probing
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20230608194519.10665-1-s.shtylyov@omp.ru>
 <20230608194519.10665-9-s.shtylyov@omp.ru>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230608194519.10665-9-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/06/23 22:45, Sergey Shtylyov wrote:
> The driver overrides the error codes returned by platform_get_irq() to
> -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
> permanently instead of the deferred probing. Switch to propagating the
> error codes upstream.
> 
> Fixes: 1b7ba57ecc86 ("mmc: sdhci-acpi: Handle return value of platform_get_irq")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in version 2:
> - refreshed the patch.
> 
>  drivers/mmc/host/sdhci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 8f0e639236b1..edf2e6c14dc6 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -829,7 +829,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	host->ops	= &sdhci_acpi_ops_dflt;
>  	host->irq	= platform_get_irq(pdev, 0);
>  	if (host->irq < 0) {
> -		err = -EINVAL;
> +		err = host->irq;
>  		goto err_free;
>  	}
>  

