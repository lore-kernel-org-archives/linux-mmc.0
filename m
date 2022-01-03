Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F18C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Jan 2022 08:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiACIZr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Jan 2022 03:25:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:50699 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232071AbiACIZq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 3 Jan 2022 03:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641198346; x=1672734346;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=FnLeG+RVwwX07zEWpejGrN1LSdZCJY2+zDTyWhtdQfo=;
  b=XFw9QwJoWtjxOmA0FD4L3xZpNi+2Ds0Lo4WNmm4agL44RLubX/ku5C5H
   r8kSEicwbpwRLCUWS3pB4upyVuaqw4stzM5ub0UNeNT+2vJdwygG/kvvO
   b5q6oXC75WKa7z+/z7w2ULSRK4FYeMSgbnDTJ4wOCVS0pDhhnISOhWp1Z
   0oSL2MR/5OSO/igJ4nnsSGMh5es6Q0E2ByHmTrGhXWFMfh/e1GJdyoVCH
   Kl3l1jUq9k+uoji2D+uhhBpB1nWmEW7dR0woO67/FgAMu6OPYUxKBfHwZ
   XcNbtY3gQOuejC2j5Fq3BPvlPtMhemDEchX3+WoxhxpB0K7DGXFboIUJa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="222703239"
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="222703239"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 00:25:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="525481979"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2022 00:25:43 -0800
Subject: Re: [PATCH RFC 09/13] mmc: sdhci-acpi: fix deferred probing
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
References: <20211223171202.8224-1-s.shtylyov@omp.ru>
 <20211223171202.8224-10-s.shtylyov@omp.ru>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7bc4f1ac-dab3-ad09-5f48-dccec6cd71e0@intel.com>
Date:   Mon, 3 Jan 2022 10:25:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211223171202.8224-10-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/12/2021 19:11, Sergey Shtylyov wrote:
> The driver overrides the error codes returned by platform_get_irq() to
> -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
> permanently instead of the deferred probing. Switch to propagating the
> error codes upstream.
> 
> Fixes: 1b7ba57ecc86 ("mmc: sdhci-acpi: Handle return value of platform_get_irq")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index f1ef0d28b0dd..1fa1d2a7bfc9 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -898,7 +898,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	host->ops	= &sdhci_acpi_ops_dflt;
>  	host->irq	= platform_get_irq(pdev, 0);
>  	if (host->irq < 0) {
> -		err = -EINVAL;
> +		err = host->irq;
>  		goto err_free;
>  	}
>  
> 

