Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24F5C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Jan 2021 12:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB50422AB9
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Jan 2021 12:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbhAEMkv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:40:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:62363 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbhAEMku (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 5 Jan 2021 07:40:50 -0500
IronPort-SDR: tBEJiEVrWBLAWAxamEYe4L7ef4o0elxzm6H3DvSjQvmfOIjsHAVZyXShi+UeIojvuGYECuX+di
 wut3vzxX0vkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="174522447"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="174522447"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 04:40:09 -0800
IronPort-SDR: 6IkOAP8MjGH/55q5jhZv/PwNqde/HhlTyXkBbEhuLnYqyG5Fv6u6PZ1FXQAKnJF+IXsFmgeDuX
 lxq3BIYT4zZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="421760825"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2021 04:40:06 -0800
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix some resource leaks in the remove
 function
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ulf.hansson@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20201217204236.163446-1-christophe.jaillet@wanadoo.fr>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1cfeeb62-8211-4a2a-0cf5-c3799d7ef42e@intel.com>
Date:   Tue, 5 Jan 2021 14:39:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201217204236.163446-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/12/20 10:42 pm, Christophe JAILLET wrote:
> 'sdhci_remove_host()' and 'sdhci_pltfm_free()' should be used in place of
> 'mmc_remove_host()' and 'mmc_free_host()'.
> 
> This avoids some resource leaks, is more in line with the error handling
> path of the probe function, and is more consistent with other drivers.
> 
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Other adjustment may be needed.
> I'm not sure at all of the 0 passed to 'sdhci_remove_host()'. Some drivers
> pass 0, some have some more complicated computation.

'0' means cleanup nicely. '1' (dead) means nothing works anymore, including
interrupts, so give up on requests immediately.

Either should work.  '0' is better unless your host controller really is
dead, which is mostly not possible except for some legacy PCI devices.

> ---
>  drivers/mmc/host/sdhci-sprd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index f85171edabeb..5dc36efff47f 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -708,14 +708,14 @@ static int sdhci_sprd_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
> -	struct mmc_host *mmc = host->mmc;
>  
> -	mmc_remove_host(mmc);
> +	sdhci_remove_host(host, 0);
> +
>  	clk_disable_unprepare(sprd_host->clk_sdio);
>  	clk_disable_unprepare(sprd_host->clk_enable);
>  	clk_disable_unprepare(sprd_host->clk_2x_enable);
>  
> -	mmc_free_host(mmc);
> +	sdhci_pltfm_free(pdev);
>  
>  	return 0;
>  }
> 

