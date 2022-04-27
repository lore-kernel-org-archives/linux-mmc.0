Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A14C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Apr 2022 04:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357727AbiD0Eoh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Apr 2022 00:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357725AbiD0Eog (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2022 00:44:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26EE12AAC;
        Tue, 26 Apr 2022 21:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651034486; x=1682570486;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FOoMj3CV1xNcLvj1+jF+2iIlIlqLKQAJc7bxju62e08=;
  b=FMTrDcHA4gpSwzb6YlspJC5c2rc83Q+i31lVeyOyZvV3bcuH+n8Q6CPP
   B57pCnsVPuA/5ck81v4LLcDsF0A5qH9ycPAE3qFek2pCqRmVaFFZkqrcn
   j+EHJkwubWkVq+pYP8WXfg2oxckiO7IRko2DhuH4KdiLAbn1hc5ZLr2Ce
   KtY/ZTkT9vdWfOYXcLsw2+ueNIjtMJuES7u8dH9ejl+mbuT/tcuVgYM9e
   FNKuB70fVRKHXHzB5UXa5kY4jvOlZB1fRGmIS2uhy0aBJfGnNfGsMpWZP
   cik78XRVC0rfWrPTgI/aln4SSw5E7oP6aBB49oMMrKV4AYTRK6DHH6ndh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265621348"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="265621348"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 21:41:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="580363700"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 21:41:06 -0700
Message-ID: <7ef5d473-a3ce-c66e-df33-14c4e91596e2@intel.com>
Date:   Wed, 27 Apr 2022 07:41:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH 1/5] mmc: sdhci-brcmstb: "mmc1: Internal clock never
 stabilised." seen on 72113
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220421182803.6495-1-kdasu.kdev@gmail.com>
 <20220421182803.6495-2-kdasu.kdev@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220421182803.6495-2-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/04/22 21:27, Kamal Dasu wrote:
> From: Al Cooper <alcooperx@gmail.com>
> 
> The problem is in the .shutdown callback that was added to the
> sdhci-iproc and sdhci-brcmstb drivers to save power in S5. The
> shutdown callback will just call the sdhci_pltfm_suspend() function
> to suspend the lower level driver and then stop the sdhci system
> clock. The problem is that in some cases there can be a worker
> thread in the "system_freezable_wq" work queue that is scanning
> for a device every second. In normal system suspend, this queue
> is suspended before the driver suspend is called. In shutdown the
> queue is not suspended and the thread my run after we stop the
> sdhci clock in the shutdown callback which will cause the "clock
> never stabilised" error. The solution will be to have the shutdown
> callback cancel the worker thread before calling suspend (and
> stopping the sdhci clock).
> 
> NOTE: This is only happening on systems with the Legacy RPi SDIO
> core because that's the only controller that doesn't have the
> presence signal and needs to use a worker thread to do a 1 second
> poll loop.
> 
> Fixes: 5b191dcba719 ("mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend")
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index f24623aac2db..11037cd14cfa 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -313,6 +313,10 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  
>  static void sdhci_brcmstb_shutdown(struct platform_device *pdev)
>  {
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +
> +	/* Cancel possible rescan worker thread */
> +	cancel_delayed_work_sync(&host->mmc->detect);
>  	sdhci_pltfm_suspend(&pdev->dev);
>  }
>  

I think we fixed that already with the commit below:


commit 66c915d09b942fb3b2b0cb2f56562180901fba17
Author: Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri Dec 3 15:15:54 2021 +0100

    mmc: core: Disable card detect during shutdown
    
    It's seems prone to problems by allowing card detect and its corresponding
    mmc_rescan() work to run, during platform shutdown. For example, we may end
    up turning off the power while initializing a card, which potentially could
    damage it.
    
    To avoid this scenario, let's add ->shutdown_pre() callback for the mmc host
    class device and then turn of the card detect from there.
    
    Reported-by: Al Cooper <alcooperx@gmail.com>
    Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
    Cc: stable@vger.kernel.org
    Link: https://lore.kernel.org/r/20211203141555.105351-1-ulf.hansson@linaro.org

